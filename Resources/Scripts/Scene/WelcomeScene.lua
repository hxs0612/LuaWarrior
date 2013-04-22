local winSize = CCDirector:sharedDirector():getWinSize()

local function start_callback()
    cclog("start click!")
    CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(0.5, SceneAgent:createScene(GameScene)))
end

local function option_callback()
    cclog("option click!")
    CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(0.5, SceneAgent:createScene(OptionScene)))
end

local function about_callback()
    cclog("about invoked!")
    CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(0.5, SceneAgent:createScene(AboutScene)))
end

local function setupView(scene)
	
    -- create a layer
    local layer = CCLayer:create()
    
    -- set background
	local background = CCSprite:create(MainScene_BG)
	background:setPosition(winSize.width / 2, winSize.height / 2)
	layer:addChild(background)
    
    -- load menu textrue
    local menuTextrue = CCTextureCache:sharedTextureCache():addImage(MainScene_Menu)
    
    -- create menu item
    local startNormal = CCSprite:createWithTexture(menuTextrue, CCRectMake(0, 0, 126, 33))
    local startPressed = CCSprite:createWithTexture(menuTextrue, CCRectMake(0, 33, 126, 33))
    local startDisabled = CCSprite:createWithTexture(menuTextrue, CCRectMake(0, 66, 126, 33))
    
    local startItem = CCMenuItemSprite:create(startNormal, startPressed, startDisabled)
    startItem:registerScriptTapHandler(start_callback)
    startItem:setPosition(0, 86)
    
    local optionNormal = CCSprite:createWithTexture(menuTextrue, CCRectMake(126, 0, 126, 33))
    local optionPressed = CCSprite:createWithTexture(menuTextrue, CCRectMake(126, 33, 126, 33))
    local optionDisabled = CCSprite:createWithTexture(menuTextrue, CCRectMake(126, 66, 126, 33))
    
    local optionItem = CCMenuItemSprite:create(optionNormal, optionPressed, optionDisabled)
    optionItem:registerScriptTapHandler(option_callback)
    optionItem:setPosition(0, 43)
    
    local aboutNormal = CCSprite:createWithTexture(menuTextrue, CCRectMake(252, 0, 126, 33))
    local aboutPressed = CCSprite:createWithTexture(menuTextrue, CCRectMake(252, 33, 126, 33))
    local aboutDisabled = CCSprite:createWithTexture(menuTextrue, CCRectMake(252, 66, 126, 33))
    
    local aboutItem = CCMenuItemSprite:create(aboutNormal, aboutPressed, aboutDisabled)
    aboutItem:registerScriptTapHandler(about_callback)
    aboutItem:setPosition(0, 0)
    
    -- create the main menu
    local mainMenu = CCMenu:create()
    mainMenu:addChild(startItem)
    mainMenu:addChild(optionItem)
    mainMenu:addChild(aboutItem)
    mainMenu:setPosition(winSize.width / 2, winSize.height / 2 - 40)
    layer:addChild(mainMenu)
    
    -- append the logo
    local logo = CCSprite:create(MainScene_Logo)
    logo:setAnchorPoint(ccp(0.5, 1))
    logo:setPosition(winSize.width / 2, winSize.height - 20)
    layer:addChild(logo)
    
    -- append the layer
    scene:addChild(layer)
	
    if CCUserDefault:sharedUserDefault():getBoolForKey(Setting_playBGM) then
        if not SimpleAudioEngine:sharedEngine():isBackgroundMusicPlaying() then
            -- loop the bg music
            SimpleAudioEngine:sharedEngine():playBackgroundMusic(MainScene_BGM, true)
        end
    else
        SimpleAudioEngine:sharedEngine():stopBackgroundMusic()
    end
    
end

WelcomeScene = {}

function WelcomeScene:create()
    local scene = CCScene:create()
    
    setupView(scene)
    
    return scene
end
