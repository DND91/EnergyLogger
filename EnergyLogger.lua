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
local config = loadFile("energy.config")
local monitor = peripheral.wrap(config.monitorSide)
monitor.setTextScale(config.textScale)
monitor.clear()
local width, height = monitor.getSize()


-- PROGRAM BODY
-- monitor.setCursorPos(x,y)
-- monitor.write(char)

while true do
    monitor.clear()
    for x = 0, width, 1 do
        for y = 0, height, 1 do
            monitor.setCursorPos(x,y)
            monitor.write("*")
        end
    end
    os.sleep(5)
end

