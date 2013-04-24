local layer, bulletArray, enemyTextrue, bulletBatchNode

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
    
end

EnemyBulletLayer = {}

function EnemyBulletLayer:create()
    layer = CCLayer:create()
    
    init(layer)
    
    return layer
end

function EnemyBulletLayer:addBullet(enemy)
    tolua.cast(enemy, "CCSprite")
    local enemyType = enemy:getTag()
    
    if enemyType == 3 then
        
        local bullet1 = BulletFactory:createBullet(enemyType)
        local x1, y1 = enemy:getPosition()
        bullet1:setPosition(x1 - 10, y1)
        bullet1:setRotation(30)
        bulletArray:addObject(bullet1)
        bulletBatchNode:addChild(bullet1)
        
        local bullet2 = BulletFactory:createBullet(enemyType)
        local x2, y2 = enemy:getPosition()
        bullet2:setPosition(x2, y2)
        bulletArray:addObject(bullet2)
        bulletBatchNode:addChild(bullet2)
        
        local bullet3 = BulletFactory:createBullet(enemyType)
        local x3, y3 = enemy:getPosition()
        bullet3:setPosition(x3 + 10, y3)
        bullet3:setRotation(-30)
        bulletArray:addObject(bullet3)
        bulletBatchNode:addChild(bullet3)
        
    else
        local bullet = BulletFactory:createBullet(enemyType)
        local x, y = enemy:getPosition()
        bullet:setPosition(x, y)
        bulletArray:addObject(bullet)
        bulletBatchNode:addChild(bullet)
    end
end

function EnemyBulletLayer:moveBullets()
    local index, len = 0, bulletArray:count()
    if len > 0 then
        local player = PlayerAgent:getPlayer()
        while index < len do
            local b = tolua.cast(bulletArray:objectAtIndex(index),"CCSprite")
            local r = b:getRotation() / 360 * math.pi
            local x = b:getPositionX() - math.sin(r) * EnemyBulletLayer_Bullet_Speed
            local y = b:getPositionY() - math.cos(r) * EnemyBulletLayer_Bullet_Speed
            if x < 0 or x > winSize.width or y < 0 then
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
                    PlayerAgent:playerHitten()
                    
                    return nil
                    
                else
                    -- move the bullet
                    b:setPositionX(x)
                    b:setPositionY(y)
                    index = index + 1
                end
           end
        end
    end
end