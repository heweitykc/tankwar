local GameClient = class("GameClient")  --游戏client

function GameClient:ctor()
      self.wsclient = require("network.ws").new()      
end

function GameClient:init(sockid, addr)
    self.wsclient:init(sockid, addr)
end

function GameClient:addCallback(recvFunc, errFunc)
    self.wsclient:addCallback(recvFunc, errFunc)
end

function GameClient:send(msg)
    self.wsclient:send(msg)
end

function GameClient:connect()
    self.wsclient:connect()
end

function GameClient:close()
    self.wsclient:close()
end

return GameClient
