local HallClient = class("HallClient")  --大厅client

local SOCK_ID = 2

function HallClient:ctor() 
    self.wsclient = require("network.ws").new()    
    self.wsclient:init()
end

function HallClient:init()
    self.wsclient:init(SOCK_ID, CfgMgr.SERVERCONFIG.wsserver)    
end

function HallClient:connect()
    self.wsclient:connect()
end

function HallClient:addCallback(recvFunc, errFunc)
    self.wsclient:addCallback(recvFunc, errFunc)
end

-- 清除登录信息
function HallClient:logout()
    self.login_msg = nil
    local ret = self.wsclient:getStatus()
    if ret == CONNECTED then
        self.wsclient:close()
    end
end

function HallClient:send(msg)
    local ret = self.wsclient:getStatus()

    -- 断线处理
    if ret ~= Enum.NET_STATUS.CONNECTED and HallApp.currentState ~= Enum.GAME_STATE.LOGIN then
        self.wsclient.msglist:clear()
        UIMgr:ShowNetError()
        return
     end

    self.wsclient:send(msg)
end

function HallClient:close()
    self.wsclient:close()
end

return HallClient