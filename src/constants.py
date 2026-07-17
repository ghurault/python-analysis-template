"""Constants."""

# Constants are better defined here than in config.py to avoid side effects in modules
# that require these constants.

# %%
# Imports

from pathlib import Path

# %%
# Paths

PROJ_ROOT = Path(__file__).resolve().parents[1]

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
