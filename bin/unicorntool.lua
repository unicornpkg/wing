local unicorn = dofile("/lib/unicorn/init.lua")

local tArgs = {...}

local command = tArgs[1]
local target = tArgs[2]

if command == "install" or command == "add" then
	local f = dofile(target)
	unicorn.core.install(f)
elseif command == "uninstall" or command == "remove" then
	unicorn.core.uninstall(target)
else
	error("No such command.")
end
