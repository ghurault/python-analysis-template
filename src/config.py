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
# Palettes and plotting configurations

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

# To update matplotlib style, e.g. with matplotlib.rc_context(STYLE_GRID)
STYLE_GRID = {
    "axes.grid.which": "major",
    "axes.grid": True,
    "grid.color": "#EFEFEF",
    "grid.linewidth": 1,
}

try:
    import matplotlib.pyplot as plt
    import seaborn as sns

    CB_PALETTE = sns.color_palette(CB_PALETTE).as_hex()
    CBB_PALETTE = sns.color_palette(CBB_PALETTE).as_hex()

    # Update Matplotlib (and seaborn) defaults
    sns.set_palette(CB_PALETTE)
    plt.rcParams.update({"figure.dpi": 300})

except ImportError:
    pass

try:
    from plotnine import theme_set, theme_bw

    theme_set(theme_bw(base_size=15))
except ImportError:
    pass

# %%
