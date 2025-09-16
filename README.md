# Python analysis template

[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ⚙️ Project setup

This repository follows a standard setup I use for data science projects, which includes:

- A [research compendium](https://doi.org/10.1080/00031305.2017.1375986) layout, including a local Python package (see [File Structure](#️-file-structure)).
- [Visual Studio Code](https://code.visualstudio.com/) (VSC) as the preferred IDE, with [recommended extensions](.vscode/extensions.json).
- A [VS Code Dev Container](https://code.visualstudio.com/docs/devcontainers/containers), powered by [Docker](https://www.docker.com/), as a reproducible development environment.
- [pre-commit](https://pre-commit.com/) to manage git hooks.
- Python tooling:
  - [Black](https://black.readthedocs.io/en/stable/index.html) for code formatting (pre-commit and VSC extension).
    In addition, I follow the [Google style guide](https://google.github.io/styleguide/pyguide.html).
  - [Ruff](https://docs.astral.sh/ruff/) (pre-commit and VSC extension) and [SonarLint](https://marketplace.visualstudio.com/items?itemName=SonarSource.sonarlint-vscode) (VSC extension) for linting.
  - [mypy](https://www.mypy-lang.org/) for type checking (VSC extension).
  - [uv](https://docs.astral.sh/uv/) to compile requirements.
  - [pdoc](https://pdoc.dev/docs/pdoc.html) to generate API documentation (including a pre-commit hook for generating a local documentation).
    Python docstrings are written following the [Google docstring format](https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html) and with the help of the [autoDocstring VSC extension](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring).
  - [pytest](https://docs.pytest.org/en/stable/) for testing, with [doctest](https://docs.python.org/3/library/doctest.html) enabled.
  - Automatic versioning of the local package from git tags via [setuptools_scm](https://setuptools-scm.readthedocs.io/en/stable/), following [semantic versioning](https://semver.org/).
- [SQLFluff](https://sqlfluff.com/) as a linter and formatter for SQL files (pre-commit and VSC extension).
- [prettier](https://prettier.io/) (VSC extension) as a formatter for YAML, JSON and Markdown files.
- [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint) (VSC extension) as a linter for Markdown.
- [Taplo](https://marketplace.visualstudio.com/items?itemName=tamasfe.even-better-toml) (VSC extension) as a formatter for TOML files.
- A [Makefile](Makefile) to provide an interface to common tasks (see [Make commands](#️-make-commands)).
- [Conventional commit messages](https://www.conventionalcommits.org/en/v1.0.0/) (enforced by pre-commit).

## 🗂️ File structure

```text
.
├── analysis/                  # Analysis scripts and notebooks
├── data/                      # Data files (usually git ignored)
├── docs/                      # API documentation (git ignored)
├── results/                   # Output files: figures, tables, etc. (git ignored)
├── scripts/                   # Utility scripts (e.g. env setup)
├── src/                       # Local Python package
│   ├── __init__.py
│   └── config.py              # Configs, constants, settings
├── tests/                     # Unit tests for src/
│   └── test_*.py
├── .devcontainer/             # VS Code Dev container setup
├── .vscode/                   # VS Code settings and extensions
├── Dockerfile                 # Dockerfile used for dev container
├── Makefile                   # Utility commands (docs, env, versioning)
├── pyproject.toml             # Configs for package, tools (Ruff, mypy, etc.) and direct deps
├── requirements.txt           # Pinned dependencies (generated)
├── taplo.toml                 # Configs for TOML formatter
├── .pre-commit-config.yaml    # Configs for pre-commit
├── .sqlfluff                  # Configs for SQLFluff
```

## 🐳 Development environment

The preferred development environment for this project is a **VS Code Dev Container**, which provides a consistent and reproducible setup using Docker.

1. Install and launch [Docker](https://www.docker.com/).
2. Install and open the project in VS Code.
3. Open the container by using the command palette in VS Code (`Ctrl + Shift + P`) to search for "Dev Containers: Open Folder in Container...".

Once inside the container, the dependencies specified in [`requirements.txt`](requirements.txt) are installed and the local package is available in editable mode.
If needed, the container can be rebuilt by searching for "Dev Containers: Rebuild Container...".

For more details regarding Dev Containers, or alternative environment setups (venv, conda, etc.), please refer to [`DEVELOPMENT.md`](DEVELOPMENT.md).

Regardless of the environment, install Git hooks after setup with `pre-commit install` to ensure the code is automatically linted and formatted on commit.

## 📦 Managing requirements

Requirements are managed with:

- [`pyproject.toml`](pyproject.toml) to list direct dependencies of the `src` package and development dependencies (e.g. for the analysis).
- [`requirements.txt`](requirements.txt) to pin alls dependencies (direct and indirect).
  This file is automatically generated with [`uv`](https://docs.astral.sh/uv/) and is used to fully recreate the environment.

⚠️ The local package (`src`) is not included in `requirements.txt`, so installation is a two-step process.

### Workflow

- **Initial setup** or **adding new direct dependencies**:

  1. Add dependencies to `pyproject.toml`.
  2. Run `make reqs` to compile `requirements.txt`.

- **Upgrading packages**: compile new requirements with `uv pip compile pyproject.toml -o requirements.txt --all-extras --upgrade`, then make deps.

Finally, run `make deps` to install pinned dependencies and the local package in editable mode.

## 🛠️ Make commands

Common utility commands are available via the Makefile:

- `make reqs`: Compile `requirements.txt` from `pyproject.toml`.
- `make deps`: Install requirements and the local package.
- `make docs`: Generate the package documentation.
- `make tag`: Create and push a new Git tag by incrementing the version.
- `make venv`: Set up a venv environment (see [DEVELOPMENT.md](DEVELOPMENT.md)).

## 🧰 Using the template

> Delete this section after initialising a project from the template.

This template aims to be relatively lightweight and tailored to my needs.
It is therefore opinionated and also in constant evolution, reflecting with data science journey with Python.
It is also worth noting that this template is more focused on experimentation rather than sharing a single final product.

### Getting started

1. Initialise your GitHub repository with this template. Alternatively, fork (or copy the content of) this repository.
2. Update

   - project metadata in [`pyproject.toml`](pyproject.toml), such as the description and the authors.
   - the repository name (if the template was forked).
   - the README (title, badges, sections).
   - the license.

3. Set up your preferred development environment (see [Development Environment](#-development-environment)).
4. Specify, compile and install your requirements (see [Managing requirements](#-managing-requirements)).
5. Adjust the configurations to your needs (e.g. Python configuration in `src/config.py`, the SQL dialect in `.sqlfluff`, etc.).
6. Add a git tag for the initial version with `git tag -a v0.1.0 -m "Initial setup"`, and push it with `git push origin --tags`. Alternatively, use `make tag`.

### Possible extensions

#### Suggested modules for the local package

The `src/` package could contain the following modules or sub-packages depending on the project:

- `utils` for utility functions.
- `data_processing`, `data` or `datasets` for data processing functions.
- `features` for extracting features.
- `models` for defining models.
- `evaluation` for evaluating performance.
- `plots` for plotting functions.

#### Additional directories

The repository structure could be extended with:

- `models/` to store model files.
- subfolders in `data/` such as `data/raw/` for storing raw data.

#### Experiment tracking with MLflow

[MLflow](https://mlflow.org/) can be used as a tool to track Machine Learning experiments.
Often, MLflow will be configured so that the results are saved on a remote database and artifact store.
If this is not the case, the following can be added in [`src/config.py`](src/config.py) to set up a local storage for MLflow experiments:

```python
MLRUNS_DIR = RES_DIR / "mlruns"
TRACKING_URI = "file:///" + MLRUNS_DIR.as_posix()
os.environ["MLFLOW_TRACKING_URI"] = TRACKING_URI
```

Then, the MLflow UI can be launched with:

```bash
mlflow ui --backend-store-uri file:///path/to/results/mlruns
```

#### Environment configuration via `.env`

Configurations, such as credentials, can be loaded from a `.env` file.

This can be achieved by [mounting a `.env` file directly in the Dev Container](https://code.visualstudio.com/remote/advancedcontainers/environment-variables#_option-2-use-an-env-file), updating the `runArgs` option in [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json) accordingly.

Alternatively, one can use the [python-dotenv](https://pypi.org/project/python-dotenv/) package and add the following in [`src/config.py`](src/config.py):

```python
from dotenv import load_dotenv

load_dotenv()
```

#### Project documentation

A full project documentation (beyond the API) could be generated using [mkdocs](https://www.mkdocs.org/) or [quartodoc](https://machow.github.io/quartodoc/get-started/overview.html).

#### Continuous Integration

This template is not tied to a specific platform and does not include continuous integration workflows.
Nevertheless, the template could be extended with the following integrations:

- [GitHub's Dependabot](https://docs.github.com/en/code-security/getting-started/dependabot-quickstart-guide) for dependency updates, or [pip-audit](https://pypi.org/project/pip-audit/).
- Testing and code coverage.
- Building and hosting documentation.

### Related

This template is inspired by the concept of a [research compendium](https://doi.org/10.1080/00031305.2017.1375986), similar projects I created for R projects (e.g. [reproducible-workflow](https://github.com/ghurault/reproducible-workflow)), and other, more exhaustive, templates such as:

- [Cookiecutter Data Science](https://github.com/drivendataorg/cookiecutter-data-science/).
- [https://joserzapata.github.io/data-science-project-template/](https://joserzapata.github.io/data-science-project-template/)
- [Data Science for Social Good's hitchhiker's guide template](https://github.com/dssg/hitchhikers-guide/tree/master/sources/curriculum/0_before_you_start/pipelines-and-project-workflow)
- [https://github.com/khuyentran1401/data-science-template](https://github.com/khuyentran1401/data-science-template)
