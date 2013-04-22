require "Scene/LoadingScene"
require "Scene/WelcomeScene"
require "Scene/GameScene"
require "Scene/OptionScene"
require "Scene/AboutScene"
require "Scene/GameScene2"

local scheduleStack = {}
local scheduler = CCDirector:sharedDirector():getScheduler()
local scene, score

SceneAgent = {}

function SceneAgent:createScene(Class)
    SceneAgent:cleanSchedule()
    sceneClass = Class
    scene = Class:create()
    score = 0
    return scene
end

local function nextScene()
    local layer = CCLayer:create()
    local clean = CCLabelTTF:create(SceneAgent_Clean, FONT_ARIAL, 24)
    clean:setPosition(winSize.width / 2, winSize.height / 2)
    layer:addChild(clean)
    scene:addChild(layer)
    
    local function replace_schedule()
        CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(0.5, SceneAgent:createScene(sceneClass.nextScene())))
    end
    SceneAgent:addSchedule(replace_schedule, 3, false)
end

function SceneAgent:addScore(delta)
    score = score + delta
    if score >= sceneClass.goal then
        nextScene()
    end
end

function SceneAgent:gameOver()
    local layer = CCLayer:create()
    local sprite = CCSprite:create(GameScene_GameOver)
    sprite:setPosition(winSize.width / 2, winSize.height / 2)
    layer:addChild(sprite)
    layer:setPosition(0, 0)
    scene:addChild(layer, GameScene_GameOverLayer_ID)
    
    local function replace_schedule()
        CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(0.5, SceneAgent:createScene(WelcomeScene)))
    end
    
    SceneAgent:addSchedule(replace_schedule, 3, false)
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