require "Layer/PauseLayer"
require "Layer/PlayerLayer"
require "Layer/PlayerBulletLayer"
require "Layer/EnemyLayer"
require "Layer/EnemyBulletLayer"

local scene,
      background, background_2, 
      playerLayer, playerBulletLayer, 
      pauseLayer, pauseMenu, 
      enemyLayer, enemyBulletLayer

local function background_schedule()
    background:setPositionY(background:getPositionY() - 1)
    background_2:setPositionY(background:getPositionY() + background:getContentSize().height)
    
    if background_2:getPositionY() <= 0 then
       background:setPositionY(0)
    end
    
end

local function addbullet_schedule()
    -- add player bullet
    local player = PlayerLayer:getPlayer()
    if player then
        local x, y = player:getPosition()
        PlayerBulletLayer:addNewBullet(x, y)
    end
    
    -- add enemy bullet
    local enemyArray = EnemyLayer:getEnemyArray()
    local index, len = 0, enemyArray:count()
    local enemy
    while index < len do
        enemy = enemyArray:objectAtIndex(index)
        EnemyBulletLayer:addBullet(enemy)
        index = index + 1
    end
    
end

local function pause_callback()
    
    -- show pause layer
    pauseLayer:setVisible(true)
    
    -- hide the pause menu
    pauseMenu:setVisible(false)
    
    -- pause director
    CCDirector:sharedDirector():pause()
    
    -- stop the bgm
    if SimpleAudioEngine:sharedEngine():isBackgroundMusicPlaying() then
        SimpleAudioEngine:sharedEngine():pauseBackgroundMusic()
    end
    
end

local function setupView(scene)
    
    -- set background
    local backgroundLayer = CCLayer:create()
    
    background = CCSprite:create(GameScene_BG)
    background_2 = CCSprite:create(GameScene_BG)
    
    background:setAnchorPoint(ccp(0, 0))
    background_2:setAnchorPoint(ccp(0, 0))
    background:setPosition(0, 0)
    background_2:setPosition(0, background:getContentSize().height)
    backgroundLayer:addChild(background)
    backgroundLayer:addChild(background_2)
    
    -- set background scroll
    SceneAgent:addSchedule(background_schedule, 0.03, false)
    
    scene:addChild(backgroundLayer, 0, GameScene_BackgroundLayer_ID)
    
    -- add pause menu
    local pauseItem = CCMenuItemImage:create(GameScene_Pause, GameScene_Pause)
    pauseItem:setAnchorPoint(ccp(1, 1))
    pauseItem:setPosition(winSize.width, winSize.height)
    pauseItem:registerScriptTapHandler(pause_callback)
    
    pauseMenu = CCMenu:create()
    pauseMenu:addChild(pauseItem)
    pauseMenu:setPosition(0, 0)
    backgroundLayer:addChild(pauseMenu, 0, GameScene_PauseMenu_ID)
    
    -- add pause layer
    pauseLayer = PauseLayer:create()
    pauseLayer:setPosition(0, 0)
    pauseLayer:setVisible(false)
    scene:addChild(pauseLayer, GameScene_PauseLayer_ID)
    
    -- add player layer
    playerLayer = PlayerLayer:create()
    playerLayer:setPosition(0, 0)
    scene:addChild(playerLayer, GameScene_PlayerLayer_ID)
    
    -- add player bullet layer
    playerBulletLayer = PlayerBulletLayer:create()
    scene:addChild(playerBulletLayer)
    
    -- add enemy layer
    enemyLayer = EnemyLayer:create()
    enemyLayer:setPosition(0, 0)
    scene:addChild(enemyLayer, GameScene_EnemyLayer_ID)
    
    -- add enmy bullet layer
    enemyBulletLayer = EnemyBulletLayer:create()
    enemyBulletLayer:setPosition(0, 0)
    scene:addChild(enemyBulletLayer)
    
    -- set layer relationship
    PlayerBulletLayer:setEnemyLayer(EnemyLayer)
    EnemyBulletLayer:setPlayerLayer(PlayerLayer)
    
    -- test
    local param = {
        enemyType = 2,
        startX = 0,
        startY = winSize.height / 2,
        endX = winSize.width * 0.75,
        endY = winSize.height * 0.75,
        speed = 100,
    }
    EnemyLayer:addEnemy(param)
    
    local param2 = {
        enemyType = 2,
        startX = winSize.width,
        startY = winSize.height / 2,
        endX = winSize.width * 0.25,
        endY = winSize.height * 0.75,
        speed = 100,
    }
    EnemyLayer:addEnemy(param2)
    
    -- add bullet schedule
    SceneAgent:addSchedule(addbullet_schedule, 0.3, false)
    
end

GameScene2 = {
    goal = 2,
    nextScene = function()
        return WelcomeScene
    end
}

function GameScene2:create()
    scene = CCScene:create()
    
    setupView(scene)
    
    return scene
end

function GameScene2:showGameOver()
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