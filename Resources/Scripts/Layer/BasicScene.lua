BasicScene = {
	winSize,
	setWinSize,
	setBackground,
}

function BasicScene:setWinSize()
	self.winSize = CCDirector:sharedDirector():getWinSize()
end

function BasicScene:setBackground()
	
end

local function sceneEventHandler(isOnEnter)
    if isOnEnter then
        if scene.onEnter then scene:onEnter() end
    else
        if scene.onExit then scene:onExit() end
    end
end

scene:registerScriptHandler(sceneEventHandler)