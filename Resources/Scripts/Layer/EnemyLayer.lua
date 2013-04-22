local layer, enemyArray

local function init(layer)
    
    -- init enemy array
    enemyArray = CCArray:create()
    enemyArray:retain()
    
end

EnemyLayer = {}

function EnemyLayer:create()
    layer = CCLayer:create()
    
    init(layer)
    
    return layer
end

function EnemyLayer:addEnemy(param)
    
    -- create a enemy entity
    local enemy = EnemyFactory:createEnemy(param.enemyType)
    enemy:setPosition(param.startX, param.startY)
    layer:addChild(enemy)
    
    -- add move action
    local t = math.sqrt((param.startX - param.endX) ^ 2 + (param.startY - param.endY) ^ 2) / param.speed
    local moveToAction = CCMoveTo:create(t, ccp(param.endX, param.endY))
    enemy:runAction(moveToAction)
    
    enemyArray:addObject(enemy)
end

function EnemyLayer:getEnemyArray()
    return enemyArray
end

function EnemyLayer:enemyHitten(enemy)
    enemyArray:removeObject(enemy)
    enemy:cleanup()
    local boomActions = EffectFactory:createBoomActions()
    enemy:runAction(boomActions)
end