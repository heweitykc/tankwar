local Enum = {}                 --公共枚举

--当前场景状态
local PLATFORM = {}
PLATFORM.PC = 0            -- PC平台
PLATFORM.MOBILE = 1    -- 移动平台
Enum.PLATFORM = PLATFORM

local EMAILTYPE = {}
EMAILTYPE.RANK = 1
EMAILTYPE.FRIENDGOLD = 2
EMAILTYPE.FRIENDGIFT = 3
EMAILTYPE.FRIENDAPPLY = 4
EMAILTYPE.SYSTEM = 5
Enum.EMAILTYPE = EMAILTYPE

local TASKSTATUS = {}
TASKSTATUS.HANDING = 0   -- 进行中
TASKSTATUS.DONE = 1         -- 已完成
Enum.TASKSTATUS = TASKSTATUS

local SHOPTYPE = {}
SHOPTYPE.GOLDBEAN = 1
SHOPTYPE.GOLD = 2
SHOPTYPE.RMB = 3
Enum.SHOPTYPE = SHOPTYPE

-- UI窗口类型
local UI_WINTYPE = {}
UI_WINTYPE.NONE = 0             --无
UI_WINTYPE.FULLSCREEN = 1   --全屏窗口
UI_WINTYPE.DIALOG = 2          --弹出窗口
Enum.UI_WINTYPE = UI_WINTYPE

-- 网络状态
local NET_STATUS = {}
NET_STATUS.CONNECTED = 0    --已连接
NET_STATUS.BROKEN = 1           --连接断开
NET_STATUS.ERROR = 2                --连接错误
NET_STATUS.CONNECTING = 3   --连接中
Enum.NET_STATUS = NET_STATUS

--当前场景状态
local GAME_STATE = {}
GAME_STATE.LOGIN = 0    -- 登录
GAME_STATE.LOBBY = 1    -- 大厅
GAME_STATE.GAME = 2     -- 游戏
Enum.GAME_STATE = GAME_STATE

return Enum