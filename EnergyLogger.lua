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

function getResource()
    return math.random(0, 1000)
end

-- INIT VARIABLES
local config = loadFile("energy.config")
local monitor = peripheral.wrap(config.monitorSide)
monitor.setTextScale(config.textScale)
monitor.clear()
local width, height = monitor.getSize()

local maxValue = 100
local valuePerDot = 1

local valueTable = {}
for x = 0, width, 1 do
    valueTable[x] = {}
    for y = 0, height, 1 do
        valueTable[x][y] = "*"
    end
end

-- PROGRAM BODY
-- monitor.setCursorPos(x,y)
-- monitor.write(char)

while true do
    monitor.clear()
    for x = 0, width, 1 do
        for y = 0, height, 1 do
            monitor.setCursorPos(x,y)
            monitor.write(valueTable[x][y])
        end
    end
    os.sleep(5)
end

