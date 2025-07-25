# Keep setup.py to facilitate local package installation in editable mode
# cf. https://setuptools.pypa.io/en/latest/userguide/quickstart.html#development-mode

# ruff: noqa

from setuptools import find_packages, setup

setup(name="src", packages=find_packages())
