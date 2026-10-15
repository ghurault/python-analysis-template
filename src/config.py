"""Configurations.

Usage:

    >>> from src import config
"""

# ruff: noqa: F401

# %%
# Imports

import logging
import os

from src.constants import CB_PALETTE, CBB_PALETTE, DATA_DIR, PROJ_ROOT, RES_DIR

# %%
# Logging

logging.basicConfig(
    format="{asctime} - {levelname} - {name} - {message}",
    style="{",
    datefmt="%Y-%m-%d %H:%M:%S",
)
# The global config should not be redefined
# The config can still be overridden in custom loggers

logging.captureWarnings(True)

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

logger.info("PROJ_ROOT path is: %s", PROJ_ROOT)

# %%
# Plotting defaults

os.environ.setdefault("MATPLOTLIBRC", str(PROJ_ROOT / "matplotlibrc"))

try:
    import matplotlib as mpl

    # MATPLOTLIBRC is only read on matplotlib's first import, which may precede this one
    mpl.rc_file(mpl.matplotlib_fname())
except ModuleNotFoundError:
    pass

try:
    from plotnine import theme_bw, theme_set  # type: ignore

    theme_set(theme_bw(base_size=15))
except ModuleNotFoundError:
    pass

# %%

logger.info("All configurations have been set.")

# %%
