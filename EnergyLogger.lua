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
local maxValue = 0
local valueTable = {}

for col = 0, width, 1 do
    valueTable[col] = 0
end

-- POST INIT FUNCTIONS

function moveOneStepLeftTable()
    for col = 1, width, 1 do
        valueTable[col-1] = valueTable[col]
    end
    valueTable[width] = 0
end

function updateLastRow()
    local v = getResource()
    valueTable[width] = v
    print("Max Value: "..maxValue.." Value: "..v)
    if maxValue < v then
        maxValue = v
    end
end

-- PROGRAM BODY
-- monitor.setCursorPos(x,y)
-- monitor.write(char)

while true do
    moveOneStepLeftTable()
    updateLastRow()
    monitor.clear()
    for col = 0, width, 1 do
        local val = valueTable[col]
        
        local dots = height * (val / maxValue)
        
        for y = 0, dots, 1 do
            monitor.setCursorPos(col,y)
            monitor.write("*")
        end
    end
    os.sleep(5)
end

