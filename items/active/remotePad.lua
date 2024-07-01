require("/scripts/vec2.lua")
require("/items/active/weapons/weapon.lua")

-- local upd = update
function init()
  sb.logInfo("LFSB: remote pad inited")
  script.setUpdateDelta(1)
  self.weapon = Weapon:new()

  self.weapon:addTransformationGroup("weapon", {0, 0}, 0)
  self.weapon:addTransformationGroup("muzzle", self.weapon.muzzleOffset, 0)
  local primaryAbility = getPrimaryAbility()
  self.weapon:addAbility(primaryAbility)

  local secondaryAbility = getAltAbility(self.weapon.elementalType)
  if secondaryAbility then self.weapon:addAbility(secondaryAbility) end

  self.weapon:init()

  -- self.aimAngle = 0
  -- self.aimDirection = 1
  -- self.vehicleId = nil
end

function activate(fireMode, shiftHeld)
  -- sb.logInfo("LFSB: remote pad inited")
  -- sb.logInfo(sb.printJson(activeItem.ownerAimPosition()))
  if fireMode == "primary" then getVehicleGui() end
  if fireMode == "alt" then controlVehicle() end
end

function controlVehicle()
  if self.vehicleId ~= nil then world.sendEntityMessage(self.vehicleId, "moveToPos", activeItem.ownerAimPosition()) end
end

function getVehicleGui()
  local pos = activeItem.ownerAimPosition()
  -- sb.logInfo(sb.printJson(pos))
  self.guipane = config.getParameter("interactData")

  local entityList = world.entityQuery(pos, 1)
  for _, v in ipairs(entityList) do
    if world.entityType(v) == "vehicle" then
      self.vehicleId = v
      activeItem.setCameraFocusEntity(v)
      return
    end
  end
  self.vehicleId = nil
end

function update(dt, fireMode, shiftHeld)
  -- sb.logInfo("update" .. dt)
  -- updateAim()
  self.weapon:update(dt, fireMode, shiftHeld)
  if self.vehicleId == nil then
    localanimator("spawnParticle", {{
      type = "text",
      text = "^shadow;Select vehicle",
      fullbright = true,
      position = {0, 3},
      size = 0.5,
      layer = "front",
      color = {250, 0, 0, 200},
      timeToLive = 0
    }, world.entityPosition(activeItem.ownerEntityId())})
  else
    localanimator("spawnParticle", {{
      type = "text",
      text = "^shadow;Vehicle Selected",
      fullbright = true,
      position = {0, 3},
      size = 0.5,
      layer = "front",
      color = {0, 250, 0, 200},
      timeToLive = 0
    }, world.entityPosition(activeItem.ownerEntityId())})
  end

  if fireMode == "alt" then controlVehicle() end
  if shiftHeld then
    if self.guiCanToggle then
      if self.vehicleId ~= nil then openGuiPane() end
      self.guiCanToggle = false
    end
  else
    self.guiCanToggle = true
  end
end

function openGuiPane()
  local pane = root.assetJson(self.guipane)
  pane.vehicleId = self.vehicleId
  pane.isRemoteOpen = true
  pane.vehicleName = "remote control"
  activeItem.interact("ScriptPane", pane);
end
-- function updateAim()
--   self.aimAngle, self.aimDirection = activeItem.aimAngleAndDirection(0, activeItem.ownerAimPosition())
--   activeItem.setArmAngle(self.aimAngle)
--   activeItem.setFacingDirection(self.aimDirection)
--   if (self.aimDirection > 0) then activeItem.setOutsideOfHand(false) end
--   if (self.aimDirection < 0) then activeItem.setOutsideOfHand(true) end
-- end

function localanimator(func, args, player)
  if not args then args = {} end
  local driver = activeItem.ownerEntityId()
  -- if player ~= nil then driver = player end
  if driver ~= nil then world.sendEntityMessage(driver, func, table.unpack(args)) end
end

function uninit()
  activeItem.setCameraFocusEntity()

end
