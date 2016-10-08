-- 游戏场景基类
local GameClient = require("network/gameclient")

local GameMain1 = {} 

local NETMSG = {
    ENTER = 10000,  BET = 10002, 
    _UPDATE_SEAT=20000, _UPDATE_BET = 20002, _GAME_RESULT = 20004
}

local COMMON_COLOR = cc.c3b(255,255,255)
local HIGHLIGHT_COLOR = cc.c3b(0,0,255)
local BET = {10, 100, 1000}
local TYPE = {DA=1,XIAO=2,HE=3}

local GAME_PHASE = {
    TOTAL=25, BET = 15, RESULT = 10    
} 

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
    -- scene:addChild(self.ui.rootNode)

    local function onEnter()
        self:sendEnterGame()        
    end

    local function onExit()
        self:exitGame()
    end

    -- self.ui:resgiterSceneEvent(onEnter, onExit)
    return scene
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
        if msg.msg_id == NETMSG._UPDATE_SEAT then
            self:onSeatData(msg)
        elseif msg.msg_id == NETMSG._UPDATE_BET then
            self:onBetData(msg)
        elseif msg.msg_id == NETMSG._GAME_RESULT then
            self:onGameResult(msg)
        end
    end
end

function GameMain1:errFunc()
    return function(errcode)
        UIMgr:ShowDialog("错误 " .. tostring(errcode))
    end
end


return GameMain1
