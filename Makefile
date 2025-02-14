# Set up virtual environments
.PHONY: venv
venv:
	./scripts/setup_venv.sh

# Install dependencies
.PHONY: deps
deps:
	pip install -r requirements.txt

# Generate documentation
.PHONY: docs
docs:
	pdoc -d google -t rust -o docs/ src
