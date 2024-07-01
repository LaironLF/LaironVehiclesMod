flightInterface = {
  leftBorder = "]\n|\n|\n|\n|\n|\n|\n]",
  rightBorder = "[\n|\n|\n|\n|\n|\n|\n[",
  horizontal = {},
  vertical = {}
}

function flightInterface:init()
  self:horizontalInit()
  self:verticalInit()

  sb.logInfo("LFSB: flight Interface inited")
end

function flightInterface:horizontalInit()
  local pos = mcontroller.position()
  for i = -10, 10, 5 do table.insert(self.horizontal, math.ceil(pos[1] + i)) end
end

function flightInterface:verticalInit()
  local pos = mcontroller.position()
  for i = -10, 10, 5 do table.insert(self.vertical, math.ceil(pos[2] + i)) end
end

function flightInterface:update()

  self:drawBorders()
  self:drawBlocks()
end

function flightInterface:drawBlocks()
  local pos = mcontroller.position()
  self:drawHorizontal(pos)
  self:drawVertical(pos)
end

function flightInterface:drawHorizontal(pos)
  -- sb.logInfo(#self.blockList)
  if #self.horizontal ~= 0 then
    -- if math.abs(self.horizontal[1] - pos[1]) > 20 then self:horizontalInit() end
    -- if math.abs(pos[1] - self.horizontal[#self.horizontal]) > 20 then self:horizontalInit() end
    -- if self.horizontal[1] + 5 > pos[1] then self:horizontalInit() end

    if self.horizontal[#self.horizontal] < math.ceil(pos[1] + 6) then
      local xpos = math.ceil(self.horizontal[#self.horizontal] + 5)
      table.insert(self.horizontal, xpos)
    end
    if self.horizontal[1] > math.ceil(pos[1] - 6) then
      local xpos = math.ceil(self.horizontal[1] - 5)
      table.insert(self.horizontal, 1, xpos)
    end

    if self.horizontal[1] < math.ceil(pos[1] - 10) then table.remove(self.horizontal, 1) end
    if self.horizontal[#self.horizontal] > math.ceil(pos[1] + 10) then
      table.remove(self.horizontal, #self.horizontal)
    end

  else
    self:horizontalInit()
  end
  for _, i in ipairs(self.horizontal) do
    local transperent = math.max(math.min(math.abs(pos[1] - i) / 2, 255), 1)
    localanimator("spawnParticle", {{
      type = "text",
      text = "^shadow;" .. i,
      fullbright = true,
      position = {0, 8},
      size = 0.6,
      layer = "front",
      color = {204, 30, 93, 255 / transperent},
      timeToLive = 0
    }, {i, pos[2]}})
    localanimator("spawnParticle", {{
      type = "text",
      text = "|",
      fullbright = true,
      position = {0, 7},
      size = 0.6,
      layer = "front",
      color = {204, 30, 93, 255 / transperent},
      timeToLive = 0
    }, {i, pos[2]}})
    localanimator("spawnParticle", {{
      type = "text",
      text = "|",
      fullbright = true,
      position = {0, 7},
      size = 0.4,
      layer = "front",
      color = {204, 30, 93, 255 / transperent},
      timeToLive = 0
    }, {i + 2.5, pos[2]}})
  end
end

function flightInterface:drawVertical(pos)
  if #self.vertical ~= 0 then
    -- if math.abs(self.horizontal[1] - pos[1]) > 20 then self:horizontalInit() end
    -- if math.abs(pos[1] - self.horizontal[#self.horizontal]) > 20 then self:horizontalInit() end
    -- if self.horizontal[1] + 5 > pos[1] then self:horizontalInit() end

    if self.vertical[#self.vertical] < math.ceil(pos[2] + 6) then
      local ypos = math.ceil(self.vertical[#self.vertical] + 5)
      table.insert(self.vertical, ypos)
    end
    if self.vertical[1] > math.ceil(pos[2] - 6) then
      local ypos = math.ceil(self.vertical[1] - 5)
      table.insert(self.vertical, 1, ypos)
    end

    if self.vertical[1] < math.ceil(pos[2] - 10) then table.remove(self.vertical, 1) end
    if self.vertical[#self.vertical] > math.ceil(pos[2] + 10) then table.remove(self.vertical, #self.vertical) end

  else
    self:verticalInit()
  end

  for _, i in ipairs(self.vertical) do
    local transperent = math.max(math.min(math.abs(pos[2] - i) / 2, 255), 1)
    -- local transperent = 1
    localanimator("spawnParticle", {{
      type = "text",
      text = "^shadow;" .. i,
      fullbright = true,
      position = {11, 0},
      size = 0.6,
      layer = "front",
      color = {204, 30, 93, 255 / transperent},
      timeToLive = 0
    }, {pos[1], i}})
    localanimator("spawnParticle", {{
      type = "text",
      text = "_",
      fullbright = true,
      position = {9, 0.25},
      size = 0.6,
      layer = "front",
      color = {204, 30, 93, 255 / transperent},
      timeToLive = 0
    }, {pos[1], i}})
    localanimator("spawnParticle", {{
      type = "text",
      text = "_",
      fullbright = true,
      position = {9, 0.25},
      size = 0.4,
      layer = "front",
      color = {204, 30, 93, 255 / transperent},
      timeToLive = 0
    }, {pos[1], i + 2.5}})
  end
end

function flightInterface:drawBorders()
  localanimator("spawnParticle", {{
    type = "text",
    text = self.leftBorder,
    fullbright = true,
    position = {-8, 0},
    size = 0.6,
    layer = "front",
    color = {204, 30, 93, 200},
    timeToLive = 0
  }, mcontroller.position()})
  localanimator("spawnParticle", {{
    type = "text",
    text = self.rightBorder,
    fullbright = true,
    position = {8, 0},
    size = 0.6,
    layer = "front",
    color = {204, 30, 93, 200},
    timeToLive = 0
  }, mcontroller.position()})
end

function flightInterface:uninit()

end

addlfscript(flightInterface)
