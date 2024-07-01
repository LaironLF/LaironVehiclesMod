rotengine = {}

function rotengine:init()
  self.wheelTitles = config.getParameter("wheelTitles")
  self.wheelTiltFactor = config.getParameter("wheelTiltFactor")
  self.wheelAngles = {}
  self.wheelPos = {}
  for _, title in pairs(self.wheelTitles) do
    table.insert(self.wheelPos, animator.partProperty(sb.print(title), "parkTransition"))
  end
  for _, title in pairs(self.wheelTitles) do table.insert(self.wheelAngles, 0) end

  sb.logInfo("LFSB: rotating engines inited")
end

function rotengine:update()
  self:animateWheels()
end

function rotengine:animateWheels()
  -- local targetWheelPos = {0, 0}
  local tilt = 0
  for _, name in pairs(self.wheelTitles) do
    animator.resetTransformationGroup(sb.print(name))
    local rotationPoint = vec2.mul(animator.partPoint(sb.print(name), "rotationCenter"), {movement.facingDirection, 1})
    local targetWheelPos = animator.partProperty(sb.print(name), "parkTransition")
    if movement.isActivated then
      targetWheelPos = {0, 0}
      local xMoveDir = mcontroller.xVelocity() > 0 and 1 or -1
      tilt = (movement.angle + mcontroller.xVelocity() * self.wheelTiltFactor * 0.5) * -movement.facingDirection
      if math.abs(mcontroller.xVelocity()) > 1 then
        if cabin.controls.jump then
          tilt = -tilt + (20 * math.pi / 180) * -xMoveDir * -movement.facingDirection
        elseif cabin.controls.left then
          tilt = tilt + (-20 * math.pi / 180) * -movement.facingDirection
        elseif cabin.controls.right then
          tilt = tilt + (20 * math.pi / 180) * -movement.facingDirection
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
    -- drawDebugInfo("WheelTargetPos: %s", targetWheelPos, {0, _})

  end
end

function rotengine:uninit()
end

addlfscript(rotengine)
