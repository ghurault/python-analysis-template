# Development Environment

## VS Code Dev Containers

In VS Code, a Docker container can be used as a development environment using [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers).
The Dev Container is configured in the [`.devcontainer`](.devcontainer/) directory.
The environment is automatically built as follows:

1. A Docker image is created with packages from `requirements.txt` (except local packages); its base image and Python version are configured in [`.devcontainer`](.devcontainer/).
2. The image is run in a container with the current directory mounted, and optional Dev Container features.
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

## venv fallback

The recommended setup is the VS Code Dev Container.
You can use `venv` when Docker is unavailable or when you prefer a lightweight local environment.

Run `scripts/setup_venv.sh` (or `make venv`) to set up a Python virtual environment with [venv](https://docs.python.org/3/library/venv.html), install dependencies in `requirements.txt` and the local package.
By default, the environment is called `.venv` and is created using the default Python interpreter in the current directory.
Activate it in each new shell with `source .venv/bin/activate` (in Windows PowerShell, use `.\.venv\Scripts\Activate.ps1`).

The `venv` setup reuses the pinned Python dependencies and installs the local package in editable mode, but it is not a substitute for the container.
It uses your selected host Python and operating system.
Compared with the Dev Container, it does not provide:

- A controlled operating-system environment or isolation from system-level dependencies on the host.
- Container-configured features, development tools, or VS Code extensions.
- Automatic execution of container lifecycle commands. Perform any needed setup manually, such as running `pre-commit install` to enable Git hooks.
- Container-specific environment variables. Configure equivalent values in your shell or VS Code environment if needed.

As a newer alternative to using Python's built-in `venv` directly, [uv](https://docs.astral.sh/uv/) can create an environment with `uv venv` and install pinned dependencies with `uv pip install -r requirements.txt`.

More generally, because this template relies on a pinned `requirements.txt` file for dependency management, it should be broadly compatible with different tools and platforms.
