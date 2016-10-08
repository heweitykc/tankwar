-- UI模块的基类

local UILayer = class("UILayer")

-- uipath为layer.csb的路径
function UILayer:ctor(uipath)
    local visi_size = cc.Director:getInstance():getVisibleSize()    
    self.rootNode = cc.CSLoader:createNode(uipath)
    self.rootNode:setContentSize(visi_size)
    ccui.Helper:doLayout(self.rootNode)
    self.winType = Enum.UI_WINTYPE.NONE
    self.Title = "title"
end

-- 重新设置大小
function UILayer:resize(w, h)
    local size = cc.size(w, h)
    self.rootNode:setContentSize(size)    
    ccui.Helper:doLayout(self.rootNode)
end

-- 获取UI节点
function UILayer:getNode(path)    
    local list = GameUtils:StringSplit(path,"/")

    if list == nil then
        print("找不到节点：" .. path)
        return nil
    end

    local len = #list;
    local current = self.rootNode:getChildByName(list[1])
    if len <= 1 then 
        return current 
    end

    for i = 2, #list  do 
        if(current == nil ) then break end
        current = current:getChildByName(list[i])
    end
    return current
end

-- 注册按钮等控件的回调事件等
-- btnAnimation 是否增加按钮动画
-- downfunc 鼠标按下时调用
function UILayer:registerCB(btnName, func, btnAnimation, downfunc)
    local btnNode = self:getNode(btnName)
    local function funcext(btnNode)
        func(btnName)
    end
    UIUtils:registerCB(btnNode, funcext, btnAnimation, downfunc)
end

-- 注册OnEnter OnExit 事件
function UILayer:resgiterSceneEvent(onEnter, onExit, onEnterFinish)
    local function sceneEvent(eventType)
            if eventType == "enter" then 
                onEnter()
            elseif eventType == "enterTransitionFinish" then 
                if onEnterFinish ~= nil then onEnterFinish() end                                    
            elseif eventType == "exit" then 
                onExit()
            end
    end
    self.rootNode:registerScriptHandler(sceneEvent)
end

-- 弹出UI
function UILayer:show()    
    self.rootNode:stopAllActions()
    
    if  self.winType == Enum.UI_WINTYPE.FULLSCREEN then
        self.rootNode:setVisible(true)
        if PLATFORM == Enum.PLATFORM.MOBILE then
            UIMgr:PopUI(self.rootNode)
        else
            UIMgr:PopWinUI(self.rootNode, self.Title)
        end
    elseif self.winType == Enum.UI_WINTYPE.DIALOG then
        local function callback()
            if self.rootNode.setTouchEnabled ~= nil then
                self.rootNode:setTouchEnabled(true)
            end 
        end    
        UIMgr:PopUI(self.rootNode)        

        local child = self.rootNode:getChildren()[2]
        if child ~= nil then
            child:setScale(0.01)
            local acts = cc.Sequence:create(cc.ScaleTo:create(0.2, 1), cc.CallFunc:create(callback))
            child:runAction(acts)
        else
            callback()
        end
    else
        self.rootNode:setVisible(true)
    end    
end

--关闭UI
function UILayer:hide()
    self.rootNode:stopAllActions()
    local that = self
    
    if self.winType == Enum.UI_WINTYPE.FULLSCREEN then
       --local acts = cc.Sequence:create(cc.MoveTo:create(0.4, cc.p(-1*UIUtils.resolution.width, 0)), cc.CallFunc :create(callback))
       --self.rootNode:runAction(acts)
       --callback()
       self.rootNode:setVisible(false)
       if PLATFORM == Enum.PLATFORM.MOBILE then
            UIMgr:CloseUI(self.rootNode, false)            
        else
            UIMgr:CloseWinUI(self.rootNode)
        end
    elseif self.winType == Enum.UI_WINTYPE.DIALOG then
        local function callback()
            UIMgr:CloseUI(self.rootNode, false)
        end    
       local child = self.rootNode:getChildren()[2]
       if self.rootNode.setTouchEnabled ~= nil then
            self.rootNode:setTouchEnabled(false)
       end
       if child ~= nil then
            local acts = cc.Sequence:create(cc.ScaleTo:create(0.2, 0.01), cc.CallFunc:create(callback))
            child:runAction(acts)
       else
            callback()
       end  
    else
        self.rootNode:setVisible(false)
    end
        
end

-- 该UI是否在显示
function UILayer:isVisible()
    return self.rootNode:isVisible()
end

return UILayer