export
CLIENTS=go

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
	--plugin=protoc-gen-doc=${BIN_DIR}/protoc-gen-doc \
	--doc_out=./docs

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

.PHONY: vendor
vendor: go.sum .gitmodules
	@echo "Updating vendor..."
	@git submodule update --init
	@go mod download
	@go mod vendor

.PHONY: plugin
plugin:
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


# PROTOC
.PHONY: proto clean release
proto: $(foreach var, $(CLIENTS), proto/$(var))
clean: $(foreach var, $(CLIENTS), clean/$(var))
release: $(foreach var, $(CLIENTS), release/$(var))

proto/% release/% clean/%:
	@:

.PHONY: proto/go
proto/go:
	@echo "Generating go client from proto..."
	@rm -rf ${GEN_GO_DIR} && mkdir -p ${GEN_GO_DIR}
	# Standard grpc client for go
	@find proto -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} protoc ${PROTOC_GO_OPTS} {}
	# Generate mocks
	@find gen/go -name '*.pb.go' -print0 | xargs -0 -I{} -P${CPUS} bash -c "f={}; $(BIN_DIR)/mockgen -source="'$$f'" -package=\`grep '^package' "'$$f'" | head -1 | cut -d' ' -f2\` -destination=\`dirname "'$$f'"\`/mock_\`basename "'$$f'"\`"
	# GRPC Gateway for go
	@find proto -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} protoc ${PROTOC_GATEWAY_SPEC_OPT} {}
	# REST -> GRPC gateway for go
	@find proto -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} protoc ${PROTOC_GRPC_GATEWAY_OPTS} {}
	# Ensure can be build: mockgen can generate files with unused imports, so we run goimports to remove them
	@find gen/go/ -name '*.pb.go' -print0 | xargs -0 -I{} -P${CPUS} $(BIN_DIR)/goimports -w {}

.PHONY: clean/go
clean/go:
	@echo "Cleaning go client..."
	@rm -rf ${GEN_GO_DIR}

.PHONY: release/go
release/go: proto docs
	@echo "Publishing go client..."
	@rm -rf ${TMP_REPO_DIR} && mkdir -p ${TMP_REPO_DIR}
	@git clone ${REPO}-go.git ${TMP_REPO_DIR}/client-go
	@cd ${TMP_REPO_DIR}/client-go && git clean -fdx #&& git checkout main
	@cp $(PWD)/scripts/go/go.mod ${TMP_REPO_DIR}/client-go/go.mod
	@cp $(PWD)/docs/README.md ${TMP_REPO_DIR}/client-go/README.md
	@cp $(PWD)/CHANGELOG.md ${TMP_REPO_DIR}/client-go/CHANGELOG.md
	@cp -R $(PWD)/gen/go/src ${TMP_REPO_DIR}/client-go
	@$(eval NEXT_VERSION=$(shell test $(NEXT_VERSION) && echo $(NEXT_VERSION) || echo $(LAST_TAG)))
	@cd ${TMP_REPO_DIR}/client-go && git add . && git commit -m "bump(version): $(NEXT_VERSION)" && git tag -a $(NEXT_VERSION) -m '$(NEXT_VERSION)' && git push --tags origin main

.PHONY: docs
docs:
	@echo "Generating docs..."
	@rm -rf docs && mkdir -p docs
	@find proto -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} protoc ${PROTO_DOCS_OPTS} --doc_opt=markdown,README.md {}


LINT_PLUGIN=${BIN_DIR}/protoc-gen-lint
.PHONY: lint
lint:
	@echo "Linting..."
	@find proto -type f -name "*.proto" | xargs | (read p: protoc $(ROTOC_OPTION) --plugin=$(LINT_PLUGIN) --lint_out=. $$p)

.PHONY: changelog
changelog:
	@echo "Generating changelog..."
	@$(eval NEXT_VERSION=$(shell test $(NEXT_VERSION) && echo $(NEXT_VERSION) || echo $(LAST_TAG) | awk -F. '{print $$1"."$$2+1"."$$3}'))
	@test $NEXT_VERSION || (echo "NEXT_VERSION is not set"; exit 1)
	@echo "NEXT_VERSION: $(LAST_TAG) -> $$NEXT_VERSION"
	@git branch | grep -qs "* main" || (echo "This command should be run from main branch"; exit 1)
	@git pull && git switch -c changelog_$(NEXT_VERSION) && git-chglog --next-tag $(NEXT_VERSION) -o CHANGELOG.md && git add CHANGELOG.md && git tag -a $(NEXT_VERSION) -m '$(NEXT_VERSION)' && git commit -m "add $(NEXT_VERSION) changelog" && git push --tags --set-upstream origin changelog_$(NEXT_VERSION) && git switch main && git branch -D changelog_$(NEXT_VERSION)
