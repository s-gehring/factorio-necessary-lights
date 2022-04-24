#!/usr/bin/env bash

set -euo pipefail

TARGET_FOLDER_PATH="$APPDATA/Factorio/mods/necessary-lights_0.0.1"
STEAM="/d/Spiele/Steam/steam.exe"

(rm -rf "${TARGET_FOLDER_PATH:?}" && echo "Successfully cleaned folder from old files.") || echo "Failed removing files. Is Factorio still running?"
mkdir "$TARGET_FOLDER_PATH"
cp src/* "$TARGET_FOLDER_PATH"

$STEAM steam://rungameid/427520 # Factorio Steam ID