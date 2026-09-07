ARG PYTHON_VERSION=3.13

FROM mcr.microsoft.com/devcontainers/python:${PYTHON_VERSION}-bookworm

# Install Java Runtime 17 for SonarQube
# hadolint ignore=DL3008
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends openjdk-17-jre \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME=/usr

# Install requirements except editables
COPY requirements.txt /tmp/pip-tmp/
# hadolint ignore=DL3013
RUN pip install --no-cache-dir --upgrade pip \
    && grep -vE '(^-e)' /tmp/pip-tmp/requirements.txt > /tmp/pip-tmp/clean-reqs.txt \
    && pip --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/clean-reqs.txt \
    && rm -rf /tmp/pip-tmp
