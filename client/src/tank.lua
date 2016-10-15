local Tank = class("Tank", cc.Sprite)

function Tank:ctor()
    local spriteFrameCache = cc.SpriteFrameCache:getInstance()
    spriteFrameCache:addSpriteFrames("common.plist")
	
	self.setSpriteFrame(spriteFrameCache:getSpriteFrameByName("mingciyuanpan.png"))
	
end

return Tank