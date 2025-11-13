fs.makeDir("/tmp")
shell.run("wget https://github.com/unicornpkg/wing/releases/latest/download/install.lua.sfx /tmp/install.lua.sfx")
shell.run("/tmp/install.lua.sfx /")
shell.run("rm /tmp/install.lua.sfx")

package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")
unicorn.remote.install("semver")
unicorn.remote.install("sha256")
