cabin = {
  controls = {
    up = false,
    left = false,
    right = false,
    down = false,
    jump = false,
    alt = false,
    primary = false,
    special1 = false,
    special2 = false,
    special3 = false
  },
  driver = nil
}

function cabin:init()

  sb.logInfo("LFSB: cabin inited")
end

function cabin:update()
  self:updateControls()
  self.driver = vehicle.entityLoungingIn("drivingSeat")
  -- if self.controls.special3 then vehicle.destroy() end
end

function cabin:updateControls()
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

function cabin:uninit()

end

addlfscript(cabin)
