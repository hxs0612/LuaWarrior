EffectFactory = {}

function EffectFactory:init()
    -- preload the explosion frame
    CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile(EffectFactory_Explosion_plist)
    
    -- push boom animation into cache
    local boomAnimation = CCAnimation:create()
    boomAnimation:setDelayPerUnit(0.05)
    boomAnimation:setLoops(1)
    
    local i = 1
    while i <= EffectFactory_Boom_Len do
        local frameName = string.format("explosion_%02d.png", i)
        local frame = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(frameName)
        boomAnimation:addSpriteFrame(frame)
        i = i + 1
    end
    
    CCAnimationCache:sharedAnimationCache():addAnimation(boomAnimation, EffectFactory_Boom)
end

function EffectFactory:createBoomActions()
    
    local animation = CCAnimationCache:sharedAnimationCache():animationByName(EffectFactory_Boom)
    local animate = CCAnimate:create(animation)
    
    local function boom_callback(node)
        node:removeFromParentAndCleanup(true)
    end
    
    local callback = CCCallFuncN:create(boom_callback)
    local array = CCArray:create()
    array:addObject(animate)
    array:addObject(callback)
    local actions = CCSequence:create(array)
    
    return actions
end