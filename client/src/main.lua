local file = io.open(cc.FileUtils:getInstance():getWritablePath() .. os.date("%d") ..".txt","a")

--  Ð´ÈëÎÄ¼þlog
local function debugprint(msg)
    file:write(os.date("%c") .. "           ")
    file:write(tostring(msg))
    file:write("\n")
    file:flush()
    release_print(msg)
end

print = debugprint

cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")

require "config"
require "cocos.init"

local function main()
    local scn = require("scene2"):createScene(1, {ip="localhost", port=8080})
	cc.Director:getInstance():replaceScene(scn)
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
