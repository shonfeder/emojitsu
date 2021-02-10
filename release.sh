#!/usr/bin/env bash
set -euo pipefail

# TODO Automate version number update

dune-release tag
git push --tags
