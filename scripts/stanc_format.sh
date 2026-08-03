#!/usr/bin/env sh
set -e

if ! command -v stanc > /dev/null 2>&1; then
  echo "ERROR: stanc not found." >&2
  echo "Install CmdStan (e.g. via cmdstanpy) to enable Stan formatting." >&2
  exit 1
fi

for f in "$@"; do
  stanc \
    --auto-format \
    --max-line-length=100 \
    --canonicalize=parentheses,braces \
    --include-paths="$(dirname "$f")" \
    --o "$f" \
    "$f"
done
