local jsonmgr = class("jsonmgr")
jsonmgr.__index = jsonmgr

function jsonmgr:ctor()
    self:init()
end

function jsonmgr:readJson(fileName)
	local FileUtils = cc.FileUtils:getInstance()
	local path = FileUtils:fullPathForFilename(fileName)
    print(path)
	return json.decode(CCString:createWithContentsOfFile(path):getCString())
end

function jsonmgr:init()
    
end

return jsonmgr