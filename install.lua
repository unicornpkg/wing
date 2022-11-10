local WING_REPO = "https://raw.githubusercontent.com/unicornpkg/wing/"
local WING_REF = "main/"
local WING_URL = WING_REPO..WING_REF

shell.run("mkdir bin")
shell.run("mkdir lib/unicorn/provider")
shell.run("mkdir share/help")
shell.run("mkdir etc/unicorn/remotes")
shell.run("mkdir etc/unicorn/packages/installed")
shell.run("wget "..WING_URL.."bin/unicorntool.lua bin/unicorntool.lua")
shell.run("wget "..WING_URL.."bin/hoof.lua bin/hoof.lua")
shell.run("wget "..WING_URL.."lib/unicorn/init.lua lib/unicorn/init.lua")
shell.run("wget "..WING_URL.."lib/unicorn/core.lua lib/unicorn/core.lua")
shell.run("wget "..WING_URL.."lib/unicorn/util.lua lib/unicorn/util.lua")
shell.run("wget "..WING_URL.."lib/unicorn/remote.lua lib/unicorn/remote.lua")
shell.run("wget "..WING_URL.."lib/unicorn/provider/com.github.lua lib/unicorn/provider/com.github.lua")

local unicorn = dofile("/lib/unicorn/init.lua")

unicorn.util.fileWrite("https://unicornpkg.github.io/unicornpkg-main", "/etc/unicorn/remotes/90_main.txt")
-- multiple remotes are broken, this is a temporary hotfix
--unicorn.util.fileWrite("https://raw.githubusercontent.com/unicornpkg/libunicornpkg/main/packages/", "/etc/unicorn/remotes/30_unicornpkg_updates.txt")

