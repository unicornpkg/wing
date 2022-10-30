local WING_REPO = "https://raw.githubusercontent.com/unicornpkg/wing/"
local WING_REF = "main/"
local WING_URL = WING_REPO..WING_REF

shell.run("mkdir bin")
shell.run("mkdir lib/unicorn")
shell.run("wget "..WING_URL.."bin/unicorntool.lua bin/unicorntool.lua")
shell.run("wget "..WING_URL.."lib/unicorn/init.lua lib/unicorn/init.lua")
shell.run("wget "..WING_URL.."lib/unicorn/core.lua lib/unicorn/core.lua")
shell.run("wget "..WING_URL.."lib/unicorn/util.lua lib/unicorn/util.lua")
