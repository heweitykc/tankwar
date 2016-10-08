-- 游戏场景基类
local GameClient = require("network/gameclient")

local GameMain1 = {} 

local NETMSG = {
    ENTER = 10000,    MOVE = 10010,   FIRE = 10020,
    _ENTER = 10001,  _MOVE = 10011,  _FIRE = 10021, _NEWPLAYER = 20001
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
        if msg.msg_id == NETMSG._ENTER then
            
        elseif msg.msg_id == NETMSG._MOVE then
            
        elseif msg.msg_id == NETMSG._FIRE then
		
        elseif msg.msg_id == NETMSG._NEWPLAYER then
		
        end
    end
end

function GameMain1:errFunc()
    return function(errcode)
        UIMgr:ShowDialog("error " .. tostring(errcode))
    end
end


return GameMain1
