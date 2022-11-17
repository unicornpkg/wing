#!/usr/bin/env just --justfile

set export

default: bundle-all

setup-dirs:
	-mkdir bin
	-mkdir lib
	-mkdir tmp

bundle-all: setup-dirs
	git submodule init && git submodule update
	ln -sr .submodules/libunicorn ./lib/unicorn
	ln -sr .submodules/cli/hoof/init.lua ./bin/hoof.lua
	ln -sr .submodules/cli/unicorntool/init.lua ./bin/unicorntool.lua
	ln -sr .submodules/cli/hoof/help.txt ./usr/share/help/hoof.txt
	ln -sr .submodules/cli/unicorntool/help.txt ./usr/share/help/unicorntool.txt



