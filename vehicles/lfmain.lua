require("/scripts/vec2.lua")

lfscripts = {}

function addlfscript(script)
  table.insert(lfscripts, script)
end

function init()
  self.protection = config.getParameter("protection")
  self.maxHealth = config.getParameter("maxHealth")

  storage.health = self.maxHealth

  vehicle.setDamageTeam({
    type = "passive"
  })

  local vs = config.getParameter("lfscripts", {})
  sb.logInfo("LFSB: scripts " .. sb.printJson(vs))
  for _, v in ipairs(vs) do require(v) end
  for _, v in ipairs(lfscripts) do v:init() end
end

function update(dt)
  for _, v in ipairs(lfscripts) do v:update() end
  updateDamage()
end

function drawDebugInfo(text, data, position)
  world.debugText(sb.print(text), data, vec2.add(mcontroller.position(), position), "red")
end

function applyDamage(damageRequest)
  -- sb.logInfo("LFSB: DAMAGE")
  local damage = 0
  if damageRequest.damageType == "Damage" then
    damage = damage + root.evalFunction2("protection", damageRequest.damage, self.protection)
  elseif damageRequest.damageType == "IgnoresDef" then
    damage = damage + damageRequest.damage
  else
    return {}
  end
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
    targetMaterialKind = "robotic",
    killed = storage.health <= 0
  }}
end

function updateDamage()
  if storage.health <= 0 then
    animator.playSound("explode")
    explode(mcontroller.position())
    vehicle.destroy()
  end
end

function explode(pos)
  world.spawnProjectile("flakbullet", pos, 0, {0, 0}, true, {
    processing = "?scalenearest=0?brightness=0",
    power = 1000,
    speed = 0,
    knockback = 300,
    damageType = "IgnoresDef",
    damageTeam = {
      type = "pvp"
    },
    damageKind = "default",
    timeToLive = 0.1,
    universalDamage = false,
    piercing = true,
    movementSettings = {
      gravityMultiplier = 0
    },
    periodicActions = {{
      action = "light",
      color = {255, 255, 255},
      time = 0.001
    }, {
      action = "particle",
      count = 1,
      time = 0.001,
      specification = {
        type = "animated",
        animation = "/animations/smoke/smoke.animation?multiply=ffffff50",
        size = 1,
        variance = {
          initialVelocity = {math.random(-10, 10), math.random(-10, 10)},
          position = {math.random(-2, 2), math.random(-2, 2)},
          rotation = 180
        },
        timeToLive = 0.6,
        destructionAction = "fade",
        destructionTime = 0.25
      }
    }},
    actionOnReap = {{
      action = "projectile",
      inheritDamageFactor = 1,
      type = "bombblockexplosion",
      config = {
        knockback = 100,
        power = 500,
        damageType = "IgnoresDef",
        damageTeam = {
          type = "pvp"
        },
        damageKind = "default",
        universalDamage = false,
        piercing = true,
        statusEffects = {{
          effect = "paralysis",
          duration = 1
        }, "lowgrav", "lowgravaugment", "stafflowgrav"}
      }
    }, {
      action = "loop",
      count = 15,
      body = {{
        action = "option",
        options = {{
          action = "particle",
          specification = {
            type = "animated",
            animation = "/animations/smoke/smoke.animation?brightness=-25",
            approach = {0.5, 0.5},
            size = 2,
            layer = "front",
            destructionAction = "fade",
            destructionTime = 1,
            timeToLive = 0.5,
            variance = {
              position = {5, 5},
              initialVelocity = {75, 75},
              timeToLive = 0.1,
              rotation = 180
            }
          }
        }}
      }, {
        action = "option",
        options = {{
          action = "particle",
          specification = {
            type = "animated",
            animation = "/animations/smoke/smoke.animation?brightness=-50",
            approach = {0.5, 0.5},
            size = 2,
            layer = "front",
            destructionAction = "fade",
            destructionTime = 1,
            timeToLive = 0.5,
            variance = {
              position = {5, 5},
              initialVelocity = {50, 50},
              timeToLive = 0.1,
              rotation = 180
            }
          }
        }}
      }, {
        action = "particle",
        specification = {
          type = "animated",
          animation = "/animations/smallflame/smallflame.animation?border=2;DA530250;DA530200?hueshift=-20",
          approach = {0.5, 0.5},
          fullbright = true,
          light = {150, 150, 150},
          timeToLive = 0.6,
          layer = "front",
          size = 3,
          variance = {
            position = {3.5, 3.5},
            initialVelocity = {25, 25},
            timeToLive = 0.15,
            rotation = 180
          }
        }
      }, {
        action = "particle",
        specification = {
          type = "animated",
          animation = "/animations/fog/fog.animation?brightness=-60",
          layer = "middle",
          fullbright = true,
          variance = {
            size = 3,
            timeToLive = 2,
            position = {3.5, 3.5},
            initialVelocity = {25, 5},
            rotation = 180,
            angularVelocity = 180
          }
        }
      }, {
        action = "spark"
      }}
    }, {
      action = "loop",
      count = 1,
      body = {{
        action = "option",
        options = {{
          action = "particle",
          specification = {
            type = "textured",
            animation = "/animations/fog/fog.png:8?brightness=-50",
            approach = {0.5, 0.5},
            layer = "middle",
            destructionAction = "fade",
            destructionTime = 1,
            timeToLive = 3,
            size = 2,
            variance = {
              position = {5, 5},
              initialVelocity = {25, 5},
              angularVelocity = 720
            }
          }
        }}
      }, {
        action = "option",
        options = {{
          action = "particle",
          specification = {
            type = "textured",
            animation = "/animations/fog/fog.png:8?brightness=-80",
            approach = {0.5, 0.5},
            layer = "middle",
            destructionAction = "fade",
            destructionTime = 1,
            timeToLive = 3,
            size = 2,
            variance = {
              position = {5, 5},
              initialVelocity = {10, 25},
              angularVelocity = 720
            }
          }
        }}
      }, {
        action = "spark"
      }}
    }, {
      action = "light",
      color = {150, 150, 150}
    }, {
      action = "particle",
      specification = {
        timeToLive = 0,
        light = {200, 200, 255},
        type = "textured",
        layer = "middle",
        destructionAction = "fade",
        destructionTime = 1,
        image = "/celestial/system/orangestar.png?scalenearest=0.35?multiply=ffffff60",
        variance = {
          position = {0, 0},
          initialVelocity = {5, 5}
        }
      }
    }, {
      action = "projectile",
      type = "flakbullet",
      config = {
        movementSettings = {
          gravityMultiplier = 1
        },
        processing = "?multiply=00000000",
        speed = 40,
        periodicActions = {{
          action = "particle",
          time = 0.01,
          specification = {
            type = "animated",
            animation = "/animations/smoke/smoke.animation?multiply=ffffff50?brightness=-50",
            size = 1.2,
            variance = {
              initialVelocity = {math.random(-5, 5), math.random(-5, 5)},
              position = {math.random(-2, 2), math.random(-2, 2)},
              rotation = 180
            },
            timeToLive = 0.6,
            destructionAction = "fade",
            destructionTime = 0.25
          }
        }}
      },
      fuzzAngle = 10,
      angleAdjust = (math.random(-90, 90) + 90)
    }, {
      action = "projectile",
      type = "flakbullet",
      config = {
        movementSettings = {
          gravityMultiplier = 1
        },
        processing = "?multiply=00000000",
        speed = 40,
        periodicActions = {{
          action = "particle",
          time = 0.01,
          specification = {
            type = "animated",
            animation = "/animations/smoke/smoke.animation?multiply=ffffff50?brightness=-50",
            size = 1.2,
            variance = {
              initialVelocity = {math.random(-5, 5), math.random(-5, 5)},
              position = {math.random(-2, 2), math.random(-2, 2)},
              rotation = 180
            },
            timeToLive = 0.6,
            destructionAction = "fade",
            destructionTime = 0.25
          }
        }}
      },
      fuzzAngle = 10,
      angleAdjust = (math.random(-90, 90) + 90)
    }, {
      action = "projectile",
      type = "flakbullet",
      config = {
        movementSettings = {
          gravityMultiplier = 1
        },
        processing = "?multiply=00000000",
        speed = 40,
        periodicActions = {{
          action = "particle",
          time = 0.01,
          specification = {
            type = "animated",
            animation = "/animations/smoke/smoke.animation?multiply=ffffff50?brightness=-50",
            size = 1.2,
            variance = {
              initialVelocity = {math.random(-5, 5), math.random(-5, 5)},
              position = {math.random(-2, 2), math.random(-2, 2)},
              rotation = 180
            },
            timeToLive = 0.6,
            destructionAction = "fade",
            destructionTime = 0.25
          }
        }}
      },
      fuzzAngle = 10,
      angleAdjust = (math.random(-90, 90) + 90)
    }, {
      action = "projectile",
      type = "flakbullet",
      config = {
        movementSettings = {
          gravityMultiplier = 1
        },
        processing = "?multiply=00000000",
        speed = 40,
        periodicActions = {{
          action = "particle",
          time = 0.01,
          specification = {
            type = "animated",
            animation = "/animations/smoke/smoke.animation?multiply=ffffff50?brightness=-50",
            size = 1.2,
            variance = {
              initialVelocity = {math.random(-5, 5), math.random(-5, 5)},
              position = {math.random(-2, 2), math.random(-2, 2)},
              rotation = 180
            },
            timeToLive = 0.6,
            destructionAction = "fade",
            destructionTime = 0.25
          }
        }}
      },
      fuzzAngle = 10,
      angleAdjust = (math.random(-90, 90) + 90)
    }, {
      action = "actions",
      list = {{
        action = "projectile",
        inheritDamageFactor = 1,
        type = "regularexplosion2",
        config = {
          processing = "?scalenearest=2"
        }
      }, {
        action = "loop",
        count = 1,
        body = {{
          action = "particle",
          specification = {
            animation = "/animations/smoke/smoke.animation",
            size = 1.0,
            initial = "drift",
            rotation = 0.14,
            timeToLive = 0.6
          }
        }, {
          action = "sound",
          options = {"/sfx/gun/rocketblast2.ogg"}
        }, {
          action = "spark"
        }}
      }, {
        action = "loop",
        count = 1,
        body = {{
          action = "particle",
          specification = {
            animation = "/animations/mediumflame/mediumflame.animation",
            size = 1.0,
            initial = "drift",
            rotation = 0.14,
            timeToLive = 0.6
          }
        }}
      }, {
        action = "loop",
        count = 1,
        body = {{
          action = "particle",
          specification = {
            animation = "/animations/smallflame/smallflame.animation",
            size = 1.0,
            rotation = 0.14,
            timeToLive = 10.6
          }
        }}
      }}
    }}
  })
  vehicle.destroy()
end

function localanimator(func, args, player)
  if not args then args = {} end
  local driver = vehicle.entityLoungingIn("drivingSeat")
  if player ~= nil then driver = player end
  if driver ~= nil then world.sendEntityMessage(driver, func, table.unpack(args)) end
end

function uninit()
  for _, v in ipairs(lfscripts) do v:uninit() end
end
