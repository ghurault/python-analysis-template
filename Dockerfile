FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye

RUN pip install --upgrade pip

COPY requirements.txt /tmp/pip-tmp/

# Install requirements except editables
RUN grep -vE '(^-e)' /tmp/pip-tmp/requirements.txt | pip --no-cache-dir install -r /dev/stdin \
    && rm -rf /tmp/pip-tmp
