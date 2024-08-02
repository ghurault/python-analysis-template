# Python analysis template
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repository serves as a personal template for data science projects.

## File structure

- Analysis scripts and notebooks are located in [`analysis/`](analysis/).
- Reusable functions and modules are stored in the local package [`src/`](src/).
  - The package can then be installed in development mode with `pip install -e .` for easy prototyping.
  - [`src/config.py`](src/config.py) can be used to store variables, constants and configurations.
- Tests for functions in [`src/`](src/) should go to [`tests/`](tests/) and follow the convention `test_*.py`.

Moreover, I use the following the directories that are (usually) ignored by Git:

- [`data/`](data/) to store data files.
- [`results/`](results/) to store results/output files such as figures, output data, etc.

## Using the template
*This section can be deleted when using the template.*

### Getting started

First clone/fork/copy the repository.
Then, you should update:

- the repository name
- project information in [`pyproject.toml`](pyproject.toml)
- the README
- the license 

### Computational environment

To set up the environment with conda, navigate to the repository directory and run the following in the command line (specify the Python version and environment name as appropriate):

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

### Development environment

I usually work with Visual Studio code, for which various settings are already predefined.
In particular, I use:

- [Black](https://black.readthedocs.io/en/stable/index.html) for formatting.
- [Flake8](https://flake8.pycqa.org/en/latest/) and [SonarLint](https://marketplace.visualstudio.com/items?itemName=SonarSource.sonarlint-vscode) for linting.
- [Google docstring format](https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html) to document functions and classes, with the help of the [autoDocstring extension](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring). 

### Possible extensions

The repository structure could be extended with:

- `docs/` to store documentation (e.g. of the `src` package). For example, a documentation could be generated using [mkdocs](https://www.mkdocs.org/) or [quartodoc](https://machow.github.io/quartodoc/get-started/overview.html).
- `data-raw/` to store data processing functions whose output is stored in [`data/`](data/). For example when data is scrapped from the web and cleaned before saving it.
- `models/` to store model files.

### Related

This template is inspired by the concept of a [research compendium](https://doi.org/10.1080/00031305.2017.1375986).

This template is relatively simple and tailored to my needs.
More sophisticated templates are available elsewhere, such as the [Cookiecutter Data Science](https://github.com/drivendataorg/cookiecutter-data-science/) template.
