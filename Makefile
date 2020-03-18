SHELL = /bin/bash

CT := docker run -v $$(pwd):/opt -w /opt quay.io/helmpack/chart-testing:latest ct
HELM := docker run -v $$(pwd):/opt -w /opt alpine/helm
CHARTS := $(shell find . -name Chart.yaml -mindepth 1 -maxdepth 3 | cut -d/ -f2)

TEMPLATE_TARGETS := $(foreach c,$(CHARTS),template/$(c))
template/%:
	@echo "Rendering [$*]"
	$(HELM)	 template tpl-$* $* --output-dir=build/$* --namespace=tpl

template: $(TEMPLATE_TARGETS)

lint:
	$(CT) lint --chart-dirs=.

.PHONY: test
test:
	./test/e2e-kind.sh
