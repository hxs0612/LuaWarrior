local enemyTextrue

EnemyFactory = {}

function EnemyFactory:init()
    -- load textrue
    enemyTextrue = CCTextureCache:sharedTextureCache():addImage(EnemyFactory_EnemyTextrue)
end

function EnemyFactory:createEnemy(enemyType)
    local enemy
    if enemyType == 1 then
        enemy = CCSprite:createWithTexture(enemyTextrue, CCRectMake(64, 59, 45, 25))
        enemy:setTag(1)
    elseif enemyType == 2 then
        enemy = CCSprite:createWithTexture(enemyTextrue, CCRectMake(69, 86, 53, 28))
        enemy:setTag(2)
    end
    return enemy
end