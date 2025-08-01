# Set up virtual environments
.PHONY: venv
venv:
	./scripts/setup_venv.sh

# Compile requirements
.PHONY: reqs
reqs:
	uv pip compile pyproject.toml -o requirements.txt --all-extras

# Install dependencies
.PHONY: deps
deps:
	pip install -r requirements.txt && pip install -e .[all]

# Generate documentation
.PHONY: docs
docs:
	pdoc -d google -t rust -o docs/ --docformat google src

# Increment git tag
.PHONY: tag
tag:
	./scripts/increment-git-tag.sh
