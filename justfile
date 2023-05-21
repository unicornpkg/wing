#!/usr/bin/env just --justfile

set export
default: bundle

setup:
  #!/usr/bin/env zsh
  rm -rf ./build
  mkdir -p ./build/src/{bin,lib,share,etc}

copy-cli: setup
  #!/usr/bin/env zsh
  cp ./src/cli/unicorntool/init.lua ./build/src/bin/unicorntool.lua
  cp ./src/cli/hoof/init.lua ./build/src/bin/hoof.lua
  cp -r ./src/cli/docs/man ./build/src/share/help

copy-lib: setup
  #!/usr/bin/env zsh
  cp -r ./src/libunicornpkg/unicorn ./build/src/lib/unicorn

copy: copy-lib copy-cli

minimize: copy
  #!/usr/bin/env zsh
  for i in $(fd --base-directory ./build/src '^.*\.lua$'); do
    darklua minify ./build/src/$i ./build/$i
  done

bundle: minimize
  #!/usr/bin/env zsh
  cd ./build/src
  vfstool-rs -d ./ -a ../archive.sea --self-extracting

tag:
  #!/usr/bin/env zsh
  git tag `date +%s`

