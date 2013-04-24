require "Factory/EnemyFactory"
require "Factory/BulletFactory"
require "Factory/EffectFactory"
require "Agent/StageAgent"

local function setupView(scene)
    local layer = CCLayer:create()
    
    local background = CCSprite:create(LoadingLayer_BG)
    background:setPosition(winSize.width / 2, winSize.height / 2)
    layer:addChild(background)
    
    local label = CCLabelTTF:create(LoadingLayer_Loading, FONT_ARIAL, 24)
    label:setPosition(winSize.width / 2, winSize.height / 2 + 12)
    layer:addChild(label)
    
    scene:addChild(layer)
end

local function pre_schedule()
    
    -- preload the music
    SimpleAudioEngine:sharedEngine():preloadBackgroundMusic(MainScene_BGM)
    
    -- preload the bullet
    CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile(PlayerBulletLayer_Bullet_plist)
    
    -- preload the effect
    CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile(EffectFactory_Explosion_plist)
    
    -- init the factory
    EnemyFactory:init()
    EffectFactory:init()
    
    CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(0.5, SceneAgent:createScene(WelcomeScene)))
end

LoadingScene = {}

function LoadingScene:create()
    local scene = CCScene:create()
    
    setupView(scene)
    SceneAgent:addSchedule(pre_schedule, 0.1, false)
    
    return scene
end
