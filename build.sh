#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(git rev-parse --show-toplevel)"
STATIC_DIR="$SOURCE_DIR/src/static"
LIBUNICORNPKG_DIR="$SOURCE_DIR/src/libunicornpkg"
CLI_DIR="$SOURCE_DIR/src/cli"


echo "# Source dir is $SOURCE_DIR"
echo "# CraftOS-PC is $(which craftos)"

DATA_DIR="$(mktemp -d)"
echo "# Data dir is $DATA_DIR"
mkdir -p "$DATA_DIR"/{config,computer/0}
cp "$SOURCE_DIR"/craftos/global.json "$DATA_DIR"/config/global.json

COMPUTER_DIR="$DATA_DIR/computer/0"
cp "$SOURCE_DIR"/craftos/settings "$COMPUTER_DIR"/.settings
mkdir -p "$COMPUTER_DIR"/env/{lib,bin,usr/share/help}
mkdir -p "$COMPUTER_DIR"/test
cp "$SOURCE_DIR/src/sfx.lua" "$COMPUTER_DIR/sfx.lua"

cp -r "$STATIC_DIR/"* "$COMPUTER_DIR/env"

cp -r "$LIBUNICORNPKG_DIR/unicorn" "$COMPUTER_DIR/env/lib"

# TODO: Use packages and libunicornpkg to install the CLI
cp "$CLI_DIR/hoof/init.lua" "$COMPUTER_DIR/env/bin/hoof.lua"
cp "$CLI_DIR/unicorntool/init.lua" "$COMPUTER_DIR/env/bin/unicorntool.lua"

# cp "$CLI_DIR/hoof/help.txt" "$COMPUTER_DIR/env/usr/share/help/hoof.txt"
# cp "$CLI_DIR/unicorntool/help.txt" "$COMPUTER_DIR/env/usr/share/help/unicorntool.txt"

cp -r "$SOURCE_DIR" "$COMPUTER_DIR/source"

craftos --directory "$DATA_DIR" --headless --exec "shell.run('sfx.lua env install.lua.sfx'); shell.run('install.lua.sfx test') os.shutdown()"

cp "$COMPUTER_DIR/install.lua.sfx" ./.
