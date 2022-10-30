#!/usr/bin/env just --justfile

set export

TEMP_DIR := `mktemp -d`
WING_DIR := `pwd`

default: bundle-all

setup-dirs:
	-mkdir bin
	-mkdir lib
	-mkdir tmp

bundle-cli: setup-dirs
	#!/usr/bin/env bash
	wget https://raw.githubusercontent.com/unicornpkg/cli/main/unicorntool/init.lua $WING_DIR/bin/unicorntool.lua
	mv init.lua bin/unicorntool.lua

bundle-lib: setup-dirs
	#!/usr/bin/env bash
	cd tmp
	git clone https://github.com/unicornpkg/unicornpkg
	cd unicornpkg && git pull
	rm -rf ../lib/unicorn
	mv ./unicorn ../lib/unicorn

bundle-all: bundle-lib bundle-cli
	#!/usr/bin/env bash
	rm -rf tmp

