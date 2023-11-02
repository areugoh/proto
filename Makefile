export
CLIENTS=go js

# CONFIG
CPUS=`getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1`
VENDOR_DIR=vendor
SUBMODULES_DIR=third_party
BIN_DIR ?= $(PWD)/bin
REPO:=$(shell test $(REPO) && echo $(REPO) || git ls-remote --get-url | rev | cut -d '/' -f2- | rev | awk '{print $$1"/client"}')
TMP_REPO_DIR=$(PWD)/repo
GEN_GO_DIR=gen/go
LAST_TAG:=$(shell git describe --tags --abbrev=0 2>/dev/null || echo v0.0.0)

export GO111MODULE=on

# PROTO
GOOGLEAPIS_PROTO=${SUBMODULES_DIR}/googleapis
GOOGLEPROTOBUF_PROTO=${SUBMODULES_DIR}/protobuf/src
PROTOC_GEN_VALIDATE_PROTO=${SUBMODULES_DIR}/protoc-gen-validate
GOOGLE_OPENAPI_PROTO=${SUBMODULES_DIR}/gnostic/openapiv3
PROTO_OPTION=-I. -I${SUBMODULES_DIR} -I${GOOGLEAPIS_PROTO} -I${GOOGLEPROTOBUF_PROTO} -I${PROTOC_GEN_VALIDATE_PROTO} -I${GOOGLE_OPENAPI_PROTO}
PROTO_DOCS_OPTS=${PROTO_OPTION} \
	--plugin=protoc-gen-doc=${BIN_DIR}/protoc-gen-doc

.PHONY: help
help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  vendor        - Update vendor"
	@echo "  plugin        - Build protoc plugins"
	@echo "  proto         - Generate all of the proto clients"
	@echo "  clean         - Clean all of the proto clients"
	@echo "  release       - Publish all of the proto clients"
	@echo "  proto/go      - Generate go client from proto"
	@echo "  clean/go      - Clean go client"
	@echo "  release/go    - Publish go client"
	@echo "  proto/js      - Generate javascript client from proto"
	@echo "  release/js    - Publish javascript client"
	@echo "  dep/js        - Install javascript dependencies"
	@echo "  docs          - Generate docs"
	@echo "  lint          - Lint proto"
	@echo "  fmt           - Format proto (wip)"
	@echo "  changelog     - Generate changelog"
	@echo "  help          - Show this help message"

.PHONY: vendor
vendor: go.sum .gitmodules
	@echo "Updating vendor..."
	@git submodule update --init
	@go mod download
	@go mod vendor

.PHONY: plugin
plugin: plugin/lint
	@echo "Building protoc plugins..."
	@rm -rf $(BIN_DIR) && mkdir -p $(BIN_DIR) && touch $(BIN_DIR)/.dummy
	@GOBIN=${BIN_DIR} go install -v github.com/googleapis/api-linter/cmd/api-linter@v1.59.0
	@GOBIN=${BIN_DIR} go install -v github.com/quasilyte/go-consistent@v0.6.0
	@GOBIN=${BIN_DIR} go install -v google.golang.org/protobuf/cmd/protoc-gen-go@v1.31.0
	@GOBIN=${BIN_DIR} go install -v github.com/envoyproxy/protoc-gen-validate/cmd/protoc-gen-validate-go@v1.0.2
	@GOBIN=${BIN_DIR} go install -v github.com/google/gnostic/cmd/protoc-gen-openapi@v0.7.0
	@GOBIN=${BIN_DIR} go install -v google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2
	@GOBIN=${BIN_DIR} go install -v github.com/golang/mock/mockgen@v1.6.0
	@GOBIN=${BIN_DIR} go install -v golang.org/x/tools/cmd/goimports@v0.14.0
	@GOBIN=${BIN_DIR} go install -v github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@v2.18.0
	@GOBIN=${BIN_DIR} go install -v github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc@v1.5.1
	@curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.55.0

.PHONY: plugin/lint
plugin/lint:
	@GOBIN=${BIN_DIR} go install -v github.com/ckaznocha/protoc-gen-lint@v0.3.0

# PROTOC
.PHONY: proto clean release
proto: $(foreach var, $(CLIENTS), proto/$(var))
clean: $(foreach var, $(CLIENTS), clean/$(var))
release: $(foreach var, $(CLIENTS), release/$(var))

proto/% release/% clean/%:
	@:

# GO
PROTOC_GO_OPTS=${PROTO_OPTION} \
	--plugin=protoc-gen-go=${BIN_DIR}/protoc-gen-go \
	--go_out=${GEN_GO_DIR} \
	--plugin=protoc-gen-go-grpc=${BIN_DIR}/protoc-gen-go-grpc \
	--go-grpc_out=require_unimplemented_servers=false:${GEN_GO_DIR} \
	--plugin=protoc-gen-validate=${BIN_DIR}/protoc-gen-validate-go \
	--validate_out=${GEN_GO_DIR}
PROTOC_GATEWAY_SPEC_OPT=${PROTO_OPTION} \
	--plugin=protoc-gen-openapi=${BIN_DIR}/protoc-gen-openapi \
	--openapi_out=:${GEN_GO_DIR}
PROTOC_GRPC_GATEWAY_OPTS=${PROTO_OPTION} \
	--plugin=protoc-gen-grpc-gateway=${BIN_DIR}/protoc-gen-grpc-gateway \
	--grpc-gateway_out=logtostderr=true:${GEN_GO_DIR}

.PHONY: proto/go
proto/go:
	@echo "Generating go client from proto..."
	@rm -rf ${GEN_GO_DIR} && mkdir -p ${GEN_GO_DIR}
	# Standard grpc client for go
	@find proto -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} protoc ${PROTOC_GO_OPTS} hoguera/platform/{}
	# Generate mocks
	@find gen/go -name '*.pb.go' -print0 | xargs -0 -I{} -P${CPUS} bash -c "f={}; $(BIN_DIR)/mockgen -source="'$$f'" -package=\`grep '^package' "'$$f'" | head -1 | cut -d' ' -f2\` -destination=\`dirname "'$$f'"\`/mock_\`basename "'$$f'"\`"
	# GRPC Gateway for go
	@find proto -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} protoc ${PROTOC_GATEWAY_SPEC_OPT} hoguera/platform/{}
	# REST -> GRPC gateway for go
	@find proto -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} protoc ${PROTOC_GRPC_GATEWAY_OPTS} hoguera/platform/{}
	# Ensure can be build: mockgen can generate files with unused imports, so we run goimports to remove them
	@find gen/go/ -name '*.pb.go' -print0 | xargs -0 -I{} -P${CPUS} $(BIN_DIR)/goimports -w {}

.PHONY: clean/go
clean/go:
	@echo "Cleaning go client..."
	@rm -rf ${GEN_GO_DIR}

.PHONY: release/go
release/go: proto
	@echo "Publishing go client..."
	@git switch main && git pull origin main && git fetch --tags
	@rm -rf ${TMP_REPO_DIR} && mkdir -p ${TMP_REPO_DIR}
	@git clone ${REPO}-go.git ${TMP_REPO_DIR}/client-go
	@cd ${TMP_REPO_DIR}/client-go && git clean -fdx #&& git checkout main
	@cp $(PWD)/scripts/go/go.mod ${TMP_REPO_DIR}/client-go/go.mod
	@cp $(PWD)/scripts/go/README.md ${TMP_REPO_DIR}/client-go/README.md
	@cp $(PWD)/CHANGELOG.md ${TMP_REPO_DIR}/client-go/CHANGELOG.md
	@cp -R $(PWD)/gen/go/* ${TMP_REPO_DIR}/client-go
	@rm -rf ${TMP_REPO_DIR}/client-go/**openapi**.*
	@$(eval NEXT_VERSION=$(shell test $(NEXT_VERSION) && echo $(NEXT_VERSION) || echo $(LAST_TAG)))
	@cd ${TMP_REPO_DIR}/client-go && git add . && git commit -m "bump(version): $(NEXT_VERSION)" && git tag -a $(NEXT_VERSION) -m '$(NEXT_VERSION)' && git push --tags origin main

# JS
NODE_MODULES=$(PWD)/node_modules
JAVASCRIPT_OUTPUT=gen/javascript
PROTOC_JS_OPT=${PROTO_OPTION} \
	--plugin=protoc-gen-grpc-web=${NODE_MODULES}/protoc-gen-grpc-web/bin/protoc-gen-grpc-web \
	--grpc-web_out=import_style=commonjs,mode=grpcwebtext:${JAVASCRIPT_OUTPUT} \
	--plugin=protoc-gen-js=${NODE_MODULES}/protoc-gen-js/bin/protoc-gen-js \
	--js_out=import_style=commonjs,binary:${JAVASCRIPT_OUTPUT}
PROTOC_JS_LIB_OPT=-I${SUBMODULES_DIR} -I${GOOGLEAPIS_PROTO} \
	--plugin=protoc-gen-js=${NODE_MODULES}/protoc-gen-js/bin/protoc-gen-js \
	--js_out=import_style=commonjs,binary:${JAVASCRIPT_OUTPUT}

.PHONY: proto/js
proto/js:
	@echo "Generating javascript client from proto..."
	@rm -rf $(JAVASCRIPT_OUTPUT) && mkdir -p $(JAVASCRIPT_OUTPUT)
	@find proto -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} protoc ${PROTOC_JS_OPT} {}
	@find ${SUBMODULES_DIR}/googleapis/google/api -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} protoc ${PROTOC_JS_LIB_OPT} {}
	#protoc -I${SUBMODULES_DIR} -I${GOOGLEAPIS_PROTO} \
	#--plugin=protoc-gen-js=${NODE_MODULES}/protoc-gen-js/bin/protoc-gen-js \
    #--js_out=import_style=commonjs,binary:${JAVASCRIPT_OUTPUT}  \
    #--proto_path=${SUBMODULES_DIR}/googleapis/google/api \
    #annotations.proto

.PHONY: release/js
release/js: proto/js docs
	@echo "Publishing javascript client..."
	@git fetch --tags
	@rm -rf ${TMP_REPO_DIR} && mkdir -p ${TMP_REPO_DIR}
	@git clone ${REPO}-javascript.git ${TMP_REPO_DIR}/client-javascript
	@cd ${TMP_REPO_DIR}/client-javascript&& git clean -fdx #&& git checkout main
	@cp $(PWD)/scripts/javascript/*.* ${TMP_REPO_DIR}/client-javascript/
	@cp -R $(PWD)/scripts/javascript/.github ${TMP_REPO_DIR}/client-javascript/
	@cp $(PWD)/docs/README.md ${TMP_REPO_DIR}/client-javascript/README.md
	@cp $(PWD)/CHANGELOG.md ${TMP_REPO_DIR}/client-javascript/CHANGELOG.md
	@cp -R $(PWD)/gen/javascript/src ${TMP_REPO_DIR}/client-javascript
	@$(eval NEXT_VERSION=$(shell test $(NEXT_VERSION) && echo $(NEXT_VERSION) || echo $(LAST_TAG)))
	@cd ${TMP_REPO_DIR}/client-javascript&& git add . && git commit -m "bump(version): $(NEXT_VERSION)" && git tag -a $(NEXT_VERSION) -m '$(NEXT_VERSION)' && git push --tags origin main

.PHONY: dep/js
dep/js:
	@echo "Installing js dependencies..."
	@npm install

# ALL
.PHONY: docs
docs:
	@echo "Generating docs..."
	@find proto -name '*.proto' -printf '%h\0' | sort -zu | xargs -0 -I{} -P${CPUS} bash -c "d={}; protoc ${PROTO_DOCS_OPTS} --doc_opt=./scripts/markdown.tmpl,README.md:google/* --doc_out=hoguera/platform/"'$$d'" hoguera/platform/"'$$d'"/*.proto"


LINT_PLUGIN=${BIN_DIR}/protoc-gen-lint
.PHONY: lint
lint:
	@echo "Linting..."
	@find proto -type f -name "*.proto" | xargs | (read p; protoc $(PROTO_OPTION) --plugin=$(LINT_PLUGIN) --lint_out=. $$p)

.PHONY: fmt
fmt:
	@echo "Formatting..."
	@find proto -type f -name "*.proto" | xargs -I{} -P${CPUS} clang-format -i {}

.PHONY: changelog
changelog:
	@echo "Generating changelog..."
	@$(eval NEXT_VERSION=$(shell test $(NEXT_VERSION) && echo $(NEXT_VERSION) || echo $(LAST_TAG) | awk -F. '{print $$1"."$$2+1".0"}'))
	@test $NEXT_VERSION || (echo "NEXT_VERSION is not set"; exit 1)
	@echo "NEXT_VERSION: $(LAST_TAG) -> $$NEXT_VERSION"
	@git branch | grep -qs "* main" || (echo "This command should be run from main branch"; exit 1)
	@git pull && git switch -c changelog_$(NEXT_VERSION) && git-chglog --next-tag $(NEXT_VERSION) -o CHANGELOG.md && make docs && git add . && git tag -a $(NEXT_VERSION) -m '$(NEXT_VERSION)' && git commit -m "add $(NEXT_VERSION) changelog" && git push --tags --set-upstream origin changelog_$(NEXT_VERSION) && git switch main && git branch -D changelog_$(NEXT_VERSION)
