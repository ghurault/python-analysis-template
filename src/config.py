"""Configurations."""

# %%
# Imports

import os

import matplotlib.pyplot as plt
import seaborn as sns
from plotnine import theme_set, theme_bw

# %%
# Paths

try:
    from pyprojroot import here
    # Safer to use here() than relying on relative path...

    PROJ_ROOT = here()
except ModuleNotFoundError:
    from pathlib import Path

    PROJ_ROOT = Path(__file__).resolve().parents[1]

DATA_DIR = PROJ_ROOT / "data"
RES_DIR = PROJ_ROOT / "results"

# %%
# MLflow

MLRUNS_DIR = RES_DIR / "mlruns"
TRACKING_URI = "file:///" + MLRUNS_DIR.as_posix()
os.environ["MLFLOW_TRACKING_URI"] = TRACKING_URI

# %%
# Palette and plotting styles

CB_PALETTE = (
    "#999999",
    "#E69F00",
    "#56B4E9",
    "#009E73",
    "#F0E442",
    "#0072B2",
    "#D55E00",
    "#CC79A7",
)
CB_PALETTE = sns.color_palette(CB_PALETTE).as_hex()

CBB_PALETTE = (
    "#000000",
    "#E69F00",
    "#56B4E9",
    "#009E73",
    "#F0E442",
    "#0072B2",
    "#D55E00",
    "#CC79A7",
)
CBB_PALETTE = sns.color_palette(CBB_PALETTE).as_hex()

theme_set(theme_bw(base_size=15))
# Update Matplotlib (and seaborn) defaults
sns.set_palette(CB_PALETTE)
plt.rcParams.update(
    {
        "axes.grid.which": "major",
        "axes.grid": True,
        "grid.color": "#EFEFEF",
        "grid.linewidth": 1,
        "figure.dpi": 300,
    }
)

# %%
