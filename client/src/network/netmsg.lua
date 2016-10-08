-- 网络消息ID
local NetMsg = class("NetMsg")

function NetMsg:ctor()
    self.REGISTER = 10020
    self.__REGISTER = 10021

    self.LOGIN= 10010
    self.__LOGIN = 10011

    --用户列表
    self.USERLIST = 10030
    self.__USERLIST = 10031
    --用户信息
    self.USERINFO = 10032
    self.__USERINFO = 10033

    --获取在线人数
    self.ONLINENUM = 10102
    self.__ONLINENUM = 10103

-------------银行--------------------
    --开通银行
    self.OPENBANK = 10200
    self.__OPENBANK = 10201
    --存款
    self.DEPOSIT = 10210
    self.__DEPOSIT = 10211 
    --取款
    self.CASH = 10220
    self.__CASH = 10221
    --赠送金币
    self.GIVEGOLD = 10230
    self.__GIVEGOLD = 10231
    --操作记录
    self.GETRECORD = 10240
    self.__GETRECORD = 10241


    -- 任务列表    
    self.TASKLIST = 10300 
    self.__TASKLIST = 10301

    --领取任务奖励
    self.TASKCOMPLETE = 10310
    self.__TASKCOMPLETE = 10311 

    --新任务
    self.__TASKADD= 20030    

    --任务完成
    self.__TASKDONE= 20020    

    --结束任务
    self.TASKDONE = 40000

    --查询排名
    self.QUERYRANK = 10400
    self.__QUERYRANK = 10401
    --自身排名
    self.QUERY_SELFRANK = 10410
    self.__QUERY_SELFRANK = 10411

    --购买商品
    self.PURCHASE = 10150
    self.__PURCHASE = 10151

    --邮件列表
    self.EMAILLIST = 10500
    self.__EMAILLIST = 10501

    --领取邮件
    self.RECEIVEEMAIL = 10510
    self.__RECEIVEEMAIL = 10511

    --收到新邮件
    self.__NEWEMAIL = 20050

    --邮件丢弃(拒绝好友邀请)
    self.DISCARDEMAIL = 10520
    self.__DISCARDEMAIL = 10521

    --好友请求
    self.FRIENDREQUEST = 10160
    self.__FRIENDREQUEST = 10161

    --有新增好友
    self.__NEWFFRIEND = 20090

    --删除好友
    self.DELETEFRIEND = 10170
    self.__DELETEFRIEND = 10171

    --赠送好友礼物
    self.FIRENDGIFT = 10162
    self.__FIRENDGIFT = 10163

    --  签到数据
    self.SIGNINFO = 10140
    self.__SIGNINFO = 10141

    --  签到
    self.SIGN = 10130
    self.__SIGN = 10131

    --  VIP签到
    self.VIPSIGN = 10132
    self.__VIPSIGN = 10133

    -- 修改模型(头像)
    self.MODIFY_HEAD = 10110
    self.__MODIFY_HEAD = 10111

    -- 修改昵称
    self.MODIFY_NICKNAME = 10120
    self.__MODIFY_NICKNAME = 10121

    -- 修改性别
    self.SET_SEX = 10122
    self.__SET_SEX = 10123

     -- 修改登录密码
    self.SET_PWD = 10124
    self.__SET_PWD = 10125

    -- 修改银行密码
    self.SET_BANK_PWD = 10202
    self.__SET_BANK_PWD = 10203

     -- 绑定用户名/密码
    self.BIND_ACCOUNT = 10022
    self.__BIND_ACCOUNT = 10023

    --使用喇叭
    self.USEHORN = 10190
    self.__USEHORN = 10191
    self.__HORN_RECEIVE = 20100

    --购买秘书
    self.BUYSECRETARY = 10180
    self.__BUYSECRETARY = 10181
    --秘书列表
    self.SECRETARYLIST = 10184
    self.__SECRETARYLIST = 10185
    --设置秘书
    self.SETSECRETARY = 10182
    self.__SETSECRETARY = 10183

     -- 新秘书解封    
    self.__NEWSECRETARY = 20080

    --  经验增加
    self.__EXP_ADD = 20110
    -- 金币变化
    self.__GOLD_CHANGE = 20120

    --列出游戏room信息
    self.GAMEROOMLIST = 10610
    self.__GAMEROOMLIST = 10611

    --列出游戏table信息
    self.GAMETABLELIST = 10620
    self.__GAMETABLELIST = 10621

    --进入游戏
    self.ENTERGAME = 10600
    self.__ENTERGAME = 10601
end

return NetMsg
