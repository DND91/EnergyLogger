-- Pastebin URL: http://pastebin.com/vKyec2if

local argsv = { ... }

-- HTTP TEST
if not http then
  print("No access to web")
  return
end

-- FUNCTION INIT

function tableLength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function download_files(files)
    for _, file in ipairs(files) do
      local path
      if file.folder then
        if not fs.exists(file.folder) then
          fs.makeDir(file.folder)
        end
        path = fs.combine(file.folder, file.name)
      else
        path = file.name
      end
      local currText = ""
      if fs.exists(path) then
        local f = fs.open(path, "r")
        currText = f.readAll()
        f.close()
        io.write("update  ")
      else
        io.write("install ")
      end
      io.write("'"..file.name.."'"..string.rep(" ", math.max(0, 8 - #file.name)))
      if file.folder then
        io.write(" in '"..file.folder.."'"..string.rep(".", math.max(0, 8 - #file.folder)).."...")
      else
        io.write("    .............")
      end
      local request = http.get(file.url)
      if request then
        local response = request.getResponseCode()
        if response == 200 then
          local newText = request.readAll()
          if newText == currText then
            print("skip")
          else
            local f = fs.open(path, "w")
            f.write(newText)
            f.close()
            print("done")
          end
        else
          print(" bad HTTP response code " .. response)
          return false
        end
      else
        print(" no request handle")
        return false
      end
      os.sleep(0.1)
    end
    return true
end

function loadFile(fileName)
  local f = fs.open(fileName, "r")
  if f ~= nil then
    local data = f.readAll()
    f.close()
    return textutils.unserialize(data)
  end
end

-- VARIABLE INIT

local leng = tableLength(argsv)

if leng < 4 then
    print("I want arguments for github Username, github Project name and last Branch name")
    return
end

local username = argsv[1]
local project_name = argsv[2]
local branch_name = argsv[3]
local config_name = "dnd.config"

local files = {
  {
    name = "dnd.config",
    url = "https://raw.github.com/"..username.."/"..project_name.."/"..branch_name.."/dnd.config"
  }
}

-- PROGRAM BODY

if download_files(files) then
    print("Downloaded dnd.config")
else
    print("Failed to download dnd.config...")
    return
end

local config = loadFile("dnd.config")

if download_files(config) then
    print("Downloaded project files")
else
    print("Failed to download project files...")
    return
end
