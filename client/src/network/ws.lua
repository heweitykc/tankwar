local WsClient = class("WsClient")  --websocket client

function WsClient:ctor()
    self.msglist = require("base/list").new()    
    local scheduler = cc.Director:getInstance():getScheduler()
    self.schedulerRef = scheduler:scheduleScriptFunc(self:update(), 0, false)    
    self.sockid = 0
end

function WsClient:init(sockid, addr)
    self.sockid = sockid
    self.addr = addr
end

function WsClient:addCallback(recvFunc, errFunc)
    self.recvFunc = recvFunc
    self.errFunc = errFunc
end

function WsClient:connect()
    cm_wsconnect(self.addr, self.sockid)
end

function WsClient:_send(msg)
    -- local now = os.tick();
    print("send msg:" .. msg..  "   --    ")
    cm_wssend(msg, self.sockid)
end

function WsClient:send(msg)
     print("send:" .. tostring(msg))
     local jsonstr = json.encode(msg)
     self.msglist:pushfirst(jsonstr)

     -- local ret = cm_wscheckstatus(self.sockid)
     -- if ret ~= Enum.NET_STATUS.CONNECTED and  ret ~= Enum.NET_STATUS.CONNECTING then
        -- self:connect(self.addr)
     -- end
end

function WsClient:getStatus()
    local ret = cm_wscheckstatus(self.sockid)
    return ret
end

function WsClient:update()
    return function (dt)
        local ret = cm_wscheckstatus(self.sockid)
        if ret ~= Enum.NET_STATUS.CONNECTED then
            return  --未连接，直接返回
        end        

        -- 接收数据
        local ret = cm_wscheckmsg(self.sockid)
        if ret ~= 0 then 
            local msg =  json.decode(ret)
            print("recv:" .. ret .. "   --    ")
            self.recvFunc(msg)
        end
        
        -- 一次最多发2条
        if self.msglist:size() > 0 then  self:_send(self.msglist:poplast())  end
        if self.msglist:size() > 0 then  self:_send(self.msglist:poplast())  end
    end
end

function WsClient:close()
    print("close socket...")
    cm_wsclose(self.sockid)
end

return WsClient