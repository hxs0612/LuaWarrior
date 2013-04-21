local function getBulletFrame(enemyType)
    if enemyType == 1 then
        return EnemyBulletLayer_Bullet_Frame1
    elseif enemyType == 2 then
        return PlayerBulletLayer_Bullet_Frame
    end
end

BulletFactory = {}

function BulletFactory:init()
    -- todo
end

function BulletFactory:createBullet(enemyType)
    local bullet = CCSprite:createWithSpriteFrameName(getBulletFrame(enemyType))
    bullet:setTag(enemyType)
    return bullet
end

-- function BulletFactory:getBulletSize(bulletType)
--     if bulletType == 1 then
--         return 3, 3
--     elseif bulletType == 2 then
--         return 3, 6
--     end
-- end