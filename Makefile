.DEFAULT_GOAL := help

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
	pip install -r requirements.txt && pip install -e '.[all]'

## Generate documentation
.PHONY: docs
docs:
	find docs -mindepth 1 -maxdepth 1 ! -name .gitignore -exec rm -rf {} +
	pdoc --docformat google -o docs/ src

## Increment git tag
.PHONY: tag
tag:
	./scripts/increment-git-tag.sh

## Delete compiled Python files and caches
.PHONY: clean
clean:
	find . -path ./.venv -prune -o -type d -name "__pycache__" -exec rm -rf {} +
	find . -path ./.venv -prune -o -type f -name "*.py[co]" -exec rm -f {} +
	find . -path ./.venv -prune -o -type d -name "*.egg-info" -exec rm -rf {} +
	rm -rf .pytest_cache .ruff_cache .coverage htmlcov build dist

## Show this help message
.PHONY: help
help:
	@awk '\
		/^##/ {sub(/^## ?/, "", $$0); doc=$$0; next} \
		/^[a-zA-Z0-9_.-]+:([^=]|$$)/ && $$1 !~ /^\./ { \
			target=$$1; sub(/:.*/, "", target); \
			print target "|" doc; doc="" \
		} \
	' $(MAKEFILE_LIST) | sort | awk -F"|" '{printf "%-20s %s\n", $$1, $$2}'
