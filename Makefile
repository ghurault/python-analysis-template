# Set up virtual environments
.PHONY: venv
venv:
	./scripts/setup_venv.sh

# Compile requirements
.PHONY: reqs
reqs:
	pip-compile --extra=dev

# Install dependencies
.PHONY: deps
deps:
	pip install -r requirements.txt && pip install -e .[dev]

# Generate documentation
.PHONY: docs
docs:
	pdoc -d google -t rust -o docs/ src

# Increment git tag
.PHONY: tag
tag:
	./scripts/increment-git-tag.sh
