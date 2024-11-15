"""Configurations.

Usage:

    >>> from src import config
"""

# %%
# Preamble

import logging

from pyprojroot import here

logging.basicConfig(
    format="{asctime} - {levelname} - {name} - {message}",
    style="{",
    datefmt="%Y-%m-%d %H:%M:%S",
)
# The global config should not be redefine
# The config can still be overriden in custom loggers

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# %%
# Paths

PROJ_ROOT = here()

logger.info(f"PROJ_ROOT path is: {PROJ_ROOT}")

DATA_DIR = PROJ_ROOT / "data"
RES_DIR = PROJ_ROOT / "results"

# %%
# Palettes

CB_PALETTE = [
    "#999999",
    "#E69F00",
    "#56B4E9",
    "#009E73",
    "#F0E442",
    "#0072B2",
    "#D55E00",
    "#CC79A7",
]
CBB_PALETTE = CB_PALETTE.copy()
CBB_PALETTE[0] = "#000000"

# %%
