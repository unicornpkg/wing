# Wing

Pre-bundled installations of [unicornpkg](https://github.com/unicornpkg/unicornpkg) and its [CLI tools](https://github.com/unicornpkg/cli), ready to use.

## Installation

`wget run` the install.lua file in the repo's root directory. This will bootstrap the directory structure and install the required files.

## For unicornpkg developers
### System outline

The entrypoint for users is `./install.lua`, which downloads the latest `install.lua.sfx` from the GitHub Releases in this directory. 

The `install.lua.sfx` is generated from the `build.sh` script in the repository. Each component of unicornpkg is a Git submodule located in `src`,[^1] and the relevant files are copied into a temporary directory in the correct layout. CraftOS-PC is launched and executes `src/sfx.lua`, which packs everything into `install.lua.sfx`. This file is copied into the repository's working directory by `build.sh`.

The entire release process is executed through GitHub Actions on every push.

If necessary for an unforseen problem, the `./publish.sh` script allows developers to publish the self-extracting archive manually, assuming that the GitHub CLI is available. `publish.sh` also tests that the installer works using CraftOS-PC.

[^1]: The `src/static` directory contains files that will be copied as-is into the temporary directory.
