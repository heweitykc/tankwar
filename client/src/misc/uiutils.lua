local UIUtils = class("UIUtils")

function UIUtils:ctor()
    local glview = cc.Director:getInstance():getOpenGLView()
    self.resolution = glview:getDesignResolutionSize()
    print("resolution w = " .. self.resolution.width .. "  h = " .. self.resolution.height)
    self.centerPos = cc.p(self.resolution.width/2, self.resolution.height/2)
    self.coolTime = 0   -- 交互的冷却时间

    print("curren resolution :" .. tostring(self.resolution.width) .. "-" .. tostring(self.resolution.height))
end

-- UI布局 居中, node的锚点默认0,0
function UIUtils:center(node, offset)
    local size = node:getContentSize()
    if offset == nil then
        node:setPosition((self.resolution.width - size.width)/2, (self.resolution.height - size.height)/2)
    else
        node:setPosition((self.resolution.width - size.width -  offset.x)/2 + offset.x, (self.resolution.height - size.height -  offset.y)/2 + offset.y)
    end
end

-- UI布局 上居中, node的锚点默认0,0
function UIUtils:centertop(node, offset)
    local size = node:getContentSize()
    if offset == nil then
        node:setPosition((self.resolution.width - size.width)/2, self.resolution.height - size.height)
    else
        node:setPosition((self.resolution.width - size.width -  offset.x)/2 + offset.x, self.resolution.height - size.height + offset.y)        
    end
end

-- UI布局 下居中, node的锚点默认0,0
function UIUtils:centerbottom(node, offset)
    local size = node:getContentSize()
    if offset == nil then
        node:setPosition((self.resolution.width - size.width)/2, 0)
    else
        node:setPosition((self.resolution.width - size.width -  offset.x)/2 + offset.x, offset.y)
    end
end

-- UI布局 左边居中, node的锚点默认0,0
function UIUtils:leftcenter(node, offset)
    local size = node:getContentSize()
    if offset == nil then
        node:setPosition(0, (self.resolution.height - size.height)/2)
    else
        node:setPosition(0+offset.x, (self.resolution.height - size.height - offset.y)/2 + offset.y)
    end
end

-- UI布局 右边居中, node的锚点默认0,0
function UIUtils:rightcenter(node, offset)
    local size = node:getContentSize()
    if offset == nil then
        node:setPosition(self.resolution.width - size.width,  (self.resolution.height - size.height)/2)
    else
        node:setPosition(self.resolution.width - size.width+offset.x,  (self.resolution.height - size.height - offset.y)/2+offset.y)
    end
end

-- UI布局 右上, node的锚点默认0,0
function UIUtils:righttop(node, offset)
    local size = node:getContentSize()
    if offset == nil then
        node:setPosition(self.resolution.width - size.width, self.resolution.height - size.height)
    else
        node:setPosition(self.resolution.width - size.width+offset.x, self.resolution.height - size.height+offset.y)
    end
end

-- UI布局 左上, node的锚点默认0,0
function UIUtils:leftop(node, offset)
    local size = node:getContentSize()
    if offset == nil then
        node:setPosition(0,  self.resolution.height - size.height)
    else
        node:setPosition(0+offset.x,  self.resolution.height - size.height+offset.y)
    end
end

-- UI布局 右下, node的锚点默认0,0
function UIUtils:rightbottom(node, offset)
    local size = node:getContentSize()
    if offset == nil then
        node:setPosition(self.resolution.width - size.width, 0)
    else
        node:setPosition(self.resolution.width - size.width +offset.x , 0+offset.y)
    end
end

-- UI布局 左下
function UIUtils:leftbottom(node,offset)
    local size = node:getContentSize()
    if offset == nil then
        node:setPosition(0,  0)
    else
        node:setPosition(0 +offset.x,  0 +offset.y)
    end
end

-- UI布局 将node得高度填充满
function UIUtils:fillHeight(node, otherheight)
    local size = node:getContentSize()
    size.height = self.resolution.height - otherheight
    node:setContentSize(size)
    ccui.Helper:doLayout(node)
    return  size.height 
end

-- 带按钮起伏效果
function UIUtils:registerCB(btnNode, func, btnAnimation, downfunc)
    if btnAnimation == nil then 
        btnAnimation = true
    end
    if not btnAnimation then
        local function btndown(sender, eventType)
            if eventType ~= ccui.TouchEventType.ended then return end            
            func(btnNode)
            AudioMgr:playEffect(2)
            if downfunc ~= nil then downfunc() end
        end
        btnNode:addTouchEventListener(btndown)
        return
    end
    
    local function btn_cb(sender, eventType)
        if eventType == ccui.TouchEventType.began then             
            sender:stopAllActions() 
            sender:runAction(cc.ScaleTo:create(0.05, 0.92))
            --sender:runAction(cc.ScaleBy:create(0.05, 0.92))
            if downfunc ~= nil then downfunc() end
        elseif eventType == ccui.TouchEventType.canceled then             
            sender:stopAllActions() 
            sender:runAction(cc.ScaleTo:create(0.05, 1))
            --sender:runAction(cc.ScaleBy:create(0.05, 1.0 / 0.92))
        elseif eventType == ccui.TouchEventType.ended then
            sender:stopAllActions() 
            sender:runAction(cc.ScaleTo:create(0.05, 1))
            --sender:runAction(cc.ScaleBy:create(0.05, 1.0 / 0.92))            

            -- 整个界面的按钮1秒只能交互一次
            local now = GameUtils.realtimeSinceStartup
            if (now - self.coolTime) < 0.3 then return end                    
            self.coolTime = now            
            func(btnNode)
            AudioMgr:playEffect(2)            
        end
    end
    btnNode:addTouchEventListener(btn_cb)

    if PLATFORM == Enum.PLATFORM.PC then
        local function onMouseMove(event)
            local rect = btnNode:getBoundingBox()
            local pos = event:getLocationInView()
            local locationInNode = btnNode:getParent():convertToNodeSpace(pos)
            if cc.rectContainsPoint(rect, locationInNode) then
                btnNode:setColor(cc.c3b(255, 255, 255))
            else            
                btnNode:setColor(cc.c3b(220, 220, 220))
            end        
        end
        btnNode:setColor(cc.c3b(220, 220, 220))
        local mouseListener = cc.EventListenerMouse:create()
        mouseListener:registerScriptHandler(onMouseMove,    cc.Handler.EVENT_MOUSE_MOVE)
        local eventDispatcher = btnNode:getEventDispatcher()
        eventDispatcher:addEventListenerWithSceneGraphPriority(mouseListener, btnNode)
    end
end

-- 任务引导
function UIUtils:DoTask(taskid, params)
    local lobbyui = UIMgr:GetLobbyUI()
    if taskid == 1001 then
        lobbyui:showPersonal(0)
    elseif taskid == 1002 then
        
    elseif taskid == 1003 then
        
    elseif taskid == 1004 then
        lobbyui:showSignin()
    elseif taskid == 1005 then
        lobbyui:showSignin()
    elseif taskid == 1006 then
        lobbyui:showBank(1)
    elseif taskid == 1007 then
        lobbyui:showBank(1)
    elseif taskid == 1008 then
        lobbyui:showBank(1)
    elseif taskid == 1009 then
        lobbyui:showSecretary()
    elseif taskid == 1010 then
        lobbyui:showMall(Enum.SHOPTYPE.GOLD)
    elseif taskid == 1011 then
        lobbyui:showBank(2)
    elseif taskid == 1012 then
        
    elseif taskid>1012 and taskid<1040 then
        lobbyui:showMall(Enum.SHOPTYPE.GOLDBEAN)
    end
end

-- 延迟调用某函数
function UIUtils:delayCall(key, func, delay)
    if self.delaycalls == nil then
        self.delaycalls = {}
    end    
    local  scheduler = cc.Director:getInstance():getScheduler()
    if self.delaycalls[key] == nil then
        local function delayfunc()            
            scheduler:unscheduleScriptEntry(self.delaycalls[key])
            self.delaycalls[key] = nil
            func()
        end        
        local schedulerEntry = scheduler:scheduleScriptFunc(delayfunc, delay, false)
        self.delaycalls[key] = schedulerEntry
    end
end

-- 达到10位使用中文单位“亿"
function UIUtils:formatMoney(val)    
    if val > 99999999 then
        val = val/100000000
        return  string.format(StrCfg.money_str, val)
    end
    return tostring(val)
end

--计算UTF8字符串长度, 
function UIUtils:utfstrlen(str)
    local len = #str
    local left = len
    local cnt = 0
    local arr={0,0xc0,0xe0,0xf0,0xf8,0xfc}
    while left ~= 0 do
        local tmp=string.byte(str,-left)
        local i=#arr
        while arr[i] do
            if tmp>=arr[i] then left=left-i;break;end
            i=i-1
        end
        cnt=cnt+1
    end
    return cnt
end

--时间戳转换为日期
function UIUtils:UnixTimeToDate(time, _format)
    local format = _format or "%Y/%m/%d %H:%M"
    return os.date(format,tonumber(time))
end

-- 初始化带动画的node节点
-- animPath 动画文件路径
-- 返回 能播放节点动画的函数
function UIUtils:initUIAnimation(effectNode, animPath, loop)
    return function ()
        effectNode:setVisible(false)
        effectNode:stopAllActions()
        effectNode:setVisible(true)

        local signinAction0 = cc.CSLoader:createTimeline(animPath)
        effectNode:runAction(signinAction0)
        signinAction0:play("animation1", false)    
        signinAction0:gotoFrameAndPause(100)    --暂停到动画结尾        
        signinAction0:gotoFrameAndPlay(1, loop)
        
        return signinAction0    
    end
end

function UIUtils:dumpUI(node)
    print("current ui json tree ")
    self.uitree = ""
   -- self:__dumpUI(node, 0, true)
    print("{" .. self.uitree .. "}")
end

-- dump当前场景的UI结构
function UIUtils:__dumpUI(node, layerCnt, isLast)
    local name = node:getName()
    if name == nil or name == "" then
        name = "none"
    end
    local cnt = node:getChildrenCount()
    local isvisible = node:isVisible()
    local key = ""
    local touchstr = ""
    if node.isTouchEnabled and node:isTouchEnabled()  then        
        touchstr = "_active"
    else
        touchstr = ""
    end
    if isvisible then
        key ="\"" .. name .. touchstr .. "\" : "
    else
        key ="\"____" .. name .. touchstr .. "\" : "
    end
    self.uitree = self.uitree .. key
    if cnt <= 0 then
        if isLast then self.uitree = self.uitree .."0"
        else self.uitree = self.uitree .. "0," end                    
        return 
    end
    self.uitree = self.uitree .. "{"
    local children = node:getChildren()
    for i= 1, cnt do
        local child = children[i]
        self:__dumpUI(child, layerCnt+1, i == cnt)
    end
    if isLast then self.uitree = self.uitree .. "}"
    else  self.uitree = self.uitree .. "},"  end
end

-- 设置输入框的光标
function UIUtils:InitInputCursor(tf)
    if tf.setCursorEnabled and PLATFORM == Enum.PLATFORM.PC then
        tf:setCursorEnabled(true)
        tf:setCursorChar(124)
    end
end

return UIUtils
