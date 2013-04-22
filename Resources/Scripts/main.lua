-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

cclog = function(...)
	print(string.format(...))
end

local function main()
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
	
	require "resources"
    require "Agent/SceneAgent"
    
    -- silence
	SimpleAudioEngine:sharedEngine():stopBackgroundMusic()
    
    local scene = SceneAgent:createScene(WelcomeScene)
    CCDirector:sharedDirector():runWithScene(scene)
end

xpcall(main, __G__TRACKBACK__)
