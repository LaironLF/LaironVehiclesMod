local ini = init

function init()
  ini()
  sb.logInfo("xSB: Local animator bridge from LaironVehicles loaded.")
  message.setHandler("addDrawable", function(_, sameClient, drawableConfig, layer)
    if sameClient then pcall(localAnimator.addDrawable, drawableConfig, layer) end
  end)
  message.setHandler("clearDrawables", function(_, sameClient)
    if sameClient then localAnimator.clearDrawables() end
  end)
  message.setHandler("addLightSource", function(_, sameClient, lightConfig)
    if sameClient then pcall(localAnimator.addLightSource, lightConfig) end
  end)
  message.setHandler("clearLightSources", function(_, sameClient)
    if sameClient then localAnimator.clearLightSources() end
  end)
  message.setHandler("playAudio", function(_, sameClient, sound, loops, volume)
    if sameClient then pcall(localAnimator.playAudio, sound, loops, volume) end
  end)
  message.setHandler("spawnParticle", function(_, sameClient, particleConfig, position)
    if sameClient then pcall(localAnimator.spawnParticle, particleConfig, position) end
  end)
  message.setHandler("interact", function(_, sameClient, interactionType, interactionData)
    if sameClient then pcall(player.interact, interactionType, interactionData) end
  end)
  message.setHandler("statusProperty", function(_, sameClient, property, default)
    if sameClient then return status.statusProperty(property, default) end
  end)
  message.setHandler("setStatusProperty", function(_, sameClient, property, value)
    if sameClient then
      status.setStatusProperty(property, value)
      sb.logInfo(sb.print(status.statusProperty("inShip", nil)))
    end
  end)
  message.setHandler("callPlayer", function(_, sameClient, func, retn, ...)
    if sameClient then
      if retn then
        return player[func](...)
      else
        pcall(player[func], ...)
      end
    end
  end)
  -- message.setHandler("lfvehicledata", function(a, b, params)
  --   -- if params.speed ~= nil then sb.logInfo("LFSB: " .. params.speed) end
  -- end)
end
function update(dt)
end
function uninit()
end
