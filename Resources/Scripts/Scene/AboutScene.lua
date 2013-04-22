local winSize = CCDirector:sharedDirector():getWinSize()

local function back_callback()
    cclog("back invoked!")
    CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(0.5, SceneAgent:createScene(WelcomeScene)))
end

local function setupView(scene)
    
    -- create a layer
    local layer = CCLayer:create()
    
    -- set background
    local background = CCSprite:create(MainScene_BG)
    background:setPosition(winSize.width / 2, winSize.height / 2)
    layer:addChild(background)
    
    -- set title
    local title = CCSprite:create(AboutScene_Title, CCRectMake(0, 35, 110, 40))
    title:setAnchorPoint(ccp(0.5, 1))
    title:setPosition(winSize.width / 2, winSize.height - 50)
    layer:addChild(title)
    
    -- create the back menu
    local backItem = CCMenuItemLabel:create(CCLabelTTF:create(AboutScene_Back, FONT_ARIAL, 24))
    backItem:setPosition(winSize.width / 2, 50)
    backItem:registerScriptTapHandler(back_callback)
    local menu = CCMenu:create()
    menu:addChild(backItem)
    menu:setPosition(0, 0)
    layer:addChild(menu)
    
    scene:addChild(layer)
end

AboutScene = {}

function AboutScene:create()
    local scene = CCScene:create()
    
    setupView(scene)
    
    return scene
end