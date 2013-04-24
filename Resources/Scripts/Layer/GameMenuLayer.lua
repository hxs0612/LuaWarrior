local function init(layer)
    
    -- add pause menu
    local pauseItem = CCMenuItemImage:create(GameScene_Pause, GameScene_Pause)
    pauseItem:setAnchorPoint(ccp(1, 1))
    pauseItem:setPosition(winSize.width, winSize.height)
    pauseItem:registerScriptTapHandler(StageAgent.pauseGame)
    
    local pauseMenu = CCMenu:create()
    pauseMenu:addChild(pauseItem)
    pauseMenu:setPosition(0, 0)
    
    -- menu layer
    layer:addChild(pauseMenu, 0, GameScene_PauseMenu_ID)
end

GameMenuLayer = {}

function GameMenuLayer:create()
    local layer = CCLayer:create()
    init(layer)
    return layer
end