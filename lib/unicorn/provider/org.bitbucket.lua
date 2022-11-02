local unicorn = dofile("/lib/unicorn/init.lua")

--- Package provider for Bitbucket.org.
-- @param package_table table A valid package table
local function install_bitbucket(package_table)
	for k,v in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp("https://bitbucket.org/raw/" .. package_table.instdat.repo_owner .."/".. package_table.instdat.repo_name .."/".. package_table.instdat.repo_ref .."/".. k)
		unicorn.util.fileWrite(http_data, v)
	end
end

return install_bitbucket