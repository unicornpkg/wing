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
		local tries = 0

		while tries < 5 do
			tries = tries + 1
			print("Request:", filename)
			local handle, err, errHandle = http.get(WING_URL .. filename)

			if handle then
				local fileHandle, fileErr = io.open(filename, 'w')
				if fileHandle then
					fileHandle:write(handle.readAll())
					fileHandle:close()
					handle.close()
					print("Downloaded", filename)

					return
				else
					printError("Failed to open", filename, "for writing:", fileErr)
				end
			else
				printError("Failed to download", filename, ":", err)

				if errHandle.getResponseCode() ~= 404 then
					printError("Failed to download", filename, ": 404 Not Found")
					errHandle.close()
					return
				end

				errHandle.close()
			end

			printError(("Retrying in %d second%s..."):format(tries * 2, tries > 1 and "s" or ""))
			sleep(tries * 2)
		end

		printError("Failed to download", filename, "after 5 tries.")
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
