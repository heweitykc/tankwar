--------------帐号输入框合法性检查----------------------
local acountcheck = class("acountcheck")
function acountcheck:ctor()
    self:init()
end
function acountcheck:init()
    --长度限制
    self.minNum = 6;
    self.maxNum = 12;
    --匹配模式
    self.checkMatch = "[^%w]"
end
function acountcheck:check(str)
    local ismatch = false
   --空字符串检查
    if str == "" then
        UIMgr:ShowDialog(StrCfg.registerInfo_acountNil)
        return ismatch
    end

    --模式检查
    local index = string.find(str, self.checkMatch)
    if index ~= nil then
        UIMgr:ShowDialog(StrCfg.registerInfo_Word)
        return ismatch
    end

    --长度检查
    local len = str:len()
    if len < self.minNum or len > self.maxNum then
        UIMgr:ShowDialog(StrCfg.registerInfo_acountNum)
        return ismatch
    end

    ismatch = true
    return ismatch
end

--------------密码输入框合法性检查----------------------
local passwordcheck = class("passwordcheck", acountcheck)
function passwordcheck:ctor()
    self:init()
end
function passwordcheck:init()
    self.minNum = 6;
    self.maxNum = 12;
    self.checkMatch = "[^%w]"
end
function passwordcheck:check(str)
    local ismatch = false

    if str == "" then
        UIMgr:ShowDialog(StrCfg.registerInfo_pwNil)
        return ismatch
    end

    local index = string.find(str, self.checkMatch)
    if index ~= nil then
        UIMgr:ShowDialog(StrCfg.registerInfo_Word)
        return ismatch
    end

    local len = str:len()
    if len < self.minNum or len > self.maxNum then
        UIMgr:ShowDialog(StrCfg.registerInfo_pwNum)
        return ismatch
    end

    ismatch = true
    return ismatch
end

--------------银行输入框合法性检查----------------------
local bankpwdcheck = class("bankpwdcheck", acountcheck)
function bankpwdcheck:ctor()
    self:init()
end
function bankpwdcheck:init()
    self.minNum = 6;
    self.maxNum = 6;
    self.checkMatch = "[^%d]"
end
function bankpwdcheck:check(str)
    local ismatch = false

    if str == "" then
        UIMgr:ShowDialog(StrCfg.registerInfo_pwNil)
        return ismatch
    end

    local index = string.find(str, self.checkMatch)
    if index ~= nil then
        UIMgr:ShowDialog(StrCfg.openBank_Word)
        return ismatch
    end

    local len = str:len()
    if len < self.minNum or len > self.maxNum then
        UIMgr:ShowDialog(StrCfg.openBank_Word)
        return ismatch
    end

    ismatch = true
    return ismatch
end

--------------金币输入框合法性检查----------------------
local goldcheck = class("goldcheck", acountcheck)
function goldcheck:ctor()
    self:init()
end
function goldcheck:init()
    self.checkMatch = "[^%d]"
end
function goldcheck:check(str)
    local ismatch = false

    if str == "" or string.find(str, self.checkMatch) ~= nil then
        UIMgr:ShowDialog(StrCfg.Gold_Word)
        return ismatch
    end

    local number = tonumber(str)
    if number == nil then
        UIMgr:ShowDialog(StrCfg.Gold_Word)
        return ismatch
    end

    ismatch = true
    return ismatch
end
--------------手机号输入框合法性检查----------------------
local phonecheck = class("phonecheck", acountcheck)
function phonecheck:ctor()
    self:init()
end
function phonecheck:init()
    self.minNum = 11;
    self.maxNum = self.minNum
    self.checkMatch = "[^%d]"
end
function phonecheck:check(str)
    local ismatch = false

    if str == "" then
        UIMgr:ShowDialog(StrCfg.phone_nil)
        return ismatch
    end

    if string.find(str, self.checkMatch) ~= nil then
        UIMgr:ShowDialog(StrCfg.phone_num)
        return ismatch
    end

    local len = str:len()
    if len < self.minNum or len > self.maxNum then
        UIMgr:ShowDialog(StrCfg.phone_num)
        return ismatch
    end

    ismatch = true
    return ismatch
end
--------------ID输入框合法性检查----------------------
local uidcheck = class("phonecheck", acountcheck)
function uidcheck:ctor()
    self:init()
end
function uidcheck:init()
    --self.minNum = 11;
    --self.maxNum = self.minNum
    self.checkMatch = "[^%d]"
end
function uidcheck:check(str)
    local ismatch = false

    if str == "" then
        UIMgr:ShowDialog(StrCfg.friend_nil)
        return ismatch
    end

    if string.find(str, self.checkMatch) ~= nil then
        UIMgr:ShowDialog(StrCfg.friend_nonExistent)
        return ismatch
    end

    ismatch = true
    return ismatch
end
--------------喇叭输入框合法性检查----------------------
local horncheck = class("horncheck", acountcheck)
function horncheck:ctor()
    self:init()
end
function horncheck:init()
    self.minNum = 0
    self.maxNum = 20
    --self.checkMatch = "[^%d]"
end
function horncheck:check(str)
    local ismatch = false

    if str == "" then
        UIMgr:ShowDialog(StrCfg.horn_nil)
        return ismatch
    end

    local len = UIUtils:utfstrlen(str)
    print(len)
    if len < self.minNum or len > self.maxNum then
        UIMgr:ShowDialog(string.format(StrCfg.horn_num, self.maxNum))
        return ismatch
    end
    ismatch = true

    return ismatch
end
-----------------------------------------------------
local inputmgr = class("inputmgr")
function inputmgr:ctor()
    self:init()
end

function inputmgr:init()
    self.AcountCheck = acountcheck:new()
    self.PasswordCheck = passwordcheck:new()
    self.BankPwdCheck = bankpwdcheck:new()
    self.GoldCheck = goldcheck:new()
    self.PhoneCheck = phonecheck:new()
    self.UIDCheck = uidcheck:new()
    self.HornCheck = horncheck:new()
end

return inputmgr