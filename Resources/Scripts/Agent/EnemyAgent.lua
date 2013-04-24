EnemyAgent = {}

function EnemyAgent:create(scene)
    
    local enemyLayer = EnemyLayer:create()
    enemyLayer:setPosition(0, 0)
    scene:addChild(enemyLayer)
    
    local enemyBulletLayer = EnemyBulletLayer:create()
    enemyBulletLayer:setPosition(0, 0)
    scene:addChild(enemyBulletLayer)
    
end

function EnemyAgent:getEnemyArray()
    return EnemyLayer:getEnemyArray()
end

function EnemyAgent:addEnemy(param)
    EnemyLayer:addEnemy(param)
end

function EnemyAgent:shot()
    local enemyArray = EnemyLayer:getEnemyArray()
    local index, len = 0, enemyArray:count()
    local enemy
    while index < len do
        enemy = enemyArray:objectAtIndex(index)
        EnemyBulletLayer:addBullet(enemy)
        index = index + 1
    end
end

function EnemyAgent:moveBullets()
    EnemyBulletLayer:moveBullets()
end