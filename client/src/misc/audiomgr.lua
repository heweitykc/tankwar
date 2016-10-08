local AudioMgr = class("AudioMgr")

function AudioMgr:ctor()
    self:init()
    self.currentBg = nil
end

function AudioMgr:init()
    self.audioEngine = ccexp.AudioEngine
    self.audioEngine:lazyInit()
    self.OverallVolume = 1.0
    self.OldOverallVolume = 1.0
end

-- 播放音乐
function AudioMgr:playBg(id, loop)
    self.currentBg = id
    local fname = CfgMgr:getAudio(id)
    if fname == nil then return end                
    fname = "gamemusic/" .. fname .. ".mp3"
    if self.isBgOn() then        
        return self.audioEngine:play2d(fname, loop, 1.0)
    end
    return nil    
end

-- 恢复背景音乐
function AudioMgr:resumeBg()
    self:playBg(self.currentBg, true, 1.0)
end

-- 播放音效
function AudioMgr:playEffect(id)
    local fname = CfgMgr:getAudio(id)
    if fname == nil then return end    
    if self.isEffectOn() then
        fname = "gamemusic/" .. fname .. ".mp3"        
        return self.audioEngine:play2d(fname, false, 1.0)
    end    
end

-- 设置全局音效的音量
function AudioMgr:setAllMusicVolume(volume)
    self.OverallVolume = volume
    for id = 0, self.audioEngine:getMaxAudioInstance() do
        self:setVolume(id,  self.OverallVolume)
    end
end

-- 设置特定音效的音量
function AudioMgr:setVolume(id, volume)
    self.audioEngine:setVolume(id, volume)
end

-- 关闭音乐
function AudioMgr:offMusic()
    self.audioEngine:stopAll()
    LocalDataMgr:setBoolForKey(LocalDataMgr.GLOBAL_MUSCI, false)
end

-- 开启音乐
function AudioMgr:onMusic()
    LocalDataMgr:setBoolForKey(LocalDataMgr.GLOBAL_MUSCI, true)
    self:resumeBg()    
end

-- 关闭音效
function AudioMgr:offEffect()
      LocalDataMgr:setBoolForKey(LocalDataMgr.GLOBAL_EFFECT, false)
end

-- 开启音效
function AudioMgr:onEffect()
      LocalDataMgr:setBoolForKey(LocalDataMgr.GLOBAL_EFFECT, true)
end

-- 背景音是否开启
function AudioMgr:isBgOn()
    return LocalDataMgr:getBoolForKey(LocalDataMgr.GLOBAL_MUSCI, true)    
end

-- 音效是否开启
function AudioMgr:isEffectOn()
    return LocalDataMgr:getBoolForKey(LocalDataMgr.GLOBAL_EFFECT, true)    
end

--清除所有声音
function AudioMgr:Clear()
    self.audioEngine:stopAll()
end

-- 关闭所有声音
function AudioMgr:TurnOff()
    self:offMusic()
    self:offEffect()
end

-- 打开所有声音
function AudioMgr:TurnOn()
   self:onMusic()   
   self:onEffect() 
end

return AudioMgr