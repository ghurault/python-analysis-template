FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye

# Install Java Runtime 17 for SonarQube
RUN apt update -y && apt install -y openjdk-17-jre && apt clean
ENV JAVA_HOME=/usr

# Install requirements except editables
COPY requirements.txt /tmp/pip-tmp/
RUN pip install --upgrade pip && \
    grep -vE '(^-e)' /tmp/pip-tmp/requirements.txt > tmp/pip-tmp/clean-reqs.txt && \
    pip --disable-pip-version-check --no-cache-dir install -r tmp/pip-tmp/clean-reqs.txt && \
    rm -rf /tmp/pip-tmp
