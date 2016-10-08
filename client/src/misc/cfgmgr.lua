local cfgmgr = class("cfgmgr")

-- 大厅的配置文件
function cfgmgr:ctor()
    print("cfgmgr inited")
    self:init()
end

function cfgmgr:init()
    local FileUtils = cc.FileUtils:getInstance()
    self.SERVERCONFIG= GameUtils:readJson("config/serverConfig.json")
    print("hotupdate addr :" .. self.SERVERCONFIG.hotupdate)

    --self.AGREEMENT= FileUtils:getStringFromFile("config/agreement.txt")        

    self.DICT_CFG = require("config.dictionary_cfg")
    self.HEAD_CFG = require("config.head_cfg")
    self.IMAGE_CFG = require("config.image_cfg")
    self.TASK_CFG = require("config.task_cfg")
    self.VIP_CFG = require("config.vip_cfg")
    self.VIP_DESC_CFG = require("config.vip_describe_cfg")
    self.VIP_POWER_CFG = require("config.vip_power_cfg")
    self.SHOP_CFG = require("config.shop_cfg")
    self.MAIL_CFG = require("config.mail_format_cfg")
    self.AUDIO_CFG = require("config.audio_cfg")
    self.HALLSETTING_CFG = require("config.hall_setting_cfg")
    self.GAMELIST_CFG = require("config.game_list_cfg")
    self.DICE_CFG = require("config.dice_setting_cfg")
    self.SIGN_CFG = require("config.sign_cfg")

    --配置数据
    self.CFG = {
        relief_gold = self.DICT_CFG[0].data,     --救济金
        vip_sign = self.DICT_CFG[1].data,     --VIP签到
        give_factorage = self.DICT_CFG[2].data,     --赠送手续费(百分比)
        exchange_rmb = self.DICT_CFG[3].data,     --1元人民币兑换金豆
        exchange_bean = self.DICT_CFG[4].data,     --1金豆兑换金币
        --fund = self.DICT_CFG[5],     --好友每日礼包最小金币额
        --fund = self.DICT_CFG[6],     --好友每日礼包最大金币金额
        --fund = self.DICT_CFG[7]     --救济金
        --fund = self.DICT_CFG[8]     --救济金
        --fund = self.DICT_CFG[9]     --救济金
        --fund = self.DICT_CFG[10]     --救济金
        --fund = self.DICT_CFG[11]     --救济金
        laba_len = self.DICT_CFG[12].data,     --大喇叭字数长度
        laba_price = self.DICT_CFG[13].data,     --大喇叭价格
        mail_expire = self.DICT_CFG[14].data,     --邮件过期时间
        nickname_len = self.DICT_CFG[15].data,     --昵称字数长度
        fund = self.DICT_CFG[16].data     --银行转账最小金额
    }
end

--获取任务数据
function cfgmgr:getTaskItem(taskid)
    for key, item in pairs(self.TASK_CFG) do
        if item.id == taskid then return item end                    
    end
    return nil
end

--获取商品数据
function cfgmgr:getShopItem(shopid)
    for key, item in pairs(self.SHOP_CFG) do
        if item.id == shopid then return item end                    
    end
    return nil
end

--获取VIP加成数据
function cfgmgr:getVipItem(viplv)
    for key, item in pairs(self.VIP_POWER_CFG) do
        if item.vip_lv == viplv then return item end
    end
    return nil
end

--获取商品数据
function cfgmgr:getMailItem(mailType)
    for key, item in pairs(self.MAIL_CFG) do
        if item.type == mailType then return item end
    end
    return nil
end

--获取玩家头像
function cfgmgr:getHeaditem(headid)
    for key, item in pairs(self.HEAD_CFG) do
        if item.id == headid then return item end                    
    end
    return nil
end

-- 获取秘书数据
function cfgmgr:getSecretaryitem(sid)
    for key, item in pairs(self.IMAGE_CFG) do
        if item.id == sid then return item end                    
    end
    return nil
end

-- 获取vip特权描述
function cfgmgr:getVipDesc(viplv)
    for key, item in pairs(self.VIP_DESC_CFG) do
        if item.vip_lv == viplv then return item end                    
    end
    return nil
end

-- 获取vip数据
function cfgmgr:getVip(viplv)
    for key, item in pairs(self.VIP_CFG) do
        if item.vip_lv == viplv then return item end                    
    end
    return nil
end

-- 获取vip等级
function cfgmgr:getVipLv(exp)
    local currentlv = 0
    for key, item in pairs(self.VIP_CFG) do
        if item.lv_exp <= exp then         
            currentlv = item.vip_lv
        end
     end
    return currentlv
end

-- 获取音效数据
function cfgmgr:getAudio(id)
    for key, item in pairs(self.AUDIO_CFG) do
        if item.id == id then return item.res end 
    end
    return nil
end

-- 获取游戏房间信息
function cfgmgr:getRoom(id)
    for key, item in pairs(self.HALLSETTING_CFG) do
        if item.id == id then return item end 
    end
    return nil
end

-- 获取房间列表
function cfgmgr:getRoomListFromGameId(gameid)
    local rooms = {}
    for key, item in pairs(self.HALLSETTING_CFG) do
        if item.game_type == gameid then 
            table.insert(rooms, item)
        end 
    end
    return rooms
end

-- 获取游戏id 
function cfgmgr:getGameIdFromRoomId(roomid)
    local room = self:getRoom(roomid)
    if room then
        return room.game_type
    end
    return nil
end

--获取房间数据
function cfgmgr:getRoomInfo(roomid)
    for key, item in pairs(self.DICE_CFG) do
        if item.ground_id == roomid then             
             return item
        end 
    end
    return nil
end

--获取签到数据
function cfgmgr:getSignin(day)
    for key, item in pairs(self.SIGN_CFG) do
        if item.days == day then             
             return item
        end 
    end
    return nil
end

return cfgmgr
