"""Configurations.

Usage:

    >>> from src import config
"""

# %%
# Preamble

import logging

from pyprojroot import here

# logging.basicConfig(level=logging.INFO)

logger = logging.getLogger(__name__)

# %%
# Paths

PROJ_ROOT = here()

logger.info(f"PROJ_ROOT path is: {PROJ_ROOT}")

DATA_DIR = PROJ_ROOT / "data"
RES_DIR = PROJ_ROOT / "results"
