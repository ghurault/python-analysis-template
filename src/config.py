"""Configurations.

Usage:

    >>> from src import config
"""

# %%
# Preamble

import logging
from pathlib import Path

logging.basicConfig(
    format="{asctime} - {levelname} - {name} - {message}",
    style="{",
    datefmt="%Y-%m-%d %H:%M:%S",
)
# The global config should not be redefine
# The config can still be overridden in custom loggers

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# %%
# Paths

PROJ_ROOT = Path(__file__).resolve().parents[1]

logger.info("PROJ_ROOT path is: %s", PROJ_ROOT)

DATA_DIR = PROJ_ROOT / "data"
RES_DIR = PROJ_ROOT / "results"

# %%
# Palettes and plotting defaults

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

# os.environ["MATPLOTLIBRC"] = str(PROJ_ROOT / "matplotlibrc")

# %%

logger.info("All configurations have been set.")

# %%
