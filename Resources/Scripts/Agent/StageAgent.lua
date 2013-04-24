require "Agent/PlayerAgent"
require "Agent/EnemyAgent"
require "Stage/FirstStage"
require "Stage/SecondStage"
require "Stage/ThirdStage"
require "Layer/GameMenuLayer"
require "Layer/PauseLayer"
require "Layer/PlayerLayer"
require "Layer/PlayerBulletLayer"
require "Layer/EnemyLayer"
require "Layer/EnemyBulletLayer"

local stage, scene, isGameover

local function setStage()
    isGameover = false
    StageAgent:setBackground()
    StageAgent:pauseEnable()
    PlayerAgent:create(scene)
    EnemyAgent:create(scene)
    
    SceneAgent:addSchedule(stage.common_schedule, 0, false)
end
  
local firstStage = FirstStage

StageAgent = {}

function StageAgent:initStage()
    stage = firstStage
    scene = stage:create()
    setStage()
    return scene
end

function StageAgent:moveBullets()
    PlayerAgent:moveBullets()
    EnemyAgent:moveBullets()
end

function StageAgent:playerShot()
    PlayerAgent:shot()
end

function StageAgent:enemyShot()
    EnemyAgent:shot()
end

function StageAgent:addEnemy(param)
    EnemyAgent:addEnemy(param)
end

function StageAgent:getEnemyArray()
    return EnemyAgent:getEnemyArray()
end

function StageAgent:pauseEnable()
    
    -- pause layer
    local pauseLayer = PauseLayer:create()
    pauseLayer:setPosition(0, 0)
    pauseLayer:setVisible(false)
    scene:addChild(pauseLayer, GameScene_PauseLayer_ID, GameScene_PauseLayer_ID)
    
    local menuLayer = GameMenuLayer:create()
    menuLayer:setPosition(0, 0)
    scene:addChild(menuLayer, GameScene_MenuLayer_ID, GameScene_MenuLayer_ID)
end

function StageAgent:pauseGame()
    
    -- player layer touch disable
    local playerLayer = scene:getChildByTag(GameScene_PlayerLayer_ID)
    playerLayer:setTouchEnabled(false)
    
    -- show pause layer
    local pauseLayer = scene:getChildByTag(GameScene_PauseLayer_ID)
    pauseLayer:setVisible(true)
    
    -- hide pause menu
    local pauseMenu = scene:getChildByTag(GameScene_MenuLayer_ID):getChildByTag(GameScene_PauseMenu_ID)
    pauseMenu:setVisible(false)
    
    -- pause bgm
    if SimpleAudioEngine:sharedEngine():isBackgroundMusicPlaying() then
        SimpleAudioEngine:sharedEngine():pauseBackgroundMusic()
    end
    
    -- pause director
    CCDirector:sharedDirector():pause()
end

function StageAgent:resumeGame()
    -- hide parse layer
    local pauseLayer = scene:getChildByTag(GameScene_PauseLayer_ID)
    pauseLayer:setVisible(false)
    
    -- show parse menu
    local pauseMenu = scene:getChildByTag(GameScene_MenuLayer_ID):getChildByTag(GameScene_PauseMenu_ID)
    pauseMenu:setVisible(true)
    
    -- resume bgm
    SimpleAudioEngine:sharedEngine():resumeBackgroundMusic()
    
    -- resume director
    CCDirector:sharedDirector():resume()
    
    -- player layer touch enable
    local playerLayer = scene:getChildByTag(GameScene_PlayerLayer_ID)
    playerLayer:setTouchEnabled(true)
end

function StageAgent:setBackground()
    
    local background_img = stage.background
    
    -- add background
    local backgroundLayer = CCLayer:create()
    
    local background = CCSprite:create(background_img)
    background:setAnchorPoint(ccp(0, 0))
    background:setPosition(0, 0)
    backgroundLayer:addChild(background)
    local background2 = CCSprite:create(background_img)
    background2:setAnchorPoint(ccp(0, 0))
    background2:setPosition(0, background:getContentSize().height)
    backgroundLayer:addChild(background2)
    
    local function background_schedule()
        background:setPositionY(background:getPositionY() - 1)
        background2:setPositionY(background:getPositionY() + background:getContentSize().height)
        if background2:getPositionY() <= 0 then
            background:setPositionY(0)
        end
    end
    
    SceneAgent:addSchedule(background_schedule, 0, false)
    
    scene:addChild(backgroundLayer, GameScene_BackgroundLayer_ID, GameScene_BackgroundLayer_ID)
    
end

function StageAgent:nextStage()
    
    local menuLayer = scene:getChildByTag(GameScene_MenuLayer_ID)
    menuLayer:setVisible(false)
    
    -- add stage clean layer
    local layer = scene:getChildByTag(GameScene_ResultLayer_ID)
    if not layer then
        layer = CCLayer:create()
        scene:addChild(layer, GameScene_ResultLayer_ID, GameScene_ResultLayer_ID)
    else
        layer:removeChildByTag(GameScene_GameOver_ID, true)
    end
    local clean = CCLabelTTF:create(SceneAgent_Clean, FONT_ARIAL, 24)
    clean:setPosition(winSize.width / 2, winSize.height / 2)
    layer:addChild(clean, 0, GameScene_StageClean_ID)
    
    local function nextstage_schedule()
        if isGameover then
            return nil
        end
        SceneAgent:cleanSchedule()
        stage = stage.nextStage
        if stage then
            scene = stage:create()
            setStage()
            CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(0.5, scene))
        else
            CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(0.5, SceneAgent:createScene(WelcomeScene)))
        end
    end
    SceneAgent:addSchedule(nextstage_schedule, 3, false)
    
end

function StageAgent:gameOver()
    
    local layer = scene:getChildByTag(GameScene_ResultLayer_ID)
    if not layer then
        layer = CCLayer:create()
        scene:addChild(layer, GameScene_ResultLayer_ID, GameScene_ResultLayer_ID)
    else
        layer:removeChildByTag(GameScene_StageClean_ID, true)
    end
    local sprite = CCSprite:create(GameScene_GameOver)
    sprite:setPosition(winSize.width / 2, winSize.height / 2)
    layer:addChild(sprite, 0, GameScene_GameOver_ID)
    layer:setPosition(0, 0)
    isGameover = true
    
    local function gameover_schedule()
        CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(0.5, SceneAgent:createScene(WelcomeScene)))
    end
    
    SceneAgent:addSchedule(gameover_schedule, 3, false)
end

function StageAgent:addScore(score)
    totalScore = totalScore + score
end