# Python analysis template
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repository serves as a personal template for data science projects.

## File structure

- Analysis scripts and notebooks are located in [`analysis/`](analysis/).
- Reusable functions and modules are stored in the local package [`src/`](src/).
  - The package can then be installed in development mode with `pip install -e .` for easy prototyping.
  - [`src/config.py`](src/config.py) is used to store variables, constants and configurations.
- Tests for functions in [`src/`](src/) should go to [`tests/`](tests/) and follow the convention `test_*.py`.

Moreover, I use the following the directories that are (usually) ignored by Git:

- [`data/`](data/) to store data files.
- [`results/`](results/) to store results/output files such as figures, output data, etc.

## Development environment

> I can set up the environment differently depending on the project.
> The irrelevant sections can be deleted when using the template.

### venv setup
 
To setup a Python virtual environment with [venv](https://docs.python.org/3/library/venv.html), using the currently installed Python's version, navigate to the repository directory and run the following in the command line:

Alternatively, a virtual environment (`.venv`) can be initialised with:

```bash
$ python -m venv .venv
$ source .venv/Scripts/activate
$ pip install -e .
```

The environment can be exported with the usual `pip freeze > requirements.txt` and recreated with `pip install -r requirements.txt`.

### Conda setup

To set up the environment with [conda](https://docs.conda.io/projects/conda/en/stable/) (assuming it is already installed), navigate to the repository directory and run the following in the command line (specify the Python version and environment name as appropriate):

```bash
$ conda create -n myenv python=3.11
$ conda activate myenv
$ pip install -e .
```

The environment can then be exported and recreated with:

```bash
$ conda env export > environment.yml
$ conda create -n myenv -f environment.yml
```

### VS Code Dev Containers (Docker)

A Docker container can be used as a development environment.
In VS Code, this can be achieved using [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers), which are configured in the [`.devcontainer`](.devcontainer/) directory.
Essentially, a Docker image of Python is created (with optional requirements), and the current directory is mounted in the corresponding container.
The Python Docker image can be changed by modifying the [Dockerfile](Dockerfile).

To set up the dev container:

1. Install [Docker](https://www.docker.com/) and run it.
2. Open the container by using the command palette in VS Code (`Ctrl + Shift + P`) to search for "Dev Containers: Open Folder in Container...".

If needed, the container can be rebuilt by searching for "Dev Containers: Rebuild Container...".

## Using the template

> This section can be deleted when using the template.

### Getting started

First clone/fork/copy the repository (on GitHub, you can use it as a template directly).
Then, you should update:

- the repository name
- project information in [`pyproject.toml`](pyproject.toml)
- the README
- the license 

Finally, you can set up your preferred development environment (see above).

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

- `docs/` to store documentation (e.g. of the `src` package). For example, a documentation could be generated using [mkdocs](https://www.mkdocs.org/) or [quartodoc](https://machow.github.io/quartodoc/get-started/overview.html).
- subfolders in `data/` such as `data/raw/` for storing raw data.
- `models/` to store model files.

### Related

This template is inspired by the concept of a [research compendium](https://doi.org/10.1080/00031305.2017.1375986) and similar projects I created for R projects (e.g. [reproducible-workflow](https://github.com/ghurault/reproducible-workflow)).

This template is relatively simple and tailored to my needs.
More sophisticated templates are available elsewhere, such as:

- [Cookiecutter Data Science](https://github.com/drivendataorg/cookiecutter-data-science/).
- [https://joserzapata.github.io/data-science-project-template/](https://joserzapata.github.io/data-science-project-template/)
- [Data Science for Social Good's hitchhikers guide template](https://github.com/dssg/hitchhikers-guide/tree/master/sources/curriculum/0_before_you_start/pipelines-and-project-workflow)
- [https://github.com/khuyentran1401/data-science-template](https://github.com/khuyentran1401/data-science-template)

As opposed to other templates, this template is more focused on experimentation rather than sharing a single final product.
