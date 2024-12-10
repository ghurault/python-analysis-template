# Python analysis template
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repository serves as a personal template for data science projects.

## File structure

- Analysis scripts and notebooks are located in [`analysis/`](analysis/).
- Reusable functions and modules are stored in the local package [`src/`](src/).
  - The package can then be installed in development mode with `pip install -e .` for easy prototyping.
  - [`src/config.py`](src/config.py) is used to store variables, constants and configurations.
  - The package version is extracted from git tags using [setuptools_scm](https://setuptools-scm.readthedocs.io/en/stable/) following [semantic versioning](https://semver.org/).
- Tests for functions in [`src/`](src/) should go to [`tests/`](tests/) and follow the convention `test_*.py`.

Moreover, I use the following the directories that are (usually) ignored by Git:

- [`data/`](data/) to store data files.
- [`docs/`](docs/) to store API documentation generated with [pdoc](https://pdoc.dev/docs/pdoc.html) by running `scripts/build_docs.sh`.
- [`results/`](results/) to store results/output files such as figures, output data, etc.

## Development environment

> I can set up the environment differently depending on the project.
> The irrelevant sections can be deleted when using the template.

### Requirements

> The following does not apply when managing requirements with conda, see the section below.

The requirements are specified in the following files:

- [`requirements.in`](requirements.in) to specify direct dependencies.
- [`requirements.txt`](requirements.txt) to pin the dependencies (direct and indirect).
This is the file used to recreate the environment from scratch using `pip install -r requirements.txt`.
- [`pyproject.toml`](pyproject.toml) to store the direct dependencies of the `src` package.

The [`requirements.txt`](requirements.txt) file should not be updated manually.
Instead, I use `pip-compile` from [pip-tools](https://pip-tools.readthedocs.io/en/latest/) to generate `requirements.txt`.

#### Initial setup

1. Start with an empty `requirements.txt`.
2. Install pip-tools with `pip install pip-tools`.
3. Compile requirements with `pip-compile` to generate a `requirements.txt` file.
4. Install requirements with `pip-sync` (or `pip install -r requirements.txt`).

NB: the advantage of using `pip-sync` over `pip install -r requirements.txt` is that `pip-sync` will make sure the environment matches `requirements.txt`, i.e. removing packages in the environment but not in `requirements.txt`, if required.

#### Update the environment

- To upgrade packages, run `pip-compile --upgrade`.
- To add new packages, add packages in `requirements.in` and then compile requirements with `pip-compile`.

Then, the environment can be updated with `pip-sync`.

### venv setup

Run `scripts/setup_venv.sh` to setup a Python virtual environment with [venv](https://docs.python.org/3/library/venv.html) and install packages in `requirements.txt`.
By default, the environment is called `.venv` and is created using the default Python interpreter in the current directory.

### Conda setup

To set up the environment with [conda](https://docs.conda.io/projects/conda/en/stable/) (assuming it is already installed), navigate to the repository directory and run the following in the command line (specify the Python version and environment name as appropriate):

```bash
$ conda create -n myenv python=3.11
$ conda activate myenv
$ pip install -r requirements.in
$ pip install -e .
```

Then pin the requirements with:

```bash
$ conda env export > environment.yml
```

Finally, the environment can be recreated with:

```bash
$ conda create -n myenv -f environment.yml
```

### VS Code Dev Containers (Docker)

A Docker container can be used as a development environment.
In VS Code, this can be achieved using [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers), which are configured in the [`.devcontainer`](.devcontainer/) directory.
The environment is automatically built as follows:

1. A Docker image of Python is created with packages installed from `requirements.txt` (except local packages). The Python's version can be edited in the [Dockerfile](Dockerfile).
2. The image is ran in a container and the current directory is mounted.
3. The local packages are installed in the container, along with some VS Code extensions.

To set up the dev container:

1. Install and launch [Docker](https://www.docker.com/).
2. Open the container by using the command palette in VS Code (`Ctrl + Shift + P`) to search for "Dev Containers: Open Folder in Container...".

If needed, the container can be rebuilt by searching for "Dev Containers: Rebuild Container...".

### Setup Git pre-commit hooks

Pre-commit hooks are configured using the [pre-commit](https://pre-commit.com/) tool.
Currently, the hooks consists in formatting with [Black](https://black.readthedocs.io/en/stable/index.html).
When this repository is first initialised, the hooks need to be installed with `pre-commit install`.

## Using the template

> This section can be deleted when using the template.

### Getting started

1. Initialise your GitHub repository with this template. Alternatively, fork (or copy the content of) this repository.
2. Update
   - [ ] project information in [`pyproject.toml`](pyproject.toml), such as the description and the authors.
   - [ ] the repository name (if the template was forked).
   - [ ] the README (title, badges, sections).
   - [ ] the license.
3. Set up your preferred development environment, notably specifying the Python's version.
4. Add a git tag for the inital version with `git tag -a v0.1.0 -m "Initial setup"`, and push it with `git push origin --tags`.

### VS Code

I usually work with Visual Studio code, for which various settings are already predefined.
In particular, I use the following extensions for Python development.

- [Black](https://black.readthedocs.io/en/stable/index.html) for formatting.
- [Flake8](https://flake8.pycqa.org/en/latest/) and [SonarLint](https://marketplace.visualstudio.com/items?itemName=SonarSource.sonarlint-vscode) for linting.
- [autoDocstring extension](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring) to generate docstrings skeleton following the [Google docstring format](https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html).

### Possible extensions

The `src/` package could contain the following modules or sub-packages depending on the project:

- `utils` for utility functions.
- `data_processing` for data processing functions (this could be imported as `dp`).
- `features`: for extracting features.
- `models`: for defining models.
- `evaluation`: for evaluating performance.
- `plots`: for plotting functions.

The repository structure could be extended with:

- subfolders in `data/` such as `data/raw/` for storing raw data.
- `models/` to store model files.

Finally, a full project documentation (beyond the API) could be generated using [mkdocs](https://www.mkdocs.org/) or [quartodoc](https://machow.github.io/quartodoc/get-started/overview.html).

### Related

This template is inspired by the concept of a [research compendium](https://doi.org/10.1080/00031305.2017.1375986) and similar projects I created for R projects (e.g. [reproducible-workflow](https://github.com/ghurault/reproducible-workflow)).

This template is relatively simple and tailored to my needs.
More sophisticated templates are available elsewhere, such as:

- [Cookiecutter Data Science](https://github.com/drivendataorg/cookiecutter-data-science/).
- [https://joserzapata.github.io/data-science-project-template/](https://joserzapata.github.io/data-science-project-template/)
- [Data Science for Social Good's hitchhikers guide template](https://github.com/dssg/hitchhikers-guide/tree/master/sources/curriculum/0_before_you_start/pipelines-and-project-workflow)
- [https://github.com/khuyentran1401/data-science-template](https://github.com/khuyentran1401/data-science-template)

As opposed to other templates, this template is more focused on experimentation rather than sharing a single final product.
