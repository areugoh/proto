export
CLIENTS=go nodejs rust

# CONFIG
CPUS=`getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1`
VENDOR_DIR=vendor
SUBMODULES_DIR=third_party
BIN_DIR ?= $(PWD)/bin
REPO:=$(shell test $(REPO) && echo $(REPO) || git ls-remote --get-url | rev | cut -d '/' -f2- | rev | awk '{print $$1"/client"}')
TMP_REPO_DIR=$(PWD)/repo
GEN_GO_DIR=gen/go
LAST_TAG:=$(shell git describe --tags --abbrev=0 2>/dev/null || echo v0.0.0)
PSEUDO_VERSION:=$(shell git rev-parse --short HEAD | awk -v LAST_TAG=$(LAST_TAG) '{print LAST_TAG"-pre."$$1}')
GIT_USERNAME:=$(shell git config user.name)
GIT_EMAIL:=$(shell git config user.email)
GITHUB_ORG:=areugoh
GIT_CLIENT_BASE_BRANCH=main

export GO111MODULE=on

PLATFORM_PREFIX=hoguera/platform
NODE_MODULES_BIN=$(PWD)/node_modules/.bin
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
	@echo "  dep               - Install dependencies"
	@echo "  vendor            - Update vendor"
	@echo "  plugin            - Build protoc plugins"
	@echo ""
	@echo "  proto             - Generate all of the proto clients"
	@echo "  clean             - Clean all of the proto clients"
	@echo "  release           - Publish all of the proto clients"
	@echo "  release-pseudo    - Publish all of the proto clients with pseudo version"
	@echo ""
	@echo "  proto/go          - Generate go client from proto"
	@echo "  clean/go          - Clean go client"
	@echo "  release/go        - Publish go client"
	@echo "  proto/nodejs      - Generate nodejs client from proto"
	@echo "  clean/nodejs      - Clean nodejs client"
	@echo "  release/nodejs    - Publish nodejs client"
	@echo "  proto/rust        - Generate rust client from proto"
	@echo "  clean/rust        - Clean rust client"
	@echo "  release/rust      - Publish rust client"
	@echo ""
	@echo "  lint              - Lint proto"
	@echo "  fmt               - Format proto (wip)"
	@echo ""
	@echo "  docs              - Generate docs"
	@echo "  changelog         - Generate changelog"
	@echo ""
	@echo "  help              - Show this help message"

.PHONY: pseudo/version
pseudo/version:
	@echo $(PSEUDO_VERSION)

define BODY
#### $(PSEUDO_VERSION)
Your pseudo version `$(PSEUDO_VERSION)` is ready to use!
Follow the instructions in the README.md of each client to use it.

- :hamster: **GO**: https://github.com/areugoh/client-go/releases/tag/$(PSEUDO_VERSION)
- :crab: **RUST**: https://github.com/areugoh/client-rust/releases/tag/$(PSEUDO_VERSION)
- :penguin: **NODEJS**: https://github.com/areugoh/client-nodejs/tree/$(PSEUDO_VERSION)

> :warning: **WARNING**: This version is not stable and can be changed at any time.
> To recreate this version, remove the `pseudo-version` label from the PR and add it again.
endef
.PHONY: pseudo/md
pseudo/md:
	@echo "$$BODY"

.PHONY: vendor
vendor: go.sum .gitmodules
	@echo "Updating vendor..."
	@git submodule update --init
	@go mod vendor

.PHONY: plugin
plugin: plugin/gen plugin/lint

.PHONY: plugin/gen
plugin/gen:
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
.PHONY: proto clean release release-pseudo
proto: $(foreach var, $(CLIENTS), proto/$(var))
clean: $(foreach var, $(CLIENTS), clean/$(var))
release: $(foreach var, $(CLIENTS), release/$(var))
release-pseudo: $(foreach var, $(CLIENTS), release-pseudo/$(var))

proto/% release/% clean/% release-pseudo/%:
	@:

# GO
PROTOC_GO_OPTS=${PROTO_OPTION} \
	--plugin=protoc-gen-go=${BIN_DIR}/protoc-gen-go \
	--go_out=${GEN_GO_DIR} \
	--plugin=protoc-gen-go-grpc=${BIN_DIR}/protoc-gen-go-grpc \
	--go-grpc_out=require_unimplemented_servers=false:${GEN_GO_DIR} \
	--plugin=protoc-gen-validate=${BIN_DIR}/protoc-gen-validate-go \
	--validate_out=${GEN_GO_DIR}
PROTOC_GRPC_GATEWAY_OPTS=${PROTO_OPTION} \
	--plugin=protoc-gen-grpc-gateway=${BIN_DIR}/protoc-gen-grpc-gateway \
	--grpc-gateway_out=logtostderr=true:${GEN_GO_DIR}

.PHONY: proto/go
proto/go:
	@echo "Generating go client from proto..."
	@rm -rf ${GEN_GO_DIR} && mkdir -p ${GEN_GO_DIR}
	# Standard grpc client for go
	@find proto -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} protoc ${PROTOC_GO_OPTS} ${PLATFORM_PREFIX}/{}
	# Generate mocks
	@find gen/go -name '*.pb.go' -print0 | xargs -0 -I{} -P${CPUS} bash -c "f={}; $(BIN_DIR)/mockgen -source="'$$f'" -package=\`grep '^package' "'$$f'" | head -1 | cut -d' ' -f2\` -destination=\`dirname "'$$f'"\`/mock_\`basename "'$$f'"\`"
	# REST -> GRPC gateway for go
	@find proto -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} protoc ${PROTOC_GRPC_GATEWAY_OPTS} ${PLATFORM_PREFIX}/{}
	# Ensure can be build: mockgen can generate files with unused imports, so we run goimports to remove them
	@find gen/go/ -name '*.pb.go' -print0 | xargs -0 -I{} -P${CPUS} $(BIN_DIR)/goimports -w {}

.PHONY: clean/go
clean/go:
	@echo "Cleaning go client..."
	@rm -rf ${GEN_GO_DIR}

.PHONY: release/go
release/go: proto
	@echo "Publishing go client..."
	$(if $PSEUDO, @git fetch --tags,@git switch $(GIT_CLIENT_BASE_BRANCH) && git pull origin $(GIT_CLIENT_BASE_BRANCH) && git fetch --tags)
	@rm -rf ${TMP_REPO_DIR} && mkdir -p ${TMP_REPO_DIR}
	@$(if $(GH_TOKEN),git clone https://$(GH_TOKEN)@github.com/${GITHUB_ORG}/client-go ${TMP_REPO_DIR}/client-go,git clone ${REPO}-go.git ${TMP_REPO_DIR}/client-go)
	$(if $(GH_TOKEN),cd ${TMP_REPO_DIR}/client-go && git remote set-url origin https://x-access-token:$(GH_TOKEN)@github.com/${GITHUB_ORG}/client-go && git config --global user.email $(GIT_EMAIL) && git config --global user.name $(GIT_USERNAME),@echo "GH_TOKEN is not set")
	@cd ${TMP_REPO_DIR}/client-go && git clean -fdx #&& git checkout main
	@cp $(PWD)/scripts/go/go.mod ${TMP_REPO_DIR}/client-go/go.mod
	@cp $(PWD)/scripts/go/README.md ${TMP_REPO_DIR}/client-go/README.md
	@cp $(PWD)/CHANGELOG.md ${TMP_REPO_DIR}/client-go/CHANGELOG.md
	@cp -R $(PWD)/$(GEN_GO_DIR)/* ${TMP_REPO_DIR}/client-go
	@rm -rf ${TMP_REPO_DIR}/client-go/**openapi**.*
	@$(eval NEXT_VERSION=$(shell test $(NEXT_VERSION) && echo $(NEXT_VERSION) || echo $(LAST_TAG)))
	@$(eval RELEASE_BRANCH=$(shell test $(PSEUDO) && echo $(PSEUDO_VERSION) || echo $(GIT_CLIENT_BASE_BRANCH)))
	@cd ${TMP_REPO_DIR}/client-go && git add . && git commit -m "bump(version): $(NEXT_VERSION)" && git tag -a $(NEXT_VERSION) -m '$(NEXT_VERSION)' && git push --tags origin $(GIT_CLIENT_BASE_BRANCH):$(RELEASE_BRANCH)

.PHONY: release-pseudo/go
release-pseudo/go:
	@NEXT_VERSION=$(PSEUDO_VERSION) make release/go PSEUDO=true
	@echo $(PSEUDO_VERSION)

# NodeJS
NODEJS_OUTPUT=gen/nodejs
PROTOC_NODEJS_OPT=${PROTO_OPTION} \
	--js_out=import_style=commonjs,binary:${NODEJS_OUTPUT} \
	--grpc_out=grpc_js:${NODEJS_OUTPUT}
NODEJS_COMMAND=${NODE_MODULES_BIN}/grpc_tools_node_protoc \
	${PROTOC_NODEJS_OPT}
.PHONY: proto/nodejs
proto/nodejs: clean/nodejs
	@echo "Generating nodejs client from proto..."
	@rm -rf $(NODEJS_OUTPUT) && mkdir -p $(NODEJS_OUTPUT)
	@find proto -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} ${NODEJS_COMMAND} {}
	@echo "Generating nodejs vendor..."
	@mkdir -p google/protobuf && cp $(GOOGLEPROTOBUF_PROTO)/google/protobuf/*.proto google/protobuf
	@mkdir -p google/api && cp $(GOOGLEAPIS_PROTO)/google/api/*.proto google/api
	@mkdir -p google/rpc && cp $(GOOGLEAPIS_PROTO)/google/rpc/*.proto google/rpc
	@mkdir -p google/type && cp $(GOOGLEAPIS_PROTO)/google/type/*.proto google/type
	@mkdir -p google/longrunning && cp $(GOOGLEAPIS_PROTO)/google/longrunning/*.proto google/longrunning
	@mkdir validate && cp $(PROTOC_GEN_VALIDATE_PROTO)/validate/validate.proto validate
	@find google -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} ${NODEJS_COMMAND} {} 2>/dev/null || true
	@find validate -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} ${NODEJS_COMMAND} {} 2>/dev/null || true

.PHONY: release/nodejs
release/nodejs: proto/nodejs
	@echo "Publishing nodejs client..."
	$(if $PSEUDO, @git fetch --tags,@git switch $(GIT_CLIENT_BASE_BRANCH) && git pull origin $(GIT_CLIENT_BASE_BRANCH) && git fetch --tags)
	@rm -rf ${TMP_REPO_DIR} && mkdir -p ${TMP_REPO_DIR}
	@$(if $(GH_TOKEN),git clone https://$(GH_TOKEN)@github.com/${GITHUB_ORG}/client-nodejs ${TMP_REPO_DIR}/client-nodejs,git clone ${REPO}-nodejs.git ${TMP_REPO_DIR}/client-nodejs)
	$(if $(GH_TOKEN),cd ${TMP_REPO_DIR}/client-nodejs && git config --global user.email $(GIT_EMAIL) && git config --global user.name $(GIT_USERNAME) && git remote set-url origin https://x-access-token:$(GH_TOKEN)@github.com/${GITHUB_ORG}/client-nodejs,@echo "GH_TOKEN is not set")
	@cd ${TMP_REPO_DIR}/client-nodejs && git clean -fdx #&& git checkout main
	@cp -R $(PWD)/scripts/nodejs/ ${TMP_REPO_DIR}/client-nodejs/
	@cp -R $(PWD)/scripts/nodejs/.git* ${TMP_REPO_DIR}/client-nodejs/
	@cp -R $(PWD)/scripts/nodejs/.npmrc ${TMP_REPO_DIR}/client-nodejs/.npmrc
	@cp $(PWD)/CHANGELOG.md ${TMP_REPO_DIR}/client-nodejs/CHANGELOG.md
	@cp -R $(PWD)/$(NODEJS_OUTPUT)/* ${TMP_REPO_DIR}/client-nodejs
	@$(eval NEXT_VERSION=$(shell test $(NEXT_VERSION) && echo $(NEXT_VERSION) || echo $(LAST_TAG)))
	@$(eval RELEASE_BRANCH=$(shell test $(PSEUDO) && echo $(PSEUDO_VERSION) || echo $(GIT_CLIENT_BASE_BRANCH)))
	@cd ${TMP_REPO_DIR}/client-nodejs && git add . && git commit -m "bump(version): $(NEXT_VERSION)" && npm version $(NEXT_VERSION) && git push --tags origin $(GIT_CLIENT_BASE_BRANCH):$(RELEASE_BRANCH)

.PHONY: release-pseudo/nodejs
release-pseudo/nodejs:
	@NEXT_VERSION=$(PSEUDO_VERSION) make release/nodejs PSEUDO=true
	@echo $(PSEUDO_VERSION)

.PHONY: clean/nodejs
clean/nodejs:
	@echo "Cleaning nodejs client..."
	@rm -rf $(NODEJS_OUTPUT)
	@rm -rf google validate

# Rust
RUST_OUTPUT=gen/rust
PROTOC_RUST_OPTS=${PROTO_OPTION} \
	--plugin=protoc-gen-grpc=`which grpc_rust_plugin` \
	--rust_out=experimental-codegen=enabled,kernel=cpp:${RUST_OUTPUT}
.PHONY: proto/rust
proto/rust:
	@echo "Generating rust client from proto..."
	@rm -rf $(RUST_OUTPUT) && mkdir -p $(RUST_OUTPUT)
	@find proto -name '*.proto' -print0 | xargs -0 -I{} -P${CPUS} protoc ${PROTOC_RUST_OPTS} {}

.PHONY: release/rust
release/rust: proto/rust
	@echo "Publishing rust client..."
	$(if $PSEUDO, @git fetch --tags,@git switch $(GIT_CLIENT_BASE_BRANCH) && git pull origin $(GIT_CLIENT_BASE_BRANCH) && git fetch --tags)
	@rm -rf ${TMP_REPO_DIR} && mkdir -p ${TMP_REPO_DIR}
	@$(if $(GH_TOKEN),git clone https://$(GH_TOKEN)@github.com/${GITHUB_ORG}/client-rust ${TMP_REPO_DIR}/client-rust,git clone ${REPO}-rust.git ${TMP_REPO_DIR}/client-rust)
	$(if $(GH_TOKEN),cd ${TMP_REPO_DIR}/client-rust && git config --global user.email $(GIT_EMAIL) && git config --global user.name $(GIT_USERNAME) && git remote set-url origin https://x-access-token:$(GH_TOKEN)@github.com/${GITHUB_ORG}/client-rust,@echo "GH_TOKEN is not set")
	@cd ${TMP_REPO_DIR}/client-rust && git clean -fdx #&& git checkout main
	@cp -R $(PWD)/scripts/rust/ ${TMP_REPO_DIR}/client-rust/
	@cp $(PWD)/CHANGELOG.md ${TMP_REPO_DIR}/client-rust/CHANGELOG.md
	@mkdir -p ${TMP_REPO_DIR}/client-rust/src
	@cp -R $(PWD)/$(RUST_OUTPUT)/proto/* ${TMP_REPO_DIR}/client-rust/src
	@$(eval NEXT_VERSION=$(shell test $(NEXT_VERSION) && echo $(NEXT_VERSION) || echo $(LAST_TAG)))
	@$(eval RELEASE_BRANCH=$(shell test $(PSEUDO) && echo $(PSEUDO_VERSION) || echo $(GIT_CLIENT_BASE_BRANCH)))
	@cd ${TMP_REPO_DIR}/client-rust && git add . && git commit -m "bump(version): $(NEXT_VERSION)" && git tag -a $(NEXT_VERSION) -m '$(NEXT_VERSION)' && git push --tags origin $(GIT_CLIENT_BASE_BRANCH):$(RELEASE_BRANCH)

.PHONY: release-pseudo/rust
release-pseudo/rust:
	@NEXT_VERSION=$(PSEUDO_VERSION) make release/rust PSEUDO=true
	@echo $(PSEUDO_VERSION)

.PHONY: clean/rust
clean/rust:
	@echo "Cleaning rust client..."
	@rm -rf $(RUST_OUTPUT)

.PHONY: dep
dep:
	@echo "Installing nodejs dependencies..."
	@npm install
	@echo "Installing go dependencies..."
	@go mod download
	@echo "Installing rust dependencies..."
	@cargo install protobuf-codegen
	@cargo install grpcio-compiler

# ALL
.PHONY: docs
docs:
	@echo "Generating docs..."
	@find proto -name '*.proto' -printf '%h\0' | sort -zu | xargs -0 -I{} -P${CPUS} bash -c "d={}; protoc ${PROTO_DOCS_OPTS} --doc_opt=./scripts/markdown.tmpl,README.md:google/* --doc_out=${PLATFORM_PREFIX}/"'$$d'" ${PLATFORM_PREFIX}/"'$$d'"/*.proto"

PROTOC_GATEWAY_SPEC_OPT=${PROTO_OPTION} \
	--plugin=protoc-gen-openapi=${BIN_DIR}/protoc-gen-openapi
OPENAPI_GEN_DIR=gen/openapi
.PHONY: openapi
openapi:
	@echo "Generating openapi..."
	@rm -rf ${OPENAPI_GEN_DIR} && mkdir -p ${OPENAPI_GEN_DIR}
	@find proto -name '*.proto' -printf '%h\0' | sort -zu | xargs -0 -I{} -P${CPUS} bash -c "d={}; mkdir -p ${OPENAPI_GEN_DIR}/"'$$d'" && protoc ${PROTOC_GATEWAY_SPEC_OPT} --openapi_out=fq_schema_naming=true,default_response=false:${OPENAPI_GEN_DIR}/"'$$d'" ${PLATFORM_PREFIX}/"'$$d'"/*.proto"
	@find ${OPENAPI_GEN_DIR} -name '*.yaml' -printf '%h\0' | sort -zu | xargs -0 -I{} -P${CPUS} bash -c "d={}; $(NODE_MODULES_BIN)/redocly build-docs "'$$d'"/*.yaml -o "'$$d'"/index.html"
	@rm -rf ${OPENAPI_GEN_DIR}/**/*.yaml



LINT_PLUGIN=${BIN_DIR}/protoc-gen-lint
.PHONY: lint
lint:
	@echo "Linting..."
	@find $(PLATFORM_PREFIX)/proto/ -type f -name "*.proto" | xargs | (read p; protoc $(PROTO_OPTION) --plugin=$(LINT_PLUGIN) --lint_out=. $$p)

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
