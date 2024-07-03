require("/scripts/vec2.lua")

function init()
  self.levelApproachFactor = config.getParameter("levelApproachFactor")
  self.angleApproachFactor = config.getParameter("angleApproachFactor")
  self.maxGroundSearchDistance = config.getParameter("maxGroundSearchDistance")
  self.maxAngle = config.getParameter("maxAngle") * math.pi / 180
  self.hoverTargetDistance = config.getParameter("hoverTargetDistance")
  self.hoverVelocityFactor = config.getParameter("hoverVelocityFactor")
  self.hoverControlForce = config.getParameter("hoverControlForce")
  self.targetHorizontalVelocity = config.getParameter("targetHorizontalVelocity")
  self.horizontalControlForce = config.getParameter("horizontalControlForce")
  self.zeroGTargetVelocity = config.getParameter("zeroGTargetVelocity")
  self.zeroGSpinRate = config.getParameter("zeroGSpinRate")
  self.spinFriction = config.getParameter("spinFriction")
  self.nearGroundDistance = config.getParameter("nearGroundDistance")
  self.jumpVelocity = config.getParameter("jumpVelocity")
  self.jumpTimeout = config.getParameter("jumpTimeout")
  self.backSpringPositions = config.getParameter("backSpringPositions")
  self.frontSpringPositions = config.getParameter("frontSpringPositions")
  self.bodySpringPositions = config.getParameter("bodySpringPositions")
  self.movementSettings = config.getParameter("movementSettings")
  self.occupiedMovementSettings = config.getParameter("occupiedMovementSettings")
  self.zeroGMovementSettings = config.getParameter("zeroGMovementSettings")
  self.protection = config.getParameter("protection")
  self.maxHealth = config.getParameter("maxHealth")

  self.smokeThreshold = config.getParameter("smokeParticleHealthThreshold")
  self.fireThreshold = config.getParameter("fireParticleHealthThreshold")
  self.maxSmokeRate = config.getParameter("smokeRateAtZeroHealth")
  self.maxFireRate = config.getParameter("fireRateAtZeroHealth")

  self.onFireThreshold = config.getParameter("onFireHealthThreshold")
  self.damagePerSecondWhenOnFire = config.getParameter("damagePerSecondWhenOnFire")

  self.engineDamageSoundThreshold = config.getParameter("engineDamageSoundThreshold")
  self.intermittentDamageSoundThreshold = config.getParameter("intermittentDamageSoundThreshold")

  -- this is a range
  self.maxDamageSoundInterval = config.getParameter("maxDamageSoundInterval")
  self.minDamageSoundInterval = config.getParameter("minDamageSoundInterval")

  self.minDamageCollisionAccel = config.getParameter("minDamageCollisionAccel")
  self.minNotificationCollisionAccel = config.getParameter("minNotificationCollisionAccel")
  self.terrainCollisionDamage = config.getParameter("terrainCollisionDamage")
  self.materialKind = config.getParameter("materialKind")
  self.terrainCollisionDamageSourceKind = config.getParameter("terrainCollisionDamageSourceKind")
  self.accelerationTrackingCount = config.getParameter("accelerationTrackingCount")

  self.damageStateNames = config.getParameter("damageStateNames")

  self.engineIdlePitch = config.getParameter("engineIdlePitch")
  self.engineRevPitch = config.getParameter("engineRevPitch")
  self.engineIdleVolume = config.getParameter("engineIdleVolume")
  self.engineRevVolume = config.getParameter("engineRevVolume")

  self.damageStatePassengerDances = config.getParameter("damageStatePassengerDances")
  self.damageStatePassengerEmotes = config.getParameter("damageStatePassengerEmotes")
  self.damageStateDriverEmotes = config.getParameter("damageStateDriverEmotes")
  self.name = config.getParameter("name")

  self.loopPlaying = nil;
  self.enginePitch = self.engineRevPitch;
  self.engineVolume = self.engineIdleVolume;

  self.driver = nil;
  self.facingDirection = 1
  self.angle = 0
  self.jumpTimer = 0
  self.engineRevTimer = 0.0
  self.revEngine = false
  self.damageSoundTimer = 0.0
  self.spin = 0

  self.damageEmoteTimer = 0.0

  self.collisionDamageTrackingVelocities = {}
  self.collisionNotificationTrackingVelocities = {}
  self.selfDamageNotifications = {}

  self.wheelTitles = config.getParameter("wheelTitles")
  self.wheelTiltFactor = config.getParameter("wheelTiltFactor")
  self.wheelAngles = {}
  self.wheelPos = {}
  for _, title in pairs(self.wheelTitles) do
    table.insert(self.wheelPos, animator.partProperty(sb.print(title), "parkTransition"))
  end
  for _, title in pairs(self.wheelTitles) do table.insert(self.wheelAngles, 0) end

  -- initial state
  self.headlightCanToggle = true
  self.headlightsOn = false
  self.hornPlaying = false

  self.hazardOn = false
  self.stopOn = false

  self.isGUIOpen = true
  self.isGUIOpenCanToggle = true

  self.startEngineTimout = 2
  self.startEngineTimer = self.startEngineTimout

  self.startEngineSfxTimout = 0.3
  self.startEngineSfxTimer = self.startEngineSfxTimout

  self.isActivated = false
  self.isActivatedCanToggle = true
  self.isFlyMode = false
  self.isFlyModeCanToggle = true

  self.isAim = false
  self.fixedAimPos = {0, 0}
  self.isFixedAim = false
  self.isFixedAimCanToggle = true

  self.isAimFollow = false
  self.isAimFollowCanToggle = true

  self.musicList = root.assetJson("/music/music.json")
  self.musicCurrentId = 1
  self.musicIsPlaying = false
  self.musicPitch = 1.0
  self.musicVolume = 1.0
  self.isSpawning = true

  self.wheelAngle = 0;
  self.radioGuiButtons = {
    play = {
      title = "Play",
      pos = {0, -3},
      size = 0.5,
      color = {0, 255, 255, 255},
      enabled = false,
      canClick = true
    },
    next = {
      title = "|>",
      pos = {2, -3},
      size = 0.5,
      color = {0, 255, 255, 255},
      enabled = false,
      canClick = true
    },
    previous = {
      title = "<|",
      pos = {-2, -3},
      size = 0.5,
      color = {0, 255, 255, 255},
      enabled = false,
      canClick = true
    },
    pitch = {
      title = "1.0",
      pos = {1, -1},
      size = 0.5,
      color = {0, 255, 255, 255},
      enabled = false,
      canClick = true
    },
    pitch_up = {
      title = "|>",
      pos = {2.5, -1},
      size = 0.5,
      color = {0, 255, 255, 255},
      enabled = false,
      canClick = true
    },
    pitch_down = {
      title = "<|",
      pos = {-0.5, -1},
      size = 0.5,
      color = {0, 255, 255, 255},
      enabled = false,
      canClick = true
    },
    volume = {
      title = "1.0",
      pos = {1, -2},
      size = 0.5,
      color = {0, 255, 255, 255},
      enabled = false,
      canClick = true
    },
    volume_up = {
      title = "|>",
      pos = {2.5, -2},
      size = 0.5,
      color = {0, 255, 255, 255},
      enabled = false,
      canClick = true
    },
    volume_down = {
      title = "<|",
      pos = {-0.5, -2},
      size = 0.5,
      color = {0, 255, 255, 255},
      enabled = false,
      canClick = true
    }
  }
  self.guiButtons = {
    headLights = {
      title = "HeadLights",
      pos = {5, 3},
      size = 0.5,
      color = {255, 0, 0, 255},
      enabled = false,
      canClick = true
    },
    radio = {
      title = "Radio",
      pos = {-4, 3},
      size = 0.5,
      color = {255, 0, 0, 255},
      enabled = false,
      canClick = true
    },
    hazardLights = {
      title = "Hazard",
      pos = {0, -3},
      size = 0.5,
      color = {255, 0, 0, 255},
      enabled = false,
      canClick = true
    },
    explode = {
      title = "\\!! Explode !!/",
      pos = {0, -5},
      size = 0.5,
      color = {255, 0, 0, 255},
      enabled = false,
      canClick = true
    }
  }

  self.controls = {
    up = false,
    down = false,
    right = false,
    left = false,
    jump = false,
    special1 = false,
    special2 = false,
    special3 = false
  }

  animator.setGlobalTag("rearThrusterFrame", 1)
  animator.setGlobalTag("bottomThrusterFrame", 1)

  animator.setAnimationState("rearThruster", "off")
  animator.setAnimationState("bottomThruster", "off")

  animator.setAnimationState("headlights", "off")

  -- this comes in from the controller.
  self.ownerKey = config.getParameter("ownerKey")
  vehicle.setPersistent(self.ownerKey)

  -- assume maxhealth
  if (storage.health) then
    animator.setAnimationState("movement", "idle")
  else
    local startHealthFactor = config.getParameter("startHealthFactor")

    if (startHealthFactor == nil) then
      storage.health = self.maxHealth
    else
      storage.health = math.min(startHealthFactor * self.maxHealth, self.maxHealth)
    end
    animator.setAnimationState("movement", "warpInPart1")
  end

  -- setup the store functionality
  message.setHandler("store", function(_, _, ownerKey)
    if (self.ownerKey and self.ownerKey == ownerKey and self.driver == nil and animator.animationState("movement") ==
        "idle") then
      animator.setAnimationState("movement", "warpOutPart1")
      switchHeadLights(1, 1, false)
      animator.playSound("returnvehicle")
      return {
        storable = true,
        healthFactor = storage.health / self.maxHealth
      }
    else
      return {
        storable = false,
        healthFactor = storage.health / self.maxHealth
      }
    end
  end)

  initPosition = mcontroller.position()
  self.lastPosition = mcontroller.position()
  message.setHandler("drop", function()
    self.lastPosition = vec2.add(mcontroller.position(), {0, 22})
    mcontroller.setPosition(self.lastPosition)
    self.movementSettings.collisionEnabled = false

  end)

  updateVisualEffects(storage.health, 0, false)
  -- sb.logInfo("LFSB: vehicle " .. entity.id() .. " is spawned")
end

function getVehicleData()
  local data = {
    speed = math.abs(mcontroller.xVelocity())
  }
  data.isGUIOpen = self.isGUIOpen
  data.titlemusic = self.musicList["music"][self.musicCurrentId]
  return data
end

function update()
  if mcontroller.atWorldLimit() then
    vehicle.destroy()
    return
  end

  if self.isSpawning then
    local diff = vec2.sub(initPosition, mcontroller.position())
    diff = {math.abs(diff[1]), math.abs(diff[2])}
    -- sb.logInfo(sb.printJson(initPosition) .. sb.printJson(mcontroller.position()))
    if diff[1] < 1 and diff[2] < 1 then
      self.movementSettings.collisionEnabled = true
      self.isSpawning = false
    elseif diff[1] > 50 and diff[2] > 50 then
      vehicle.destroy()
    end
  end

  if (animator.animationState("movement") == "invisible") then
    vehicle.destroy()
  elseif (animator.animationState("movement") == "warpInPart1" or animator.animationState("movement") == "warpOutPart2") then
    mcontroller.setPosition(self.lastPosition)
    mcontroller.setVelocity({0, 0})
  else
    local driverThisFrame = vehicle.entityLoungingIn("drivingSeat")
    local healthFactor = storage.health / self.maxHealth

    if (driverThisFrame ~= nil) then
      vehicle.setDamageTeam(world.entityDamageTeam(driverThisFrame))
    else
      vehicle.setDamageTeam({
        type = "passive"
      })
    end

    updateControls()
    controls()
    animate()
    drawGUI()
    controlsGUI()
    updateMovementSettings()
    updateDamage()
    updateDriveEffects(healthFactor, driverThisFrame)
    updatePassengers(healthFactor)

    if self.isActivated then
      if self.isFlyMode then
        flyMove()
      else
        move()
      end
    else
      updateAngle()
    end
    self.driver = driverThisFrame
  end

end

function localanimator(func, args)
  if not args then args = {} end
  local driver = vehicle.entityLoungingIn("drivingSeat")
  if driver ~= nil then world.sendEntityMessage(driver, func, table.unpack(args)) end
end

function updateMovementSettings()
  mcontroller.resetParameters(self.movementSettings)
  if self.isActivated then
    if not self.isFlyMode then mcontroller.applyParameters(self.occupiedMovementSettings) end
    if self.isFlyMode then mcontroller.applyParameters(self.zeroGMovementSettings) end
  end
end
-- collect controls
function updateControls()
  self.controls = {
    up = vehicle.controlHeld("drivingSeat", "up"),
    down = vehicle.controlHeld("drivingSeat", "down"),
    left = vehicle.controlHeld("drivingSeat", "left"),
    right = vehicle.controlHeld("drivingSeat", "right"),
    jump = vehicle.controlHeld("drivingSeat", "jump"),
    special1 = vehicle.controlHeld("drivingSeat", "special1"),
    special2 = vehicle.controlHeld("drivingSeat", "special2"),
    special3 = vehicle.controlHeld("drivingSeat", "special3"),
    alt = vehicle.controlHeld("drivingSeat", "AltFire"),
    primary = vehicle.controlHeld("drivingSeat", "PrimaryFire")
  }
end

function controls()

  if self.controls.special2 and not self.controls.alt then
    if self.isGUIOpenCanToggle then
      self.isGUIOpen = not self.isGUIOpen
      -- if self.isGUIOpen then
      --   self.editpane = root.assetJson("/interface/controlsgui/guipane.json")
      --   self.editpane.vehicleId = entity.id()
      --   self.editpane.vehicleName = self.name
      --   world.sendEntityMessage(self.driver, "interact", "ScriptPane", self.editpane)
      -- end
      self.isGUIOpenCanToggle = false
    end
  else
    self.isGUIOpenCanToggle = true
  end

  if self.controls.jump and not self.stopOn then
    self.stopOn = true
    animator.setAnimationState("stopsignals", "on")
  elseif not self.controls.jump and self.stopOn then
    self.stopOn = false
    animator.setAnimationState("stopsignals", "off")

  end

  if self.controls.special1 and self.controls.jump then
    if not self.isActivated and self.isActivatedCanToggle then

      if self.startEngineSfxTimer <= 0 then
        animator.setSoundPitch("startingEngine", 0.8)
        animator.playSound("startingEngine")
        self.startEngineSfxTimer = self.startEngineSfxTimout
      else
        self.startEngineSfxTimer = self.startEngineSfxTimer - script.updateDt()
      end
    end
    if self.startEngineTimer <= 0 and self.isActivatedCanToggle then
      self.isActivated = not self.isActivated
      self.isActivatedCanToggle = false
      self.startEngineTimer = self.startEngineTimout
      if self.isActivated then
        animator.setSoundPitch("engineStart", 1)
        animator.setSoundVolume("engineStart", 1)
        animator.playSound("engineStart")
      end
    end
    self.startEngineTimer = self.startEngineTimer - script.updateDt()
  else
    if self.isActivated then self.startEngineTimer = 0 end
    self.isActivatedCanToggle = true
  end

  if self.controls.special3 then
    if not self.hornPlaying then animator.playSound("hornLoop", -1) end
    self.hornPlaying = true;
  else
    if self.hornPlaying then
      animator.stopAllSounds("hornLoop")
      self.hornPlaying = false;
    end
  end
  -- localanimator("lfvehicledata", {{
  --   speed = mcontroller.xVelocity()
  -- }})
  if self.driver then

    -- localanimator("clearDrawables", {})
    -- localanimator("addDrawable", {{
    --   image = "/interface/controlsgui/body.png",
    --   position = {0, 0},
    --   fullbright = true
    -- }, "ForegroundTile-50"})
    -- localanimator("addDrawable", {{
    --   poly = {{100, -100}, {100, 100}, {-100, 100}, {-100, -100}},
    --   position = {0, 0},
    --   color = {10, 10, 10, math.min(255, 255 * (math.abs(mcontroller.xVelocity() - 30) / 60))},
    --   fullbright = true
    -- }, "BackgroundTile-99"})
    -- localanimator("addDrawable", {{
    --   image = "/cinematics/starfield0.png",
    --   color = {255, 255, 255, math.min(255, 255 * (math.abs(mcontroller.xVelocity() - 30) / 100))},
    --   position = {math.sin(os.clock() / 2) * 20, 0},
    --   rotation = -math.sin(os.clock() / 4),
    --   fullbright = true
    -- }, "BackgroundTile-97"})
    -- for i = 1, 3 do
    --   localanimator("addDrawable", {{
    --     image = "/cinematics/glitters.png?hueshift=" .. 100,
    --     color = {255, 255, 255, math.min(255, 255 * (math.abs(mcontroller.xVelocity() - 30) / 200))},
    --     position = {math.sin(os.clock() / i) * (50 / i), math.cos(os.clock() / i) * 0},
    --     rotation = math.sin(os.clock() / -i) * 2,
    --     fullbright = true
    --   }, "BackgroundTile-97"})
    -- end
    -- if mcontroller.xVelocity() > 30 then
    --   localanimator("clearLightSources")

    --   localanimator("addLightSource", {{
    --     position = mcontroller.position(),
    --     color = {math.random(255), math.random(255), math.random(255)},
    --     beamAmbiance = 10
    --   }})
    -- end
  end

  if self.controls.up and self.controls.special1 then
    if self.isFlyModeCanToggle then
      self.isFlyMode = not self.isFlyMode
      self.isFlyModeCanToggle = false
    end
  else
    self.isFlyModeCanToggle = true
  end

  if self.controls.alt and self.isActivated then
    -- toggle fixed aim
    if self.isFixedAimCanToggle and self.controls.primary then
      self.isFixedAim = not self.isFixedAim
      self.isAimFollow = false
      self.isFixedAimCanToggle = false
    elseif not self.controls.primary then
      self.isFixedAimCanToggle = true
    end
    -- toggle aim follow
    if self.isAimFollowCanToggle and self.controls.special2 then
      self.isAimFollow = not self.isAimFollow
      self.isFixedAim = false
      self.isAimFollowCanToggle = false
    elseif not self.controls.special2 then
      self.isAimFollowCanToggle = true
    end
  end
  -- results
  if self.isActivated then
    if self.controls.alt or self.isAimFollow then
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
  drawDebugInfo("isActivated: %s", self.isActivated, {-5, 2})
  drawDebugInfo("isFlyMode: %s", self.isFlyMode, {-5, 1})
  drawDebugInfo("isFixedAim: %s", self.isFixedAim, {-5, 0})
  drawDebugInfo("isAim: %s", self.isAim, {-5, -1})

end

function controlsGUI()
  local isGuiLight = self.guiButtons["headLights"].enabled
  if isGuiLight and not self.headlightsOn then
    animator.playSound("headlightSwitchOn")
    updateVisualEffects(storage.health, 0, (not self.headlightsOn))
  elseif not isGuiLight and self.headlightsOn then
    animator.playSound("headlightSwitchOff")
    updateVisualEffects(storage.health, 0, (not self.headlightsOn))
  end

  local isGuiHazard = self.guiButtons["hazardLights"].enabled
  if isGuiHazard and not self.hazardOn then
    self.hazardOn = true
    animator.setAnimationState("hazardlights", "on")
  elseif not isGuiHazard and self.hazardOn then
    self.hazardOn = false
    animator.setAnimationState("hazardlights", "off")

  end

  if self.guiButtons["explode"].enabled then storage.health = 0 end

  if self.radioGuiButtons["next"].enabled then
    self.musicCurrentId = self.musicCurrentId + 1
    if (#self.musicList["music"] + 1 <= self.musicCurrentId) then self.musicCurrentId = 1 end
    self.radioGuiButtons["next"].enabled = false
  end
  if self.radioGuiButtons["previous"].enabled then
    self.musicCurrentId = self.musicCurrentId - 1
    if (0 >= self.musicCurrentId) then self.musicCurrentId = #self.musicList["music"] end
    self.radioGuiButtons["previous"].enabled = false
  end

  if self.radioGuiButtons["pitch_up"].enabled then
    self.musicPitch = self.musicPitch + 0.1
    self.radioGuiButtons["pitch_up"].enabled = false
  end
  if self.radioGuiButtons["pitch_down"].enabled then
    self.musicPitch = self.musicPitch - 0.1
    if self.musicPitch <= 0 then self.musicPitch = 0.1 end
    self.radioGuiButtons["pitch_down"].enabled = false
  end

  if self.radioGuiButtons["volume_up"].enabled then
    self.musicVolume = self.musicVolume + 0.1
    self.musicVolume = self.musicVolume > 2 and 2 or self.musicVolume
    self.radioGuiButtons["volume_up"].enabled = false
  end
  if self.radioGuiButtons["volume_down"].enabled then
    self.musicVolume = self.musicVolume - 0.1
    self.musicVolume = self.musicVolume <= 0 and 0.1 or self.musicVolume
    self.radioGuiButtons["volume_down"].enabled = false
  end

  if self.radioGuiButtons["play"].enabled then
    self.radioGuiButtons["play"].title = "Stop"
    if not self.musicIsPlaying then
      self.musicIsPlaying = true
      local music = {self.musicList["music"][self.musicCurrentId]}
      animator.setSoundPool("music", music)
      animator.setSoundVolume("music", self.musicVolume)
      animator.setSoundPitch("music", self.musicPitch)
      animator.playSound("music", -1)
    end
  else
    if self.musicIsPlaying then
      self.musicIsPlaying = false
      animator.stopAllSounds("music")
    end
    self.radioGuiButtons["play"].title = "Play"
  end

end

-- make the driver and passenger dance and emote according to the damage state of the vehicle
function updatePassengers(healthFactor)
  if healthFactor > 0 then
    local maxDamageState = #self.damageStatePassengerDances
    local damageStateIndex = maxDamageState
    damageStateIndex = (maxDamageState - math.ceil(healthFactor * maxDamageState)) + 1

    local dance = self.damageStatePassengerDances[damageStateIndex]
    if (dance ~= "") then vehicle.setLoungeDance("passengerSeat", dance) end

    -- if we have a scared face on because of taking damage
    if self.damageEmoteTimer > 0 then
      self.damageEmoteTimer = self.damageEmoteTimer - script.updateDt()
    else
      maxDamageState = #self.damageStatePassengerEmotes
      damageStateIndex = maxDamageState
      damageStateIndex = (maxDamageState - math.ceil(healthFactor * maxDamageState)) + 1
      vehicle.setLoungeEmote("passengerSeat", self.damageStatePassengerEmotes[damageStateIndex])

      maxDamageState = #self.damageStateDriverEmotes
      damageStateIndex = maxDamageState
      damageStateIndex = (maxDamageState - math.ceil(healthFactor * maxDamageState)) + 1
      vehicle.setLoungeEmote("drivingSeat", self.damageStateDriverEmotes[damageStateIndex])
    end
  end
end

function updateDriveEffects(healthFactor, driverThisFrame)
  local startSoundName = "engineStart"
  local loopSoundName = "engineLoop"

  if (healthFactor < self.engineDamageSoundThreshold) then
    startSoundName = "engineStartDamaged"
    loopSoundName = "engineLoopDamaged"
  end

  -- if not activated -> stop all effects and exit from func
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

  self.loopPlaying = loopSoundName
  local enginePitch = self.engineIdlePitch;
  local engineVolume = self.engineIdleVolume;
  animator.setParticleEmitterActive("ventralThrusterIdle", true)
  animator.setParticleEmitterActive("rearThrusterIdle", true)
  animator.setParticleEmitterActive("ventralThrusterJump", false)
  animator.setParticleEmitterActive("rearThrusterDrive", false)

  if self.controls.left or self.controls.right then
    enginePitch = self.engineRevPitch;
    engineVolume = self.engineRevVolume;
    animator.setParticleEmitterActive("rearThrusterIdle", false)
    animator.setParticleEmitterActive("rearThrusterDrive", true)
  end
  if self.controls.jump and math.abs(mcontroller.xVelocity()) > 1 then
    enginePitch = self.engineIdlePitch;
    engineVolume = self.engineIdleVolume;
    animator.setParticleEmitterActive("rearThrusterIdle", false)
    animator.setParticleEmitterActive("rearThrusterDrive", true)
  end
  if self.controls.up then
    enginePitch = self.engineRevPitch;
    engineVolume = self.engineRevVolume;
    animator.setParticleEmitterActive("ventralThrusterIdle", false)
    animator.setParticleEmitterActive("ventralThrusterJump", true)
    -- animator.burstParticleEmitter("ventralThrusterJump")
  end
  if self.controls.primary and self.isAimFollow then
    enginePitch = self.engineRevPitch;
    engineVolume = self.engineRevVolume;
    animator.setParticleEmitterActive("rearThrusterIdle", false)
    animator.setParticleEmitterActive("rearThrusterDrive", true)
  end

  if self.enginePitch ~= enginePitch then
    self.enginePitch = enginePitch
    self.engineVolume = engineVolume
    self.engineRevTimer = 0
  end
  if (self.engineRevTimer > 0.0) then
    self.engineRevTimer = self.engineRevTimer - script.updateDt()
  else
    animator.stopAllSounds(self.loopPlaying)
    animator.setSoundPitch(self.loopPlaying, self.enginePitch, 0.5)
    animator.setSoundVolume(self.loopPlaying, self.engineVolume, 0.5)
    animator.playSound(self.loopPlaying, 0)
    self.engineRevTimer = 0.5
  end

  animator.setAnimationState("rearThruster", "on")
  animator.setAnimationState("bottomThruster", "on")

end

function updateVisualEffects(currentHealth, damage, headlights)

  local maxDamageState = #self.damageStateNames
  local prevHealthFactor = currentHealth / self.maxHealth

  -- work out the factor after damage occurs.
  local newHealthFactor = (currentHealth - damage) / self.maxHealth

  -- work out what damage state we are in before damage occurs
  local previousDamageStateIndex = maxDamageState
  if prevHealthFactor > 0 then
    previousDamageStateIndex = (maxDamageState - math.ceil(prevHealthFactor * maxDamageState)) + 1
  end

  -- now the damage state after damage occurs
  local damageStateIndex = maxDamageState
  if newHealthFactor > 0 then damageStateIndex = (maxDamageState - math.ceil(newHealthFactor * maxDamageState)) + 1 end

  -- if we've changed damage state make some danaged effects.
  if (damageStateIndex > previousDamageStateIndex) then
    animator.burstParticleEmitter("damageShards")
    animator.playSound("changeDamageState")
  end

  switchHeadLights(previousDamageStateIndex, damageStateIndex, headlights)

  animator.setGlobalTag("damageState", self.damageStateNames[damageStateIndex])

  -- smoke particles and fire
  if newHealthFactor < 1.0 then
    if (self.smokeThreshold > 0 and newHealthFactor < self.smokeThreshold) then
      local smokeFactor = 1.0 - (newHealthFactor / self.smokeThreshold)
      animator.setParticleEmitterActive("smoke", true)
      animator.setParticleEmitterEmissionRate("smoke", smokeFactor * self.maxSmokeRate)
    end

    if (self.fireThreshold > 0 and newHealthFactor < self.fireThreshold) then
      local fireFactor = 1.0 - (newHealthFactor / self.fireThreshold)
      animator.setParticleEmitterActive("fire", true)
      animator.setParticleEmitterEmissionRate("fire", fireFactor * self.maxFireRate)
    end

    if (self.onFireThreshold and newHealthFactor < self.onFireThreshold) then
      animator.setAnimationState("onfire", "on")
    else
      animator.setAnimationState("onfire", "off")
    end
  else
    animator.setParticleEmitterActive("smoke", false)
    animator.setParticleEmitterActive("fire", false)
    animator.setAnimationState("onfire", "off")
  end
end

function switchHeadLights(oldIndex, newIndex, activate)
  if (activate ~= self.headlightsOn or oldIndex ~= newIndex) then
    local listOfLists = config.getParameter("lightsInDamageState")

    if (listOfLists ~= nil) then
      if (oldIndex ~= newIndex) then
        local listToSwitchOff = listOfLists[oldIndex]
        for i, name in ipairs(listToSwitchOff) do animator.setLightActive(name, false) end
      end

      local listToSwitchOn = listOfLists[newIndex]
      for i, name in ipairs(listToSwitchOn) do animator.setLightActive(name, activate) end
    end
    self.headlightsOn = activate

    if (self.headlightsOn) then
      animator.setAnimationState("headlights", "on")
    else
      animator.setAnimationState("headlights", "off")
    end
  end
end

function setDamageEmotes()
  local damageTakenEmote = config.getParameter("damageTakenEmote")
  self.damageEmoteTimer = config.getParameter("damageEmoteTime")
  vehicle.setLoungeEmote("drivingSeat", damageTakenEmote)
  vehicle.setLoungeEmote("passengerSeat", damageTakenEmote)
end

function applyDamage(damageRequest)
  local damage = 0
  if damageRequest.damageType == "Damage" then
    damage = damage + root.evalFunction2("protection", damageRequest.damage, self.protection)
  elseif damageRequest.damageType == "IgnoresDef" then
    damage = damage + damageRequest.damage
  else
    return {}
  end

  setDamageEmotes()

  updateVisualEffects(storage.health, damage, self.headlightsOn)

  local healthLost = math.min(damage, storage.health)
  storage.health = storage.health - healthLost

  return {{
    sourceEntityId = damageRequest.sourceEntityId,
    targetEntityId = entity.id(),
    position = mcontroller.position(),
    damageDealt = damage,
    healthLost = healthLost,
    hitType = "Hit",
    damageSourceKind = damageRequest.damageSourceKind,
    targetMaterialKind = self.materialKind,
    killed = storage.health <= 0
  }}
end

function selfDamageNotifications()
  local sdn = self.selfDamageNotifications
  self.selfDamageNotifications = {}
  return sdn
end

function flyMove()

  local groundDistance = minimumSpringDistance(self.bodySpringPositions)
  if groundDistance <= self.hoverTargetDistance then
    mcontroller.approachYVelocity((self.hoverTargetDistance - groundDistance) * self.hoverVelocityFactor,
        self.hoverControlForce)
  end

  local xMove = math.sin(os.clock() * 1.5) * 0.8
  local yMove = math.sin(os.clock() * 0.8) * 0.9
  local move = not self.isAimFollow

  if self.controls.jump then
    mcontroller.approachXVelocity(xMove, self.horizontalControlForce * 1.5)
    mcontroller.approachYVelocity(yMove, self.horizontalControlForce * 1.5)
    -- elseif self.controls.primary and self.isAimFollow then
    --   local diff = world.distance(self.fixedAimPos, mcontroller.position())
    --   local len = math.sqrt(diff[1] * diff[1] + diff[2] * diff[2])
    --   diff = {diff[1] / len, diff[2] / len}
    --   diff = vec2.mul(diff, {self.targetHorizontalVelocity, self.targetHorizontalVelocity})
    --   xMove = diff[1]
    --   yMove = diff[2]
    --   mcontroller.approachVelocity(diff, self.horizontalControlForce)
  else

    if self.controls.primary and self.isAimFollow then
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
    if self.controls.left then
      xMove = -self.targetHorizontalVelocity
      if not self.isAim then self.facingDirection = -1 end
    elseif self.controls.right then
      xMove = self.targetHorizontalVelocity
      if not self.isAim then self.facingDirection = 1 end
    end

    -- up down
    if self.controls.up then
      yMove = self.targetHorizontalVelocity
    elseif self.controls.down then
      yMove = -self.targetHorizontalVelocity
    end
    move = (self.targetHorizontalVelocity == math.abs(xMove)) or (self.targetHorizontalVelocity == math.abs(yMove)) or
               move
    if move then
      mcontroller.approachXVelocity(xMove, self.horizontalControlForce)
      mcontroller.approachYVelocity(yMove, self.horizontalControlForce)
    end
  end
  updateAngle()
end

function updateAngle()
  local targetAngle = 0
  local groundDistance = minimumSpringDistance(self.bodySpringPositions)
  local nearGround = groundDistance < self.nearGroundDistance
  if self.isAim and self.isActivated then
    mcontroller.setRotation(self.angle)
    return
  end
  if not nearGround and not self.isActivated then

  elseif not nearGround and self.isActivated then
    if self.controls.up then
      targetAngle = (self.facingDirection < 0) and -self.maxAngle or self.maxAngle
    elseif self.controls.down then
      targetAngle = (self.facingDirection < 0) and self.maxAngle or -self.maxAngle
    else
      targetAngle = 0
    end
    self.angle = self.angle + (targetAngle - self.angle) * self.angleApproachFactor
  else
    local frontSpringDistance = minimumSpringDistance(self.frontSpringPositions)
    local backSpringDistance = minimumSpringDistance(self.backSpringPositions)
    if frontSpringDistance == self.maxGroundSearchDistance and backSpringDistance == self.maxGroundSearchDistance then
      self.angle = self.angle - self.angle * self.angleApproachFactor
    else
      self.angle = self.angle + math.atan((backSpringDistance - frontSpringDistance) * self.levelApproachFactor)
      self.angle = math.min(math.max(self.angle, -self.maxAngle), self.maxAngle)
    end
  end
  mcontroller.setRotation(self.angle)

end

function move()
  self.spin = 0

  local groundDistance = minimumSpringDistance(self.bodySpringPositions)
  local nearGround = groundDistance < self.nearGroundDistance

  if groundDistance <= self.hoverTargetDistance then
    mcontroller.approachYVelocity((self.hoverTargetDistance - groundDistance) * self.hoverVelocityFactor,
        self.hoverControlForce)
  end
  if self.controls.jump then
    mcontroller.approachXVelocity(0, self.horizontalControlForce * 1.5)
  else
    local xMove = 0
    local yMove = 0
    local force = 0
    if self.controls.left then
      if not self.isAim then self.facingDirection = -1 end
      xMove = -self.targetHorizontalVelocity
      force = self.horizontalControlForce

    elseif self.controls.right then
      if not self.isAim then self.facingDirection = 1 end
      xMove = self.targetHorizontalVelocity
      force = self.horizontalControlForce
    end
    mcontroller.approachXVelocity(xMove, force)

  end

  if self.controls.up or self.controls.down then end
  updateAngle()
end

-- Animate stuff

function animate()
  animator.resetTransformationGroup("rotation")
  animator.rotateTransformationGroup("rotation", self.angle * self.facingDirection)
  animator.setFlipped(self.facingDirection < 0 and true or false)
  animateWheels()
  if self.isAim then animateVehicleAim() end

end

function animateVehicleAim()
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

function animateWheels()
  -- local targetWheelPos = {0, 0}
  local tilt = 0
  for _, name in pairs(self.wheelTitles) do
    animator.resetTransformationGroup(sb.print(name))
    local rotationPoint = vec2.mul(animator.partPoint(sb.print(name), "rotationCenter"), {self.facingDirection, 1})

    local targetWheelPos = animator.partProperty(sb.print(name), "parkTransition")
    if self.isActivated then
      targetWheelPos = {0, 0}
      local xMoveDir = mcontroller.xVelocity() > 0 and 1 or -1
      tilt = (self.angle + mcontroller.xVelocity() * self.wheelTiltFactor * 0.5) * -self.facingDirection
      if math.abs(mcontroller.xVelocity()) > 1 then
        if self.controls.jump then
          tilt = -tilt + (20 * math.pi / 180) * -xMoveDir * -self.facingDirection
        elseif self.controls.left then
          tilt = tilt + (-20 * math.pi / 180) * -self.facingDirection
        elseif self.controls.right then
          tilt = tilt + (20 * math.pi / 180) * -self.facingDirection
        end
      end
      tilt = math.min(math.max(tilt, (-90 * math.pi / 180)), (90 * math.pi / 180))
    end

    -- groundSmoke(sb.print(name))

    self.wheelPos[_] = vec2.add(self.wheelPos[_], vec2.mul(vec2.sub(targetWheelPos, self.wheelPos[_]), 0.2))
    self.wheelAngles[_] = self.wheelAngles[_] + (tilt - self.wheelAngles[_]) * 0.1
    animator.rotateTransformationGroup(sb.print(name), self.wheelAngles[_], rotationPoint)
    animator.translateTransformationGroup(sb.print(name), self.wheelPos[_])

    -- drawDebugInfo("Engine angle: %s", tilt, {0, 0})
    -- drawDebugInfo("Hull angle: %s", self.angle, {0, 2})
    -- drawDebugInfo("Face Direction: %s", self.facingDirection, {0, 1})
    drawDebugInfo("WheelTargetPos: %s", targetWheelPos, {0, _})

  end
end

-- Draw and handle GUI

function drawGUI()
  -- local pos = mcontroller.position()
  -- localanimator("spawnParticle", {{
  --   type = "text",
  --   text = "{ " .. math.ceil(pos[1]) .. ", " .. math.ceil(pos[2])  .. " }",
  --   fullbright = true,
  --   position = {0, 4},
  --   size = 0.5,
  --   layer = "front",
  --   color = {255, 150, 0, 255},
  --   timeToLive = 0
  -- }, mcontroller.position()})
  if self.isGUIOpen then
    -- if false then
    local speed = math.ceil(mcontroller.xVelocity() * self.facingDirection)
    if not self.isActivated then speed = "^shadow;^red;off" end
    if self.guiButtons["radio"].enabled then drawRadioGUI() end
    localanimator("spawnParticle", {{
      type = "text",
      text = "" .. speed,
      fullbright = true,
      position = {0, 4},
      size = 0.5,
      layer = "front",
      color = {255, 150, 0, 255},
      timeToLive = 0
    }, mcontroller.position()})
    localanimator("spawnParticle", {{
      type = "text",
      text = "/--------|________|--------\\",
      fullbright = true,
      position = {0, 3.7},
      size = 0.5,
      layer = "front",
      color = {255, 150, 0, 200},
      timeToLive = 0
    }, mcontroller.position()})
    localanimator("spawnParticle", {{
      type = "text",
      text = "\\--------|-------|--------/",
      fullbright = true,
      position = {0, -4},
      size = 0.5,
      layer = "front",
      color = {255, 150, 0, 200},
      timeToLive = 0
    }, mcontroller.position()})
    local color = {255, 0, 0, 220}
    if self.isFlyMode then color = {0, 255, 0, 220} end
    localanimator("spawnParticle", {{
      type = "text",
      text = "Flymode",
      fullbright = true,
      position = {0, 3},
      size = 0.5,
      layer = "front",
      color = color,
      timeToLive = 0
    }, mcontroller.position()})
    for _, b in pairs(self.guiButtons) do
      local mousePos = vehicle.aimPosition("drivingSeat");
      if b.enabled then
        b.color = {0, 255, 0, 255}
      else
        b.color = {255, 0, 0, 255}
      end
      if world.magnitude(mousePos, vec2.add(mcontroller.position(), b.pos)) < 1 then
        b.size = 0.6
        if self.controls.primary then
          if b.canClick then
            b.enabled = not b.enabled
            b.canClick = false
          end
        else
          b.canClick = true
        end
      else
        b.size = 0.5
      end
      drawButton(b);
    end
  end
end

function drawRadioGUI()
  local offset = {-9, 2}
  localanimator("spawnParticle", {{
    type = "text",
    text = "^shadow;|----|-------|----|",
    fullbright = true,
    position = vec2.add(offset, {0, 1}),
    size = 0.5,
    layer = "front",
    color = {255, 150, 0, 255},
    timeToLive = 0
  }, mcontroller.position()})
  localanimator("spawnParticle", {{
    type = "text",
    text = "^shadow;" .. self.musicList["music"][self.musicCurrentId],
    fullbright = true,
    position = vec2.add(offset, {0, 0}),
    size = 0.5,
    layer = "front",
    color = {255, 150, 0, 255},
    timeToLive = 0
  }, mcontroller.position()})
  localanimator("spawnParticle", {{
    type = "text",
    text = "^shadow;Pitch:",
    fullbright = true,
    position = vec2.add(offset, {-2, -1}),
    size = 0.5,
    layer = "front",
    color = {255, 150, 0, 255},
    timeToLive = 0
  }, mcontroller.position()})
  localanimator("spawnParticle", {{
    type = "text",
    text = "^shadow;Volume:",
    fullbright = true,
    position = vec2.add(offset, {-2.4, -2}),
    size = 0.5,
    layer = "front",
    color = {255, 150, 0, 255},
    timeToLive = 0
  }, mcontroller.position()})
  self.radioGuiButtons["pitch"].title = self.musicPitch
  self.radioGuiButtons["volume"].title = self.musicVolume
  for _, b in pairs(self.radioGuiButtons) do
    local mousePos = vehicle.aimPosition("drivingSeat");
    local btnPos = vec2.add(offset, b.pos)
    local button = {
      title = b.title,
      pos = btnPos,
      size = b.size,
      color = b.color
    }
    if world.magnitude(mousePos, vec2.add(mcontroller.position(), btnPos)) < 0.5 then
      button.size = button.size + 0.1
      if self.controls.primary then
        if b.canClick then
          b.enabled = not b.enabled
          b.canClick = false
        end
      else
        b.canClick = true
      end
    end
    drawButton(button)
  end
end

function drawButton(button)
  localanimator("spawnParticle", {{
    type = "text",
    text = "^shadow;" .. button.title,
    fullbright = true,
    position = button.pos,
    size = button.size,
    layer = "front",
    color = button.color,
    timeToLive = 0
  }, mcontroller.position()})
end

-- Ground smoke

function groundSmoke(name)
  local point = vec2.mul(animator.partPoint(name, "rotationCenter"), {self.facingDirection, 1})
  local invertedPoint = vec2.mul(point, {self.facingDirection, 1})
  local startPoint = vec2.add(mcontroller.position(), invertedPoint)
  local endPoint = vec2.add(mcontroller.position(), vec2.add(
      vec2.rotate({0, -6}, self.wheelAngle * self.facingDirection + self.angle), invertedPoint))

  world.debugLine(startPoint, endPoint, {255, 255, 255, 255})
  local intPoint = world.lineCollision(startPoint, endPoint)

  if intPoint and self.isActivated then
    world.debugPoint(intPoint, {255, 255, 255, 255})
    local distance = world.distance(startPoint, intPoint)[2]
    animator.resetTransformationGroup("engineGroundDust")

    -- animator.rotateTransformationGroup("engineGroundDust", self.wheelAngle, point)
    animator.translateTransformationGroup("engineGroundDust", vec2.sub(invertedPoint, {0, distance - 0.5}))
    animator.setParticleEmitterActive("thrusterDust", true)
  else
    animator.setParticleEmitterActive("thrusterDust", false)
  end
end

function groundSmoke_v1(groupName)

  animator.resetTransformationGroup("groundpos_front")
  animator.resetTransformationGroup("groundpos_back")

  local startPoint_front = vec2.add(mcontroller.position(),
      vec2.rotate({5, -2}, util.toRadians(self.angle) * self.facingDirection))
  local endPoint_front = vec2.add(mcontroller.position(), vec2.add({0, -10}, vec2.rotate({5, -2}, util.toRadians(
      self.angle) * self.facingDirection)))

  world.debugLine(startPoint_front, endPoint_front, {255, 255, 255, 255})
  local intPoint_front = world.lineCollision(startPoint_front, endPoint_front)

  if intPoint_front and self.launched then
    world.debugPoint(intPoint_front, {255, 255, 255, 255})
    animator.translateTransformationGroup("groundpos_front",
        {5, 0.875 - world.distance(mcontroller.position(), intPoint_front)[2]})
    animator.setParticleEmitterActive("thrusterDustFront", true)
  else
    animator.setParticleEmitterActive("thrusterDustFront", false)
  end

end

-- another stuff

function updateDamage()
  if animator.animationState("onfire") == "on" then
    setDamageEmotes()

    local damageThisFrame = self.damagePerSecondWhenOnFire * script.updateDt()
    updateVisualEffects(storage.health, damageThisFrame, self.headlightsOn)
    storage.health = storage.health - damageThisFrame
  end

  if storage.health <= 0 then
    animator.burstParticleEmitter("damageShards")
    animator.burstParticleEmitter("wreckage")
    animator.playSound("explode")
    animator.stopAllSounds("engineLoop")
    animator.stopAllSounds("engineLoopDamaged")
    self.isGUIOpen = false

    local projectileConfig = {
      damageTeam = {
        type = "indiscriminate"
      },
      power = config.getParameter("explosionDamage"),
      onlyHitTerrain = false,
      timeToLive = 0,
      actionOnReap = {{
        action = "config",
        file = config.getParameter("explosionConfig")
      }}
    }
    world.spawnProjectile("invisibleprojectile", mcontroller.position(), 0, {0, 0}, false, projectileConfig)

    vehicle.destroy()
  end

  local newPosition = mcontroller.position()
  local newVelocity = vec2.div(vec2.sub(newPosition, self.lastPosition), script.updateDt())
  self.lastPosition = newPosition

  if mcontroller.isColliding() then
    function findMaxAccel(trackedVelocities)
      local maxAccel = 0
      for _, v in ipairs(trackedVelocities) do
        local accel = vec2.mag(vec2.sub(newVelocity, v))
        if accel > maxAccel then maxAccel = accel end
      end
      return maxAccel
    end

    if findMaxAccel(self.collisionDamageTrackingVelocities) >= self.minDamageCollisionAccel then
      animator.playSound("collisionDamage")
      setDamageEmotes()

      updateVisualEffects(storage.health, self.terrainCollisionDamage, self.headlightsOn)

      storage.health = storage.health - self.terrainCollisionDamage
      self.collisionDamageTrackingVelocities = {}
      self.collisionNotificationTrackingVelocities = {}

      table.insert(self.selfDamageNotifications, {
        sourceEntityId = entity.id(),
        targetEntityId = entity.id(),
        position = mcontroller.position(),
        damageDealt = self.terrainCollisionDamage,
        healthLost = self.terrainCollisionDamage,
        hitType = "Hit",
        damageSourceKind = self.terrainCollisionDamageSourceKind,
        targetMaterialKind = self.materialKind,
        killed = storage.health <= 0
      })
    end

    if findMaxAccel(self.collisionNotificationTrackingVelocities) >= self.minNotificationCollisionAccel then
      animator.playSound("collisionNotification")
      self.collisionNotificationTrackingVelocities = {}
    end
  end

  function appendTrackingVelocity(trackedVelocities, newVelocity)
    table.insert(trackedVelocities, newVelocity)
    while #trackedVelocities > self.accelerationTrackingCount do table.remove(trackedVelocities, 1) end
  end

  appendTrackingVelocity(self.collisionDamageTrackingVelocities, newVelocity)
  appendTrackingVelocity(self.collisionNotificationTrackingVelocities, newVelocity)
end

function minimumSpringDistance(points)
  local min = nil
  for _, point in ipairs(points) do
    point = vec2.rotate(point, self.angle)
    point = vec2.add(point, mcontroller.position())
    local d = distanceToGround(point)
    if min == nil or d < min then min = d end
  end
  return min
end

function distanceToGround(point)
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

function drawDebugInfo(text, data, position)
  world.debugText(sb.print(text), data, vec2.add(mcontroller.position(), position), "red")
end
