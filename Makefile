export
CLIENTS=go

# CONFIG
CPUS=`getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1`
VENDOR_DIR=vendor
SUBMODULES_DIR=third_party
BIN_DIR ?= $(PWD)/bin
GEN_GO_DIR=gen/go

export GO111MODULE=on

# PROTO
GOOGLEAPIS_PROTO=${SUBMODULES_DIR}/googleapis
GOOGLEPROTOBUF_PROTO=${SUBMODULES_DIR}/protobuf/src
PROTOC_GEN_VALIDATE_PROTO=${SUBMODULES_DIR}/protoc-gen-validate
GOOGLE_OPENAPI_PROTO=${SUBMODULES_DIR}/gnostic/openapiv3
PROTO_OPTION=-I. -I${SUBMODULES_DIR} -I${GOOGLEAPIS_PROTO} -I${GOOGLEPROTOBUF_PROTO} -I${PROTOC_GEN_VALIDATE_PROTO} -I${GOOGLE_OPENAPI_PROTO}

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
plugin: vendor
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
	@curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.55.0


# PROTOC
.PHONY: proto clean publish
proto: $(foreach var, $(CLIENTS), proto/$(var))
clean: $(foreach var, $(CLIENTS), clean/$(var))
publish: $(foreach var, $(CLIENTS), publish/$(var))

proto/% publish/% clean/%:
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
	@find gen/go -name '*.pb.go' -print0 | xargs -0 -I{} -P${CPUS} $(BIN_DIR)/goimports -w {}

.PHONY: clean/go
clean/go:
	@echo "Cleaning go client..."
	@rm -rf ${GEN_GO_DIR}

.PHONY: release/go
publish/go:
	@echo "Publishing go client..$@."


LINT_PLUGIN=${BIN_DIR}/protoc-gen-lint
.PHONY: lint
lint:
	@echo "Linting..."
	@find proto -type f -name "*.proto" | xargs | (read p: protoc $(ROTOC_OPTION) --plugin=$(LINT_PLUGIN) --lint_out=. $$p)
