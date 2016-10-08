local GameUtils = class("GameUtils")

function GameUtils:ctor()
    self.version = HALL_VERSION
    self.storagepath = cc.FileUtils:getInstance():getWritablePath() .. "game" .. self.version
    self.realtimeSinceStartup = 0   --游戏自自启动后的运行时间    
end

function GameUtils:readJson(fileName)
	local FileUtils = cc.FileUtils:getInstance()
	local path = FileUtils:fullPathForFilename(fileName)
    print(path)
   
	return json.decode(FileUtils:getStringFromFile(path))
end

function GameUtils:md5(keystr)
    return cm_md5(keystr)
end

function GameUtils:base64Decode(str)
    return cm_base64decode(str)
end

function GameUtils:base64Encode(str)
    return cm_base64encode(str)
end

function GameUtils:jpush_setalias(uid)
    cm_jpush_setalias(uid)
end

-- 移动窗体开始
function GameUtils:win_dragstart()
    cm_win_dragstart()
end

-- 移动窗体开始
function GameUtils:win_drag(x, y)
    cm_win_drag(x, y)
end

-- 移动窗体开始
function GameUtils:win_dragend()
    cm_win_dragend()
end

--隐藏窗口
function GameUtils:win_minimum()
    cm_win_gominimum()
end

--窗口最大化
function GameUtils:win_maximize()    
    cm_win_gomaximize()
    local glview = cc.Director:getInstance():getOpenGLView()
    glview:setDesignResolutionSize(1024, GameUtils:win_getwhratio() * 1024, cc.ResolutionPolicy.FIXED_WIDTH)
end

--恢复窗口
function GameUtils:win_normal()    
    local w = SCREEN_SIZE.width
    local h = SCREEN_SIZE.height
    cm_win_gonormal(w, h)
    local glview = cc.Director:getInstance():getOpenGLView()
    glview:setDesignResolutionSize(w, h, cc.ResolutionPolicy.FIXED_WIDTH)
end

-- 获取窗口比例
function GameUtils:win_getwhratio()
    local ratio = cm_win_getratio()
    return ratio
end

function GameUtils:nullManifest(str)
    local i, j = string.find(str, "\"version\":")
    str = string.sub(str, 0, j)
    return str .. "\"0.0.0\"}"
end

--获取格式化后的游戏目录
function GameUtils:getGameRootDir(gameid)
    return "____" .. "game" .. tostring(gameid)
end

-- 注册当前游戏的搜索路径
function GameUtils:registerGamePath(gameid)
        local gamestr = self:getGameRootDir(gameid)
        local gamepath = cc.FileUtils:getInstance():getWritablePath() .. gamestr
        local respath = gamepath .. "/res/"
        local srcpath = gamepath .. "/src/"        
        cc.FileUtils:getInstance():addSearchPath(respath, true)
        cc.FileUtils:getInstance():addSearchPath(srcpath, true)        
        self:printPaths()
end

--取消按当前游戏的搜索路径
function GameUtils:unregisterGamePath(gameid)
    local searchPaths = cc.FileUtils:getInstance():getSearchPaths()
    local newpaths = {}
    local dir = self:getGameRootDir(gameid)
    local j = 1
    for i=1, #(searchPaths) do 
        local path = searchPaths[i]
        if string.find(path, dir) == nil then
            newpaths[j] = path
            j = j + 1
        end
    end
    cc.FileUtils:getInstance():setSearchPaths(newpaths)
    self:printPaths()
end

-- 获取游戏实际路径
function GameUtils:getpath(path, gameid)
        if ENABLE_UPDATE then
            return path
        else
            return "game" .. tostring(gameid) .. "/" .. path
        end
end

function GameUtils:SendEvent(evtname, msg)
    local event = cc.EventCustom:new(evtname)
    event._usedata = msg
    Dispatcher:dispatchEvent(event)
end

function GameUtils:RegEvent(evtname, callback)
    local open_ltn_sc = cc.EventListenerCustom:create(evtname, callback)    
    Dispatcher:addEventListenerWithFixedPriority(open_ltn_sc, 1)
end

function GameUtils:printPaths()
    --[[
    print(".................................................")
    local searchPaths = cc.FileUtils:getInstance():getSearchPaths()
    for i=1, #(searchPaths) do      
        print("searchpath = " .. searchPaths[i])
    end 
    print(".................................................")
    ]]
end

-- 获取用户头像图片地址
function GameUtils:gethead(headid)
    local headdata = CfgMgr:getHeaditem(headid)
    if headdata == nil then
        return "gameres/head/head001.png"
    end
    return "gameres/head/" .. headdata.head_resources .. ".png"
end

function GameUtils:getGoodsIcon(goodsid)
    local icon = ""

    if goodsid >= 1 and goodsid <= 10 then 
        icon = string.format("jindou%d.png", goodsid)
    elseif goodsid >= 11 and goodsid <= 15 then
        icon = string.format("jinbi%d.png", goodsid - 10)
    elseif goodsid >= 16 and goodsid <= 18 then
        icon = string.format("shiwuchongzhi%d.png", goodsid - 15)
    end

    return icon
end

function GameUtils:StringSplit(s, delim)
    if type(delim) ~= "string" or string.len(delim) <= 0 then
        return
    end

    local start = 1
    local t = {}

    if not(string.find (s, delim, start, true)) then
        table.insert (t, s)        
        return t
    end

    while true do
        local pos = string.find (s, delim, start, true) -- plain find
        if not pos then
          break
        end
        table.insert (t, string.sub (s, start, pos - 1))
        start = pos + string.len (delim)
    end
    table.insert (t, string.sub(s, start))

    return t
end

function GameUtils:random(scene, t)
    local rand = math.floor(math.random(35))
    if rand == 1 then
        scene = cc.TransitionJumpZoom:create(t, scene)
    elseif rand == 2 then
        scene = cc.TransitionProgressRadialCCW:create(t, scene)
    elseif rand == 3 then
        scene = cc.TransitionProgressRadialCW:create(t, scene)
    elseif rand == 4 then
        scene = cc.TransitionProgressHorizontal:create(t, scene)
    elseif rand == 5 then
        scene = cc.TransitionJumpZoom:create(t, scene)
    elseif rand == 6 then
        scene = cc.TransitionProgressVertical:create(t, scene)
    elseif rand == 7 then
        scene = cc.TransitionProgressInOut:create(t, scene)
    elseif rand == 8 then
        scene = cc.TransitionProgressOutIn:create(t, scene)
    elseif rand == 9 then
        scene = cc.TransitionPageTurn:create(t, scene)
    elseif rand == 10 then
        scene = cc.TransitionCrossFade:create(t, scene)
    elseif rand == 11 then
        scene = cc.TransitionCrossFade:create(t, scene)
--    elseif rand == 12 then
--        scene = cc.TransitionPageTurn:create(t, scene,false)
    elseif rand == 13 then
        scene = cc.TransitionFadeTR:create(t, scene)
    elseif rand == 14 then
        scene = cc.TransitionFadeBL:create(t, scene)
    elseif rand == 15 then
        scene = cc.TransitionFadeUp:create(t, scene)
    elseif rand == 16 then
        scene = cc.TransitionFadeDown:create(t, scene)
    elseif rand == 17 then
        scene = cc.TransitionTurnOffTiles:create(t, scene)
    elseif rand == 18 then
        scene = cc.TransitionSplitRows:create(t, scene)
    elseif rand == 19 then
        scene = cc.TransitionSplitCols:create(t, scene)
    elseif rand == 20 then
        scene = cc.TransitionFlipX:create(t, scene, cc.TRANSITION_ORIENTATION_LEFT_OVER)
    elseif rand == 21 then
        scene = cc.TransitionFlipY:create(t, scene, cc.TRANSITION_ORIENTATION_RIGHT_OVER)
    elseif rand == 22 then
        scene = cc.TransitionFlipAngular:create(t, scene, cc.TRANSITION_ORIENTATION_LEFT_OVER)
    elseif rand == 23 then
        scene = cc.TransitionZoomFlipX:create(t, scene, cc.TRANSITION_ORIENTATION_RIGHT_OVER)
    elseif rand == 24 then
        scene = cc.TransitionZoomFlipY:create(t, scene, cc.TRANSITION_ORIENTATION_UP_OVER)
    elseif rand == 25 then
        scene = cc.TransitionZoomFlipAngular:create(t, scene, cc.TRANSITION_ORIENTATION_RIGHT_OVER)
    elseif rand == 26 then
        scene = cc.TransitionShrinkGrow:create(t, scene)
    elseif rand == 27 then
        scene = cc.TransitionRotoZoom:create(t, scene)
    elseif rand == 28 then
        scene = cc.TransitionMoveInL:create(t, scene)
    elseif rand == 29 then
        scene = cc.TransitionMoveInR:create(t, scene)
    elseif rand == 30 then
        scene = cc.TransitionMoveInT:create(t, scene)
    elseif rand == 31 then
        scene = cc.TransitionMoveInB:create(t, scene)
    elseif rand == 32 then
        scene = cc.TransitionSlideInL:create(t, scene)
    elseif rand == 33 then
        scene = cc.TransitionSlideInR:create(t, scene)
    elseif rand == 34 then
        scene = cc.TransitionSlideInT:create(t, scene)
    elseif rand == 35 then
        scene = cc.TransitionSlideInB:create(t, scene)
    end
    return scene
end

return GameUtils