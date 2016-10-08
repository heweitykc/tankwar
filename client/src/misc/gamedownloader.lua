local GameDownloader= class("GameDownloader")

function GameDownloader:ctor()        
        self.updater = require("hotupdate/resupdater"):new()
end

function GameDownloader:init(gameid, foundUpdate, updateProgress, updateOK, updateFailed)
    self.gameid = gameid
    self.updateFailed = updateFailed
    self.updater:addCallback(foundUpdate, updateProgress, updateOK, updateFailed)
end

-- 开始下载\更新游戏
function GameDownloader:startUpdate()
    -- 先检查本地是否有游戏
    -- 如果没有，先down一个白的manifest到缓存        
    -- 检查更新
    -- 进入游戏
    
    local gamestr = GameUtils:getGameRootDir(self.gameid)
    local storagepath = cc.FileUtils:getInstance():getWritablePath() .. gamestr .. "/"
    local manifestpath = "project.manifest"
    local localmanifest =  storagepath .. manifestpath

    local that = self    

    print(gamestr .. "  storagepath = " .. storagepath)

    local function preloadOK(msg)
        print(" preloadOK: " .. localmanifest)
        cc.FileUtils:getInstance():createDirectory(storagepath)
        local nullmanifestContent = GameUtils:nullManifest(msg)
        print("nullmanifestContent = "  .. nullmanifestContent)
        cc.FileUtils:getInstance():writeStringToFile(nullmanifestContent, localmanifest)
        that.updater:startUpdate()
    end

    local function preloadFail(status)
        local log = "manifest load failed " .. tostring(status)
        print(log)
        self.updateFailed(log)
    end
    
    self.updater:setPath(gamestr .. "/" .. manifestpath, storagepath)    
    if cc.FileUtils:getInstance():isFileExist(localmanifest) then
        self.updater:startUpdate()
    else
        local url = CfgMgr.SERVERCONFIG.hotupdate .. "game" .. tostring(self.gameid) .. "/version.manifest"
        print("start download...")        
        HttpMgr:Req(url, preloadOK, preloadFail)                
    end

end

function GameDownloader:startDownload()    
    self.updater:update()
end

return GameDownloader
