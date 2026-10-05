ARG PYTHON_VERSION=3.13

FROM mcr.microsoft.com/devcontainers/python:${PYTHON_VERSION}-bookworm

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install requirements except editables
COPY requirements.txt /tmp/pip-tmp/
# hadolint ignore=DL3013
RUN pip install --no-cache-dir --upgrade pip \
    && grep -vE '(^-e)' /tmp/pip-tmp/requirements.txt > /tmp/pip-tmp/clean-reqs.txt \
    && pip --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/clean-reqs.txt \
    && rm -rf /tmp/pip-tmp
