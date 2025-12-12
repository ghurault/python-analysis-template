## Set up a virtual environment
.PHONY: venv
venv:
	./scripts/setup_venv.sh

## Compile requirements
.PHONY: reqs
reqs:
	uv pip compile pyproject.toml -o requirements.txt --all-extras

## Install dependencies
.PHONY: deps
deps:
	pip install -r requirements.txt && pip install -e .[all]

## Generate documentation
.PHONY: docs
docs:
	pdoc --docformat google -o docs/ src

## Increment git tag
.PHONY: tag
tag:
	./scripts/increment-git-tag.sh

## Show this help message
.PHONY: help
help:
	@awk '\
		/^##/ {sub(/^## ?/, "", $$0); doc=$$0; next} \
		/^[a-zA-Z0-9_.-]+:/ && $$1 !~ /^\./ { \
			target=$$1; sub(/:.*/, "", target); \
			print target "|" doc; doc="" \
		} \
	' $(MAKEFILE_LIST) | sort | awk -F"|" '{printf "%-20s %s\n", $$1, $$2}'
