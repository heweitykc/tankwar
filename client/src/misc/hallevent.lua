local HallEvent = class("HallEvent")

function HallEvent:ctor()    
    self.REGISTER_RETURN = "register_return"    
    self.LOGIN_RETURN = "login_return"
    self.OPENBANK_RETURN = "openbank_return"
    self.DEPOSIT_RETURN = "deposit_return"
    self.CASH_RETURN = "cash_return"
    self.GIVEGOLD_RETURN = "givegold_return"
    self.RECORD_RETURN = "getrecord_return"
    self.GETRANK_RETURN = "getrank_return"  --获取排行列表
    self.GETSELFRANK_RETURN = "getselfrank_return"  --获取自身排行

    self.TASK_COMPLETE_RETURN = "task_complete_return"
    self.TASK_ADD_RETURN = "task_add_return"
    self.TASK_DONE_RETURN = "task_done_return"

    self.MONEY_CHANGE = "money_change"  --玩家财富数据发生变化
    self.PURCHASE = "purchase"  --购买物品

    self.RECEIVE_EMAIL = "receive_email" --领取邮件
    self.DISCARD_EMAIL = "discard_email" --丢弃邮件
    self.NEW_EMAIL_RETURN = "new_email_return" --收到新邮件
    self.EMAIL_LIST = "email_list"  --获取邮件列表

    self.FRIEND_REQUEST = "friend_request" --好友请求
    self.DELETE_FRIEND = "delete_friend" --删除好友
    self.NEW_FRIEND = "new_friend"  --新增好友
    self.FRIEND_LIMIT_CHANGE = "friend_limit_change" --好友上限变化
    self.FRIEND_GIFT = "friend_gift" --好友礼物

    self.SIGN_RETURN = "signin_return" -- 签到返回

    self.NICKNAME_RETURN = "nickname_return" -- 修改昵称
    self.HEAD_RETURN = "head_return" -- 修改头像
    self.BIND_ACCOUNT_RETURN = "bind_account_return" -- 绑定账户
    self.MODIFY_SEX = "modify_sex" -- 设置性别
    self.MODIFY_PWD = "modify_pwd" -- 修改密码
    self.MODIFY_BANK_PWD = "modify_bank_pwd" -- 修改银行密码
    self.EXP_ADD = "exp_add" -- 经验值增加
    self.GOLD_CHANGE = "gold_change" -- 金币变化

    self.USER_INFO = "user_info" -- 获取用户信息
    self.USER_LIST = "user_list" -- 获取用户列表

    self.SECRETARY_LIST = "secretary_list" --秘书列表
    self.SECRETARY_SET = "secretary_set" -- 秘书设置
    self.SECRETARY_BUY = "secretary_buy" --秘书购买
    self.SECRETARY_NEW = "secretary_new" -- 新秘书

    self.HORN_RECEIVE = "horn_receive" --接受喇叭消息

    self.GAME_ROOM_LIST = "game_room_list" --游戏room列表
    self.GAME_TABLE_LIST = "game_table_list" --游戏table列表
    self.ENTER_GAME = "enter_room" --进入游戏
    self.QUIT_GAME = "quit_game" --退出游戏

    self.ONLINE_NUMBER = "online_number" --在线人数
end

return HallEvent
