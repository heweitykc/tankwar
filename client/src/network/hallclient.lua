local HallClient = class("HallClient")  --����client

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

-- �����¼��Ϣ
function HallClient:logout()
    self.login_msg = nil
    local ret = self.wsclient:getStatus()
    if ret == CONNECTED then
        self.wsclient:close()
    end
end

function HallClient:send(msg)
    local ret = self.wsclient:getStatus()

    -- ���ߴ���
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