local AnimationSprite = class("AnimationSprite", cc.Sprite)

-- 动画精灵
function AnimationSprite:Init(animinfo)
    self.body = cc.Sprite:create()
    self:addChild(self.body)
    local spriteFrameCache = cc.SpriteFrameCache:getInstance()
    self.animations = {}
    for k, item in pairs(animinfo) do
        local animation = cc.Animation:create()
        for i, val in ipairs(item) do      
            local frm = spriteFrameCache:getSpriteFrame(val)
            animation:addSpriteFrame(frm)
        end
        animation:setDelayPerUnit(0.033)
        self.animations[k] = cc.Animate:create(animation)
    end
end

-- 播放动画
function AnimationSprite:Play(animName)
    self.body:stopAllActions()    
    self.body:runAction(cc.RepeatForever:create(self.animations[animName]))
end

return AnimationSprite