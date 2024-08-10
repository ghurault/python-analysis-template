"""Configurations.

Usage:

    >>> from src import config
"""

# %%
# Paths

try:
    from pyprojroot import here
    # Safer to use here() than relying on relative path

    PROJ_ROOT = here()
except ModuleNotFoundError:
    from pathlib import Path

    PROJ_ROOT = Path(__file__).resolve().parents[1]

DATA_DIR = PROJ_ROOT / "data"
RES_DIR = PROJ_ROOT / "results"
