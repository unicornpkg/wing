--- Installer for wing
-- This program's strategy is to bootstrap the bare minimum required for `unicornpkg` to work,
-- and then to install everything else.

print("WARNING: This installer is not for public use.")
print("There are no stability guarantees.")

local shell = shell

if _HOST:find("Recrafted") then
	shell = require("shell")
end

local REPO = "https://raw.githubusercontent.com/unicornpkg/libunicornpkg/"
local REF  = "v1.0.0/"
local URL  = REPO .. REF

local PACKAGES = "https://raw.githubusercontent.com/unicornpkg/wing/main/packages/"

local folders = {
	"/bin",
	"/lib/unicorn/provider",
	"/etc/unicorn/remotes",
	"/etc/unicorn/remotes/installed",
	"/usr/share/help"
}

local files = {
	["unicorn/init.lua"] = "/lib/unicorn/init.lua",
	["unicorn/core.lua"] = "/lib/unicorn/core.lua",
	["unicorn/util.lua"] = "/lib/unicorn/util.lua",
	["unicorn/remote.lua"] = "/lib/unicorn/remote.lua",
	["unicorn/provider/com.github.lua"] = "/lib/unicorn/provider/com.github.lua",
	["unicorn/semver.lua"] = "/lib/unicorn/semver.lua"
}

for _, v in pairs(folders) do
	shell.run("mkdir " .. v)
end

for k, v in pairs(files) do
	shell.run("wget " .. URL .. k .. " " .. v)
end

local unicorn = dofile("/lib/unicorn/init.lua")

local install_packages = {
	loadstring(unicorn.util.smartHttp(PACKAGES .. "semver.lua"))(),
	loadstring(unicorn.util.smartHttp(PACKAGES .. "unicornpkg.lua"))(),
	loadstring(unicorn.util.smartHttp(PACKAGES .. "unicornpkg-provider-github.lua"))(),
	loadstring(unicorn.util.smartHttp(PACKAGES .. "unicornpkg-provider-github-releases.lua"))(),
	loadstring(unicorn.util.smartHttp(PACKAGES .. "unicornpkg-provider-github-gist.lua"))(),
	loadstring(unicorn.util.smartHttp(PACKAGES .. "unicornpkg-provider-gitlab.lua"))(),
	loadstring(unicorn.util.smartHttp(PACKAGES .. "unicornpkg-provider-pastebin.lua"))(),
	loadstring(unicorn.util.smartHttp(PACKAGES .. "unicornpkg-provider-bitbucket.lua"))(),
	loadstring(unicorn.util.smartHttp(PACKAGES .. "unicornpkg-provider-generic.lua"))(),
	loadstring(unicorn.util.smartHttp(PACKAGES .. "unicornpkg-provider-string.lua"))(),
	loadstring(unicorn.util.smartHttp(PACKAGES .. "unicorntool.lua"))(),
	loadstring(unicorn.util.smartHttp(PACKAGES .. "hoof.lua"))(),
}

for _, v in pairs(install_packages) do
	unicorn.core.install(v)
end

-- setup default package remote
unicorn.util.fileWrite("https://unicornpkg.github.io/unicornpkg-main", "/etc/unicorn/remotes/90_main.txt")
