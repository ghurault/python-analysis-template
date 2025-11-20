FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye

COPY requirements.txt /tmp/pip-tmp/

# Install requirements except editables
RUN pip install --upgrade pip && \
    grep -vE '(^-e)' /tmp/pip-tmp/requirements.txt > tmp/pip-tmp/clean-reqs.txt && \
    pip --disable-pip-version-check --no-cache-dir install -r tmp/pip-tmp/clean-reqs.txt && \
    rm -rf /tmp/pip-tmp
