local shell = require("craftos.shell")

local WING_REPO = "https://raw.githubusercontent.com/unicornpkg/wing/"
local WING_REF  = "main/"
local WING_URL  = WING_REPO .. WING_REF

shell.run("mkdir bin")
shell.run("mkdir lib/unicorn/provider")
shell.run("mkdir share/help")
shell.run("mkdir etc/unicorn/remotes")
shell.run("mkdir etc/unicorn/packages/installed")
shell.run("wget " .. WING_URL .. "bin/unicorntool.lua bin/unicorntool.lua")
shell.run("wget " .. WING_URL .. "bin/hoof.lua bin/hoof.lua")
shell.run("wget " .. WING_URL .. "lib/unicorn/init.lua lib/unicorn/init.lua")
shell.run("wget " .. WING_URL .. "lib/unicorn/core.lua lib/unicorn/core.lua")
shell.run("wget " .. WING_URL .. "lib/unicorn/util.lua lib/unicorn/util.lua")
shell.run("wget " .. WING_URL .. "lib/unicorn/remote.lua lib/unicorn/remote.lua")

-- providers
shell.run("wget " .. WING_URL .. "lib/unicorn/provider/com.github.lua lib/unicorn/provider/com.github.lua")
shell.run("wget " .. WING_URL .. "lib/unicorn/provider/com.github.gist.lua lib/unicorn/provider/com.github.gist.lua")
shell.run("wget " .. WING_URL .. "lib/unicorn/provider/com.gitlab.lua lib/unicorn/provider/com.gitlab.lua")
shell.run("wget " .. WING_URL .. "lib/unicorn/provider/com.pastebin.lua lib/unicorn/provider/com.pastebin.lua")
-- :salute:
-- shell.run("wget " .. WING_URL .. "lib/unicorn/provider/dev.devbin.lua lib/unicorn/provider/dev.devbin.lua")
shell.run("wget " .. WING_URL .. "lib/unicorn/provider/org.bitbucket.lua lib/unicorn/provider/org.bitbucket.lua")

local unicorn = dofile("/lib/unicorn/init.lua")

unicorn.util.fileWrite("https://unicornpkg.github.io/unicornpkg-main", "/etc/unicorn/remotes/90_main.txt")

-- using multiple remotes is broken, this is a band-aid to tempoarily fix it
--[[unicorn.util.fileWrite(
    "https://raw.githubusercontent.com/unicornpkg/libunicornpkg/main/packages/",
    "/etc/unicorn/remotes/30_unicornpkg_updates.txt"
)
--]]
