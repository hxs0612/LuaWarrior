local layer, bulletArray, enemyTextrue, bulletBatchNode, playerLayer

local function movebullet_schedule()
    local index, len = 0, bulletArray:count()
    if len > 0 and playerLayer then
        local player = playerLayer:getPlayer()
        while index < len do
            local b = tolua.cast(bulletArray:objectAtIndex(index),"CCSprite")
            local y = b:getPositionY() - 5
            if y < 0 then
                -- remove the bullet when overflow
                bulletArray:removeObject(b)
                bulletBatchNode:removeChild(b, true)
                len = len - 1
            else
                if player and b:boundingBox():intersectsRect(player:boundingBox()) then
                    
                    -- remove the bullet when overflow
                    bulletArray:removeObject(b)
                    bulletBatchNode:removeChild(b, true)
                    
                    -- remove the player
                    playerLayer:playerHitten()
                    
                    return nil
                    
                else
                    -- move the bullet
                    b:setPositionY(y)
                    index = index + 1
                end
           end
        end
    end
end

local function init(layer)
    
    -- load bullet
    bulletBatchNode = CCSpriteBatchNode:create(PlayerBulletLayer_Bullet)
    
    -- load blend
    local blend = ccBlendFunc()
    blend.src = GL_SRC_ALPHA
    blend.dst = GL_ONE
    bulletBatchNode:setBlendFunc(blend)
    
    -- init bullet array
    bulletArray = CCArray:create()
    bulletArray:retain()
    
    layer:addChild(bulletBatchNode)
    
    SceneAgent:addSchedule(movebullet_schedule, 0.01, false)
    
end

EnemyBulletLayer = {}

function EnemyBulletLayer:create()
    layer = CCLayer:create()
    
    init(layer)
    
    return layer
end

function EnemyBulletLayer:addBullet(enemy)
    tolua.cast(enemy, "CCSprite")
    
    local bullet = BulletFactory:createBullet(enemy:getTag())
    local x, y = enemy:getPosition()
    bullet:setPosition(x, y)
    bulletArray:addObject(bullet)
    bulletBatchNode:addChild(bullet)
    local s = bullet:getContentSize()
end

function EnemyBulletLayer:setPlayerLayer(layer)
    playerLayer = layer
end