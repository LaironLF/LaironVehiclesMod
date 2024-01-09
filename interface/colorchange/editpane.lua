require "/scripts/vec2.lua"
require "/scripts/util.lua"
require "/scripts/poly.lua"

function init()
  self.vehicleParams = config.getParameter("vehicleParams", {})

  -- if self.shipConfig.animation.globalTagDefaults.bodyColor1 then
  --   self.bodyColor1 = self.shipConfig.animation.globalTagDefaults.bodyColor1
  --   widget.setImage("shipModel", self.shipConfig.animation.animatedParts.parts.body.properties.image)
  -- end

  widget.setText("bodyColor1", status.statusProperty(self.vehicleParams.id .. "_bodycolor1", "ffffff"))

end

function update()
  widget.setImage("palette", "/interface/colorchange/palette.png" .. "?multiply=" ..
      status.statusProperty(self.vehicleParams.id .. "_bodycolor1", "ffffff"))
end

function setColor()
  local color = valid(widget.getText("bodyColor1"))
  status.setStatusProperty(self.vehicleParams.id .. "_bodycolor1", color)
end

function apply()
  pane.dismiss()
end

function valid(color)
  if string.len(color) == 4 or string.len(color) == 6 then
    return color
  else
    return "FFFFFF"
  end
end
