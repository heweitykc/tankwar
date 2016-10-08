local StrCfg = class("StrCfg")

function StrCfg:ctor()
    self.success = "更新成功！"
    self.fail = "更新失败！"
    self.reg_success = "注册成功！"
    self.reg_failed = "注册失败！"
    self.version_file = "版本文件"
    self.manifest_file = "清单列表"

    self.login_failed = "登陆失败！"

    self.registerInfo_pwDifference = "两次输入密码不同！"

    self.registerInfo_acountNil = "请输入您的账号！"
    self.registerInfo_acountNum = "请输入正确的账号名！"

    self.registerInfo_pwNil = "请输入您的密码！"
    self.registerInfo_pwNum = "请输入正确的登陆密码！"

    self.registerInfo_Word = "请使用英文或数字！"

    self.get_notice_failed = "读取公告失败！"

    self.openBank_success = "成功设置银行密码！"
    self.openBank_pwNil = "请输入密码！"
    self.openBank_Word = "请输入6位数字密码！"

    self.Gold_Word = "请输入正确的金额！"
    self.Gold_Lack = "请核对您的金币数量！"    
    self.Deposit_Lack = "您当前的存款不足！"
    self.Bean_Lack = "请核对您的金豆数量！"

    self.deposit_success = "成功存入%d金币！"
    self.cash_success = "成功取出%d金币！"

    self.friend_nil = "请输入好友ID！"
    self.friend_nonExistent = "请输入正确的好友ID！"
    self.friend_delete = "是否删除好友%s？"

    self.BankOperationType  = {
        "存款",
        "取款",
        "赠送"
    }

   self.giveGold_tip = "本次赠送将扣除10%%(%0.2f)手续费！"
   self.giveGold_success = "成功赠送%0.2f金币！"

   self.welcome = "欢迎登录润发游戏大厅"
   self.enter_lobby = "进入游戏大厅"
   self.task_complete = "任务完成！"
   self.task_complete_gold = "金币+%d"
   self.task_complete_bean = "金豆+%d"
   self.task_vip_tip = "升级VIP可领取！"

   self.phone_nil = "请输入您的手机号!"
   self.phone_num = "请输入11位号码!"
   self.name_nil = "请输入您的姓名!"
   self.get_gold = "恭喜您获得%d金币！"
   self.modify_head = "修改头像成功！"
   self.bind_account = "绑定账户成功！"
   self.modify_nickname = "修改昵称成功！"

   self.delect_friend = "您已删除好友%s。"
   self.request_friend = "正在向%s发出好友申请，请等待通过。"
   self.repeatRequest_friend = "请勿重复添加！耐心等待%s通过您的申请！"
   self.friend_countLimit = "您的好友数量已达到上限，可提升VIP等级提升好友上限!"
   self.friend_gift = "您成功赠送礼包给好友%s！"

    self.sex  = {}
    self.sex[1] = "男"
    self.sex[2] = "女"
    local nil_fuc = {__index = function ()
        return "未知"
    end}
    setmetatable(self.sex, nil_fuc)


    self.add_gold = "成功购买%d金币。"
    self.add_goldBean = "成功购买%d金豆。"
    self.gain_gold = "成功获得%d金币。"
    self.gain_goldBean = "成功获得%d金豆。"

    self.horn_nil = "请输入消息!"
    self.horn_num = "消息最大长度%d个字!"

    self.vip_exp_notice = "距离下一等级还需充值：%d金豆！"

    self.pwd_modify_ok = "登陆密码修改成功！"
    self.sex_modify_ok = "性别修改成功！"
    self.bankpwd_modify_ok = "银行密码修改成功！"

    self.exp_add = "经验值增加%d。"
    self.vip_add = "恭喜您VIP等级提高到%d！"

    self.email_nil = "当前没有人给你发来邮件..."

    self.money_str = "%0.2f亿"

    self.nickname_strict = "昵称最多为6位中英文或数字！"

    self.horn_cost = "全服喇叭:(每次消耗%d金豆)"

    self.game_download_tip = "要下载游戏吗？"
    self.game_exit_tip = "是否要退出游戏吗？"

    self.open_bank_power = "提升到VIP2后可使用，请前往充值！"

    self.User_Ac = "请勾选用户协议！"

    self.horn_system = "【系统公告】"
    self.horn_consumer = "【%s】"

    self.WinTitle = {        
        barter = "实物兑换",
        bank = "银行",
        mail = "邮件",
        mall = "商城",
        personal = "个人中心",
        rank = "排行榜",
        secretary = "秘书",
        task = "任务",
        vip = "VIP",
        hall = "大厅",
        seat = "桌子"
    }

end


return StrCfg