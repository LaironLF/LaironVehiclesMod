drop = {}

function drop:init()
  self.despawnTimer = 0
  self.despawnTime = 0
  self.drop = false
  self.undrop = false
  self.initPos = mcontroller.position()
  message.setHandler("drop", function()
    self.despawnTime = 0.6
    self.despawnTimer = self.despawnTime
    self.drop = true
    -- mcontroller.setPosition(vec2.add(mcontroller.position(), {0, 5}))
    movement.movementSettings.collisionEnabled = false
  end)
  message.setHandler("undrop", function()
    self.initPos = mcontroller.position()
    self.despawnTime = 0.6
    self.despawnTimer = self.despawnTime
    self.drop = false
    self.undrop = true
  end)

  sb.logInfo("LFSB: drop inited")
end

function drop:update()
  if self.drop then
    animator.burstParticleEmitter("drop")
    animator.setParticleEmitterActive("drop", true)
    local multiply, fade, light
    self.despawnTimer = math.max(0, self.despawnTimer - script.updateDt())
    if self.despawnTimer >= 0.5 * self.despawnTime then
      fade = 1.0
      light = (0.5 * self.despawnTime) / self.despawnTimer - (0.5 * self.despawnTime)
      multiply = math.floor(255 * light)
    else
      fade = 1 * self.despawnTimer
      light = fade
      multiply = 255
    end
    mcontroller.setPosition(vec2.add(self.initPos, {0, 6 * self.despawnTimer}))

    animator.setGlobalTag("dropTag", string.format("?multiply=ffffff%02x?fade=ffffff;%.1f", multiply, fade))
    if self.despawnTimer == 0 then
      self.drop = false
      animator.setParticleEmitterActive("drop", false)
      movement.movementSettings.collisionEnabled = true
    end
  end
  if self.undrop then
    animator.burstParticleEmitter("drop")
    animator.setParticleEmitterActive("drop", true)
    local multiply, fade, light
    self.despawnTimer = math.max(0, self.despawnTimer - script.updateDt())
    if self.despawnTimer > 0.5 * self.despawnTime then
      fade = 1.0 - (self.despawnTimer - 0.5 * self.despawnTime) / (0.5 * self.despawnTime)
      light = fade
      multiply = 255
    else
      fade = 1.0
      light = self.despawnTimer / (0.5 * self.despawnTime)
      multiply = math.floor(255 * light)
    end
    mcontroller.setPosition(vec2.add(self.initPos, {0, 6 * self.despawnTime - 6 * self.despawnTimer}))

    animator.setGlobalTag("dropTag", string.format("?multiply=ffffff%02x?fade=ffffff;%.1f", multiply, fade))
    vehicle.setLoungeEnabled("drivingSeat", false)
    if self.despawnTimer == 0 then vehicle.destroy() end
  end
end

function drop:uninit()

end

addlfscript(drop)
