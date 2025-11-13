fs.makeDir("/tmp")
shell.run("wget https://github.com/unicornpkg/wing/releases/latest/download/install.lua.sfx /tmp/install.lua.sfx")
shell.run("/tmp/install.lua.sfx /")
shell.run("rm /tmp/install.lua.sfx")
