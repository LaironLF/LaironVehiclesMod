require "/scripts/vec2.lua"
require "/scripts/util.lua"
require "/scripts/poly.lua"

function init()
  self.preview = widget.bindCanvas("vehiclePreview")

  --  self.mainConfig = root.assetJson("/ships/mainconfig.json")

  vehicles = root.assetJson("/vehicles/vehicles.json")

  self.vehicles = "vehicles.vehicleItemList"
  for k, v in pairs(vehicles.list) do
    local listItem = string.format("%s.%s", self.vehicles, widget.addListItem(self.vehicles))
    shipConfig = root.assetJson(v)
    local name = shipConfig.name
    local subName = shipConfig.subName
    widget.setText(string.format("%s.shipName", listItem), name)
    widget.setText(string.format("%s.shipId", listItem), subName)
    if shipConfig.icon ~= nil then widget.setImage(string.format("%s.icon", listItem), shipConfig.icon) end
    widget.setData(listItem, {
      vehiclePath = shipConfig.vehiclePath,
      vehiclePaneConfig = v,
      scale = shipConfig.previewScale or 1
    })
    -- sb.logInfo("vehicleItem:" .. listItem)
  end

  self.itemData = nil

end

function update()
  local listItem = widget.getListSelected(self.vehicles)
  if listItem then
    self.itemData = widget.getData(string.format("%s.%s", self.vehicles, listItem))
    local vehiclePaneConfig = root.assetJson(self.itemData.vehiclePaneConfig)

    widget.setButtonEnabled("btnDeploy", true)
    widget.setButtonEnabled("btnEdit", vehiclePaneConfig.colorCanChanging or false)
    showShipPreview()
  else
    widget.setButtonEnabled("btnDeploy", false)
    widget.setButtonEnabled("btnEdit", false)
    self.itemData = nil
  end
end

function showShipPreview()

  local vehicleBaseParams = root.assetJson(self.itemData.vehiclePath)
  local vehiclePaneConfig = root.assetJson(self.itemData.vehiclePaneConfig)
  local scale = self.itemData.scale

  vehicleBaseParams.animation.globalTagDefaults.bodyColor1 = "?multiply=" ..
                                                                 status.statusProperty(
          vehiclePaneConfig.name .. "_bodycolor1", "ffffff")

  self.preview:clear()

  local imagesToDraw = {}
  for k, v in pairs(vehicleBaseParams.animation.animatedParts.parts) do

    local part = v
    local partName = k

    if part.properties.image then
      local tags = util.stringTags(part.properties.image)
      local image = part.properties.image
      local offset = vec2.mul(part.properties.offset, {8, 8}) or {0, 0}

      for _, v in pairs(tags) do
        image = image:gsub("<" .. v .. ">", vehicleBaseParams.animation.globalTagDefaults[v])
      end

      if image ~= "" then
        table.insert(imagesToDraw, {
          image = image,
          offset = vec2.add(vec2.mul(offset, scale), {149, 90}),
          zLevel = part.properties.zLevel
        })
      end
    end
  end

  table.sort(imagesToDraw, function(a, b)
    return a.zLevel < b.zLevel
  end)

  for k, v in pairs(imagesToDraw) do self.preview:drawImageDrawable(v.image, v.offset, scale) end

end

function getExtremum(a, extremum)
  local xValues = {}
  local yValues = {}

  for k, v in pairs(a) do
    xValues[#xValues + 1] = v[1]
    yValues[#yValues + 1] = v[2]
  end
  table.sort(xValues)
  table.sort(yValues)

  return (extremum == "max") and xValues[#xValues] or (extremum == "min") and xValues[#xValues],
      (extremum == "max") and yValues[#yValues] or (extremum == "min") and yValues[#yValues]
end

function deploy()
  local vehicleBaseParams = root.assetJson(self.itemData.vehiclePath)
  local vehiclePaneConfig = root.assetJson(self.itemData.vehiclePaneConfig)

  vehicleBaseParams.name = vehiclePaneConfig.name
  vehicleBaseParams.ownerKey = world.entityUniqueId(player.id())
  vehicleBaseParams.animation.globalTagDefaults.bodyColor1 = "?multiply=" ..
                                                                 status.statusProperty(
          vehiclePaneConfig.name .. "_bodycolor1", "ffffff")

  local vehicleType = vehiclePaneConfig.vehicleType or "hoverbikekhaki"

  local dropPos = world.entityPosition(player.id())
  local ship = world.spawnVehicle(vehicleType, dropPos, vehicleBaseParams)
  -- sb.logInfo("LFSB: Spawned Vehicle id" .. ship)

  world.sendEntityMessage(ship, "drop")
  pane.dismiss()
end

function edit()
  local listItem = widget.getListSelected(self.vehicles)
  local vehicleParams = root.assetJson(self.itemData.vehiclePath)
  local vehiclePaneConfig = root.assetJson(self.itemData.vehiclePaneConfig)
  -- sb.logInfo("CONFIG PATH:" .. vehicleConfig.name)
  vehicleParams.id = vehiclePaneConfig.name

  local editpane = root.assetJson("/interface/colorchange/editpane.json")
  editpane.vehicleParams = vehicleParams
  player.interact("ScriptPane", editpane)
end

function uninit()
  -- sb.logInfo("deployPaneClosed")
end
