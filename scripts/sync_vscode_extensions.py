"""Sync VS Code extension recommendations from the devcontainer config."""

import argparse
import json
from pathlib import Path

import json5

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / ".devcontainer" / "devcontainer.json"
TARGET = ROOT / ".vscode" / "extensions.json"


def main() -> int:
    """Write recommendations or check whether the generated file is current."""
    parser = argparse.ArgumentParser()
    parser.add_argument("--write", action="store_true")
    args = parser.parse_args()

    config = json5.loads(SOURCE.read_text(encoding="utf-8"))
    extensions = config["customizations"]["vscode"]["extensions"]
    if not isinstance(extensions, list) or not all(
        isinstance(extension, str) for extension in extensions
    ):
        raise ValueError("customizations.vscode.extensions must be a list of strings")

    source_extensions = set(extensions)

    if args.write:
        expected = (
            json.dumps(
                {"recommendations": sorted(source_extensions)},
                indent=2,
            )
            + "\n"
        )
        TARGET.write_text(expected, encoding="utf-8")
        return 0

    target_config = json.loads(TARGET.read_text(encoding="utf-8"))
    recommendations = target_config["recommendations"]
    if not isinstance(recommendations, list) or not all(
        isinstance(recommendation, str) for recommendation in recommendations
    ):
        raise ValueError("recommendations must be a list of strings")

    if set(recommendations) != source_extensions:
        print("VS Code extension recommendations are out of date; run with --write.")
        return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
