radio = {}

function radio:init()
  self.musicList = root.assetJson("/music/configmusic.json").music
  self.musicVolume = 1
  self.musicPitch = 1
  self.currentid = 1
  self.musicIsPlaying = false
  -- for _, v in ipairs(self.musicList) do sb.logInfo(v.title) end

  sb.logInfo("LFSB: radio inited")
end

function radio:next()
  if #self.musicList ~= 0 then
    self.currentid = self.currentid + 1
    self.currentid = self.currentid > #self.musicList and 1 or self.currentid
    -- self.musicVolume = self.musicVolume + 0.1
    -- animator.setSoundVolume("music", self.musicVolume)
    -- self.musicPitch = self.musicPitch + 0.1

    -- animator.setSoundPitch("music", self.musicPitch)

  end
end

function radio:prev()
  if #self.musicList ~= 0 then
    self.currentid = self.currentid - 1
    self.currentid = self.currentid > 0 and self.currentid or #self.musicList
  end
end

function radio:getTitle()
  return self.musicList[self.currentid].title
end

function radio:getSize()
  return {self.currentid, #self.musicList}
end

function radio:play()
  self.musicIsPlaying = not self.musicIsPlaying
  if self.musicIsPlaying then
    local music = {self.musicList[self.currentid].path}
    animator.setSoundPool("music", music)
    animator.setSoundVolume("music", self.musicVolume)
    animator.setSoundPitch("music", self.musicPitch)
    animator.playSound("music", -1)
  else
    animator.stopAllSounds("music")
  end
end

function radio:update()

end

function radio:uninit()

end

addlfscript(radio)
