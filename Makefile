.PHONY: generate

OPENAPI_IMAGE=openapitools/openapi-generator-cli
VERSION=$(shell cat package.json | jq '.version')
OPENAPI_SPEC=https://raw.githubusercontent.com/ory/hydra/v${VERSION}/docs/api.swagger.json

default: generate

api.swagger.json:
	curl ${OPENAPI_SPEC} --output api.swagger.json

generate: api.swagger.json
	@docker run --rm -u $(shell id -u):$(shell id -g) -v `pwd`:/src $(OPENAPI_IMAGE) generate \
		-i ${OPENAPI_SPEC} \
		-g typescript-axios \
		-o /src
