# Python analysis template

This repository can be used as a template for data science projects.
After cloning the repository, you can change:

- The repository name
- The name of the VS code workspace file (`*.code-workspace`).
- Project information in [`pyproject.toml`](pyproject.toml)

## File structure

- Analysis scripts and notebooks should go to [`analysis/`](analysis/)
- Data files should go to [`data/`](data/). By default, files in `data/` are ignored by Git.
- Results/output files (e.g. figures, output data) should go to [`results/`](results/). These files are ignored by Git.
- Reusable functions and modules are stored in the local package [`src/`](src/). The package can then be installed in development mode with `pip install -e .`
- Tests for functions in [`src/`](src/) should go to [`tests/`](tests/) and follow the convention `test_*.py`.

The repository structure could also be extended with:

- `docs/` to store documentation (e.g. of the `src` package). For example, a documentation could be generated using [mkdocs](https://www.mkdocs.org/) or [quartodoc](https://machow.github.io/quartodoc/get-started/overview.html).
- `data-raw/` to store data processing functions whose output is stored in [`data/`](data/). For example when data is scrapped from the web and cleaned before saving it.
- `models/` to store model files.
- `src/constants.py` to store various constants (incl. directory paths).

## Computational environment

To set up the environment with conda, navigate to the repository directory and run the following in the command line:

```
conda create -n myenv python=3.11
conda activate myenv
pip install -e .
```

The environment can then be exported with `conda env export > environment.yml` and recreated with `conda create -n myenv -f environment.yml`.

NB: to access the different folders, I use the `here()` function from the `pyprojroot` package.
For example:

```{python}
from pyprojroot import here

DATA_DIR = here("data")
```

## Development environment

I usually work with Visual Studio code, and I have predefined some settings.
In particular, I use:

- [Black](https://black.readthedocs.io/en/stable/index.html) for formatting.
- Flake8 for linting.
- [Google docstring format](https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html) to document functions and classes, with the help of the autoDocstring extension. 

## Related

This template is inspired by the concept of a [research compendium](https://doi.org/10.1080/00031305.2017.1375986).

This template is relatively simple, and more sophisticated templates are available elsewhere such as the [Cookiecutter Data Science](https://github.com/drivendataorg/cookiecutter-data-science/) template.
