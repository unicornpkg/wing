-- Source: https://pastebin.com/rxnjypsW
tArgs = { ... }

if #tArgs ~= 2 then
	print( "Usage= sfx <directory> <archivename>" )
	return
end

local sfxFiles = ""
local sfxDirs = ""

root = tArgs[1] .. "/"

function serDir(path)
  print("dir  " .. root .. path)
  local files = fs.list(root .. path) 
  for _,file in ipairs( files ) do 
    local fpath = path .. file    
    if fs.isDir(root .. fpath) then
      sfxDirs = sfxDirs .. "\"" .. fpath .. "\",\n"
      serDir(fpath .. "/")
    else
      serFile(fpath)
    end
  end  
end

function serFile(fpath)
  sleep(0.05)
  print("file " .. root .. fpath)  
  if fs.getSize(root .. fpath) > 1000000 then
    print (root .. fpath .. " is too long, skipping")
  else  
    local file = fs.open(root .. fpath, "r")
    local text = file.readAll()
    file.close()
    sfxFiles = sfxFiles .. "\"" .. fpath .. "\",\n[=====[\n" .. text .. "\n]=====],\n"
  end
end

serDir("")

local sfx = [[
local tArgs = { ... }

if #tArgs ~= 1 then
	print( "Usage= blabla.sfx <dir>" )
	return
end

local root = tArgs[1] .. "/"

local files = {
]] .. sfxFiles .. [[
}

local dirs = {]] .. sfxDirs .. [[}

if not fs.isDir(tArgs[1]) then
  fs.makeDir(tArgs[1])
end

for _,dir in ipairs(dirs) do
  local fpath = root .. dir
  print("dir " .. fpath)
  if not fs.isDir(fpath) then
    fs.makeDir(fpath)
  end
end

i = 1
while i<#files do
  sleep(0.05)
  local fpath = root .. files[i]
  local data = files[i+1]
  print("file " .. fpath)
  local file = fs.open(fpath, "w")
  file.write(data)
  file.close()
  i = i+2
end]]

local file = fs.open(tArgs[2],"w")
file.write(sfx)
file.close()
