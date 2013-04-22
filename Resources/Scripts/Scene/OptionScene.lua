local function music_callback()
    if CCUserDefault:sharedUserDefault():getBoolForKey(Setting_playBGM) then
        SimpleAudioEngine:sharedEngine():stopBackgroundMusic()
        CCUserDefault:sharedUserDefault():setBoolForKey(Setting_playBGM, false)
    else
        SimpleAudioEngine:sharedEngine():playBackgroundMusic(MainScene_BGM, true)
        CCUserDefault:sharedUserDefault():setBoolForKey(Setting_playBGM, true)
    end
end

local function effect_callback()
    if CCUserDefault:sharedUserDefault():getBoolForKey(Setting_playEffect) then
        CCUserDefault:sharedUserDefault():setBoolForKey(Setting_playEffect, false)
    else
        CCUserDefault:sharedUserDefault():setBoolForKey(Setting_playEffect, true)
    end
end

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
    local title = CCSprite:create(AboutScene_Title, CCRectMake(0, 0, 133, 35))
    title:setAnchorPoint(ccp(0.5, 1))
    title:setPosition(winSize.width / 2, winSize.height - 50)
    layer:addChild(title)
    
    -- create the music item
    local musicItem = CCMenuItemToggle:create(nil)
    musicItem:addSubItem(CCMenuItemLabel:create(CCLabelTTF:create(OptionScene_Music_On, FONT_ARIAL, 24)))
    musicItem:addSubItem(CCMenuItemLabel:create(CCLabelTTF:create(OptionScene_Music_Off, FONT_ARIAL, 24)))
    musicItem:setPosition(winSize.width / 2, winSize.height / 2 + 15)
    musicItem:registerScriptTapHandler(music_callback)
    
    if CCUserDefault:sharedUserDefault():getBoolForKey(Setting_playBGM) then
        musicItem:setSelectedIndex(1) 
    else
        musicItem:setSelectedIndex(0) 
    end
    
    -- create the effect item
    local effectItem = CCMenuItemToggle:create(nil)
    effectItem:addSubItem(CCMenuItemLabel:create(CCLabelTTF:create(OptionScene_Effect_On, FONT_ARIAL, 24)))
    effectItem:addSubItem(CCMenuItemLabel:create(CCLabelTTF:create(OptionScene_Effect_Off, FONT_ARIAL, 24)))
    effectItem:setPosition(winSize.width / 2, winSize.height / 2 - 15)
    effectItem:registerScriptTapHandler(effect_callback)
    
    if CCUserDefault:sharedUserDefault():getBoolForKey(Setting_playEffect) then
        effectItem:setSelectedIndex(1) 
    else
        effectItem:setSelectedIndex(0) 
    end
    
    -- create the back item
    local backItem = CCMenuItemLabel:create(CCLabelTTF:create(OptionScene_Back, FONT_ARIAL, 24))
    backItem:setPosition(winSize.width / 2, 50)
    backItem:registerScriptTapHandler(back_callback)
    
    local menu = CCMenu:create()
    menu:addChild(musicItem)
    menu:addChild(effectItem)
    menu:addChild(backItem)
    menu:setPosition(0, 0)
    layer:addChild(menu)
    
    scene:addChild(layer)
end

OptionScene = {}

function OptionScene:create()
    local scene = CCScene:create()
    
    setupView(scene)
    
    return scene
end