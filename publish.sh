#!/usr/bin/env bash
set -euo pipefail

# Get mtime from install.lua.sfx, to prevent accidentally releasing an old install.lua.sfx (gh cli errors)
TIMESTAMP="$(date -r install.lua.sfx +%s)"

gh release create "$TIMESTAMP" install.lua.sfx --title "" --notes-file /dev/null

## As a test, run the installer like a user would

DATA_DIR="$(mktemp -d)"
echo "# Data dir is $DATA_DIR"
mkdir -p "$DATA_DIR"/{config,computer/0}
craftos --directory "$DATA_DIR" --headless --exec "shell.run('wget run https://unicornpkg.github.io/wing/install.lua'); shell.run('bin/hoof.lua install unix-path-bootstrap'); shell.run('bin/hoof.lua uninstall unix-path-bootstrap'); os.shutdown()"
