SHELL = /bin/bash

CT := docker run -v $$(pwd):/opt -w /opt quay.io/helmpack/chart-testing:latest ct
HELM := docker run -v $$(pwd):/opt -w /opt alpine/helm
CHARTS := $(shell find charts -name Chart.yaml -mindepth 2 -maxdepth 2 | cut -d/ -f2)

TEMPLATE_TARGETS := $(foreach c,$(CHARTS),template/$(c))
template/%:
	@echo "Rendering [$*]"
	$(HELM)	 template tpl-$* charts/$* --output-dir=build/$* --namespace=tpl

template: $(TEMPLATE_TARGETS)

lint:
	$(CT) lint

.PHONY: test
test:
	./test/e2e-kind.sh

docs:
	helm-docs
