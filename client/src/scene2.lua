-- 游戏场景基类
local GameClient = require("network/gameclient")
print = release_print

local GameMain1 = {} 

local NETMSG = {
    ENTER = 10000,    MOVE = 10010,   FIRE = 10020,
    _ENTER = 10001,  _MOVE = 10011,  _FIRE = 10021
}

local COMMON_COLOR = cc.c3b(255,255,255)
local HIGHLIGHT_COLOR = cc.c3b(0,0,255)

function GameMain1:createScene(gameid, gameinfo)
	cc.exports.Enum = require("enum")
		
    local scene = cc.Scene:create() 
    local path = string.format("ws://%s:%s/game", gameinfo.ip, gameinfo.port)
    self.gameid = gameid

    self.client = GameClient.new()
    self.client:init(self.gameid, path)
    self.client:addCallback(self:recvFunc(), self:errFunc())
    self.client:connect()
    self.gameinfo = gameinfo

    self:init()
	self.ui = cc.Layer:create()
    scene:addChild(self.ui)
    
    local httpLabel = ccui.Text:create("", "", 20)
	self.ui:addChild(httpLabel)	
	httpLabel:setPosition(cc.p(200,200))
	
	self:sendEnterGame()
	
    return scene
end

function GameMain1:sendEnterGame()
    local msgobj = {}
    msgobj["id"] = NETMSG.ENTER	
    self.client:send(msgobj)
end

function GameMain1:exitGame()
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerRef) --反注册主循环
    self.client:close()
end

function GameMain1:init()
    print("GameMain 1 : init")    

    local scheduler = cc.Director:getInstance():getScheduler()
    self.schedulerRef = scheduler:scheduleScriptFunc(self:loopFunc(), 0, false)    
end

function GameMain1:loopFunc()
    return function (deltatime)
		
    end
end

function GameMain1:recvFunc()
    return function(msg)		
		print("msg = " ..  json.decode(msg))
        if msg.id == NETMSG._ENTER then			
            if msg.init ~= nil then self:initRoom(msg)
			elseif msg.enter ~= nil then self:playerEnter(msg)
			elseif msg.leave ~= nil then self:playerLeave(msg)
			end
        elseif msg.id == NETMSG._MOVE then
            
        elseif msg.id == NETMSG._FIRE then
		
        elseif msg.id == NETMSG._NEWPLAYER then
		
        end
    end
end

function GameMain1:initRoom(msg)	
	local num = table.nums(msg.room)
	for k, p in  pairs(msg.room) do
		print("p.uid = " .. p.uid)
	end
end

function GameMain1:playerEnter(msg)
	print("playerEnter")
end

function GameMain1:playerLeave(msg)
	print("playerLeave")
end

function GameMain1:errFunc()
    return function(errcode)
        UIMgr:ShowDialog("error " .. tostring(errcode))
    end
end

return GameMain1
