"""Configurations.

Usage:

    >>> from src import config
"""

# ruff: noqa: F401

# %%
# Imports

import logging

from src.constants import CB_PALETTE, CBB_PALETTE, DATA_DIR, PROJ_ROOT, RES_DIR

# %%
# Logging

logging.basicConfig(
    format="{asctime} - {levelname} - {name} - {message}",
    style="{",
    datefmt="%Y-%m-%d %H:%M:%S",
)
# The global config should not be redefine
# The config can still be overridden in custom loggers

logging.captureWarnings(True)

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

logger.info("PROJ_ROOT path is: %s", PROJ_ROOT)

# %%
# Plotting defaults

# os.environ["MATPLOTLIBRC"] = str(PROJ_ROOT / "matplotlibrc")

# %%

logger.info("All configurations have been set.")

# %%
