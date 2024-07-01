movement = {}

function movement:init()
  self.targetHorizontalVelocity = config.getParameter("targetHorizontalVelocity")
  self.horizontalControlForce = config.getParameter("horizontalControlForce")
  self.hoverTargetDistance = config.getParameter("hoverTargetDistance")
  self.hoverControlForce = config.getParameter("hoverControlForce")
  self.bodySpringPositions = config.getParameter("bodySpringPositions")
  self.maxGroundSearchDistance = config.getParameter("maxGroundSearchDistance")
  self.nearGroundDistance = config.getParameter("nearGroundDistance")
  self.hoverVelocityFactor = config.getParameter("hoverVelocityFactor")
  self.backSpringPositions = config.getParameter("backSpringPositions")
  self.levelApproachFactor = config.getParameter("levelApproachFactor")
  self.maxAngle = config.getParameter("maxAngle") * math.pi / 180
  self.frontSpringPositions = config.getParameter("frontSpringPositions")
  self.engineIdlePitch = config.getParameter("engineIdlePitch")
  self.engineRevPitch = config.getParameter("engineRevPitch")
  self.engineIdleVolume = config.getParameter("engineIdleVolume")
  self.angleApproachFactor = config.getParameter("angleApproachFactor")
  self.engineRevVolume = config.getParameter("engineRevVolume")
  self.lightsList = config.getParameter("lightsList")

  self.movementSettings = config.getParameter("movementSettings")
  self.occupiedMovementSettings = config.getParameter("occupiedMovementSettings")
  self.zeroGMovementSettings = config.getParameter("zeroGMovementSettings")

  self.enginePitch = 0;
  self.engineVolume = self.engineIdleVolume;
  self.engineStartingTimout = 2
  self.engineStartingTimer = self.engineStartingTimout

  self.engineStartingSfxTimout = 0.3
  self.engineStartingSfxTimer = self.engineStartingSfxTimout

  self.facingDirection = 1
  self.loopPlaying = nil
  self.angle = 0
  self.isAim = false
  self.isActivated = false
  self.isActivatedCanToggle = true
  self.engineRevTimer = 0.0
  self.isFlyMode = false
  self.fixedAimPos = {0, 0}
  self.headlightsOn = false
  self.headlightsOnPrev = false

  animator.setAnimationState("rearThruster", "off")
  animator.setAnimationState("bottomThruster", "off")

  sb.logInfo("LFSB: movements inited")
end

function movement:update()
  if self.isActivated then
    if self.isFlyMode then
      self:flymove()
    else
      self:move()
    end
  end
  self:controls()
  self:animate()
  self:updateAngle()
  self:updateParts()
  self:updateMovementsParams()

  if self.remoteControl then
    if self.remoteControlTimer <= 0 then self.remoteControl = false end
    self.remoteControlTimer = self.remoteControlTimer - script.updateDt()
  end
end

function movement:updateMovementsParams()
  mcontroller.resetParameters(self.movementSettings)
  if self.isActivated then
    if not self.isFlyMode then mcontroller.applyParameters(self.occupiedMovementSettings) end
    if self.isFlyMode then mcontroller.applyParameters(self.zeroGMovementSettings) end
  end
end

function movement:starter()
  if not self.isActivated then
    if self.engineStartingSfxTimer <= 0 then
      animator.stopAllSounds("engineStart")
      animator.setSoundPitch("startingEngine", 0.8)
      animator.setSoundVolume("startingEngine", 0.8)
      animator.playSound("startingEngine")
      self.engineStartingSfxTimer = self.engineStartingSfxTimout
    end

    if self.engineStartingTimer <= 0 then
      self.isActivated = true
      self.isActivatedCanToggle = false
      self.engineStartingTimer = self.engineStartingTimout
      if self.isActivated then
        animator.setSoundPitch("engineStart", 1)
        animator.setSoundVolume("engineStart", 1)
        animator.playSound("engineStart")
      end
    end
    self.engineStartingTimer = self.engineStartingTimer - script.updateDt()
    self.engineStartingSfxTimer = self.engineStartingSfxTimer - script.updateDt()
  else
    self.isActivated = false
    self.isActivatedCanToggle = false
    animator.setSoundPitch("turnOffEngine", 1)
    animator.setSoundVolume("turnOffEngine", 1)
    animator.playSound("turnOffEngine")
  end
end

function movement:moveToPos(pos)
  -- sb.logInfo("recieved" .. sb.printJson(pos))
  if not self.isActivated then return end
  local diff = world.distance(pos, mcontroller.position())
  local len = math.sqrt(diff[1] * diff[1] + diff[2] * diff[2])
  self.facingDirection = pos[1] < mcontroller.position()[1] and -1 or 1
  self.remoteControl = true
  self.remoteControlTimer = 1
  -- diff = {diff[1] / len, diff[2] / len}
  -- diff = vec2.mul(diff, {self.targetHorizontalVelocity, self.targetHorizontalVelocity})
  mcontroller.approachXVelocity(diff[1], self.horizontalControlForce)
  mcontroller.approachYVelocity(diff[2], self.horizontalControlForce)
end

function movement:controls()

  if cabin.controls.jump and cabin.controls.special1 then
    if self.isActivatedCanToggle then self:starter() end
  else
    self.isActivatedCanToggle = true
  end

  if cabin.controls.up and cabin.controls.special1 then
    if self.isFlyModeCanToggle then
      self.isFlyMode = not self.isFlyMode
      self.isFlyModeCanToggle = false
    end
  else
    self.isFlyModeCanToggle = true
  end

  if cabin.controls.special3 then
    if not self.hornPlaying then animator.playSound("hornLoop", -1) end
    self.hornPlaying = true;
  else
    if self.hornPlaying then
      animator.stopAllSounds("hornLoop")
      self.hornPlaying = false;
    end
  end

  if cabin.controls.alt and self.isActivated then
    -- sb.logInfo("LFSB: alt pressed")
    -- toggle fixed aim
    if self.isFixedAimCanToggle and cabin.controls.primary then
      self.isFixedAim = not self.isFixedAim
      self.isAimFollow = false
      self.isFixedAimCanToggle = false
    elseif not cabin.controls.primary then
      self.isFixedAimCanToggle = true
    end
    -- toggle aim follow
    if self.isAimFollowCanToggle and cabin.controls.special2 then
      self.isAimFollow = not self.isAimFollow
      self.isFixedAim = false
      self.isAimFollowCanToggle = false
    elseif not cabin.controls.special2 then
      self.isAimFollowCanToggle = true
    end
  end
  -- results
  if self.isActivated then
    if cabin.controls.alt or self.isAimFollow then
      self.fixedAimPos = vehicle.aimPosition("drivingSeat")
      self.isAim = true
    elseif self.isFixedAim then
      self.isAim = true
    else
      self.isAim = false
    end
  else
    self.isAim = false
  end

end

function movement:move()
  self.spin = 0

  local groundDistance = self:minimumSpringDistance(self.bodySpringPositions)
  local nearGround = groundDistance < self.nearGroundDistance

  if groundDistance <= self.hoverTargetDistance then
    mcontroller.approachYVelocity((self.hoverTargetDistance - groundDistance) * self.hoverVelocityFactor,
        self.hoverControlForce)
  end

  if cabin.controls.jump then
    mcontroller.approachXVelocity(0, self.horizontalControlForce * 1.5)
  else
    local xmovement = 0
    local ymovement = 0
    local force = 0
    if cabin.controls.left then
      if not self.isAim then self.facingDirection = -1 end
      xmovement = -self.targetHorizontalVelocity
      force = self.horizontalControlForce

    elseif cabin.controls.right then
      if not self.isAim then self.facingDirection = 1 end
      xmovement = self.targetHorizontalVelocity
      force = self.horizontalControlForce
    end
    mcontroller.approachXVelocity(xmovement, force)

  end
  if cabin.controls.up or cabin.controls.down then end
end

function movement:flymove()
  local groundDistance = self:minimumSpringDistance(self.bodySpringPositions)
  if groundDistance <= self.hoverTargetDistance then
    mcontroller.approachYVelocity((self.hoverTargetDistance - groundDistance) * self.hoverVelocityFactor,
        self.hoverControlForce)
  end

  local xMove = math.sin(os.clock() * 1.5) * 0.8
  local yMove = math.sin(os.clock() * 0.8) * 0.9
  local move = not self.isAimFollow and not self.remoteControl

  if cabin.controls.jump then
    mcontroller.approachXVelocity(xMove, self.horizontalControlForce * 1.5)
    mcontroller.approachYVelocity(yMove, self.horizontalControlForce * 1.5)
    -- elseif cabin.controls.primary and self.isAimFollow then
    --   local diff = world.distance(self.fixedAimPos, mcontroller.position())
    --   local len = math.sqrt(diff[1] * diff[1] + diff[2] * diff[2])
    --   diff = {diff[1] / len, diff[2] / len}
    --   diff = vec2.mul(diff, {self.targetHorizontalVelocity, self.targetHorizontalVelocity})
    --   xMove = diff[1]
    --   yMove = diff[2]
    --   mcontroller.approachVelocity(diff, self.horizontalControlForce)
  else

    if cabin.controls.primary and self.isAimFollow then
      local diff = world.distance(self.fixedAimPos, mcontroller.position())
      local len = math.sqrt(diff[1] * diff[1] + diff[2] * diff[2])
      diff = {diff[1] / len, diff[2] / len}
      diff = vec2.mul(diff, {self.targetHorizontalVelocity, self.targetHorizontalVelocity})
      xMove = diff[1]
      yMove = diff[2]
      -- mcontroller.approachVelocity(diff, self.horizontalControlForce)
      move = true
    end

    -- left right dir
    if cabin.controls.left then
      xMove = -self.targetHorizontalVelocity
      if not self.isAim then self.facingDirection = -1 end
    elseif cabin.controls.right then
      xMove = self.targetHorizontalVelocity
      if not self.isAim then self.facingDirection = 1 end
    end

    -- up down
    if cabin.controls.up then
      yMove = self.targetHorizontalVelocity
    elseif cabin.controls.down then
      yMove = -self.targetHorizontalVelocity
    end
    move = (self.targetHorizontalVelocity == math.abs(xMove)) or (self.targetHorizontalVelocity == math.abs(yMove)) or
               move
    if move then
      mcontroller.approachXVelocity(xMove, self.horizontalControlForce)
      mcontroller.approachYVelocity(yMove, self.horizontalControlForce)
    end
  end
end

function movement:animate()
  animator.resetTransformationGroup("rotation")
  animator.rotateTransformationGroup("rotation", self.angle * self.facingDirection)
  animator.setFlipped(self.facingDirection < 0 and true or false)
  if self.isAim then self:animateVehicleAim() end
end

function movement:animateVehicleAim()
  local diff = world.distance(self.fixedAimPos, mcontroller.position())
  local targetAngle = math.atan(diff[2] * self.facingDirection, diff[1] * self.facingDirection)
  self.angle = self.angle + (targetAngle - self.angle) * self.angleApproachFactor * 1.5;
  if (targetAngle > (90 * math.pi / 180) * self.facingDirection and targetAngle > -(90 * math.pi / 180) *
      self.facingDirection) or
      (targetAngle < (90 * math.pi / 180) * self.facingDirection and targetAngle < -(90 * math.pi / 180) *
          self.facingDirection) then
    self.facingDirection = -self.facingDirection
    self.angle = -self.angle
  end
  if (not self.isFixedAim) then return end
  localanimator("spawnParticle", {{
    type = "animated",
    animation = "/animations/fizz1/fizz1.animation",
    fullbright = true,
    approach = {8, 8},
    size = 2.0,
    initialVelocity = {0, 0},
    timeToLive = 0,
    layer = "front"
  }, self.fixedAimPos})
end

function movement:updateParts()
  -- self.hazardOn = true
  if self.hazardOn then
    animator.setAnimationState("hazardlights", "on")
  else
    animator.setAnimationState("hazardlights", "off")
  end

  if self.headlightsOn ~= self.headlightsOnPrev then self:switchHeadLights(self.headlightsOn) end

  if cabin.controls.jump then
    animator.setAnimationState("stopsignals", "on")
  else
    animator.setAnimationState("stopsignals", "off")
  end

  if not self.isActivated then
    if self.loopPlaying ~= nil then
      animator.stopAllSounds(self.loopPlaying)
      self.loopPlaying = nil
    end
    animator.setParticleEmitterActive("rearThrusterIdle", false)
    animator.setParticleEmitterActive("rearThrusterDrive", false)
    animator.setParticleEmitterActive("ventralThrusterIdle", false)
    animator.setParticleEmitterActive("ventralThrusterJump", false)

    animator.setAnimationState("rearThruster", "off")
    animator.setAnimationState("bottomThruster", "off")
    return
  end
  local engineLoop = "engineLoop"
  local enginePitch = self.engineIdlePitch;
  local engineVolume = self.engineIdleVolume;
  animator.setParticleEmitterActive("ventralThrusterIdle", true)
  animator.setParticleEmitterActive("rearThrusterIdle", true)
  animator.setParticleEmitterActive("ventralThrusterJump", false)
  animator.setParticleEmitterActive("rearThrusterDrive", false)
  self.loopPlaying = engineLoop

  if cabin.controls.left or cabin.controls.right then
    enginePitch = self.engineRevPitch
    engineVolume = self.engineRevVolume
    animator.setParticleEmitterActive("rearThrusterIdle", false)
    animator.setParticleEmitterActive("rearThrusterDrive", true)
  end
  if cabin.controls.jump and math.abs(mcontroller.xVelocity()) > 1 then
    enginePitch = self.engineRevPitch;
    engineVolume = self.engineRevVolume;
    animator.setParticleEmitterActive("rearThrusterIdle", false)
    animator.setParticleEmitterActive("rearThrusterDrive", true)
  end
  if cabin.controls.up then
    enginePitch = self.engineRevPitch;
    engineVolume = self.engineRevVolume;
    animator.setParticleEmitterActive("ventralThrusterIdle", false)
    animator.setParticleEmitterActive("ventralThrusterJump", true)
    -- animator.burstParticleEmitter("ventralThrusterJump")
  end
  if cabin.controls.primary and self.isAimFollow then
    enginePitch = self.engineRevPitch;
    engineVolume = self.engineRevVolume;
    animator.setParticleEmitterActive("rearThrusterIdle", false)
    animator.setParticleEmitterActive("rearThrusterDrive", true)
  end

  if self.enginePitch ~= enginePitch then
    animator.stopAllSounds(self.loopPlaying)

    self.enginePitch = enginePitch
    self.engineVolume = engineVolume
    self.engineRevTimer = 0
    animator.playSound(self.loopPlaying, -1)

  end
  -- if (self.engineRevTimer > 0.0) then
  --   self.engineRevTimer = self.engineRevTimer - script.updateDt()
  -- else
  --   -- animator.stopAllSounds(self.loopPlaying)
  --   local pitch = self.enginePitch + (math.abs(mcontroller.xVelocity()) + math.abs(mcontroller.yVelocity())) /
  --                     self.targetHorizontalVelocity
  --   animator.setSoundPitch(self.loopPlaying, pitch)
  --   animator.setSoundVolume(self.loopPlaying, 2)
  --   -- animator.playSound(self.loopPlaying, 0)
  --   self.engineRevTimer = 0.1
  -- end
  local pitch = self.enginePitch + (math.abs(mcontroller.xVelocity()) + math.abs(mcontroller.yVelocity())) /
                    self.targetHorizontalVelocity
  animator.setSoundPitch(self.loopPlaying, pitch)
  animator.setSoundVolume(self.loopPlaying, self.engineVolume)

  animator.setAnimationState("rearThruster", "on")
  animator.setAnimationState("bottomThruster", "on")

end

function movement:switchHeadLights(isTurnedOn)
  if isTurnedOn then
    animator.setAnimationState("headlights", "on")
    animator.playSound("headlightSwitchOn")
    for _, v in ipairs(self.lightsList) do animator.setLightActive(v, true) end
  else
    animator.setAnimationState("headlights", "off")
    animator.playSound("headlightSwitchOff")
    for _, v in ipairs(self.lightsList) do animator.setLightActive(v, false) end
  end
  self.headlightsOnPrev = isTurnedOn
end

function movement:minimumSpringDistance(points)
  local min = nil
  for _, point in ipairs(points) do
    point = vec2.rotate(point, self.angle)
    point = vec2.add(point, mcontroller.position())
    local d = movement:distanceToGround(point)
    if min == nil or d < min then min = d end
  end
  return min
end

function movement:distanceToGround(point)
  local endPoint = vec2.add(point, {0, -self.maxGroundSearchDistance})

  world.debugLine(point, endPoint, {255, 255, 0, 255})
  local intPoint = world.lineCollision(point, endPoint)

  if intPoint then
    world.debugPoint(intPoint, {255, 255, 0, 255})
    return point[2] - intPoint[2]
  else
    return self.maxGroundSearchDistance
  end
end

function movement:updateAngle()
  local targetAngle = 0
  local groundDistance = movement:minimumSpringDistance(self.bodySpringPositions)
  local nearGround = groundDistance < self.nearGroundDistance
  if self.isAim and self.isActivated then
    mcontroller.setRotation(self.angle)
    return
  end
  if not nearGround and not self.isActivated then

  elseif not nearGround and self.isActivated then
    if cabin.controls.up then
      targetAngle = (self.facingDirection < 0) and -self.maxAngle or self.maxAngle
    elseif cabin.controls.down then
      targetAngle = (self.facingDirection < 0) and self.maxAngle or -self.maxAngle
    else
      targetAngle = 0
    end
    self.angle = self.angle + (targetAngle - self.angle) * self.angleApproachFactor
  else
    local frontSpringDistance = movement:minimumSpringDistance(self.frontSpringPositions)
    local backSpringDistance = movement:minimumSpringDistance(self.backSpringPositions)
    if frontSpringDistance == self.maxGroundSearchDistance and backSpringDistance == self.maxGroundSearchDistance then
      self.angle = self.angle - self.angle * self.angleApproachFactor
    else
      self.angle = self.angle + math.atan((backSpringDistance - frontSpringDistance) * self.levelApproachFactor)
      self.angle = math.min(math.max(self.angle, -self.maxAngle), self.maxAngle)
    end
  end
  mcontroller.setRotation(self.angle)

end

function movement:uninit()
end

addlfscript(movement)
