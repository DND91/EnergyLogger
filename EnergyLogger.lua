-- https://raw.githubusercontent.com/DND91/EnergyLogger/master/EnergyLogger.lua

-- INIT FUNCTIONS
function loadFile(fileName)
  local f = fs.open(fileName, "r")
  if f ~= nil then
    local data = f.readAll()
    f.close()
    return textutils.unserialize(data)
  end
end

-- INIT VARIABLES


-- PROGRAM BODY
