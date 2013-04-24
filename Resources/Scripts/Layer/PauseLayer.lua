local layer

local function init(layer)
    
    local playItem = CCMenuItemImage:create(PauseLayer_Play, PauseLayer_Play)
    playItem:setPosition(winSize.width / 2, winSize.height / 2)
    playItem:registerScriptTapHandler(StageAgent.resumeGame)
    
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