local layer

local function play_callback()
    
    -- hide parse layer
    layer:setVisible(false)
    
    -- show parse menu
    local pauseMenu = layer:getParent():getChildByTag(GameScene_BackgroundLayer_ID):getChildByTag(GameScene_PauseMenu_ID)
    pauseMenu:setVisible(true)
    
    -- clean player's animate
    -- to solve the BUG :
    -- if u touch the screen when game paused,
    -- the player will moves to the point that u touched when game resumed
    -- I do think this's a bad way to solve the bug
    PlayerLayer:getPlayer():cleanup()
    
    -- resume bgm
    SimpleAudioEngine:sharedEngine():resumeBackgroundMusic()
    
    -- resume director
    CCDirector:sharedDirector():resume()
end

local function init(layer)
    
    local playItem = CCMenuItemImage:create(PauseLayer_Play, PauseLayer_Play)
    playItem:setPosition(winSize.width / 2, winSize.height / 2)
    playItem:registerScriptTapHandler(play_callback)
    
    local menu = CCMenu:create()
    menu:addChild(playItem)
    menu:setPosition(0, 0)
    
    layer:addChild(menu)

end

PauseLayer = {}

function PauseLayer:create()
    layer = CCLayerColor:create(ccc4(0, 0, 0, 127))
    
    init(layer)
    
    return layer
end