local completion = require("cc.shell.completion")
local unicorn = dofile("/lib/unicorn/init.lua")

local tArgs = {...}

local command = tArgs[1]
local target = tArgs[2]

local usage = [[hoof - tool for interacting with unicornpkg remotes

Usage:

hoof install package
hoof uninstall package

See also:

help unicorntool
help hoof
]]


local function complete()
	local completion = require "cc.shell.completion"
	shell.setCompletionFunction(shell.getRunningProgram(), 
	completion.build(
		{ completion.choice, { "install", "uninstall" } }
		)
	)
	shell.setCompletionFunction(shell.getRunningProgram() .. " install", 
	completion.build(
		completion.file
		)
	)
end

complete()

if command == "install" or command == "add" then
	unicorn.remote.install(target)
elseif command == "uninstall" or command == "remove" then
	unicorn.core.uninstall(target)
end

