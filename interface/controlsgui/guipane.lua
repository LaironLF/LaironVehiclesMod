require "/scripts/vec2.lua"
require "/scripts/util.lua"
require "/scripts/poly.lua"

function init()
  self.vehicleId = config.getParameter("vehicleId", nil)
  self.vehicleName = config.getParameter("vehicleName", nil)
  self.isRemoteOpen = config.getParameter("isRemoteOpen", false)
  self.displayedHealth = 0
  widget.setText("name", self.vehicleName)
  sb.logInfo("LFSB: (GUI) " .. self.vehicleId .. " is opened")
  widget.setProgress("health", 0.5)
  -- message.setHandler("lfvehicledata", function(a, b, params)
  --   if params.speed ~= nil then sb.logInfo("LFSB: " .. a .. b .. params.speed) end
  -- end)

end

function update()
  -- widget.setImage("palette", "/interface/colorchange/palette.png" .. "?multiply=" ..
  --     status.statusProperty(self.vehicleParams.id .. "_bodycolor1", "ffffff"))
  local data = {
    speed = 0,
    isGUIOpen = false,
    isHazard = false,
    isHeadlights = false,
    musicTitle = "OFFLINE",
    isMusicPlay = false,
    radioSize = {0, 0},
    health = 0,
    maxHealth = 1
  }
  if world.entityType(self.vehicleId) == "vehicle" then
    data = world.callScriptedEntity(self.vehicleId, "getVehicleData")
  end
  updateGuiData(data)
  -- sb.logInfo("speed: " .. data.speed)
end

function updateGuiData(data)
  -- sb.logInfo(sb.printJson(data))
  if not data.isGUIOpen and not self.isRemoteOpen then pane.dismiss() end
  widget.setText("speed", string.format("%02d", math.ceil(data.speed)))
  if data.isHazard then
    widget.setButtonImage("btn_hazard", "/interface/controlsgui/hazardon.png")
  else
    widget.setButtonImage("btn_hazard", "/interface/controlsgui/hazardoff.png")
  end

  if data.isHeadlights then
    widget.setButtonImage("btn_headlights", "/interface/controlsgui/headlightson.png")
  else
    widget.setButtonImage("btn_headlights", "/interface/controlsgui/headlightsoff.png")
  end

  if data.isMusicPlay then
    widget.setButtonImage("radio_play", "/interface/controlsgui/radio_stop.png")
  else
    widget.setButtonImage("radio_play", "/interface/controlsgui/radio_play.png")
  end
  if data.health then
    self.displayedHealth = self.displayedHealth + (data.health / data.maxHealth - self.displayedHealth) * 0.2
    -- sb.logInfo("" .. data.health .. " / " .. data.maxHealth .. " / " .. self.displayedHealth)
    widget.setProgress("health", self.displayedHealth)
  end
  if data.radioSize then widget.setText("radio_size", data.radioSize[1] .. "/" .. data.radioSize[2]) end

  if data.musicTitle then widget.setText("radio_title", data.musicTitle) end
end

function hazard()
  world.sendEntityMessage(self.vehicleId, "hazard")
end

function headlights()
  world.sendEntityMessage(self.vehicleId, "headlights")
end

function radioplay()
  world.sendEntityMessage(self.vehicleId, "radioplay")
end
function radionext()
  world.sendEntityMessage(self.vehicleId, "radionext")
end
function radioprev()
  world.sendEntityMessage(self.vehicleId, "radioprev")
end
function undrop()
  world.sendEntityMessage(self.vehicleId, "undrop")
  pane.dismiss()
end

function map()
  player.interact("scriptPane", "/interface/celestialmap/cockpit.config")
end

function remote()
  sb.logInfo("remote!")
  world.sendEntityMessage(self.vehicleId, "starter")

end

function uninit()
  -- if not self.isPrevOpen then status.setStatusProperty("controlsIsOpen", false) end
end
