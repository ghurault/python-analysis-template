# Python analysis template

This repository can be used as a template for data science projects.
After cloning the repository, you can change:

- The repository name
- The name of the VS code workspace file
- Project information in [`pyproject.toml`](pyproject.toml)

## File structure

- Analysis scripts and notebooks should go to [`analysis/`](analysis/)
- Data files should go to [`data/`](data/). By default, files in `data/` are ignored by Git.
- Results/output files (e.g. figures, output data) should go to [`results/`](results/). These files are ignored by Git.
- Reusable functions and modules are stored in the local package [`src/`](src/). The package can be installed in development mode with `pip install -e .`
- Tests for functions in [`src/`](src/) should go to [`tests/`](tests/) and follow the convention `test_*.py`.


## Setup computational environment

To set up the environment with conda, navigate to the repository directory and run the following in the command line:

```
conda create -n myenv python=3.11
conda activate myenv
pip install -e .
```

## Development environment

I usually work with Visual Studio code, and I have predefined some settings.
In particular, I use:

- [Black](https://black.readthedocs.io/en/stable/index.html) for formatting.
- Flake8 for linting.
- [Google docstring format](https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html) to document functions and classes, with the help of the autoDocstring extension. 
