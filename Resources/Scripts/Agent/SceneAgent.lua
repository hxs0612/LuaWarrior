local scheduleStack = {}
local scheduler = CCDirector:sharedDirector():getScheduler()

SceneAgent = {}

function SceneAgent:createScene()
    SceneAgent:cleanSchedule()
    return CCScene:create()
end

function SceneAgent:addSchedule(handler, interval, pause)
    local scheduleId = scheduler:scheduleScriptFunc(handler, interval, pause)
    scheduleStack[#scheduleStack + 1] = scheduleId
end

function SceneAgent:removeSchedule()
    -- todo
end

function SceneAgent:cleanSchedule()
    for i = 1, #scheduleStack do
        scheduler:unscheduleScriptEntry(scheduleStack[i])
    end
    scheduleStack = {}
end