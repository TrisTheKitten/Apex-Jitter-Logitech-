--[[
This is the script that works with all Logitech mouses. 
It is a simple script that allows you to control the recoil of a weapon in a game. 
The script is activated by pressing the caplock button, and you can switch between different modifiers by pressing the fourth mouse button. 
The script will then jitter the mouse in a specific pattern and will remove 90% of recoil from the gun.
To use the script, you need to install the Logitech G Hub and create a new script in the profile you desire. 
Then copy and paste the script into the editor and save it.

This script is for educational purposes only. Using macros are against the terms of service of most games and can get you banned. Use at your own risk.
--]]

local movePattern = {
    {-12, 10}, {10, -12}
}
local speeds = {1, 3, 5, 10}
local moveIndex, currentSpeedIndex = 1, 1
local patternSize = 13 

local IsKeyLockOn = IsKeyLockOn
local MoveMouseRelative = MoveMouseRelative
local OutputLogMessage = OutputLogMessage
local IsMouseButtonPressed = IsMouseButtonPressed
local GetRunningTime = GetRunningTime
local Sleep = Sleep

local lastSwitchTime = 0
local debounceDelay = 200

-- Helper function to check debounce
local function isDebounced()
    local currentTime = GetRunningTime()
    if currentTime - lastSwitchTime > debounceDelay then
        lastSwitchTime = currentTime
        return true
    end
    return false
end

-- Function to switch speed
local function switchSpeed()
    currentSpeedIndex = currentSpeedIndex % #speeds + 1
    OutputLogMessage("Switched to speed %d ms\n", speeds[currentSpeedIndex])
end

-- Function to jitter the mouse
local function jitterMouse()
    while IsMouseButtonPressed(1) do
        local move = movePattern[moveIndex]
        MoveMouseRelative(move[1] * patternSize, move[2] * patternSize)
        moveIndex = moveIndex % #movePattern + 1
        Sleep(speeds[currentSpeedIndex])
    end
end

-- Main event handler function
local function handleMousePress(arg)
    if arg == 5 and isDebounced() then
        switchSpeed()
    elseif arg == 1 then
        if IsKeyLockOn("capslock") then
            jitterMouse()
        end
    end
end

function OnEvent(event, arg)
    if event == "PROFILE_ACTIVATED" then
        EnablePrimaryMouseButtonEvents(true)
    elseif event == "MOUSE_BUTTON_PRESSED" then
        handleMousePress(arg)
    end
end


--[[ This script is developed by Tris The Kitten and you can request feature updates or report bugs on the GitHub page:
I will be updating the script with new features and improvements. Thank you for using the script! --]]