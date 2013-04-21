local winSize = CCDirector:sharedDirector():getWinSize()

local layer, player
local player_v = 200

local function onTouchBegan(x, y)
    if not player then
        return
    end
    local width = player:getContentSize().width
    local height = player:getContentSize().height
    x = math.min(math.max(width / 2, x), winSize.width - width / 2)
    y = math.min(math.max(height / 2, y), winSize.height - height / 2)
    
    local t = math.sqrt((player:getPositionX() - x) ^ 2 + (player:getPositionY() - y) ^ 2) / player_v
    
    local moveToAction = CCMoveTo:create(t, ccp(x, y))
    player:stopAllActions()
    player:runAction(moveToAction)
    -- player:setPosition(x, y)
    
end

local function onTouch(eventType, x, y)
    if eventType == CCTOUCHBEGAN then
        return onTouchBegan(x, y)
    end
end

local function init(layer)
    
    -- add player
    player = CCSprite:create(PlayerLayer_player, CCRectMake(60, 0, 60, 43))
    player:setPosition(winSize.width / 2, 30)
    layer:addChild(player)
    
    -- add player animation
    local animation = CCAnimation:create()
    animation:setDelayPerUnit(0.1)
    animation:addSpriteFrame(CCSpriteFrame:create(PlayerLayer_player, CCRectMake(60, 0, 60, 43)))
    animation:addSpriteFrame(CCSpriteFrame:create(PlayerLayer_player, CCRectMake(0, 0, 60, 43)))
    local animate = CCAnimate:create(animation)
    player:runAction(CCRepeatForever:create(animate))
    
    -- set touch event
    layer:registerScriptTouchHandler(onTouch)
    layer:setTouchEnabled(true)
end

PlayerLayer = {}

function PlayerLayer:create()
    layer = CCLayer:create()
    
    init(layer)
    
    return layer
end

function PlayerLayer:setTouchEnabled()
    layer:setTouchEnabled(true)
end

function PlayerLayer:setTouchDisabled()
    layer:setTouchEnabled(false)
end

function PlayerLayer:getPlayer()
    return player
end

function PlayerLayer:playerHitten()
    player:setVisible(false)
    player = nil
end