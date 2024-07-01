gui = {}

function gui:init()
  self.isGUIOpen = false
  self.isGUIOpenCanToggle = true
  self.editpane = nil
  self.starterOn = false
  self.isCommand = false
  self.isMoving = false
  self.pos = {0, 0}
  message.setHandler("hazard", function()
    movement.hazardOn = not movement.hazardOn
  end)
  message.setHandler("headlights", function()
    movement.headlightsOn = not movement.headlightsOn
  end)
  message.setHandler("radioplay", function()
    radio:play()
  end)
  message.setHandler("radionext", function()
    radio:next()
  end)
  message.setHandler("radioprev", function()
    radio:prev()
  end)
  message.setHandler("starter", function()
    -- movement.isActivatedCanToggle = true
    self.starterOn = not self.starterOn
    self.isCommand = true
  end)
  message.setHandler("moveToPos", function(_, _, pos)
    self.isMoving = true
    self.pos = pos
  end)
  sb.logInfo("LFSB: gui inited")
end

function gui:update()
  self:contols()
  if self.isMoving then
    local distance = world.distance(self.pos, mcontroller.position())
    if math.abs(distance[1]) < 1 and math.abs(distance[2]) < 1 then self.isMoving = false end
    movement:moveToPos(self.pos)
    localanimator("spawnParticle", {{
      type = "text",
      text = "vehicle",
      fullbright = true,
      position = {0, 0},
      size = 0.6,
      layer = "front",
      color = {204, 30, 93, 200},
      timeToLive = 0
    }, mcontroller.position()})
  end
  if self.starterOn ~= movement.isActivated and self.isCommand then
    movement:starter()
  else
    self.isCommand = false
  end
end

function gui:contols()
  if cabin.controls.special2 and not cabin.controls.alt then
    if self.isGUIOpenCanToggle then
      self.isGUIOpen = not self.isGUIOpen
      if self.isGUIOpen then
        self.editpane = root.assetJson("/interface/controlsgui/guipane.json")
        self.editpane.vehicleId = entity.id()
        self.editpane.vehicleName = config.getParameter("name")
        world.sendEntityMessage(cabin.driver, "interact", "ScriptPane", self.editpane)
      end
      self.isGUIOpenCanToggle = false
    end
  else
    self.isGUIOpenCanToggle = true
  end

end

function getVehicleData()
  local data = {}
  data.speed = math.abs(mcontroller.xVelocity())
  data.isGUIOpen = gui.isGUIOpen
  data.isHazard = movement.hazardOn
  data.isHeadlights = movement.headlightsOn
  data.musicTitle = radio:getTitle()
  data.isMusicPlay = radio.musicIsPlaying
  data.radioSize = radio:getSize()
  data.health = storage.health
  data.maxHealth = self.maxHealth
  return data
end

function gui:uninit()

end

addlfscript(gui)
