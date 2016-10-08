local localdatamgr = class("localdatamgr")
--localdatamgr.__index = localdatamgr

function localdatamgr:ctor()
    self:init()
end

function localdatamgr:init()
    self.userDefault = cc.UserDefault:getInstance()
    self.REMEBER_PASSWORD = "remeberPw"
    self.ACCOUNT = "account"
    self.PASSWORD = "password"
    self.TOURIST_ACCOUNT = "t_account"
    self.TOURIST_PASSWORD = "t_password"

    self.GLOBAL_MUSCI = "g_musci"
    self.GLOBAL_EFFECT = "g_effect"
    self.GLOBAL_SHAKE = "g_shake"
    self.EMAIL_PUSH = "email_push"
    self.RANK_PUSH = "rank_push"
    self.READEMAIL = "read_email"
end

-- Get bool value by key, if the key doesn't exist, will return passed default value.
-- @param key The key to get value.
-- @param defaultValue The default value to return if the key doesn't exist.
function localdatamgr:getBoolForKey(key, defaultValue)
    defaultValue = defaultValue or false
    return self.userDefault:getBoolForKey(key, defaultValue)
end
function localdatamgr:setBoolForKey(key, value)
    self.userDefault:setBoolForKey(key, value)
end

-- Get bool value by key, if the key doesn't exist, will return passed default value.
-- @param key The key to get value.
-- @param defaultValue The default value to return if the key doesn't exist.
-- @return Integer value of the key.
function localdatamgr:getIntegerForKey(key, defaultValue)
    defaultValue = defaultValue or 0
    return self.userDefault:getIntegerForKey(key, defaultValue)
end
function localdatamgr:setIntegerForKey(key, value)
    self.userDefault:setIntegerForKey(key, value)
end

-- Get float value by key, if the key doesn't exist, will return passed default value.
-- @param key The key to get value.
-- @param defaultValue The default value to return if the key doesn't exist.
-- @return Float value of the key.
function localdatamgr:getFloatForKey(key, defaultValue)
    defaultValue = defaultValue or 0.0
    return self.userDefault:getFloatForKey(key, defaultValue)
end
function localdatamgr:setFloatForKey(key, value)
    self.userDefault:setIntegerForKey(key, value)
end

function localdatamgr:getDoubleForKey(key, defaultValue)
    defaultValue = defaultValue or 0.0
    return self.userDefault:getDoubleForKey(key, defaultValue)
end
function localdatamgr:setDoubleForKey(key, value)
    self.userDefault:setDoubleForKey(key, value)
end

-- Get string value by key, if the key doesn't exist, will return passed default value.
-- @param key The key to get value.
-- @param defaultValue The default value to return if the key doesn't exist.
-- @return String value of the key.
function localdatamgr:getStringForKey(key, defaultValue)
    defaultValue = defaultValue or ""
    return self.userDefault:getStringForKey(key, defaultValue)
end
function localdatamgr:setStringForKey(key, value)
    self.userDefault:setStringForKey(key, value)
end

-- Get Data value by key, if the key doesn't exist, will return an empty Data.
-- @param key The key to get value.
-- @param defaultValue The default value to return if the key doesn't exist.
-- @return Data value of the key.
function localdatamgr:getDataForKey(key, defaultValue)
    defaultValue = defaultValue or nil
    return self.userDefault:getDataForKey(key, defaultValue)
end
function localdatamgr:getDataForKey(key, value)
    self.userDefault:getDataForKey(key, value)
end

function localdatamgr:flush()
    self.userDefault:flush()
end

function localdatamgr:deleteValueForKey(key)
    self.userDefault:deleteValueForKey(key)
end

return localdatamgr