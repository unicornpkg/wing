local shell = shell

if _HOST:find("Recrafted") then
	shell = require("shell")
end

local WING_REPO = "https://raw.githubusercontent.com/unicornpkg/wing/"
local WING_REF  = "main/"
local WING_URL  = WING_REPO .. WING_REF

local folders = {
	"/bin",
	"/lib/unicorn/provider",
	"/etc/unicorn/remotes",
	"/etc/unicorn/remotes/installed",
	"/usr/share/help"
}

local files = {
	"bin/unicorntool.lua",
	"bin/hoof.lua",
	"usr/share/help/unicorntool.txt",
	"usr/share/help/hoof.txt",
	"lib/unicorn/init.lua",
	"lib/unicorn/core.lua",
	"lib/unicorn/util.lua",
	"lib/unicorn/remote.lua",
	"lib/unicorn/semver.lua",
	"lib/unicorn/provider/com.github.gist.lua",
	"lib/unicorn/provider/com.github.lua",
	"lib/unicorn/provider/com.github.release.lua",
	"lib/unicorn/provider/com.gitlab.lua",
	"lib/unicorn/provider/com.pastebin.lua",
	"lib/unicorn/provider/local.generic.lua",
	"lib/unicorn/provider/local.string.lua",
	"lib/unicorn/provider/org.bitbucket.lua",
	"startup/completion-hoof.lua",
	"startup/completion-unicorntool.lua"
}

for _, v in pairs(folders) do
	fs.makeDir(v)
end

local fns = {}
for i, filename in ipairs(files) do
	fns[i] = function()
		print("Request:", filename)
		local handle, err, err_handle = http.get(WING_URL .. filename)
		
		if handle then
			local f_handle, f_err = io.open(filename, 'w')
			if f_handle then
				f_handle:write(handle.readAll())
				f_handle:close()
				handle.close()
				print("Downloaded", filename)
			else
				-- You may wish to hard-fail here instead.
				printError(("Failed to open %s for writing: %s"):format(filename, f_err))
			end
		else
			-- Again, you may wish to hard-fail here instead, with err_handle.readAll()
			printError(("Failed to download %s: %s"):format(filename, err))
			err_handle.close()
		end
	end
end

parallel.waitForAll(table.unpack(fns))

local unicorn = dofile("/lib/unicorn/init.lua")

unicorn.util.fileWrite("https://unicornpkg.github.io/unicornpkg-main", "/etc/unicorn/remotes/90_main.txt")

-- using multiple remotes is broken, this is a band-aid to tempoarily fix it
--[[unicorn.util.fileWrite(
    "https://raw.githubusercontent.com/unicornpkg/libunicornpkg/main/packages/",
    "/etc/unicorn/remotes/30_unicornpkg_updates.txt"
)
--]]
