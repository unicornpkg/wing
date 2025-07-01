local TIMESTAMP = '1747884192'
fs.makeDir("/tmp")
shell.run("wget https://github.com/unicornpkg/wing/releases/download/" .. TIMESTAMP .. "/install.lua.sfx /tmp/install.lua.sfx")
shell.run("/tmp/install.lua.sfx /")
shell.run("rm /tmp/install.lua.sfx")
