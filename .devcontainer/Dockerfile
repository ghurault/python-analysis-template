FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye

RUN pip install --upgrade pip

COPY requirements.txt /tmp/pip-tmp/

RUN pip --no-cache-dir install -r /tmp/pip-tmp/requirements.txt && rm -rf /tmp/pip-tmp
