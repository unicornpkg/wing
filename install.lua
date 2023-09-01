local TIMESTAMP = '1693605888'
fs.makeDir("/tmp")
shell.run("wget https://github.com/unicornpkg/wing/releases/download/" .. TIMESTAMP .. "/install.lua /tmp/install.lua")
shell.run("/tmp/install.lua /")
shell.run("rm /tmp/install.lua")
