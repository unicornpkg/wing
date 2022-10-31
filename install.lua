local BASE_REPO = "https://raw.githubusercontent.com/unicornpkg/"
local BASE_REF = "main/"
local LIB_URL = BASE_REPO.."unicornpkg/"..BASE_REF.."unicorn/"
local UNICORNTOOL_URL = BASE_REPO.."cli/"..BASE_REF.."unicorntool/"

local shell = shell

shell.run("mkdir /bin")
shell.run("mkdir /lib/unicorn")
shell.run("mkdir /share/help")
shell.run("mkdir /tmp")
shell.run("wget "..UNICORNTOOL_URL.."init.lua bin/unicorntool.lua")
shell.run("wget "..LIB_URL.."init.lua lib/unicorn/init.lua")
shell.run("wget "..LIB_URL.."core.lua lib/unicorn/core.lua")
shell.run("wget "..LIB_URL.."util.lua lib/unicorn/util.lua")
