# Development Environment

## VS Code Dev Containers

In VS Code, a Docker container can be used as a development environment using [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers).
The Dev Container is configured in the [`.devcontainer`](.devcontainer/) directory.
The environment is automatically built as follows:

1. A Docker image of Python is created with packages installed from `requirements.txt` (except local packages). The Python's version can be edited in the [Dockerfile](Dockerfile).
2. The image is run in a container and the current directory is mounted.
3. The local packages are installed in the container, along with some VS Code extensions.

NB: Python packages in `requirements.txt` are installed in the global location of the Docker image.
However, within the container (unless logging in as a root user), packages are installed in the user location and packages in the global location cannot be updated/removed.

### Private Git packages

If `requirements.txt` contains Python packages in private Git repositories, it is easier to install them in the devcontainer post-creation step since Git credentials used in VSC are shared with the devcontainer (alternatively, credentials have to be made available in the Dockerfile).

One way to achieve this is to exclude git packages from being installed in the Docker image and update the devcontainer post-creation step to install these packages, similarly to how local package are excluded.

For example, in the [`Dockerfile`](Dockerfile):

```docker
RUN grep -vE '(^-e|@ ?git ?+)' /tmp/pip-tmp/requirements.txt | pip --no-cache-dir install -r /dev/stdin
```

And in [`devcontainer.json`](.devcontainer/devcontainer.json):

```json
"postCreateCommand": "grep -E '(^-e|@ ?git ?+)' requirements.txt | pip install -r /dev/stdin"
```

## Alternative environments

While the preferred setup uses Docker (via VS Code Dev Containers) to ensure full environment reproducibility, other Python environments (e.g. virtualenv, Conda) are also supported.

This template relies on a pinned `requirements.txt` file for dependency management.
This approach is broadly compatible and should work across different tools and platforms.

Below are setup instructions for some alternatives to Docker.

### venv setup

Run `scripts/setup_venv.sh` (or `make venv`) to set up a Python virtual environment with [venv](https://docs.python.org/3/library/venv.html), install dependencies in `requirements.txt` and the local package.
By default, the environment is called `.venv` and is created using the default Python interpreter in the current directory.

### Conda setup

To set up the environment with [Conda](https://docs.conda.io/projects/conda/en/stable/) (assuming it is already installed), navigate to the repository directory and run `scripts/setup_conda.sh` (specify the Python version and environment name as appropriate with the `-p` argument):

Then pin the requirements with:

```bash
conda env export > environment.yml
```

Finally, the environment can be recreated with:

```bash
conda create -n myenv -f environment.yml
```
