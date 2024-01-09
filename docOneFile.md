# activeitem.md
The activeItem table contains bindings which provide functionality for the ActiveItem and for the item's 'owner' (a ToolUser entity currently holding the item).

---

#### `EntityId` activeItem.ownerEntityId()

Returns the entity id of the owner entity.

---

#### `DamageTeam` activeItem.ownerTeam()

Returns the damage team of the owner entity.

---

#### `Vec2F` activeItem.ownerAimPosition()

Returns the world aim position of the owner entity.

---

#### `float` activeItem.ownerPowerMultiplier()

Returns the power multiplier of the owner entity.

---

#### `String` activeItem.fireMode()

Returns the current fire mode of the item, which can be "none", "primary" or "alt". Single-handed items held in the off hand will receive right click as "primary" rather than "alt".

---

#### `String` activeItem.hand()

Returns the name of the hand that the item is currently held in, which can be "primary" or "alt".

---

#### `Vec2F` activeItem.handPosition([`Vec2F` offset])

Takes an input position (defaults to [0, 0]) relative to the item and returns a position relative to the owner entity.

---

#### `LuaTable` activeItem.aimAngleAndDirection(`float` aimVerticalOffset, `Vec2F` targetPosition)

Returns a table containing the `float` aim angle and `int` facing direction that would be used for the item to aim at the specified target position with the specified vertical offset. This takes into account the position of the shoulder, distance of the hand from the body, and a lot of other complex factors and should be used to control aimable weapons or tools based on the owner's aim position.

---

#### `float` activeItem.aimAngle(`float` aimVerticalOffset, `Vec2F` targetPosition)

Similar to activeItem.aimAngleAndDirection but only returns the aim angle that would be calculated with the entity's current facing direction. Necessary if, for example, an item needs to aim behind the owner.

---

#### `void` activeItem.setHoldingItem(`bool` holdingItem)

Sets whether the owner is visually holding the item.

---

#### `void` activeItem.setBackArmFrame([`String` armFrame])

Sets the arm image frame that the item should use when held behind the player, or clears it to the default rotation arm frame if no frame is specified.

---

#### `void` activeItem.setFrontArmFrame([`String` armFrame])

Sets the arm image frame that the item should use when held in front of the player, or clears it to the default rotation arm frame if no frame is specified.

---

#### `void` activeItem.setTwoHandedGrip(`bool` twoHandedGrip)

Sets whether the item should be visually held with both hands. Does not alter the functional handedness requirement of the item.

---

#### `void` activeItem.setRecoil(`bool` recoil)

Sets whether the item is in a recoil state, which will translate both the item and the arm holding it slightly toward the back of the character.

---

#### `void` activeItem.setOutsideOfHand(`bool` outsideOfHand)

Sets whether the item should be visually rendered outside the owner's hand. Items outside of the hand will be rendered in front of the arm when held in front and behind the arm when held behind.

---

#### `void` activeItem.setArmAngle(`float` angle)

Sets the angle to which the owner's arm holding the item should be rotated.

---

#### `void` activeItem.setFacingDirection(`float` direction)

Sets the item's requested facing direction, which controls the owner's facing. Positive direction values will face right while negative values will face left. If the owner holds two items which request opposing facing directions, the direction requested by the item in the primary hand will take precedence.

---

#### `void` activeItem.setDamageSources([`List<DamageSource>` damageSources])

Sets a list of active damage sources with coordinates relative to the owner's position or clears them if unspecified.

---

#### `void` activeItem.setItemDamageSources([`List<DamageSource>` damageSources])

Sets a list of active damage sources with coordinates relative to the item's hand position or clears them if unspecified.

---

#### `void` activeItem.setShieldPolys([`List<PolyF>` shieldPolys])

Sets a list of active shield polygons with coordinates relative to the owner's position or clears them if unspecified.

---

#### `void` activeItem.setItemShieldPolys([`List<PolyF>` shieldPolys])

Sets a list of active shield polygons with coordinates relative to the item's hand position or clears them if unspecified.

---

#### `void` activeItem.setForceRegions([`List<PhysicsForceRegion>` forceRegions])

Sets a list of active physics force regions with coordinates relative to the owner's position or clears them if unspecified.

---

#### `void` activeItem.setItemForceRegions([`List<PhysicsForceRegion>` forceRegions])

Sets a list of active physics force regions with coordinates relative to the item's hand position or clears them if unspecified.

---

#### `void` activeItem.setCursor([`String` cursor])

Sets the item's overriding cursor image or clears it if unspecified.

---

#### `void` activeItem.setScriptedAnimationParameter(`String` parameter, `Json` value)

Sets a parameter to be used by the item's scripted animator.

---

#### `void` activeItem.setInventoryIcon(`String` image)

Sets the inventory icon of the item.

---

#### `void` activeItem.setInstanceValue(`String` parameter, `Json` value)

Sets an instance value (parameter) of the item.

---

#### `LuaValue` activeItem.callOtherHandScript(`String` functionName, [`LuaValue` args ...])

Attempts to call the specified function name with the specified argument values in the context of an ActiveItem held in the opposing hand and synchronously returns the result if successful.

---

#### `void` activeItem.interact(`String` interactionType, `Json` config, [`EntityId` sourceEntityId])

Triggers an interact action on the owner as if they had initiated an interaction and the result had returned the specified interaction type and configuration. Can be used to e.g. open GUI windows normally triggered by player interaction with entities.

---

#### `void` activeItem.emote(`String` emote)

Triggers the owner to perform the specified emote.

---

#### `void` activeItem.setCameraFocusEntity([`EntityId` entity])

If the owner is a player, sets that player's camera to be centered on the position of the specified entity, or recenters the camera on the player's position if no entity id is specified.

 ---- 
# activeitemanimation.md
The activeItemAnimation table contains bindings available to client-side animation scripts for active items.

---

#### `Vec2F` activeItemAnimation.ownerPosition()

Returns the current entity position of the item's owner.

---

#### `Vec2F` activeItemAnimation.ownerAimPosition()

Returns the current world aim position of the item's owner.

---

#### `float` activeItemAnimation.ownerArmAngle()

Returns the current angle of the arm holding the item.

---

#### `int` activeItemAnimation.ownerFacingDirection()

Returns the current facing direction of the item's owner. Will return 1 for right or -1 for left.

---

#### `Vec2F` activeItemAnimation.handPosition([`Vec2F` offset])

Takes an input position (defaults to [0, 0]) relative to the item and returns a position relative to the owner entity.

---

#### `Vec2F` activeItemAnimation.partPoint(`String` partName, `String` propertyName)

Returns a transformation of the specified `Vec2F` parameter configured on the specified animation part, relative to the owner's position.

---

#### `PolyF` activeItemAnimation.partPoly(`String` partName, `String` propertyName)

Returns a transformation of the specified `PolyF` parameter configured on the specified animation part, relative to the owner's position.

 ---- 
# actormovementcontroller.md
# actor mcontroller

The `mcontroller` table sometimes contains functions relating to the actor movement controller.

This section of mcontroller documentation refers to the ActorMovementController lua bindings. There is other documentation referring to the mcontroller table for base MovementControllers.

* monsters
* npcs
* tech
* companion system scripts
* status effects
* quest scripts
* active items

---

#### `RectF` mcontroller.boundBox()

Returns a rect containing the entire collision of the movement controller, in local coordinates.

---

#### `PolyF` mcontroller.collisionPoly()

Returns the collision poly of the movement controller, in local coordinates.

---

#### `PolyF` mcontroller.collisionBody()

Returns the collision poly of the movement controller, in world coordinates.

---

#### `float` mcontroller.mass()

Returns the configured mass of the movement controller.

---

#### `Vec2F` mcontroller.position()

Returns the current position of the movement controller.

---

#### `float` mcontroller.xPosition()

Returns the current horizontal position of the movement controller.

---

#### `float` mcontroller.yPosition()

Returns the current vertical position of the movement controller.

---

#### `Vec2F` mcontroller.velocity()

Returns the current velocity of the movement controller.

---

#### `float` mcontroller.xVelocity()

Returns the current horizontal speed of the movement controller.

---

#### `float` mcontroller.yVelocity()

Returns the current vertical speed of the movement controller.

---

#### `float` mcontroller.rotation()

Returns the current rotation of the movement controller in radians.

---

#### `bool` mcontroller.isColliding()

Returns whether the movement controller is currently colliding with world geometry or a PhysicsMovingCollision.

---

#### `bool` mcontroller.isNullColliding()

Returns whether the movement controller is currently colliding with null world geometry. Null collision occurs in unloaded sectors.

---

#### `bool` mcontroller.isCollisionStuck()

Returns whether the movement controller is currently stuck colliding. Movement controllers can stick if the `stickyCollision` movement parameter is set.

---

#### `float` mcontroller.stickingDirection()

Returns the angle that the movement controller is currently stuck at, in radians.

---

#### `float` mcontroller.liquidPercentage()

Returns the percentage of the collision poly currently submerged in liquid;

---

#### `LiquidId` mcontroller.liquidId()

Returns the liquid ID of the liquid that the movement controller is currently submerged in. If this is several liquids this returns the most plentiful one.

---

#### `bool` mcontroller.onGround()

Returns whether the movement controller is currently on ground.

---

#### `bool` mcontroller.zeroG()

Returns `true` if the movement controller is at a world position without gravity or if gravity has been disabled.

---

#### `bool` mcontroller.atWorldLimit([`bool` bottomOnly])

Returns `true` if the movement controller is touching the bottom or the top (unless bottomOnly is specified) of the world.

---

##### `void` mcontroller.setAnchorState(`EntityId` anchorableEntity, size_t anchorPosition)

Anchors the movement controller to an anchorable entity at the given anchor index.

---

##### `void` mcontroller.resetAnchorState()

Reset the anchor state.

---

##### `EntityId`, `int` mcontroller.anchorState()

Returns ID of anchored entity and index of the anchor position.

---

#### `void` mcontroller.setPosition(`Vec2F` position)

Sets the position of the movement controller.

---

#### `void` mcontroller.setXPosition(`float` x)

Sets the horizontal position of the movement controller.

---

#### `void` mcontroller.setYPosition(`float` y)

Sets the vertical position of the movement controller.

---

#### `void` mcontroller.translate(`Vec2F` direction)

Moves the movement controller by the vector provided.

---

#### `void` mcontroller.setVelocity(`Vec2F` velocity)

Sets the velocity of the movement controller.

---

#### `void` mcontroller.setXVelocity(`Vec2F` xVelocity)

Sets the horizontal velocity of the movement controller.

---

#### `void` mcontroller.setYVelocity(`Vec2F` yVelocity)

Sets the vertical velocity of the movement controller.

---

#### `void` mcontroller.addMomentum(`Vec2F` momentum)

Adds (momentum / mass) velocity to the movement controller.

---

#### `void` mcontroller.setRotation(`float` angle)

Sets the rotation of the movement controller. Angle is in radians.

---

##### `ActorMovementParameters` mcontroller.baseParameters()

Returns the base movement parameters.

---

##### `bool` mcontroller.walking()

Returns whether the actor movement controller is currently walking.

---

##### `bool` mcontroller.running()

Returns whether the actor movement controller is currently running.

---

##### `int` mcontroller.movingDirection()

Returns the direction that the actor movement controller is currently moving in. -1 for left, 1 for right.

---

##### `int` mcontroller.facingDirection()

Returns the facing direction. -1 for left, 1 for right.

---

##### `bool` mcontroller.crouching()

Returns whether the controller is currently crouching.

---

##### `bool` mcontroller.flying()

Returns whether the controller is currently flying.

---

##### `bool` mcontroller.falling()

Returns whether the controller is currently falling.

---

##### `bool` mcontroller.canJump()

Returns whether the controller can currently jump.

---

##### `bool` mcontroller.jumping()

Returns whether the controller is currently jumping.

---

##### `bool` mcontroller.groundMovement()

Returns whether the controller is currently in a ground movement state. Movement controllers can be in ground movement even when onGround returns false.

---

##### `bool` mcontroller.liquidMovement()

Returns whether the controller is currently in liquid movement mode.

---

## controls

The actor movement controller has a set of controls. Controls can be set anywhere and are accumulated and evaluated after all scripts are run. Controls will either override previously set controls, or combine them.

Controls are either cleared before every script update, or can be set to be manually cleared.

---

##### `void` mcontroller.controlRotation(`float` rotation)

Rotates the controller. Each control adds to the previous one.

---

##### `void` mcontroller.controlAcceleration(`Vec2F` acceleration)

Controls acceleration. Each control adds to the previous one.

---

##### `void` mcontroller.controlForce()

Controls force. Each control adds to the previous one.

---

##### `void` mcontroller.controlApproachVelocity(`Vec2F` targetVelocity, `float` maxControlForce)

Approaches the targetVelocity using the force provided. If the current velocity is higher than the provided targetVelocity, the targetVelocity will still be approached, effectively slowing down the entity.

Each control overrides the previous one.

---

#### `void` mcontroller.controlApproachVelocityAlongAngle(`float` angle, `float` targetVelocity, `float` maxControlForce, `bool` positiveOnly = false)

Approaches the targetVelocity but only along the provided angle, not affecting velocity in the perpendicular axis. If positiveOnly, then it will not slow down the movementController if it is already moving faster than targetVelocity.

Each control overrides the previous one.

---

#### `void` mcontroller.controlApproachXVelocity(`float` targetVelocity, `float` maxControlForce)

Approaches an X velocity. Same as using approachVelocityAlongAngle with angle 0.

Each control overrides the previous one.

---

#### `void` mcontroller.controlApproachYVelocity(`float` targetVelocity, `float` maxControlForce)

Approaches a Y velocity. Same as using approachVelocityAlongAngle with angle (Pi / 2).

Each control overrides the previous one.

---

##### `void` mcontroller.controlParameters(`ActorMovementParameters` parameters)

Changes movement parameters. Parameters are merged into the base parameters.

Each control is merged into the previous one.

---

##### `void` mcontroller.controlModifiers(`ActorMovementModifiers` modifiers)

Changes movement modifiers. Modifiers are merged into the base modifiers.

Each control is merged into the previous one.

---

##### `void` mcontroller.controlMove(`float` direction, `bool` run)

Controls movement in a direction.

Each control replaces the previous one.

---

##### `void` mcontroller.controlFace(`float` direction)

Controls the facing direction.

Each control replaces the previous one.

---

##### `void` mcontroller.controlDown()

Controls dropping through platforms.

---

##### `void` mcontroller.controlCrouch()

Controls crouching.

---

##### `void` mcontroller.controlJump()

Controls starting a jump. Only has an effect if canJump is true.

---

##### `void` mcontroller.controlHoldJump()

Keeps holding jump. Will not trigger a new jump, and can be held in the air.

---

##### `void` mcontroller.controlFly(`Vec2F` direction)

Controls flying in the specified direction (or {0, 0} to stop) with the configured flightSpeed parameter.

Each control overrides the previous one.

---

##### `bool` mcontroller.autoClearControls()

Returns whether the controller is currently set to auto clear controls before each script update.

---

##### `void` mcontroller.setAutoClearControls(`bool` enabled)

Set whether to automatically clear controls before each script update.

---

##### `void` mcontroller.clearControls()

Manually clear all controls.

 ---- 
# animator.md
# animator

The *animator* table contains functions that relate to an attached networked animator. Networked animators are found in:

* tech
* monsters
* vehicles
* status effects
* active items

---

#### `bool` animator.setAnimationState(`String` stateType, `String` State, `bool` startNew = false)

Sets an animation state. If startNew is true, restart the animation loop if it's already active. Returns whether the state was set.

---

#### `String` animator.animationState(`String` stateType)

Returns the current state for a state type.

---

#### `Json` animator.animationStateProperty(`String` stateType, `String` propertyName)

Returns the value of the specified property for a state type.

---

#### `void` animator.setGlobalTag(`String` tagName, `String` tagValue)

Sets a global animator tag. A global tag replaces any tag <tagName> with the specified tagValue across all animation parts.

---

#### `void` animator.setPartTag(`String` partType, `String` tagName, `String` tagValue)

Sets a local animator tag. A part tag replaces any tag <tagName> with the specified tagValue in the partType animation part only.

---

#### `void` animator.setFlipped(`bool` flipped)

Sets whether the animator should be flipped horizontally.

---

#### `void` animator.setAnimationRate(`float` rate)

Sets the animation rate of the animator.

---

#### `void` animator.rotateGroup(`String` rotationGroup, `float` targetAngle, `bool` immediate)

Rotates a rotation group to the specified angle. If immediate, ignore rotation speed.

*NOTE:* Rotation groups have largely been replaced by transformation groups and should only be used in a context where maintaining a rotation speed is important. When possible use transformation groups.

---

#### `float` animator.currentRotationAngle(`String` rotationGroup)

Returns the current angle for a rotation group.

---

#### `bool` animator.hasTransformationGroup(`String` transformationGroup)

Returns whether the animator contains the specified transformation group.

---

#### `void` animator.translateTransformationGroup(`String` transformationGroup, `Vec2F` translate)

Translates the specified transformation group.

---

#### `void` animator.rotateTransformationGroup(`String` transformationGroup, `float` rotation, [`Vec2F` rotationCenter])

Rotates the specified transformation group by the specified angle in radians, optionally around the specified center point.

---

#### `void` animator.scaleTransformationGroup(`String` transformationGroup, `float` scale, [`Vec2F` scaleCenter])

#### `void` animator.scaleTransformationGroup(`String` transformationGroup, `Vec2F` scale, [`Vec2F` scaleCenter])

Scales the specified transformation group by the specified scale. Optionally scale it from a scaleCenter.

---

#### `void` animator.transformTransformationGroup(`String` transformationGroup, `float` a, `float` b, `float` c, `float` d, `float` tx, `float` ty)

Applies a custom Mat3 transform to the specified transformationGroup. The applied matrix will be:

[a, b, tx,
 c, d, ty,
 0, 0, 1]

---

#### `void` animator.resetTransformationGroup(`String` transformationGroup)

Resets a transformationGroup to the identity transform.

[1, 0, 0
 0, 1, 0,
 0, 1, 1]

---

#### `void` animator.setParticleEmitterActive(`String` emitterName, `bool` active)

Sets a particle emitter to be active or inactive.

---

#### `void` animator.setParticleEmitterEmissionRate(`String` emitterName, `float` emissionRate)

Sets the rate at which a particle emitter emits particles while active.

---

#### `void` animator.setParticleEmitterBurstCount(`String` emitterName, `unsigned` burstCount)

Sets the amount of each particle the emitter will emit when using burstParticleEmitter.

---

#### `void` animator.setParticleEmitterOffsetRegion(`String` emitterName, `RectF` offsetRegion)

Sets an offset region for the particle emitter. Any particles spawned will have a randomized offset within the region added to their position.

---

#### `void` animator.burstParticleEmitter(`String` emitterName)

Spawns the entire set of particles `burstCount` times, where `burstCount` can be configured in the animator or set by setParticleEmitterBurstCount.

---

#### `void` animator.setLightActive(`String` lightName, bool active)

Sets a light to be active/inactive.

---

#### `void` animator.setLightPosition(`String` lightName, Vec2F position)

Sets the position of a light.

---

#### `void` animator.setLightColor(`String` lightName, Color color)

Sets the color of a light. Brighter color gives a higher light intensity.

---

#### `void` animator.setLightPointAngle(`String` lightName, float angle)

Sets the angle of a pointLight.

---

#### `bool` animator.hasSound(`String` soundName)

Returns whether the animator has a sound by the name of `soundName`

---

#### `void` animator.setSoundPool(`String` soundName, `List<String>` soundPool)

Sets the list of sound assets to pick from when playing a sound.

---

#### `void` animator.setSoundPosition(`String` soundName, `Vec2F` position)

Sets the position that a sound is played at.

---

#### `void` animator.playSound(`String` soundName, [`int` loops = 0])

Plays a sound. Optionally loop `loops` times. 0 plays the sound once (no loops), -1 loops indefinitely.

---

#### `void` animator.setSoundVolume(`String` soundName, `float` volume, [`float` rampTime = 0.0])

Sets the volume of a sound. Optionally smoothly transition the volume over `rampTime` seconds.

---

#### `void` animator.setSoundPitch(`String` soundName, `float` pitch, [`float` rampTime = 0.0])

Sets the relative pitch of a sound. Optionally smoothly transition the pitch over `rampTime` seconds.

---

#### `void` animator.stopAllSounds(`String` soundName)

Stops all instances of the specified sound.

---

#### `void` animator.setEffectActive(`String` effect, `bool` enabled)

Sets a configured effect to be active/inactive.

---

#### `Vec2F` animator.partPoint(`String` partName, `String` propertyName)

Returns a `Vec2F` configured in a part's properties with all of the part's transformations applied to it.

---

#### `PolyF` animator.partPoly(`String` partName, `String` propertyName)

Returns a `PolyF` configured in a part's properties with all the part's transformations applied to it.

---

#### `Json` animator.partProperty(`String` partName, `String` propertyName)

Returns an animation part property without applying any transformations.

---

#### `Json` animator.transformPoint(`String` partName, `Vec2F` point)

Applies the specified part's transformation on the given point.

---

#### `Json` animator.transformPoly(`String` partName, `PolyF` poly)

Applies the specified part's transformation on the given poly.

 ---- 
# celestial.md
# celestial

The *celestial* table contains functions that relate to the client sky, flying the player ship, system positions for planets, system objects, and the celestial database. It is available in the following contexts:

* script pane

---

#### `bool` celestial.skyFlying()

Returns whether the client sky is currently flying.
---

#### `String` celestial.skyFlyingType()

Returns the type of flying the client sky is currently performing.
---

#### `String` celestial.skyWarpPhase()

Returns the current warp phase of the client sky, if warping.
---

#### `float` celestial.skyWarpProgress()

Returns a value between 0 and 1 for how far through warping the sky is currently.
---

#### `bool` celestial.skyInHyperspace()

Returns whether the sky is currently under hyperspace flight.
---

#### `void` celestial.flyShip(`Vec3I` system, `SystemLocation` destination)

Flies the player ship to the specified SystemLocation in the specified system.

SystemLocation is either of the following types: Null, CelestialCoordinate, Object, Vec2F

The locations are specified as a pair of type and value

```
local system = celestial.currentSystem().location
local location = nil -- Null
location = {"coordinate", {location = system, planet = 1, satellite = 0}} -- CelestialCoordinate
location = {"object", "11112222333344445555666677778888"} -- Object (UUID)
location = {0.0, 0.0} -- Vec2F (position in space)
celestial.flyShip(system, location)
```

---

#### `bool` celestial.flying()

Returns whether the player ship is flying
---

#### `Vec2F` celestial.shipSystemPosition()

Returns the current position of the ship in the system.
---

#### `SystemLocation` celestial.shipDestination()

Returns the current destination of the player ship.
---

#### `SystemLocation` celestial.shipLocation()

Returns the current system location of the player ship.
---

#### `CelestialCoordinate` celestial.currentSystem()

Returns the CelestialCoordinate for system the ship is currently in.
---

#### `float` celestial.planetSize(`CelestialCoordinate` planet)

Returns the diameter of the specified planet in system space.
---

#### `Vec2F` celestial.planetPosition(`CelestialCoordinate` planet)

Returns the position of the specified planet in system space.
---

#### `CelestialParameters` celestial.planetParameters(`CelestialCoordinate` planet)

Returns the celestial parameters for the specified planet.
---

#### `VisitableParameters` celestial.visitableParameters(`CelestialCoordinate` planet)

Returns the visitable parameters for the specified visitable planet. For unvisitable planets, returns nil.
---

#### `String` celestial.planetName(`CelestialCoordinate` planet)

Returns the name of the specified planet.
---

#### `uint64_t` celestial.planetSeed(`CelestialCoordinate` planet)

Returns the seed for the specified planet.
---

#### `float` celestial.clusterSize(`CelestialCoordinate` planet)

Returns the diameter of the specified planet and its orbiting moons.
---

#### `List<String>` celestial.planetOres(`CelestialCoordinate` planet)

Returns a list of ores available on the specified planet.
---

#### `Vec2F` celestial.systemPosition(`SystemLocation` location)

Returns the position of the specified location in the *current system*.
---

#### `Vec2F` celestial.orbitPosition(`Orbit` orbit)

Returns the calculated position of the provided orbit.

```
local orbit = {
  target = planet, -- the orbit target
  direction = 1, -- orbit direction
  enterTime = 0, -- time the orbit was entered, universe epoch time
  enterPosition = {1, 0} -- the position that the orbit was entered at, relative to the target
}
```
---

#### `List<Uuid>` celestial.systemObjects()

Returns a list of the Uuids for objects in the current system.
---

#### `String` celestial.objectType(`Uuid` uuid)

Returns the type of the specified object.
---

#### `Json` celestial.objectParameters(`Uuid` uuid)

Returns the parameters for the specified object.
---

#### `WorldId` celestial.objectWarpActionWorld(`Uuid` uuid)

Returns the warp action world ID for the specified object.
---

#### `Json` celestial.objectOrbit(`Uuid` uuid)

Returns the orbit of the specified object, if any.
---

#### `Maybe<Vec2F>` celestial.objectPosition(`Uuid` uuid)

Returns the position of the specified object, if any.
---

#### `Json` celestial.objectTypeConfig(`String` typeName)

Returns the configuration of the specified object type.
---

#### `Uuid` celestial.systemSpawnObject(`String` typeName, [`Vec2F` position], [`Uuid` uuid], [`Json` parameters])

Spawns an object of typeName at position. Optionally with the specified UUID and parameters.

If no position is specified, one is automatically chosen in a spawnable range.

Objects are limited to be spawned outside a distance of  `/systemworld.config:clientSpawnObjectPadding` from any planet surface (including moons), star surface, planetary orbit (including moons), or permanent objects orbits, and at most within `clientSpawnObjectPadding` from the outermost orbit.
---

#### `List<Uuid>` celestial.playerShips()

Returns a list of the player ships in the current system.
---

#### `playerShipPosition` celestial.playerShipPosition(`Uuid` uuid)

Returns the position of the specified player ship.
---

#### `Maybe<bool>` celestial.hasChildren(`CelestialCoordinate` coordinate)

Returns definitively whether the coordinate has orbiting children. `nil` return means the coordinate is not loaded.
---

#### `List<CelestialCoordinate>` celestial.children(`CelestialCoordinate` coordinate)

Returns the children for the specified celestial coordinate. For systems, return planets, for planets, return moons.
---

#### `List<int>` celestial.childOrbits(`CelestialCoordinate` coordinate)

Returns the child orbits for the specified celestial coordinate.
---

#### `List<CelestialCoordinate>` celestial.scanSystems(`RectI` region, [`Set<String>` includedTypes])

Returns a list of systems in the given region. If includedTypes is specified, this will return only systems whose typeName parameter is included in the set. This scans for systems asynchronously, meaning it may not return all systems if they have not been generated or sent to the client. Use `scanRegionFullyLoaded` to see if this is the case.
---

#### `List<pair<Vec2I, Vec2I>>` celestial.scanConstellationLines(`RectI` region)

Returns the constellation lines for the specified universe region.
---

#### `bool` celestial.scanRegionFullyLoaded(`RectI` region)

Returns whether the specified universe region has been fully loaded.
---

#### `List<pair<String, float>>` celestial.centralBodyImages(`CelestialCoordinate` system)

Returns the images with scales for the central body (star) for the specified system coordinate.
---

#### `List<pair<String, float>>` celestial.planetaryObjectImages(`CelestialCoordinate` coordinate)

Returns the smallImages with scales for the specified planet or moon.
---

#### `List<pair<String, float>>` celestial.worldImages(`CelestialCoordinate` coordinate)

Returns the generated world images with scales for the specified planet or moon.
---

#### `List<pair<String, float>>` celestial.starImages(`CelestialCoordinate` system, `float` twinkleTime)

Returns the star image for the specified system. Requires a twinkle time to provide the correct image frame.

 ---- 
# commandprocessor.md
The command processor has a single binding for performing admin checks, available on the *CommandProcessor* table.

---

#### `String` CommandProcessor.adminCheck(`ConnectionId` connectionId, `String` actionDescription)

Checks whether the specified connection id is authorized to perform admin actions and returns `nil` if authorization is succesful. If unauthorized, returns a `String` error message to display to the client requesting the action, which may include the specified action description, such as "Insufficient privileges to do the time warp again."

 ---- 
# config.md
# config

The `config` lua bindings relate to anything that has a configuration and needs to access configuration parameters.

---

#### `Json` config.getParameter(`String` parameter, `Json` default)

Returns the value for the specified config parameter. If there is no value set, returns the default.

 ---- 
# containerpane.md
These pane bindings are available to container interface panes and include functions not specifically related to widgets within the pane.

---

#### `EntityId` pane.containerEntityId()

Returns the entity id of the container that this pane is connected to.

---

#### `EntityId` pane.playerEntityId()

Returns the entity id of the player that opened this pane.

---

#### `void` pane.dismiss()

Closes the pane.

 ---- 
# entity.md
# entity

The *entity* table contains functions that are common among all entities. Every function refers to the entity the script context is running on.

Accessible in:

* companion system scripts
* quests
* tech
* primary status script
* status effects
* monsters
* npcs
* objects
* active items

---

#### `EntityId` entity.id()

Returns the id number of the entity.

---

#### `LuaTable` entity.damageTeam()

Returns a table of the entity's damage team type and team number. Ex: {type = "enemy", team = 0}

---

#### `bool` entity.isValidTarget(`EntityId` entityId)

Returns whether the provided entity is a valid target of the current entity. An entity is a valid target if they can be damaged, and in the case of monsters and NPCs if they are aggressive.

---

#### `Vec2F` entity.distanceToEntity(`EntityId` entityId)

Returns the vector distance from the current entity to the provided entity.

---

#### `bool` entity.entityInSight(`EntityId` entityId)

Returns whether the provided entity is in line of sight of the current entity.

---

#### `Vec2F` entity.position()

Returns the position of the current entity.

---

#### `String` entity.entityType()

Returns the  type of the current entity.

---

#### `String` entity.uniqueId()

Returns the unique ID of the entity. Returns nil if there is no unique ID.

---

#### `bool` entity.persistent()

Returns `true` if the entity is persistent (will be saved to disk on sector unload) or `false` otherwise.

 ---- 
# item.md
# item

The `item` table is available in all scripted items and contains functions relating to the item itself.

---

#### `String` item.name()

Returns the name of the item.

---

#### `size_t` item.count()

Returns the stack count of the item.

---

#### `size_t` item.setCount(`size_t` count)

Sets the item count. Returns any overflow.

---

#### `size_t` item.maxStack()

Returns the max number of this item that will fit in a stack.

---

#### `bool` item.matches(`ItemDescriptor` desc, [`bool` exactMatch])

Returns whether the item matches the specified item. If exactMatch is `true` then both the items' names and parameters are compared, otherwise only the items' names.

---

#### `bool` item.consume(`size_t` count)

Consumes items from the stack. Returns whether the full count was successfuly consumed.

---

#### `bool` item.empty()

Returns whether the item stack is empty.

---

#### `ItemDescriptor` item.descriptor()

Returns an item descriptor for the item.

---

#### `String` item.description()

Returns the description for the item.

---

#### `String` item.friendlyName()

Returns the short description for the item.

---

#### `int` item.rarity()

Returns the rarity for the item.

* 0 = common
* 1 = uncommon
* 2 = rare
* 3 = legendary
* 4 = essential

---

#### `String` item.rarityString()

Returns the rarity as a string.

---

#### `size_t` item.price()

Returns the item price.

---

#### `unsigned` item.fuelAmount()

Returns the item fuel amount.

---

#### `Json` item.iconDrawables()

Returns a list of the item's icon drawables.

---

#### `Json` item.dropDrawables()

Returns a list of the item's itemdrop drawables.

---

#### `String` item.largeImage()

Returns the item's configured large image, if any.

---

#### `String` item.tooltipKind()

Returns the item's tooltip kind.

---

#### `String` item.category()

Returns the item's category

---

#### `String` item.pickupSound()

Returns the item's pickup sound.

---

#### `bool` item.twoHanded()

Returns whether the item is two handed.

---

#### `float` item.timeToLive()

Returns the items's time to live.

---

#### `Json` item.learnBlueprintsOnPickup()

Returns a list of the blueprints learned on picking up this item.

---

#### `bool` item.hasItemTag(`String` itemTag)

Returns whether the set of item tags for this item contains the specified tag.

---

#### `Json` item.pickupQuestTemplates()

Returns a list of quests acquired on picking up this item.

 ---- 
# localanimator.md
The *localAnimator* table provides bindings used by client side animation scripts (e.g. on objects and active items) to set drawables/lights and perform rendering actions.

---

#### `void` localAnimator.playAudio(`String` sound, [`int` loops], [`float` volume])

Immediately plays the specified sound, optionally with the specified loop count and volume.

---

#### `void` localAnimator.spawnParticle(`Json` particleConfig, `Vec2F` position)

Immediately spawns a particle with the specified name or configuration at the specified position.

---

#### `void` localAnimator.addDrawable(`Drawable` drawable, [`String` renderLayer])

Adds the specified drawable to the animator's list of drawables to be rendered. If a render layer is specified, this drawable will be drawn on that layer instead of the parent entity's render layer. Drawables set in this way are retained between script ticks and must be cleared manually using localAnimator.clearDrawables().

The drawable object must specify exactly one of the following keys to define its type:

* [`pair<Vec2F, Vec2F>` __line__] - Defines this drawable as a line between the specified two points.
* [`List<Vec2F>` __poly__] - Defines the drawable as a polygon composed of the specified points.
* [`String` __image__] - Defines the drawable as an image with the specified asset path.

The following additional keys may be specified for any drawable type:

* [`Vec2F` __position__] - Relative position of the drawable.
* [`Color` __color__] - Color for the drawable. Defaults to white.
* [`bool` __fullbright__] - Specifies whether the drawable is fullbright (ignores world lighting).

The following additional key may be specified for line drawables:

* [`float` __width__] - Specifies the width of the line to be rendered.

The following transformation options may be specified for image drawables. Note that if a __transformation__ is specified, it will be used instead of other specific transformation operations.

* [`Mat3F` __transformation__]
* [`bool` __centered__]
* [`float` __rotation__]
* [`bool` __mirrored__]
* [`float` __scale__]

---

#### `void` localAnimator.clearDrawables()

Clears the list of drawables to be rendered.

---

#### `void` localAnimator.addLightSource(`Json` lightSource)

Adds the specified light source to the animator's list of light sources to be rendered. Light sources set in this way are retained between script ticks and must be cleared manually using localAnimator.clearLightSources(). The configuration object for the light source accepts the following keys:

* `Vec2F` __position__
* `Color` __color__
* [`bool` __pointLight__]
* [`float` __pointBeam__]
* [`float` __beamAngle__]
* [`float` __beamAmbience__]

---

#### `void` localAnimator.clearLightSources()

Clears the list of light sources to be rendered.

 ---- 
# message.md
The message table contains a single function, setHandler, which allows entities to receive messages sent using world.sendEntityMessage. Entities which can receive messages include:

* monster
* NPC
* object
* vehicle
* stagehand
* projectile

Additionally, messages can be handled by a variety of script contexts that run on the player:

* activeitem
* quest
* playercompanions
* status

---

#### `void` message.setHandler(`String` messageName, `LuaFunction` handler)

Messages of the specified message type received by this script context will call the specified function. The first two arguments passed to the handler function will be the `String` messageName and a `bool` indicating whether the message is from a local entity, followed by any arguments sent with the message.

 ---- 
# monster.md
The monster table contains bindings specific to monsters which are available in addition to their common tables.

---

#### `String` monster.type()

Returns the monster's configured monster type.

---

#### `String` monster.seed()

Returns a string representation of the monster's random seed.

---

#### `Json` monster.uniqueParameters()

Returns a table of the monster's unique (override) parameters.

---

#### `unsigned` monster.familyIndex()

Returns the monster's family index.

---

#### `float` monster.level()

Returns the monster's level.

---

#### `void` monster.setDamageOnTouch(`bool` enabled)

Enables or disables the monster's touch damage.

---

#### `void` monster.setDamageSources([`List<DamageSource>` damageSources])

Sets the monster's active damage sources (or clears them if unspecified).

---

#### `void` monster.setDamageParts(`StringSet` damageParts)

Sets the monster's active damage parts. Damage parts must be defined in the monster's configuration parameters. A damage part specifies a damage source and an animation part to anchor the damage source to. The anchor part's transformation will be applied to the damage source's damage poly, and if a vector, the damage source's knockback.

```js
"animationDamageParts" : {
  "beam" : {
    "anchorPart" : "partName", // animation part to anchor the damage source to
    "checkLineCollision" : false, // optional, if the damage source is a line, check for collision along the line
    "bounces" : 0, // optional, if the damage source is a line and it checks for collision
    "damageSource" : {
      "line" : [ [0.0, 0.0], [5.0, 0.0] ],
      "damage" : 10,
      "damageSourceKind" : "default",
      "teamType" : "enemy",
      "teamNumber" : 2
    }
  }
}
```

```lua
monster.setDamageParts({"beam"}) -- sets the "beam" damage part active
```

---

#### `void` monster.setAggressive(`bool` aggressive)

Sets whether the monster is currently aggressive.

---

#### `void` monster.setDropPool(`Json` dropPool)

Sets the monster's drop pool, which determines the items that it will drop on death. This can be specified as the `String` name of a treasure pool, or as a `Map<String, String>` to specify different drop pools for different damage types. If specified as a map, the pool should contain a "default" entry for unhandled damage types.

---

#### `Vec2F` monster.toAbsolutePosition(`Vec2F` relativePosition)

Returns an absolute world position calculated from the given relative position.

---

#### `Vec2F` monster.mouthPosition()

Returns the world position of the monster's mouth.

---

#### `void` monster.flyTo(`Vec2F` position)

Causes the monster to controlFly toward the given world position.

---

#### `void` monster.setDeathParticleBurst([`String` particleEmitter)

Sets the name of the particle emitter (configured in the animation) to burst when the monster dies, or clears it if unspecified.

---

#### `void` monster.setDeathSound([`String` sound])

Sets the name of the sound (configured in the animation) to play when the monster dies, or clears it if unspecified.

---

#### `void` monster.setPhysicsForces(`List<PhysicsForceRegion>` forceRegions)

Sets a list of physics force regions that the monster will project, used for applying forces to other nearby entities. Set an empty list to clear the force regions.

---

#### `void` monster.setName(`String` name)

Sets the monster's name.

---

#### `void` monster.setDisplayNametag(`bool` enabled)

Sets whether the monster should display its nametag.

---

#### `bool` monster.say(`String` line, [`Map<String, String>` tags])

Causes the monster to say the line, optionally replacing any specified tags in the text. Returns `true` if anything is said (i.e. the line is not empty) and `false` otherwise.

---

#### `bool` monster.sayPortrait(`String` line, `String` portrait, [`Map<String, String>` tags])

Similar to monster.say, but uses a portrait chat bubble with the specified portrait image.

---

#### `void` monster.setDamageTeam(`DamageTeam` team)

Sets the monster's current damage team type and number.

---

#### `void` monster.setUniqueId([`String` uniqueId])

Sets the monster's unique entity id, or clears it if unspecified.

---

#### `void` monster.setDamageBar(`String` damageBarType)

Sets the type of damage bar that the monster should display. Valid options are "default", "none" and "special".

---

#### `void` monster.setInteractive(`bool` interactive)

Sets whether the monster is currently interactive.

---

#### `void` monster.setAnimationParameter(`String` key, `Json` value)

Sets a networked scripted animator parameter to be used in a client side rendering script using animationConfig.getParameter.

 ---- 
# movementcontroller.md
# mcontroller

The `mcontroller` table contains functions relating to the movement controller.

This section of mcontroller documentation refers to the MovementController lua bindings. Other documentation may refer to ActorMovementController lua bindings. MovementController is used in:

* projectiles
* vehicles

---

#### `MovementParameters` mcontroller.parameters()

Returns a table containing the movement parameters for the movement controller.

---

#### `void` mcontroller.applyParameters(`Json` parameters)

Applies the given parameters to the movement controller. The provided parameters are merged into the current movement parameters.

---

#### `void` mcontroller.resetParameters()

Resets movement parameters to their original state.

---

#### `float` mcontroller.mass()

Returns the configured mass of the movement controller.

---

#### `Vec2F` mcontroller.position()

Returns the current position of the movement controller.

---

#### `float` mcontroller.xPosition()

Returns the current horizontal position of the movement controller.

---

#### `float` mcontroller.yPosition()

Returns the current vertical position of the movement controller.

---

#### `Vec2F` mcontroller.velocity()

Returns the current velocity of the movement controller.

---

#### `float` mcontroller.xVelocity()

Returns the current horizontal speed of the movement controller.

---

#### `float` mcontroller.yVelocity()

Returns the current vertical speed of the movement controller.

---

#### `float` mcontroller.rotation()

Returns the current rotation of the movement controller in radians.

---

#### `PolyF` mcontroller.collisionPoly()

Returns the collision poly of the movement controller, in local coordinates.

---

#### `PolyF` mcontroller.collisionBody()

Returns the collision poly of the movement controller, in world coordinates.

---

#### `RectF` mcontroller.collisionBoundBox()

Returns a rect containing the entire collision poly of the movement controller, in world coordinates.

---

#### `RectF` mcontroller.localBoundBox()

Returns a rect containing the entire collision of the movement controller, in local coordinates.

---

#### `bool` mcontroller.isColliding()

Returns whether the movement controller is currently colliding with world geometry or a PhysicsMovingCollision.

---

#### `bool` mcontroller.isNullColliding()

Returns whether the movement controller is currently colliding with null world geometry. Null collision occurs in unloaded sectors.

---

#### `bool` mcontroller.isCollisionStuck()

Returns whether the movement controller is currently stuck colliding. Movement controllers can stick if the `stickyCollision` movement parameter is set.

---

#### `float` mcontroller.stickingDirection()

Returns the angle that the movement controller is currently stuck at, in radians.

---

#### `float` mcontroller.liquidPercentage()

Returns the percentage of the collision poly currently submerged in liquid;

---

#### `LiquidId` mcontroller.liquidId()

Returns the liquid ID of the liquid that the movement controller is currently submerged in. If this is several liquids this returns the most plentiful one.

---

#### `bool` mcontroller.onGround()

Returns whether the movement controller is currently on ground.

---

#### `bool` mcontroller.zeroG()

Returns `true` if the movement controller is at a world position without gravity or if gravity has been disabled.

---

#### `bool` mcontroller.atWorldLimit([`bool` bottomOnly])

Returns `true` if the movement controller is touching the bottom or the top (unless bottomOnly is specified) of the world.

---

#### `void` mcontroller.setPosition(`Vec2F` position)

Sets the position of the movement controller.

---

#### `void` mcontroller.setXPosition(`float` x)

Sets the horizontal position of the movement controller.

---

#### `void` mcontroller.setYPosition(`float` y)

Sets the vertical position of the movement controller.

---

#### `void` mcontroller.translate(`Vec2F` direction)

Moves the movement controller by the vector provided.

---

#### `void` mcontroller.setVelocity(`Vec2F` velocity)

Sets the velocity of the movement controller.

---

#### `void` mcontroller.setXVelocity(`Vec2F` xVelocity)

Sets the horizontal velocity of the movement controller.

---

#### `void` mcontroller.setYVelocity(`Vec2F` yVelocity)

Sets the vertical velocity of the movement controller.

---

#### `void` mcontroller.addMomentum(`Vec2F` momentum)

Adds (momentum / mass) velocity to the movement controller.

---

#### `void` mcontroller.setRotation(`float` angle)

Sets the rotation of the movement controller. Angle is in radians.

---

#### `void` mcontroller.rotate(`float` angle)

Rotates the movement controller by an angle relative to its current angle. Angle is in radians.

---

#### `void` mcontroller.accelerate(`Vec2F` acceleration)

Accelerates the movement controller by the given acceleration for one tick.

---

#### `void` mcontroller.force(`Vec2F` force)

Accelerates the movement controller by (force / mass) for one tick.

---

#### `void` mcontroller.approachVelocity(`Vec2F` targetVelocity, `float` maxControlForce)

Approaches the targetVelocity using the force provided. If the current velocity is higher than the provided targetVelocity, the targetVelocity will still be approached, effectively slowing down the entity.

---

#### `void` mcontroller.approachVelocityAlongAngle(`float` angle, `float` targetVelocity, `float` maxControlForce, `bool` positiveOnly = false)

Approaches the targetVelocity but only along the provided angle, not affecting velocity in the perpendicular axis. If positiveOnly, then it will not slow down the movementController if it is already moving faster than targetVelocity.

---

#### `void` mcontroller.approachXVelocity(`float` targetVelocity, `float` maxControlForce)

Approaches an X velocity. Same as using approachVelocityAlongAngle with angle 0.

---

#### `void` mcontroller.approachYVelocity(`float` targetVelocity, `float` maxControlForce)

Approaches a Y velocity. Same as using approachVelocityAlongAngle with angle (Pi / 2).

 ---- 
# npc.md
# npc

The `npc` table is for functions relating directly to the current npc. It is available only in NPC scripts.

---

#### `Vec2F` npc.toAbsolutePosition(`Vec2F` offset)

Returns the specified local position in world space.

---

#### `String` npc.species()

Returns the species of the npc.

---

#### `String` npc.gender()

Returns the gender of the npc

---

#### `Json` npc.humanoidIdentity()

Returns the specific humanoid identity of the npc, containing information such as hair style and idle pose.

---

#### `String` npc.npcType()

Returns the npc type of the npc.

---

#### `uint64_t` npc.seed()

Returns the seed used to generate this npc.

---

#### `float` npc.level()

Returns the level of the npc.

---

#### `List<String>` npc.dropPools()

Returns the list of treasure pools that will spawn when the npc dies.

---

#### `void` npc.setDropPools(`List<String>` pools)

Sets the list of treasure pools that will spawn when the npc dies.

---

#### `float` npc.energy()

Returns the current energy of the npc. Same as `status.resource("energy")`

---

#### `float` npc.maxEnergy()

Returns the current energy of the npc. Same as `status.maxResource("energy")`

---

#### `bool` npc.say(`String` line, [`Map<String,String>` tags], [`Json` config])

Makes the npc say a string. Optionally pass in tags to replace text tags. Optionally give config options for the chat message.

Returns whether the chat message was successfully added.

Available options:
```
{
  drawBorder = true,
  fontSize = 8,
  color = {255, 255, 255},
  sound = "/sfx/humanoid/avian_chatter_male1.ogg"
}
```

---

#### `bool` npc.sayPortrait(`String` line, `String` portrait, [`Map<String,String>` tags], [`Json` config])

Makes the npc say a line, with a portrait chat bubble. Optionally pass in tags to replace text tags. Optionally give config options for the chat message.
Returns whether the chat message was successfully added.

Available options:
```
{
  drawMoreIndicator = true,
  sound = "/sfx/humanoid/avian_chatter_male1.ogg"
}
```

---

#### `void` npc.emote(`String` emote)

Makes the npc show a facial emote.

---

#### `void` npc.dance(`String` dance)

Sets the current dance for the npc. Dances are defined in .dance files.

---

#### `void` npc.setInteractive(`bool` interactive)

Sets whether the npc should be interactive.

---

#### `bool` npc.setLounging(`EntityId` loungeable, [`size_t` anchorIndex])

Sets the npc to lounge in a loungeable. Optionally specify which anchor (seat) to use.
Returns whether the npc successfully lounged.

---

#### `void` npc.resetLounging()

Makes the npc stop lounging.

---

#### `bool` npc.isLounging()

Returns whether the npc is currently lounging.

---

#### `Maybe<EntityId>` npc.loungingIn()

Returns the EntityId of the loungeable the NPC is currently lounging in. Returns nil if not lounging.

---

#### `void` npc.setOfferedQuests(`JsonArray` quests)

Sets the list of quests the NPC will offer.

---

#### `void` npc.setTurnInQuests(`JsonArray` quests)

Sets the list of quests the played can turn in at this npc.

---

#### `bool` npc.setItemSlot(`String` slot, `ItemDescriptor` item)

Sets the specified item slot to contain the specified item.

Possible equipment items slots:
* head
* headCosmetic
* chest
* chestCosmetic
* legs
* legsCosmetic
* back
* backCosmetic
* primary
* alt

---

#### `ItemDescriptor` npc.getItemSlot(`String` slot)

Returns the item currently in the specified item slot.

---

#### `void` npc.disableWornArmor(`bool` disable)

Set whether the npc should not gain status effects from the equipped armor. Armor will still be visually equipped.

---

#### `void` npc.beginPrimaryFire()

Toggles `on` firing the item equipped in the `primary` item slot.

---

#### `void` npc.beginAltFire()

Toggles `on` firing the item equipped in the `alt` item slot.

---

#### `void` npc.endPrimaryFire()

Toggles `off` firing the item equipped in the `primary` item slot.

---

#### `void` npc.endAltFire()

Toggles `off` firing the item equipped in the `alt` item slot.

---

#### `void` npc.setShifting(`bool` shifting)

Sets whether tools should be used as though shift is held.

---

#### `void` npc.setDamageOnTouch(`bool` enabled)

Sets whether damage on touch should be enabled.

---

#### `Vec2F` npc.aimPosition()

Returns the current aim position in world space.

---

#### `void` npc.setAimPosition(`Vec2F` position)

Sets the aim position in world space.

---

#### `void` npc.setDeathParticleBurst(`String` emitter)

Sets a particle emitter to burst when the npc dies.

---

#### `void` npc.setStatusText(`String` status)

Sets the text to appear above the npc when it first appears on screen.

---

#### `void` npc.setDisplayNametag(`bool` display)

Sets whether the nametag should be displayed above the NPC.

---

#### `void` npc.setPersistent(`bool` persistent)

Sets whether this npc should persist after being unloaded.

---

#### `void` npc.setKeepAlive(`bool` keepAlive)

Sets whether to keep this npc alive. If true, the npc will never be unloaded as long as the world is loaded.

---

#### `void` npc.setDamageTeam(`Json` damageTeam)

Sets a damage team for the npc in the format: `{type = "enemy", team = 2}`

---

#### `void` npc.setAggressive(`bool` aggressive)

Sets whether the npc should be flagged as aggressive.

---

#### `void` npc.setUniqueId(`String` uniqueId)

Sets a unique ID for this npc that can be used to access it. A unique ID has to be unique for the world the npc is on, but not universally unique.

 ---- 
# object.md
The object table contains bindings specific to objects which are available in addition to their common tables.

---

#### `String` object.name()

Returns the object's type name.

---

#### `int` object.direction()

Returns the object's facing direction. This will be 1 for right or -1 for left.

---

#### `Vec2F` object.position()

Returns the object's tile position. This is identical to entity.position(), so use that instead.

---

#### `void` object.setInteractive(`bool` interactive)

Sets whether the object is currently interactive.

---

#### `String` object.uniqueId()

Returns the object's unique entity id, or `nil` if no unique id is set. This should be identical to entity.uniqueId(), so use that instead.

---

#### `void` object.setUniqueId([`String` uniqueId])

Sets the objects unique entity id, or clears it if unspecified.

---

#### `RectF` object.boundBox()

Returns the object's metaBoundBox in world space.

---

#### `List<Vec2I>` object.spaces()

Returns a list of the tile spaces that the object occupies.

---

#### `void` object.setProcessingDirectives(`String` directives)

Sets the image processing directives that should be applied to the object's animation.

---

#### `void` object.setSoundEffectEnabled(`bool` enabled)

Enables or disables the object's persistent sound effect, if one is configured.

---

#### `void` object.smash([`bool` smash])

Breaks the object. If smash is `true` then it will be smashed, causing it to (by default) drop no items.

---

#### `float` object.level()

Returns the "level" parameter if set, otherwise returns the current world's threat level.

---

#### `Vec2F` object.toAbsolutePosition(`Vec2F` relativePosition)

Returns an absolute world position calculated from the given relative position.

---

#### `bool` object.say(`String` line, [`Map<String, String>` tags], [`Json` config])

Causes the object to say the line, optionally replacing any specified tags in the text, and using the provided additional chat configuration. Returns `true` if anything is said (i.e. the line is not empty) and `false` otherwise.

---

#### `bool` object.sayPortrait(`String` line, `String` portrait, [`Map<String, String>` tags], [`Json` config])

Similar to object.say, but uses a portrait chat bubble with the specified portrait image.

---

#### `bool` object.isTouching(`EntityId` entityId)

Returns `true` if the specified entity's collision area overlaps the object's bound box and `false` otherwise.

---

#### `void` object.setLightColor(`Color` color)

Sets the color of light for the object to emit. This is not the same as animator.setLightColor and the animator light configuration should be used for more featureful light sources.

---

#### `Color` object.getLightColor()

Returns the object's currently configured light color.

---

#### `unsigned` object.inputNodeCount()

Returns the number of wire input nodes the object has.

---

#### `unsigned` object.outputNodeCount()

Returns the number of wire output nodes the object has.

---

#### `Vec2I` object.getInputNodePosition(`unsigned` nodeIndex)

Returns the relative position of the specified wire input node.

---

#### `Vec2I` object.getOutputNodePosition(`unsigned` nodeIndex)

Returns the relative position of the specified wire output node.

---

#### `bool` object.getInputNodeLevel(`unsigned` nodeIndex)

Returns the current level of the specified wire input node.

---

#### `bool` object.getOutputNodeLevel(`unsigned` nodeIndex)

Returns the current level of the specified wire output node.

---

#### `bool` object.isInputNodeConnected(`unsigned` nodeIndex)

Returns `true` if any wires are currently connected to the specified wire input node and `false` otherwise.

---

#### `bool` object.isOutputNodeConnected(`unsigned` nodeIndex)

Returns `true` if any wires are currently connected to the specified wire output node and `false` otherwise

---

#### `Map<EntityId, unsigned>` object.getInputNodeIds(`unsigned` nodeIndex)

Returns a map of the entity id of each wire entity connected to the given wire input node and the index of that entity's output node to which the input node is connected.

---

#### `Map<EntityId, unsigned>` object.getOutputNodeIds(`unsigned` nodeIndex)

Returns a map of the entity id of each wire entity connected to the given wire output node and the index of that entity's input node to which the output node is connected.

---

#### `void` object.setOutputNodeLevel(`unsigned` nodeIndex, `bool` level)

Sets the level of the specified wire output node.

---

#### `void` object.setAllOutputNodes(`bool` level)

Sets the level of all wire output nodes.

---

#### `void` object.setOfferedQuests([`JsonArray` quests])

Sets the list of quests that the object will offer to start, or clears them if unspecified.

---

#### `void` object.setTurnInQuests([`JsonArray` quests])

Sets the list of quests that the object will accept turn-in for, or clears them if unspecified.

---

#### `void` object.setConfigParameter(`String` key, `Json` value)

Sets the specified override configuration parameter for the object.

---

#### `void` object.setAnimationParameter(`String` key, `Json` value)

Sets the specified animation parameter for the object's scripted animator.

---

#### `void` object.setMaterialSpaces([`JsonArray` spaces])

Sets the object's material spaces to the specified list, or clears them if unspecified. List entries should be in the form of `pair<Vec2I, String>` specifying the relative position and material name of materials to be set. __Objects should only set material spaces within their occupied tile spaces to prevent Bad Things TM from happening.__

---

#### `void` object.setDamageSources([`List<DamageSource>` damageSources])

Sets the object's active damage sources (or clears them if unspecified).

---

#### `float` object.health()

Returns the object's current health.

---

#### `void` object.setHealth(`float` health)

Sets the object's current health.

 ---- 
# objectanimator.md
The objectAnimator table contains bindings available to client-side animation scripts for objects.

---

#### `Json` objectAnimator.getParameter(`String` parameter, `Json` default)

Returns the value for the specified object parameter. If there is no value set, returns the default.

---

#### `int` objectAnimator.direction()

Returns the object's facing direction. This will be 1 for right or -1 for left.

---

#### `Vec2F` objectAnimator.position()

Returns the object's tile position.

 ---- 
# physics.md
The physics table is available to objects and used to control any collisions or force regions configured on those objects.

---

#### `void` physics.setForceEnabled(`String` force, `bool` enabled)

Enables or disables the specified physics force region.

---

#### `void` physics.setCollisionPosition(`String` collision, `Vec2F` position)

Moves the specified physics collision region to the specified position.

---

#### `void` physics.setCollisionEnabled(`String` collision, `bool` enabled)

Enables or disables the specified physics collision region.

 ---- 
# player.md
The player table contains functions with privileged access to the player which run in a few contexts on the client such as scripted interface panes, quests, and player companions.

---

#### `EntityId` player.id()

Returns the player's entity id.

---

#### `String` player.uniqueId()

Returns the player's unique id.

---

#### `String` player.species()

Returns the player's species.

---

#### `String` player.gender()

Returns the player's gender.

---

#### `String` player.isAdmin()

Returns whether the player is admin.

---

#### `Json` player.getProperty(`String` name, `Json` default)

Returns the value assigned to the specified generic player property. If there is no value set, returns default.

---

#### `void` player.setProperty(`String` name, `Json` value)

Sets a generic player property to the specified value.

---

#### `void` player.addScannedObject(`String` name)

Adds the specified object to the player's scanned objects.

---

#### `void` player.removeScannedObject(`String` name)

Removes the specified object from the player's scanned objects.

---

#### `void` player.interact(`String` interactionType, `Json` config, [`EntityId` sourceEntityId])

Triggers an interact action on the player as if they had initiated an interaction and the result had returned the specified interaction type and configuration. Can be used to e.g. open GUI windows normally triggered by player interaction with entities.

---

#### `Json` player.shipUpgrades()

Returns a JSON object containing information about the player's current ship upgrades including "shipLevel", "maxFuel", "crewSize" and a list of "capabilities".

---

#### `void` player.upgradeShip(`Json` shipUpgrades)

Applies the specified ship upgrades to the player's ship.

---

#### `void` player.setUniverseFlag(`String` flagName)

Sets the specified universe flag on the player's current universe.

---

#### `void` player.giveBlueprint(`ItemDecriptor` item)

Teaches the player any recipes which can be used to craft the specified item.

---

#### `void` player.blueprintKnown(`ItemDecriptor` item)

Returns `true` if the player knows one or more recipes to create the specified item and `false` otherwise.

---

#### `void` player.makeTechAvailable(`String` tech)

Adds the specified tech to the player's list of available (unlockable) techs.

---

#### `void` player.makeTechUnavailable(`String` tech)

Removes the specified tech from player's list of available (unlockable) techs.

---

#### `void` player.enableTech(`String` tech)

Unlocks the specified tech, allowing it to be equipped through the tech GUI.

---

#### `void` player.equipTech(`String` tech)

Equips the specified tech.

---

#### `void` player.unequipTech(`String` tech)

Unequips the specified tech.

---

#### `JsonArray` player.availableTechs()

Returns a list of the techs currently available to the player.

---

#### `JsonArray` player.enabledTechs()

Returns a list of the techs currently unlocked by the player.

---

#### `String` player.equippedTech(`String` slot)

Returns the name of the tech the player has currently equipped in the specified slot, or `nil` if no tech is equipped in that slot.

---

#### `unsigned` player.currency(`String` currencyName)

Returns the player's current total reserves of the specified currency.

---

#### `void` player.addCurrency(`String` currencyName, `unsigned` amount)

Increases the player's reserve of the specified currency by the specified amount.

---

#### `bool` player.consumeCurrency(`String` currencyName, `unsigned` amount)

Attempts to consume the specified amount of the specified currency and returns `true` if successful and `false` otherwise.

---

#### `void` player.cleanupItems()

Triggers an immediate cleanup of the player's inventory, removing item stacks with 0 quantity. May rarely be required in special cases of making several sequential modifications to the player's inventory within a single tick.

---

#### `void` player.giveItem(`ItemDescriptor` item)

Adds the specified item to the player's inventory.

---

#### `bool` player.hasItem(`ItemDescriptor` item, [`bool` exactMatch])

Returns `true` if the player's inventory contains an item matching the specified descriptor and `false` otherwise. If exactMatch is `true` then parameters as well as item name must match.

---

#### `unsigned` player.hasCountOfItem(`ItemDescriptor` item, [`bool` exactMatch])

Returns the total number of items in the player's inventory matching the specified descriptor. If exactMatch is `true` then parameters as well as item name must match.

---

#### `ItemDescriptor` player.consumeItem(`ItemDescriptor` item, [`bool` consumePartial], [`bool` exactMatch])

Attempts to consume the specified item from the player's inventory and returns the item consumed if successful. If consumePartial is `true`, matching stacks totalling fewer items than the requested count may be consumed, otherwise the operation will only be performed if the full count can be consumed. If exactMatch is `true` then parameters as well as item name must match.

---

#### `Map<String, unsigned>` player.inventoryTags()

Returns a summary of all tags of all items in the player's inventory. Keys in the returned map are tag names and their corresponding values are the total count of items including that tag.

---

#### `JsonArray` player.itemsWithTag(`String` tag)

Returns a list of `ItemDescriptor`s for all items in the player's inventory that include the specified tag.

---

#### `void` player.consumeTaggedItem(`String` tag, `unsigned` count)

Consumes items from the player's inventory that include the matching tag, up to the specified count of items.

---

#### `bool` player.hasItemWithParameter(`String` parameter, `Json` value)

Returns `true` if the player's inventory contains at least one item which has the specified parameter set to the specified value.

---

#### `void` player.consumeItemWithParameter(`String` parameter, `Json` value, `unsigned` count)

Consumes items from the player's inventory that have the specified parameter set to the specified value, upt to the specified count of items.

---

#### `ItemDescriptor` player.getItemWithParameter(`String` parameter, `Json` value)

Returns the first item in the player's inventory that has the specified parameter set to the specified value, or `nil` if no such item is found.

---

#### `ItemDescriptor` player.primaryHandItem()

Returns the player's currently equipped primary hand item, or `nil` if no item is equipped.

---

#### `ItemDescriptor` player.altHandItem()

Returns the player's currently equipped alt hand item, or `nil` if no item is equipped.

---

#### `JsonArray` player.primaryHandItemTags()

Returns a list of the tags on the currently equipped primary hand item, or `nil` if no item is equipped.

---

#### `JsonArray` player.altHandItemTags()

Returns a list of the tags on the currently equipped alt hand item, or `nil` if no item is equipped.

---

#### `ItemDescriptor` player.essentialItem(`String` slotName)

Returns the contents of the specified essential slot, or `nil` if the slot is empty. Essential slot names are "beamaxe", "wiretool", "painttool" and "inspectiontool".

---

#### `void` player.giveEssentialItem(`String` slotName, `ItemDescriptor` item)

Sets the contents of the specified essential slot to the specified item.

---

#### `void` player.removeEssentialItem(`String` slotName)

Removes the essential item in the specified slot.

---

#### `ItemDescriptor` player.equippedItem(`String` slotName)

Returns the contents of the specified equipment slot, or `nil` if the slot is empty. Equipment slot names are "head", "chest", "legs", "back", "headCosmetic", "chestCosmetic", "legsCosmetic" and "backCosmetic".

---

#### `void` player.setEquippedItem(`String` slotName, `Json` item)

Sets the item in the specified equipment slot to the specified item.

---

#### `ItemDescriptor` player.swapSlotItem()

Returns the contents of the player's swap (cursor) slot, or `nil` if the slot is empty.

---

#### `void` player.setSwapSlotItem(`Json` item)

Sets the item in the player's swap (cursor) slot to the specified item.

---

#### `bool` player.canStartQuest(`Json` questDescriptor)

Returns `true` if the player meets all of the prerequisites to start the specified quest and `false` otherwise.

---

#### `QuestId` player.startQuest(`Json` questDescriptor, [`String` serverUuid], [`String` worldId])

Starts the specified quest, optionally using the specified server Uuid and world id, and returns the quest id of the started quest.

---

#### `bool` player.hasQuest(`String` questId)

Returns `true` if the player has a quest, in any state, with the specified quest id and `false` otherwise.

---

#### `bool` player.hasAcceptedQuest(`String` questId)

Returns `true` if the player has accepted a quest (which may be active, completed, or failed) with the specified quest id and `false` otherwise.

---

#### `bool` player.hasActiveQuest(`String` questId)

Returns `true` if the player has a currently active quest with the specified quest id and `false` otherwise.

---

#### `bool` player.hasCompletedQuest(`String` questId)

Returns `true` if the player has a completed quest with the specified quest id and `false` otherwise.

---

#### `Maybe<WorldId>` player.currentQuestWorld()

If the player's currently tracked quest has an associated world, returns the id of that world.

---

#### `List<pair<WorldId, bool>>` player.questWorlds()

Returns a list of world ids for worlds relevant to the player's current quests, along with a boolean indicating whether that quest is tracked.

---

#### `Maybe<Json>` player.currentQuestLocation()

If the player's currently tracked quest has an associated location (CelestialCoordinate, system orbit, UUID, or system position) returns that location.

---

#### `List<pair<Json, bool>>` player.questLocations()

Returns a list of locations for worlds relevant to the player's current quests, along with a boolean indicating whether that quest is tracked.

---

#### `void` player.enableMission(`String` missionName)

Adds the specified mission to the player's list of available missions.

---

#### `void` player.completeMission(`String` missionName)

Adds the specified mission to the player's list of completed missions.

---

#### `void` player.hasCompletedMission(`String` missionName)

Returns whether the player has completed the specified mission.

---

#### `void` player.radioMessage(`Json` messageConfig, [`float` delay])

Triggers the specified radio message for the player, either immediately or with the specified delay.

---

#### `String` player.worldId()

Returns a `String` representation of the world id of the player's current world.

---

#### `String` player.serverUuid()

Returns a `String` representation of the player's Uuid on the server.

---

#### `String` player.ownShipWorldId()

Returns a `String` representation of the world id of the player's ship world.

---

#### `bool` player.lounge(`EntityId` loungeableId, [`unsigned` anchorIndex])

Triggers the player to lounge in the specified loungeable entity at the specified lounge anchor index (default is 0).

---

#### `bool` player.isLounging()

Returns `true` if the player is currently occupying a loungeable entity and `false` otherwise.

---

#### `EntityId` player.loungingIn()

If the player is currently lounging, returns the entity id of what they are lounging in.

---

#### `double` player.playTime()

Returns the total played time for the player.

---

#### `bool` player.introComplete()

Returns `true` if the player is marked as having completed the intro instance and `false` otherwise.

---

#### `void` player.setIntroComplete(`bool` complete)

Sets whether the player is marked as having completed the intro instance.

---

#### `void` player.warp(`String` warpAction, [`String` animation], [`bool` deploy])

Immediately warps the player to the specified warp target, optionally using the specified warp animation and deployment.

---

#### `bool` player.canDeploy()

Returns whether the player has a deployable mech.

---

#### `bool` player.isDeployed()

Returns whether the player is currently deployed.

---

#### `RpcPromise` player.confirm(`Json` dialogConfig)

Displays a confirmation dialog to the player with the specified dialog configuration and returns an `RpcPromise` which can be used to retrieve the player's response to that dialog.

---

#### `void` player.playCinematic(`Json` cinematic, [`bool` unique])

Triggers the specified cinematic to be displayed for the player. If unique is `true` the cinematic will only be shown to that player once.

---

#### `void` player.recordEvent(`String` event, `Json` fields)

Triggers the specified event on the player with the specified fields. Used to record data e.g. for achievements.

---

#### `bool` player.worldHasOrbitBookmark(`Json` coordinate)

Returns whether the player has a bookmark for the specified celestial coordinate.

---

#### `List<pair<Vec3I, Json>>` player.orbitBookmarks()

Returns a list of orbit bookmarks with their system coordinates.

---

#### `List<Json>` player.systemBookmarks(`Json` systemCoordinate)

Returns a list of orbit bookmarks in the specified system.

---

#### `bool` player.addOrbitBookmark(`Json` systemCoordinate, `Json` bookmarkConfig)

Adds the specified bookmark to the player's bookmark list and returns `true` if the bookmark was successfully added (and was not already known) and `false` otherwise.

---

#### `bool` player.removeOrbitBookmark(`Json` systemCoordinate, `Json` bookmarkConfig)

Removes the specified bookmark from the player's bookmark list and returns `true` if the bookmark was successfully removed and `false` otherwise.

---

#### `List<Json>` player.teleportBookmarks()

Lists all of the player's teleport bookmarks.

---

#### `bool` player.addTeleportBookmark(`Json` bookmarkConfig)

Adds the specified bookmark to the player's bookmark list and returns `true` if the bookmark was successfully added (and was not already known) and `false` otherwise.

---

#### `bool` player.removeTeleportBoookmark(`Json` bookmarkConfig)

Removes the specified teleport bookmark.

---

#### `bool` player.isMapped(`Json` coordinate)

Returns whether the player has previously visited the specified coordinate.

---

#### `Json` player.mappedObjects(`Json` systemCoordinate)

Returns uuid, type, and orbits for all system objects in the specified system;

---

#### `List<String>` player.collectables(`String` collectionName)

Returns a list of names of the collectables the player has unlocked in the specified collection.

 ---- 
# playercompanions.md
The playerCompanions table contains bindings used to manage player companions such as pets and crew members.

---

#### `JsonArray` playerCompanions.getCompanions(`String` companionType)

Returns a list of configurations for all companions of the specified type.

---

#### `void` playerCompanions.setCompanions(`String` companionType, `JsonArray` companions)

Sets the player's companions of the specified type to the specified list of companion configurations.

 ---- 
# projectile.md
The projectile table contains bindings specific to projectiles which are available in addition to their common tables.

---

#### `Json` projectile.getParameter(`String` parameter, `Json` default)

Returns the value for the specified config parameter. If there is no value set, returns the default.

---

#### `void` projectile.die()

Destroys the projectile.

---

#### `EntityId` projectile.sourceEntity()

Returns the entity id of the projectile's source entity, or `nil` if no source entity is set.

---

#### `float` projectile.powerMultiplier()

Returns the projectile's power multiplier.

---

#### `float` projectile.power()

Returns the projectile's power (damage).

---

#### `void` projectile.setPower(`float` power)

Sets the projectile's power (damage).

---

#### `float` projectile.timeToLive()

Returns the projectile's current remaining time to live.

---

#### `void` projectile.setTimeToLive(`float` timeToLive)

Sets the projectile's current remaining time to live. Altering the time to live may cause visual disparity between the projectile's master and slave entities.

---

#### `bool` projectile.collision()

Returns `true` if the projectile has collided and `false` otherwise.

---

#### `void` projectile.processAction(`Json` action)

Immediately performs the specified action. Action should be specified in a format identical to a single entry in e.g. actionOnReap in the projectile's configuration. This function will not properly perform rendering actions as they will not be networked.

---

#### 'void' projectile.setReferenceVelocity(Maybe<`Vec2F`> velocity)

Sets the projectile's reference velocity (a base velocity to which movement is relative)

 ---- 
# quest.md
# quest

The `quest` table contains functions relating directly to the quest whose script its run in.

---

#### `String` quest.state()

Returns the current state of the quest.

Possible states:
* "New"
* "Offer"
* "Active"
* "Complete"
* "Failed"

---

#### `void` quest.complete()

Immediately completes the quest.

---

#### `void` quest.fail()

Immediately fails the quest.

---

#### `void` quest.setCanTurnIn(`bool` turnIn)

Sets whether the quest can be turned in.

---

#### `String` quest.questId()

Returns the quest id.

---

#### `String` quest.templateId()

Returns the ID of the template used to make this quest.

---

#### `uint64_t` quest.seed()

Returns the seed used to generate the quest.

---

#### `Json` quest.questDescriptor()

Returns the quest descriptor including parameters.

---

#### `Json` quest.questArcDescriptor()

Returns the quest arc descriptor.

---

#### `Vec2F` quest.questArcPosition()

Returns the quest arc position. (?)

---

#### `String` quest.worldId()

Returns the world id for the quest arc.

---

#### `String` quest.serverUuid()

Returns the server uuid for the quest.

---

#### `QuestParameters` quest.parameters()

Returns all quest parameters.

---

#### `void` quest.setParameter(`String` name, `Json` value)

Sets a quest parameter.

---

#### `void` quest.setIndicators(`List<String>` indicators)

Set a list of quest parameters to use as custom indicators.

Example:
```
-- define indicators
local entityIndicator = {
  type = "entity",
  uniqueId = "techscientist"
}
local itemIndicator = {
  type = "item",
  item = "perfectlygenericitem"
}
local itemTagIndicator = {
  type = "itemTag",
  tag = "weapon"
}
local itemListIndicator = {
  type = "itemList",
  items = [ "perfectlygenericitem", "standingturret" ]
}
local monsterTypeIndicator = {
  type = "monsterType",
  typeName = "peblit"
}

-- set quest parameters for the indicators
quest.setParameter("entity", entityIndicator)
quest.setParameter("item", itemIndicator)
quest.setParameter("itemTag", itemTagIndicator)
quest.setParameter("itemList", itemListIndicator)
quest.setParameter("monsterType", monsterTypeIndicator)

-- add the set quest parameters to the indicators list
quest.setIndicators({"entity", "item", "itemTag", "itemList", "monsterType"})
```

---

#### `void` quest.setObjectiveList(`JsonArray` objectives)

Set the objectives for the quest tracker. Objectives are in the format {text, completed}

Example:
```lua
quest.setObjectiveList({
  {"Gather 4 cotton", true},
  {"Eat 2 cotton", false}
})
```

---

#### `void` quest.setProgress(`float` progress)

Sets the progress amount of the quest tracker progress bar. Set nil to hide. Progress is from 0.0 to 1.0.

---

#### `void` quest.setCompassDirection(`float` angle)

Set the angle of the quest tracker compass. Setting nil hides the compass.

---

#### `void` quest.setTitle(`String` title)

Sets the title of the quest in the quest log.

---

#### `void` quest.setText(`String` text)

Set the text for the quest in the quest log.

---

#### `void` quest.setCompletionText(`String` completionText)

Sets the text shown in the completion window when the quest is completed.

---

#### `void` quest.setFailureText(`String` failureText)

Sets the text shown in the completion window when the quest is failed.

---

#### `void` quest.setPortrait(`String` portraitName, `JsonArray` portrait)

Sets a portrait to a list of drawables.

---

#### `void` quest.setPortraitTitle(`String` portraitName, `String` title)

Sets a portrait title.

---

#### `void` quest.addReward(`ItemDescriptor` reward)

Add an item to the reward pool.
 ---- 
# root.md
The `root` table contains functions that reference the game's currently loaded assets and don't relate to any more specific context such as a particular world or universe.

---

#### `Json` root.assetJson(`String` assetPath)

Returns the contents of the specified JSON asset file.

---

#### `Json` root.makeCurrentVersionedJson(`String` versioningIdentifier, `Json` content)

Returns a versioned JSON representation of the given JSON content with the given identifier and the most recent version as specified in `versioning.config`.

---

#### `Json` root.loadVersionedJson(`Json` versionedContent, `String` versioningIdentifier)

Returns the given JSON content and identifier after applying appropriate versioning scripts to bring it up to the most recent version as specified in `versioning.config`.

---

#### `double` root.evalFunction(`String` functionName, `double` input)

Returns the evaluation of the specified univariate function (as defined in a `.functions` file) for the given input value.

---

#### `double` root.evalFunction2(`String` functionName, `double` input1, `double` input2)

Returns the evaluation of the specified bivariate function (as defined in a `.2functions` file) for the given input values.

---

#### `Vec2U` root.imageSize(`String` imagePath)

Returns the pixel dimensions of the specified image asset.

---

#### `List<Vec2I>` root.imageSpaces(`String` imagePath, `Vec2F` worldPosition, `float` spaceScan, `bool` flip)

Returns a list of the world tile spaces the image would occupy if placed at the given position using the specified spaceScan value (the portion of a space that must be non-transparent for that space to count as filled).

---

#### `RectU` root.nonEmptyRegion(`String` imagePath)

Returns the rectangle containing the portion of the specified asset image that is non-transparent.

---

#### `Json` root.npcConfig(`String` npcType)

Returns a representation of the generated JSON configuration for an NPC of the given type.

---

#### `Json` root.npcVariant(`String` species, `String` npcType, `float` level, [`unsigned` seed], [`Json` parameters])

Generates an NPC with the specified species, type, level, seed and parameters, and returns its configuration.

---

#### `float` root.projectileGravityMultiplier(`String` projectileName)

Returns the gravity multiplier of the given projectile's movement controller configuration as configured in `physics.config`.

---

#### `Json` root.projectileConfig(`String` projectileName)

Returns a representation of the JSON configuration for the given projectile.

---

#### `Json` root.itemDescriptorsMatch(`ItemDescriptor` descriptor1, `ItemDescriptor` descriptor2, [`bool` exactMatch])

Returns `true` if the given item descriptors match. If exactMatch is `true` then both names and parameters will be compared, otherwise only names.

---

#### `JsonArray` root.recipesForItem(`String` itemName)

Returns a list of JSON configurations of all recipes which output the given item.

---

#### `String` root.itemType(`String` itemName)

Returns the item type name for the specified item.

---

#### `JsonArray` root.itemTags(`String` itemName)

Returns a list of the tags applied to the specified item.

---

#### `bool` root.itemHasTag(`String` itemName, `String` tagName)

Returns true if the given item's tags include the specified tag and false otherwise.

---

#### `Json` root.itemConfig(`ItemDescriptor` descriptor, [`float` level], [`unsigned` seed])

Generates an item from the specified descriptor, level and seed and returns a JSON object containing the `directory`, `config` and `parameters` for that item.

---

#### `ItemDescriptor` root.createItem(`ItemDescriptor` descriptor, [`float` level], [`unsigned` seed])

Generates an item from the specified descriptor, level and seed and returns a new item descriptor for the resulting item.

---

#### `Json` root.tenantConfig(`String` tenantName)

Returns the JSON configuration for the given tenant.

---

#### `JsonArray` root.getMatchingTenants(`map<String, unsigned>` colonyTags)

Returns an array of JSON configurations of tenants matching the given map of colony tags and corresponding object counts.

---

#### `JsonArray` root.liquidStatusEffects(`LiquidId` liquid)

Returns an array of status effects applied by the given liquid.

---

#### `String` root.generateName(`String` assetPath, [`unsigned` seed])

Returns a randomly generated name using the specified name gen config and seed.

---

#### `Json` root.questConfig(`String` questTemplateId)

Returns the JSON configuration of the specified quest template.

---

#### `JsonArray` root.npcPortrait(`String` portraitMode, `String` species, `String` npcType, `float` level, [`unsigned` seed], [`Json` parameters])

Generates an NPC with the specified type, level, seed and parameters and returns a portrait in the given portraitMode as a list of drawables.

---

#### `JsonArray` root.monsterPortrait(`String` typeName, [`Json` parameters])

Generates a monster of the given type with the given parameters and returns its portrait as a list of drawables.

---

#### `bool` root.isTreasurePool(`String` poolName)

Returns true if the given treasure pool exists and false otherwise. Can be used to guard against errors attempting to generate invalid treasure.

---

#### `JsonArray` root.createTreasure(`String` poolName, `float` level, [`unsigned` seed])

Generates an instance of the specified treasure pool, level and seed and returns the contents as a list of item descriptors.

---

#### `String` root.materialMiningSound(`String` materialName, [`String` modName])

Returns the path of the mining sound asset for the given material and mod combination, or `nil` if no mining sound is set.

---

#### `String` root.materialFootstepSound(`String` materialName, [`String` modName])

Returns the path of the footstep sound asset for the given material and mod combination, or `nil` if no footstep sound is set.

---

#### `float` root.materialHealth(`String` materialName)

Returns the configured health value for the specified material.

---

#### `Json` root.materialConfig(`String` materialName)

Returns a JSON object containing the `path` and base `config` for the specified material if it is a real material, or `nil` if it is a metamaterial or invalid.

---

#### `Json` root.modConfig(`String` modName)

Returns a JSON object containing the `path` and base `config` for the specified mod if it is a real mod, or `nil` if it is a metamod or invalid.

---

#### `Json` root.liquidConfig(`LiquidId` liquidId)

#### `Json` root.liquidConfig(`String` liquidName)

Returns a JSON object containing the `path` and base `config` for the specified liquid name or id if it is a real liquid, or `nil` if the liquid is empty or invalid.

---

#### `String` root.liquidName(`LiquidId` liquidId)

Returns the string name of the liquid with the given ID.

---

#### `LiquidId` root.liquidId(`String` liquidName)

Returns the numeric ID of the liquid with the given name.

---

#### `Json` root.monsterSkillParameter(`String` skillName, `String` parameterName)

Returns the value of the specified parameter for the specified monster skill.

---

#### `Json` root.monsterParameters(`String` monsterType, [uint64_t seed])

Returns the parameters for a monster type.

---

#### `ActorMovementParameters` root.monsterMovementSettings(`String` monsterType, [uint64_t seed])

Returns the configured base movement parameters for the specified monster type.

---

#### `Json` root.createBiome(`String` biomeName, `unsigned` seed, `float` verticalMidPoint, `float` threatLevel)

Generates a biome with the specified name, seed, vertical midpoint and threat level, and returns a JSON object containing the configuration for the generated biome.

---

#### `String` root.hasTech(`String` techName)

Returns `true` if a tech with the specified name exists and `false` otherwise.

---

#### `String` root.techType(`String` techName)

Returns the type (tech slot) of the specified tech.

---

#### `Json` root.techConfig(`String` techName)

Returns the JSON configuration for the specified tech.

---

#### `String` root.treeStemDirectory(`String` stemName)

Returns the path within assets from which the specified tree stem type was loaded.

---

#### `String` root.treeFoliageDirectory(`String` foliageName)

Returns the path within assets from which the specified tree foliage type was loaded.

---

#### `Collection` root.collection(`String` collectionName)

Returns the metadata for the specified collection.

---

#### `List<Collectable>` root.collectables(`String` collectionName)

Returns a list of collectables for the specified collection.

---

#### `String` root.elementalResistance(`String` elementalType)

Returns the name of the stat used to calculate elemental resistance for the specified elemental type.

---

#### `Json` root.dungeonMetadata(`String` dungeonName)

Returns the metadata for the specified dungeon definition.

---

#### `BehaviorState` root.behavior(`LuaTable` context, `Json` config, `JsonObject` parameters)

Loads a behavior and returns the behavior state as userdata.

context is the current lua context called from, in almost all cases _ENV.

config can be either the `String` name of a behavior tree, or an entire behavior tree configuration to be built.

parameters is overrides for parameters for the behavior tree.

BehaviorState contains 2 methods:

behavior:init(_ENV) -- initializes the behavior, loads required scripts, and returns a new behavior state
behavior:run(state, dt) -- runs the behavior, takes a behavior state for the first argument
behavior:clear(state) -- resets the internal state of the behavior

Example:

```lua
function init()
  self.behavior = root.behavior("monster", {})
  self.behaviorState = self.behavior:init(_ENV)
end

function update(dt)
  self.behavior:run(self.behaviorState, dt)
end
```

 ---- 
# scriptedanimator.md
# animationConfig

The `animationConfig` table contains functions for getting configuration options from the base entity and its networked animator.

It is available only in client side rendering scripts.

---

#### `Json` animationConfig.animationParameter(`String` key)

Returns a networked value set by the parent entity's master script.

---

#### `Vec2F` animationConfig.partPoint(`String` partName, `String` propertyName)

Returns a `Vec2F` configured in a part's properties with all of the part's transformations applied to it.

---

#### `PolyF` animationConfig.partPoly(`String` partName, `String` propertyName)

Returns a `PolyF` configured in a part's properties with all the part's transformations applied to it.

 ---- 
# scriptpane.md
These pane bindings are available to scripted interface panes and include functions not specifically related to widgets within the pane.

---

#### `EntityId` pane.sourceEntity()

Returns the entity id of the pane's source entity.

---

#### `void` pane.dismiss()

Closes the pane.

---

#### `void` pane.playSound(`String` sound, [`int` loops], [`float` volume])

Plays the specified sound asset, optionally looping the specified number of times or at the specified volume.

---

#### `bool` pane.stopAllSounds(`String` sound)

Stops all instances of the given sound asset, and returns `true` if any sounds were stopped and `false` otherwise.

---

#### `void` pane.setTitle(`String` title, `String` subtitle)

Sets the window title and subtitle.

---

#### `void` pane.setTitleIcon(`String` image)

Sets the window icon.

---

#### `void` pane.addWidget(`Json` widgetConfig, [`String` widgetName])

Creates a new widget with the specified config and adds it to the pane, optionally with the specified name.

---

#### `void` pane.removeWidget(`String` widgetName)

Removes the specified widget from the pane.

 ---- 
# stagehand.md
The stagehand table contains bindings specific to stagehands which are available in addition to their common tables.

---

#### `EntityId` stagehand.id()

Returns the stagehand's entity id. Identical to entity.id(), so use that instead.

---

#### `Vec2F` stagehand.position()

Returns the stagehand's position. This is identical to entity.position(), so use that instead.

---

#### `void` stagehand.setPosition(`Vec2F` position)

Moves the stagehand to the specified position.

---

#### `void` stagehand.die()

Destroys the stagehand.

---

#### `String` stagehand.typeName()

Returns the stagehand's type name.

---

#### `void` stagehand.setUniqueId([`String` uniqueId])

Sets the stagehand's unique entity id, or clears it if unspecified.

 ---- 
# statuscontroller.md
# status

The `status` table relates to the status controller attached to an entity. It is available in:

* monsters
* npcs
* status effects
* companion system scripts
* quest scripts
* tech
* primary status scripts for: player, monster, npc

---

#### `Json` status.statusProperty(`String` name, `Json` default)

Returns the value assigned to the specified status property. If there is no value set, returns default.

---

#### `void` status.setStatusProperty(`String` name, `Json` value)

Sets a status property to the specified value.

---

#### `float` status.stat(`String` statName)

Returns the value for the specified stat. Defaults to 0.0 if the stat does not exist.

---

#### `bool` status.statPositive(`String` statName)

Returns whether the stat value is greater than 0.

---

#### `List<String>` status.resourceNames()

Returns a list of the names of all the configured resources;

---

#### `bool` status.isResource(`String` resourceName)

Returns whether the specified resource exists in this status controller.

---

#### `float` status.resource(`String` resourceName)

Returns the value of the specified resource.

---

#### `bool` status.resourcePositive(`String` resourceName)

Returns whether the value of the specified resource is greater than 0.

---

#### `void` status.setResource(`String` resourceName, `float` value)

Sets a resource to the specified value.

---

#### `void` status.modifyResource(`String` resourceName, `float` value)

Adds the specified value to a resource.

---

#### `float` status.giveResource(`String` resourceName, `float` value)

Adds the specified value to a resource. Returns any overflow.

---

#### `bool` status.consumeResource(`String` resourceName, `float` amount)

Tries to consume the specified amount from a resource. Returns whether the full amount was able to be consumes. Does not modify the resource if unable to consume the full amount.

---

#### `bool` status.overConsumeResource(`String` resourceName, `float` amount)

Tries to consume the specified amount from a resource. If unable to consume the full amount, will consume all the remaining amount. Returns whether it was able to consume any at all of the resource.

---

#### `bool` status.resourceLocked(`String` resourceName)

Returns whether the resource is currently locked.

---

#### `void` status.setResourceLocked(`String` resourceName, `bool` locked)

Sets a resource to be locked/unlocked. A locked resource cannot be consumed.

---

#### `void` status.resetResource(`String` resourceName)

Resets a resource to its base value.

---

#### `void` status.resetAllResources()

Resets all resources to their base values.

---

#### `float` status.resourceMax(`String` resourceName)

Returns the max value for the specified resource.

---

#### `float` status.resourcePercentage(`String` resourceName)

Returns the percentage of max that the resource is currently at. From 0.0 to 1.0.

---

#### `void` status.setResourcePercentage(`String` resourceName, `float` value)

Sets a resource to a percentage of the max value for the resource. From 0.0 to 1.0.

---

#### `void` status.modifyResourcePercentage(`String` resourceName, `float` value)

Adds a percentage of the max resource value to the current value of the resource.

---

#### `JsonArray` status.getPersistentEffects(`String` effectCategory)

Returns a list of the currently active persistent effects in the specified effect category.

---

#### `void` status.addPersistentEffect(`String` effectCategory, `Json` effect)

Adds a status effect to the specified effect category.

---

#### `void` status.addPersistentEffects(`String` effectCategory, `JsonArray` effects)

Adds a list of effects to the specified effect category.

---

#### `void` status.setPersistentEffects(`String` effectCategory, `JsonArray` effects)

Sets the list of effects of the specified effect category. Replaces the current list active effects.

---

#### `void` status.clearPersistentEffects(`String` effectCategory)

Clears any status effects from the specified effect category.

---

#### `void` status.clearAllPersistentEffects()

Clears all persistent status effects from all effect categories.

---

#### `void` status.addEphemeralEffect(`String` effectName, [`float` duration], [`EntityId` sourceEntity])

Adds the specified unique status effect. Optionally with a custom duration, and optionally with a source entity id accessible in the status effect.

---

#### `void` status.addEphemeralEffects(`JsonArray` effects, [`EntityId` sourceEntity])

Adds a list of unique status effects. Optionally with a source entity id.

Unique status effects can be specified either as a string, "myuniqueeffect", or as a table, {effect = "myuniqueeffect", duration = 5}. Remember that this function takes a `list` of these effect descriptors. This is a valid list of effects: { "myuniqueeffect", {effect = "myothereffect", duration = 5} }

---

#### `void` status.removeEphemeralEffect(`String` effectName)

Removes the specified unique status effect.

---

#### `void` status.clearEphemeralEffects()

Clears all ephemeral status effects.

---

#### `List<pair<DamageNotification>>`, `unsigned` status.damageTakenSince([`unsigned` since = 0]])

Returns two values:
* A list of damage notifications for the entity's damage taken since the specified heartbeat.
* The most recent heartbeat to be passed into the function again to get the damage notifications taken since this function call.

Example:

```lua
_,lastStep = status.damageTakenSince() -- Returns the full buffer of damage notifications, throw this away, we only want the current step

-- stuff

notifications,lastStep = status.damageTakenSince(lastStep) -- Get the damage notifications since the last call, and update the heartbeat
```

---

#### `List<pair<EntityId,DamageRequest>>`, `unsigned` status.inflictedHitsSince([`unsigned` since = 0]])

Returns two values:
* A list {{entityId, damageRequest}} for the entity's inflicted hits since the specified heartbeat.
* The most recent heartbeat to be passed into the function again to get the inflicted hits since this function call.

---

#### `List<DamageNotification>`, `unsigned` status.inflictedDamageSince([`unsigned` since = 0])

Returns two values:
* A list of damage notifications for damage inflicted by the entity.
* The most recent heartbeat to be passed into the function again to get the list of damage notifications since the last call.

---

#### `JsonArray` status.activeUniqueStatusEffectSummary()

Returns a list of two element tables describing all unique status effects currently active on the status controller. Each entry consists of the `String` name of the effect and a `float` between 0 and 1 indicating the remaining portion of that effect's duration.

---

#### `bool` status.uniqueStatusEffectActive(`String` effectName)

Returns `true` if the specified unique status effect is currently active and `false` otherwise.

---

#### `String` status.primaryDirectives()

Returns the primary set of image processing directives applied to the animation of the entity using this status controller.

---

#### `void` status.setPrimaryDirectives([`String` directives])

Sets the primary set of image processing directives that should be applied to the animation of the entity using this status controller.

---

#### `void` status.applySelfDamageRequest(`DamageRequest` damageRequest)

Directly applies the specified damage request to the entity using this status controller.

 ---- 
# statuseffect.md
# effect

The `effect` table relates to functions specifically for status effects.

---

#### `float` effect.duration()

Returns the remaining duration of the status effect.

---

#### `void` effect.modifyDuration(`float` duration)

Adds the specified duration to the current remaining duration.

---

#### `void` effect.expire()

Immediately expire the effect, setting the duration to 0.

---

#### `EntityId` effect.sourceEntity()

Returns the source entity id of the status effect, if any.

---

#### `void` effect.setParentDirectives(`String` directives)

Sets image processing directives for the entity the status effect is active on.

---

#### `Json` effect.getParameter(`String` name, `Json` def)

Returns the value associated with the parameter name in the effect configuration. If no value is set, returns the default specified.

---

#### `StatModifierGroupId` effect.addStatModifierGroup(`List<StatModifier>` modifiers)

Adds a new stat modifier group and returns the ID created for the group. Stat modifier groups will stay active until the effect expires.

Stat modifiers are of the format:

```lua
{
  stat = "health",

  amount = 50
  --OR baseMultiplier = 1.5
  --OR effectiveMultiplier = 1.5
}
```

---

#### `void` effect.setStatModifierGroup(`StatModifierGroupId`, groupId, `List<StatModifier>` modifiers)

Replaces the list of stat modifiers in a group with the specified modifiers.

---

#### `void` effect.removeStatModifierGroup(`StatModifierGroupId` groupId)

Removes the specified stat modifier group.

 ---- 
# tech.md
# tech

The `tech` table contains functions exclusively available in tech scripts.

---

#### `Vec2F` tech.aimPosition()

Returns the current cursor aim position.

---

#### `void` tech.setVisible(`bool` visible)

Sets whether the tech should be visible.

---

#### `void` tech.setParentState(`String` state)

Set the animation state of the player.

Valid states:
* "Stand"
* "Fly"
* "Fall"
* "Sit"
* "Lay"
* "Duck"
* "Walk"
* "Run"
* "Swim"

---

#### `void` tech.setParentDirectives(`String` directives)

Sets the image processing directives for the player.

---

#### `void` tech.setParentHidden(`bool` hidden)

Sets whether to make the player invisible. Will still show the tech.

---

#### `void` tech.setParentOffset(`Vec2F` offset)

Sets the position of the player relative to the tech.

---

#### `bool` tech.parentLounging()

Returns whether the player is lounging.

---

#### `void` tech.setToolUsageSuppressed(`bool` suppressed)

Sets whether to suppress tool usage on the player. When tool usage is suppressed no items can be used.


 ---- 
# updatablescript.md
Most entity script contexts include the *script* table, which provides bindings for getting and setting the script's update rate. Update deltas are specified in numbers of frames, so a script with an update delta of 1 would run every frame, or a script with an update delta of 60 would run once per second. An update delta of 0 means that the script's periodic update will never be called, but it can still perform actions through script calls, messaging, or event hooks.

---

#### `void` script.setUpdateDelta(`unsigned` dt)

Sets the script's update delta.

---

#### `float` script.updateDt()

Returns the duration in seconds between periodic updates to the script.

 ---- 
# utility.md
The sb table contains miscellaneous utility functions that don't directly relate to any assets or content of the game.

---

#### `double` sb.nrand([`double` standardDeviation], [`double` mean])

Returns a randomized value with a normal distribution using the specified standard deviation (default is 1.0) and mean (default is 0).

---

#### `String` sb.makeUuid()

Returns a `String` representation of a new, randomly-created `Uuid`.

---

#### `void` sb.logInfo(`String` formatString, [`LuaValue` formatValues ...])

Logs the specified formatted string, optionally using the formatted replacement values, to the log file and console with the Info log level.

---

#### `void` sb.logWarn(`String` formatString, [`LuaValue` formatValues ...])

Logs the specified formatted string, optionally using the formatted replacement values, to the log file and console with the Warn log level.

---

#### `void` sb.logError(`String` formatString, [`LuaValue` formatValues ...])

Logs the specified formatted string, optionally using the formatted replacement values, to the log file and console with the Error log level.

---

#### `void` sb.setLogMap(`String` key, `String` formatString, [`LuaValue` formatValues ...])

Sets an entry in the debug log map (visible while in debug mode) using the specified format string and optional formatted replacement values.

---

#### `String` sb.printJson(`Json` value, [`bool` pretty])

Returns a human-readable string representation of the specified JSON value. If pretty is `true`, objects and arrays will have whitespace added for readability.

---

#### `String` sb.print(`LuaValue` value)

Returns a human-readable string representation of the specified `LuaValue`.

---

#### `Variant<Vec2F, double>` sb.interpolateSinEase(`double` offset, `Variant<Vec2F, double>` value1, `Variant<Vec2F, double>` value2)

Returns an interpolated `Vec2F` or `double` between the two specified values using a sin ease function.

---

#### `String` sb.replaceTags(`String` string, `Map<String, String>` tags)

Replaces all tags in the specified string with the specified tag replacement values.

---

#### `Json` sb.jsonMerge(`Json` a, `Json` b)

Returns the result of merging the contents of b on top of a.

---

#### `Json` sb.jsonQuery(`Json` content, `String` path, `Json` default)

Attempts to extract the value in the specified content at the specified path, and returns the found value or the specified default if no such value exists.

---

#### `int` sb.staticRandomI32([`LuaValue` hashValues ...])

Returns a statically randomized 32-bit signed integer based on the given list of seed values.

---

#### `int` sb.staticRandomI32Range(`int` min, `int` max, [`LuaValue` hashValues ...])

Returns a statically randomized 32-bit signed integer within the specified range based on the given list of seed values.

---

#### `double` sb.staticRandomDouble([`LuaValue` hashValues ...])

Returns a statically randomized `double` based on the given list of seed values.

---

#### `double` sb.staticRandomDoubleRange(`double` min, `double` max, [`LuaValue` hashValues ...])

Returns a statically randomized `double` within the specified range based on the given list of seed values.

---

#### `RandomSource` sb.makeRandomSource([`unsigned` seed])

Creates and returns a Lua UserData value which can be used as a random source, initialized with the specified seed. The `RandomSource` has the following methods:

##### `void` init([`unsigned` seed])

Reinitializes the random source, optionally using the specified seed.

##### `void` addEntropy([`unsigned` seed])

Adds entropy to the random source, optionally using the specified seed.

##### `unsigned` randu32()

Returns a random 32-bit unsigned integer value.

##### `unsigned` randu64()

Returns a random 64-bit unsigned integer value.

##### `int` randi32()

Returns a random 32-bit signed integer value.

##### `int` randi64()

Returns a random 64-bit signed integer value.

##### `float` randf([`float` min], [`float` max])

Returns a random `float` value within the specified range, or between 0 and 1 if no range is specified.

##### `double` randf([`double` min], [`double` max])

Returns a random `double` value within the specified range, or between 0 and 1 if no range is specified.

##### `unsigned` randf(`unsigned` minOrMax, [`unsigned` max])

Returns a random unsigned integer value between minOrMax and max, or between 0 and minOrMax if no max is specified.

##### `int` randf([`int` min], [`int` max])

Returns a random signed integer value between minOrMax and max, or between 0 and minOrMax if no max is specified.

##### `bool` randb()

Returns a random `bool` value.

---

#### `PerlinSource` sb.makePerlinSource(`Json` config)

Creates and returns a Lua UserData value which can be used as a Perlin noise source. The configuration for the `PerlinSource` should be a JSON object and can include the following keys:

* `unsigned` __seed__ - Seed value used to initialize the source.
* `String` __type__ - Type of noise to use. Valid types are "perlin", "billow" or "ridgedMulti".
* `int` __octaves__ - Number of octaves of noise to use. Defaults to 1.
* `double` __frequency__ - Defaults to 1.0.
* `double` __amplitude__ - Defaults to 1.0.
* `double` __bias__ - Defaults to 0.0.
* `double` __alpha__ - Defaults to 2.0.
* `double` __beta__ - Defaults to 2.0.
* `double` __offset__ - Defaults to 1.0.
* `double` __gain__ - Defaults to 2.0.

The `PerlinSource` has only one method:

##### `float` get(`float` x, [`float` y], [`float` z])

Returns a `float` value from the Perlin source using 1, 2, or 3 dimensions of input.

 ---- 
# vehicle.md
The vehicle table contains bindings specific to vehicles which are available in addition to their common tables.

---

#### `bool` vehicle.controlHeld(`String` loungeName, `String` controlName)

Returns `true` if the specified control is currently being held by an occupant of the specified lounge position and `false` otherwise.

---

#### `Vec2F` vehicle.aimPosition(`String` loungeName)

Returns the world aim position for the specified lounge position.

---

#### `EntityId` vehicle.entityLoungingIn(`String` loungeName)

Returns the entity id of the entity currently occupying the specified lounge position, or `nil` if the lounge position is unoccupied.

---

#### `void` vehicle.setLoungeEnabled(`String` loungeName, `bool` enabled)

Enables or disables the specified lounge position.

---

#### `void` vehicle.setLoungeOrientation(`String` loungeName, `String` orientation)

Sets the lounge orientation for the specified lounge position. Valid orientations are "sit", "stand" or "lay".

---

#### `void` vehicle.setLoungeEmote(`String` loungeName, [`String` emote])

Sets the emote to be performed by entities occupying the specified lounge position, or clears it if no emote is specified.

---

#### `void` vehicle.setLoungeDance(`String` loungeName, [`String` dance])

Sets the dance to be performed by entities occupying the specified lounge position, or clears it if no dance is specified.

---

#### `void` vehicle.setLoungeStatusEffects(`String` loungeName, `JsonArray` statusEffects)

Sets the list of status effects to be applied to entities occupying the specified lounge position. To clear the effects, set an empty list.

---

#### `void` vehicle.setPersistent(`bool` persistent)

Sets whether the vehicle is persistent, i.e. whether it will be stored when the world is unloaded and reloaded.

---

#### `void` vehicle.setInteractive(`bool` interactive)

Sets whether the vehicle is currently interactive.

---

#### `void` vehicle.setDamageTeam(`DamageTeam` team)

Sets the vehicle's current damage team type and number.

---

#### `void` vehicle.setMovingCollisionEnabled(`String` collisionName, `bool` enabled)

Enables or disables the specified collision region.

---

#### `void` vehicle.setForceRegionEnabled(`String` regionName, `bool` enabled)

Enables or disables the specified force region.

---

#### `void` vehicle.setDamageSourceEnabled(`String` damageSourceName, `bool` enabled)

Enables or disables the specified damage source.

---

#### `void` vehicle.destroy()

Destroys the vehicle.

 ---- 
# widget.md
# widget

The `widget` table contains functions to manipulate and get data about widgets in a scriptpane.

The widgetName passed into most of these functions can contain period separators for getting children.

Example:
```
widget.getPosition("itemScrollArea.itemList.1.name")
```

## General callbacks

These callbacks are available for all widgets.

---

#### `void` widget.playSound(`String` audio, [`int` loops = 0], [`float` volume = 1.0f])

Plays a sound.

---

#### `Vec2I` widget.getPosition(`String` widgetName)

Returns the position of a widget.

---

#### `void` widget.setPosition(`String` widgetName, `Vec2I` position)

Sets the position of a widget.

---

#### `Vec2I` widget.getSize(`String` widgetName)

Returns the size of a widget.

---

#### `void` widget.setSize(`String` widgetName, `Vec2I` size)

Sets the size of a widget.

---

#### `void` widget.setVisible(`String` widgetName, `bool` visible)

Sets the visibility of a widget.

---

#### `void` widget.active(`String` widgetName)

Returns whether the widget is visible.

---

#### `void` widget.focus(`String` widgetName)

Sets focus on the specified widget.

---

#### `void` widget.hasFocus(`String` widgetName)

Returns whether the specified widget is currently focused.

---

#### `void` widget.blur(`String` widgetName)

Unsets focus on the specified focused widget.

---

#### `Json` widget.getData(`String` widgetName)

Returns the arbitrary data value set for the widget.

---

#### `void` widget.setData(`String` widgetName, `Json` data)

Sets arbitrary data for the widget.
---

#### `String` widget.getChildAt(`Vec2I` screenPosition)

Returns the full name for any widget at screenPosition.

---

#### `bool` widget.inMember(`String` widgetName, `Vec2I` screenPosition)

Returns whether the widget contains the specified screenPosition.

---

#### `void` widget.addChild(`String` widgetName, `Json` childConfig, [`String` childName])

Creates a new child widget with the specified config and adds it to the specified widget, optionally with the specified name.

---

#### `void` widget.removeAllChildren(`String` widgetName)

Removes all child widgets of the specified widget.

---

#### `void` widget.removeChild(`String` widgetName, `String` childName)

Removes the specified child widget from the specified widget.

---

## Widget specific callbacks

These callbacks only work for some widget types.

---

#### `String` widget.getText(`String` widgetName)

Returns the text set in a TextBoxWidget.

---

#### `void` widget.setText(`String` widgetName, `String` text)

Sets the text of: LabelWidget, ButtonWidget, TextBoxWidget

---

#### `void` widget.setFontColor(`String` widgetName, `Color` color)

Sets the font color of: LabelWidget, ButtonWidget, TextBoxWidget

---

#### `void` widget.setImage(`String` widgetName, `String` imagePath)

Sets the image of an ImageWidget.

---

#### `void` widget.setImageScale(`String` widgetName, `float` imageScale)

Sets the scale of an ImageWidget.

---

#### `void` widget.setImageRotation(`String` widgetName, `float` imageRotation)

Sets the rotation of an ImageWidget.

---

#### `void` widget.setButtonEnabled(`String` widgetName, `bool` enabled)

Sets whether the ButtonWidget should be enabled.

---

#### `void` widget.setButtonImage(`String` widgetName, `String` baseImage)

Sets the baseImage of a ButtonWidget.

---

#### `void` widget.setButtonImages(`String` widgetName, `Json` imageSet)

Sets the full image set of a ButtonWidget.

```
{
  base = "image.png",
  hover = "image.png",
  pressed = "image.png",
  disabled = "image.png",
}
```

---

#### `void` widget.setButtonCheckedImages(`String` widgetName, `Json` imageSet)

Similar to widget.setButtonImages, but sets the images used for the checked state of a checkable ButtonWidget.

---

#### `void` widget.setButtonOverlayImage(`String` widgetName, `String` overlayImage)

Sets the overlay image of a ButtonWidget.

---

#### `bool` widget.getChecked(`String` widgetName)

Returns whether the ButtonWidget is checked.

---

#### `void` widget.setChecked(`String` widgetName, `bool` checked)

Sets whether a ButtonWidget is checked

---

#### `int` widget.getSelectedOption(`String` widgetName)

Returns the index of the selected option in a ButtonGroupWidget.

---

#### `int` widget.getSelectedData(`String` widgetName)

Returns the data of the selected option in a ButtonGroupWidget. Nil if no option is selected.

---

#### `void` widget.setSelectedOption(`String` widgetName, `int` index)

Sets the selected option index of a ButtonGroupWidget.

---

#### `void` widget.setOptionEnabled(`String` widgetName, `int` index, `bool` enabled)

Sets whether a ButtonGroupWidget option should be enabled.

---

#### `void` widget.setOptionVisible(`String` widgetName, `int` index, `bool`, visible)

Sets whether a ButtonGroupWidget option should be visible.

---

#### `void` widget.setProgress(`String` widgetName, `float` value)

Sets the progress of a ProgressWidget. Value should be between 0.0 and 1.0.

---

#### `void` widget.setSliderEnabled(`String` widgetName, `bool` enabled)

Sets whether the SliderBarWidget should be enabled.

---

#### `float` widget.getSliderValue(`String` widgetName)

Gets the current value of a SliderBarWidget.

---

#### `void` widget.setSliderValue(`String` widgetName, `int` newValue)

Sets the current value of a SliderBarWidget.

---

#### `void` widget.getSliderRange(`String` widgetName, `int` newMin, `int` newMax, [`int` newDelta])

Sets the minimum, maximum and (optionally) delta values of a SliderBarWidget.

---

#### `void` widget.clearListItems(`String` widgetName)

Clears all items in a ListWidget.

---

#### `String` widget.addListItem(`String` widgetName)

Adds a list item to a ListWidget using the configured template, and returns the name of the added list item.

---

#### `void` widget.removeListItem(`String` widgetName, `size_t` at)

Removes a list item from a ListWidget at a specific index.

---

#### `String` widget.getListSelected(`String` widgetName)

Returns the name of the currently selected widget in a ListWidget.

---

#### `void` widget.setListSelected(`String` widgetName, `String` selected)

Sets the selected widget of a ListWidget.

---

#### `void` widget.registerMemberCallback(`String` widgetName, `String` callbackName, `LuaFunction` callback)

Registers a member callback for a ListWidget's list items to use.

---

#### `ItemBag` widget.itemGridItems(`String` widgetName)

Returns the full item bag contents of an ItemGridWidget.

---

#### `ItemDescriptor` widget.itemSlotItem(`String` widgetName)

Returns the descriptor of the item in the specified item slot widget.

---

#### `void` widget.setItemSlotItem(`String` widgetName, `Json` itemDescriptor)

Sets the item in the specified item slot widget.

---

#### `void` widget.setItemSlotProgress(`String` widgetName, `float` progress)

Sets the progress overlay on the item slot to the specified value (between 0 and 1).

---

#### `CanvasWidget` widget.bindCanvas(`String` widgetName)

Binds the canvas widget with the specified name as userdata for easy access. The `CanvasWidget` has the following methods:

##### `Vec2I` size()

Returns the size of the canvas.

##### `void` clear()

Clears the canvas.

##### `Vec2I` mousePosition()

Returns the mouse position relative to the canvas.

##### `void` drawImage(`String` image, `Vec2F` position, [`float` scale], [`Color` color], [`bool` centered])

Draws an image to the canvas.

##### `void` drawImageDrawable(`String` image, `Vec2F` position, [`Variant<Vec2F, float>` scale], [`Color` color], [`float` rotation])

Draws an image to the canvas, centered on position, with slightly different options.

##### `void` drawImageRect(`String` texName, `RectF` texCoords, `RectF` screenCoords, [`Color` color])

Draws a rect section of a texture to a rect section of the canvas.

##### `void` drawTiledImage(`String` image, `Vec2F` offset, `RectF` screenCoords, [`float` scale], [`Color` color])

Draws an image tiled (and wrapping) within the specified screen area.

##### `void` drawLine(`Vec2F` start, `Vec2F` end, [`Color` color], [`float` lineWidth])

Draws a line on the canvas.

##### `void` drawRect(`RectF` rect, `Color` color)

Draws a filled rectangle on the canvas.

##### `void` drawPoly(`PolyF` poly, `Color` color, [`float` lineWidth])

Draws a polygon on the canvas.

##### `void` drawTriangles(`List<PolyF>` triangles, [`Color` color])

Draws a list of filled triangles to the canvas.

##### `void` drawText(`String` text, `Json` textPositioning, `unsigned` fontSize, [`Color` color])

Draws text on the canvas. textPositioning is in the format:

```lua
{
  position = {0, 0}
  horizontalAnchor = "left", -- left, mid, right
  verticalAnchor = "top", -- top, mid, bottom
  wrapWidth = nil -- wrap width in pixels or nil
}
```

 ---- 
# world.md
The `world` table contains functions that perform actions within a specified such as querying or modifying entities, tiles, etc. in that world.

---

#### `String` world.type()

Returns a string describing the world's type. For terrestrial worlds this will be the primary biome, for instance worlds this will be the instance name, and for ship or generic worlds this will be 'unknown'.

---

#### `bool` world.terrestrial()

Returns a `true` if the current world is a terrestrial world, i.e. a planet, and `false` otherwise.

---

#### `Vec2I` world.size()

Returns a vector describing the size of the current world.

---

#### `float` world.magnitude(`Vec2F` position1, `Vec2F` position2)

Returns the magnitude of the distance between the specified world positions. Use this rather than simple vector subtraction to handle world wrapping.

---

#### `Vec2F` world.distance(`Vec2F` position1, `Vec2F` position2)

Returns the vector difference between the specified world positions. Use this rather than simple vector subtraction to handle world wrapping.

---

#### `bool` world.polyContains(`PolyF` poly, `Vec2F` position)

Returns `true` if the specified poly contains the specified position in world space and `false` otherwise.

---

#### `Vec2F` world.xwrap(`Vec2F` position)

Returns the specified position with its X coordinate wrapped around the world width.

#### `float` world.xwrap(`float` xPosition)

Returns the specified X position wrapped around the world width.

---

#### `Variant<Vec2F, float>` world.nearestTo(`Variant<Vec2F, float>` sourcePosition, `Variant<Vec2F, float>` targetPosition)

Returns the point nearest to (i.e. on the same side of the world as) the source point. Either argument can be specified as a `Vec2F` point or as a `float` X position. The type of the targetPosition determines the return type.

---

#### `bool` world.pointCollision(`Vec2F` point, [`CollisionSet` collisionKinds])

Returns `true` if the generated collision geometry at the specified point matches any of the specified collision kinds and `false` otherwise.

---

#### `bool` world.pointTileCollision(`Vec2F` point, [`CollisionSet` collisionKinds])

Returns `true` if the tile at the specified point matches any of the specified collision kinds and `false` otherwise.

---

#### `Tuple<Maybe<Vec2F>, Maybe<Vec2F>>` world.lineCollision(`Vec2F` startPoint, `Vec2F` endPoint, [`CollisionSet` collisionKinds])

If the line between the specified points overlaps any generated collision geometry of the specified collision kinds, returns the point at which the line collides, or `nil` if the line does not collide. If intersecting a side of the poly, also returns the normal of the intersected side as a second return.

---

#### `bool` world.lineTileCollision(`Vec2F` startPoint, `Vec2F` endPoint, [`CollisionSet` collisionKinds])

Returns `true` if the line between the specified points overlaps any tiles of the specified collision kinds and `false` otherwise.

---

#### `Maybe<pair<Vec2F, Vec2F>>` world.lineTileCollisionPoint(`Vec2F` startPoint, `Vec2F` endPoint, [`CollisionSet` collisionKinds])

Returns a table of {`position`, `normal`} where `position` is the position that the line intersects the first collidable tile, and `normal` is the collision normal. Returns `nil` if no tile is intersected.

---

#### `bool` world.rectCollision(`RectF` rect, [`CollisionSet` collisionKinds])

Returns `true` if the specified rectangle overlaps any generated collision geometry of the specified collision kinds and `false` otherwise.

---

#### `bool` world.rectTileCollision(`RectF` rect, [`CollisionSet` collisionKinds])

Returns `true` if the specified rectangle overlaps any tiles of the specified collision kinds and `false` otherwise.

---

#### `bool` world.polyCollision(`PolyF` poly, [`Vec2F` position], [`CollisionSet` collisionKinds])

Returns `true` if the specified polygon overlaps any generated collision geometry of the specified collision kinds and `false` otherwise. If a position is specified, the polygon coordinates will be treated as relative to that world position.

---

#### `List<Vec2I>` world.collisionBlocksAlongLine(`Vec2F` startPoint, `Vec2F` endPoint, [`CollisionSet` collisionKinds], [`int` maxReturnCount])

Returns an ordered list of tile positions along the line between the specified points that match any of the specified collision kinds. If maxReturnCount is specified, the function will only return up to that number of points.

---

#### `List<pair<Vec2I, LiquidLevel>>` world.liquidAlongLine(`Vec2F` startPoint, `Vec2F` endPoint)

Returns a list of pairs containing a position and a `LiquidLevel` for all tiles along the line between the specified points that contain any liquid.

---

#### `Vec2F` world.resolvePolyCollision(`PolyF` poly, `Vec2F` position, `float` maximumCorrection, [`CollisionSet` collisionKinds])

Attempts to move the specified poly (relative to the specified position) such that it does not collide with any of the specified collision kinds. Will only move the poly up to the distance specified by maximumCorrection. Returns `nil` if the collision resolution fails.

---

#### `bool` world.tileIsOccupied(`Vec2I` tilePosition, [`bool` foregroundLayer], [`bool` includeEphemeral])

Returns `true` if the specified tile position is occupied by a material or tile entity and `false` if it is empty. The check will be performed on the foreground tile layer if foregroundLayer is `true` (or unspecified) and the background tile layer if it is `false`. The check will include ephemeral tile entities such as preview objects if includeEphemeral is `true`, and will not include these entities if it is `false` (or unspecified).

---

#### `bool` world.placeObject(`String` objectName, `Vec2I` tilePosition, [`int` direction], [`Json` parameters])

Attempts to place the specified object into the world at the specified position, preferring it to be right-facing if direction is positive (or unspecified) and left-facing if it is negative. If parameters are specified they will be applied to the object. Returns `true` if the object is placed successfully and `false` otherwise.

---

#### `EntityId` world.spawnItem(`ItemDescriptor` item, `Vec2F` position, [`unsigned` count], [`Json` parameters], [`Vec2F` velocity], [`float` intangibleTime])

Attempts to spawn the specified item into the world as the specified position. If item is specified as a name, it will optionally apply the specified count and parameters. The item drop entity can also be spawned with an initial velocity and intangible time (delay before it can be picked up) if specified. Returns an `EntityId` of the item drop if successful and `nil` otherwise.

---

#### `List<EntityId>` world.spawnTreasure(`Vec2F` position, `String` poolName, `float` level, [`unsigned` seed])

Attempts to spawn all items in an instance of the specified treasure pool with the specified level and seed at the specified world position. Returns a list of `EntityId`s of the item drops created if successful and `nil` otherwise.

---

#### `EntityId` world.spawnMonster(`String` monsterType, `Vec2F` position, [`Json` parameters])

Attempts to spawn a monster of the specified type at the specified position. If parameters are specified they will be applied to the spawned monster. If they are unspecified, they default to an object setting aggressive to be randomly `true` or `false`. Level for the monster may be specified in parameters. Returns the `EntityId` of the spawned monster if successful and `nil` otherwise.

---

#### `EntityId` world.spawnNpc(`Vec2F` position, `String` species, `String` npcType, `float` level, [`unsigned` seed], [`Json` parameters])

Attempts to spawn an NPC of the specified type, species, level with the specified seed and parameters at the specified position. Returns `EntityId` of the spawned NPC if successful and `nil` otherwise.

---

#### `EntityId` world.spawnStagehand(`Vec2F` position, `String` type, [`Json` overrides])

Attempts to spawn a stagehand of the specified type at the specified position with the specified override parameters. Returns `EntityId` of the spawned stagehand if successful and `nil` otherwise.

---

#### `EntityId` world.spawnProjectile(`String` projectileName, `Vec2F` position, [`EntityId` sourceEntityId], [`Vec2F` direction], [`bool` trackSourceEntity], [`Json` parameters])

Attempts to spawn a projectile of the specified type at the specified position with the specified source entity id, direction, and parameters. If trackSourceEntity is `true` then the projectile's position will be locked relative to its source entity's position. Returns the `EntityId` of the spawned projectile if successful and `nil` otherwise.

---

#### `EntityId` world.spawnVehicle(`String` vehicleName, `Vec2F` position, [`Json` overrides])

Attempts to spawn a vehicle of the specified type at the specified position with the specified override parameters. Returns the `EntityId` of the spawned vehicle if successful and `nil` otherwise.

---

#### `float` world.threatLevel()

Returns the threat level of the current world.

---

#### `double` world.time()

Returns the absolute time of the current world.

---

#### `unsigned` world.day()

Returns the absolute numerical day of the current world.

---

#### `double` world.timeOfDay()

Returns a value between 0 and 1 indicating the time within the day of the current world.

---

#### `float` world.dayLength()

Returns the duration of a day on the current world.

---

#### `Json` world.getProperty(`String` propertyName, [`Json` defaultValue])

Returns the JSON value of the specified world property, or defaultValue or `nil` if it is not set.

---

#### `void` world.setProperty(`String` propertyName, `Json` value)

Sets the specified world property to the specified value.

---

#### `LiquidLevel` world.liquidAt(`Vec2I` position)

Returns the `LiquidLevel` at the specified tile position, or `nil` if there is no liquid.

#### `LiquidLevel` world.liquidAt(`RectF` region)

Returns the average `LiquidLevel` of the most plentiful liquid within the specified region, or `nil` if there is no liquid.

---

#### `float` world.gravity(`Vec2F` position)

Returns the gravity at the specified position. This should be consistent for all non-dungeon tiles in a world but can be altered by dungeons.

---

#### `bool` world.spawnLiquid(`Vec2F` position, `LiquidId` liquid, `float` quantity)

Attempts to place the specified quantity of the specified liquid at the specified position. Returns `true` if successful and `false` otherwise.

---

#### `LiquidLevel` world.destroyLiquid(`Vec2F` position)

Removes any liquid at the specified position and returns the LiquidLevel containing the type and quantity of liquid removed, or `nil` if no liquid is removed.

---

#### `bool` world.isTileProtected(`Vec2F` position)

Returns `true` if the tile at the specified position is protected and `false` otherwise.

---

#### `PlatformerAStar::Path` world.findPlatformerPath(`Vec2F` startPosition, `Vec2F` endPosition, `ActorMovementParameters` movementParameters, `PlatformerAStar::Parameters` searchParameters)

Attempts to synchronously pathfind between the specified positions using the specified movement and pathfinding parameters. Returns the path as a list of nodes as successful, or `nil` if no path is found.

---

#### `PlatformerAStar::PathFinder` world.platformerPathStart(`Vec2F` startPosition, `Vec2F` endPosition, `ActorMovementParameters` movementParameters, `PlatformerAStar::Parameters` searchParameters)

Creates and returns a Lua UserData value which can be used for pathfinding over multiple frames. The `PathFinder` returned has the following two methods:

##### `bool` explore([`int` nodeLimit])

Explores the path up to the specified node count limit. Returns `true` if the pathfinding is complete and `false` if it is still incomplete. If nodeLimit is unspecified, this will search up to the configured maximum number of nodes, making it equivalent to world.platformerPathStart.

##### `PlatformerAStar::Path` result()

Returns the completed path.

---

#### `float` world.lightLevel(`Vec2F` position)

Returns the current logical light level at the specified position. Requires recalculation of lighting, so this should be used sparingly.

---

#### `float` world.windLevel(`Vec2F` position)

Returns the current wind level at the specified position.

---

#### `bool` world.breathable(`Vec2F` position)

Returns `true` if the world is breathable at the specified position and `false` otherwise.

---

#### `List<String>` world.environmentStatusEffects(`Vec2F` position)

Returns a list of the environmental status effects at the specified position.

---

#### `bool` world.underground(`Vec2F` position)

Returns `true` if the specified position is below the world's surface level and `false` otherwise.

---

#### `bool` world.inSurfaceLayer(`Vec2I` position)

Returns `true` if the world is terrestrial and the specified position is within its surface layer, and `false` otherwise.

#### `float` world.surfaceLevel()

Returns the surface layer base height.

---

#### `int` world.oceanLevel(`Vec2I` position)

If the specified position is within a region that has ocean (endless) liquid, returns the world Y level of that ocean's surface, or 0 if there is no ocean in the specified region.

---

#### `Variant<String, bool>` world.material(`Vec2F` position, `String` layerName)

Returns the name of the material at the specified position and layer. Layer can be specified as 'foreground' or 'background'. Returns `false` if the space is empty in that layer. Returns `nil` if the material is NullMaterial (e.g. if the position is in an unloaded sector).

---

#### `String` world.mod(`Vec2F` position, `String` layerName)

Returns the name of the mod at the specified position and layer, or `nil` if there is no mod.

---

#### `float` world.materialHueShift(`Vec2F` position, `String` layerName)

Returns the hue shift of the material at the specified position and layer.

---

#### `float` world.modHueShift(`Vec2F` position, `String` layerName)

Returns the hue shift of the mod at the specified position and layer.

---

#### `unsigned` world.materialColor(`Vec2F` position, `String` layerName)

Returns the color variant (painted color) of the material at the specified position and layer.

---

#### `void` world.setMaterialColor(`Vec2F` position, `String` layerName, `unsigned` color)

Sets the color variant of the material at the specified position and layer to the specified color.

---

#### `bool` world.damageTiles(`List<Vec2I>` positions, `String` layerName, `Vec2F` sourcePosition, `String` damageType, `float` damageAmount, [`unsigned` harvestLevel], [`EntityId` sourceEntity])

Damages all tiles in the specified layer and positions by the specified amount. The source position of the damage determines the initial direction of the damage particles. Damage types are: "plantish", "blockish", "beamish", "explosive", "fire", "tilling". Harvest level determines whether destroyed materials or mods will drop as items. Returns `true` if any damage was done and `false` otherwise.

---

#### `bool` world.damageTileArea(`Vec2F` center, `float` radius, `String` layerName, `Vec2F` sourcePosition, `String` damageType, `float` damageAmount, [`unsigned` harvestLevel, [`EntityId` sourceEntity)

Identical to world.damageTiles but applies to tiles in a circular radius around the specified center point.

---

#### `List<Vec2I>` world.radialTileQuery(`Vec2F` position, `float` radius, `String` layerName)

Returns a list of existing tiles within `radius` of the given position, on the specified tile layer.

---

#### `bool` world.placeMaterial(`Vec2I` position, `String` layerName, `String` materialName, [`int` hueShift], [`bool` allowOverlap])

Attempts to place the specified material in the specified position and layer. If allowOverlap is `true` the material can be placed in a space occupied by mobile entities, otherwise such placement attempts will fail. Returns `true` if the placement succeeds and `false` otherwise.

---

#### `bool` world.placeMod(`Vec2I` position, `String` layerName, `String` modName, [`int` hueShift], [`bool` allowOverlap])

Attempts to place the specified mod in the specified position and layer. If allowOverlap is `true` the mod can be placed in a space occupied by mobile entities, otherwise such placement attempts will fail. Returns `true` if the placement succeeds and `false` otherwise.

---

#### `List<EntityId>` world.entityQuery(`Vec2F` position, `Variant<Vec2F, float` positionOrRadius, [`Json` options])

Queries for entities in a specified area of the world and returns a list of their entity ids. Area can be specified either as the `Vec2F` lower left and upper right positions of a rectangle, or as the `Vec2F` center and `float` radius of a circular area. The following additional parameters can be specified in options:

* __withoutEntityId__ - Specifies an `EntityId` that will be excluded from the returned results
* __includedTypes__ - Specifies a list of one or more `String` entity types that the query will return. In addition to standard entity type names, this list can include "mobile" for all mobile entity types or "creature" for players, monsters and NPCs.
* __boundMode__ - Specifies the bounding mode for determining whether entities fall within the query area. Valid options are "position", "collisionarea", "metaboundbox". Defaults to "collisionarea" if unspecified.
* __order__ - A `String` used to specify how the results will be ordered. If this is set to "nearest" the entities will be sorted by ascending distance from the first positional argument. If this is set to "random" the list of results will be shuffled.
* __callScript__ - Specifies a `String` name of a function that should be called in the script context of all scripted entities matching the query.
* __callScriptArgs__ - Specifies a list of arguments that will be passed to the function called by callScript.
* __callScriptResult__ - Specifies a `LuaValue` that the function called by callScript must return; entities whose script calls do not return this value will be excluded from the results. Defaults to `true`.

---

#### `List<EntityId>` world.monsterQuery(`Vec2F` position, `Variant<Vec2F, float` positionOrRadius, [`Json` options])

Identical to world.entityQuery but only considers monsters.

---

#### `List<EntityId>` world.npcQuery(`Vec2F` position, `Variant<Vec2F, float` positionOrRadius, [`Json` options])

Identical to world.entityQuery but only considers NPCs.

---

#### `List<EntityId>` world.objectQuery(`Vec2F` position, `Variant<Vec2F, float` positionOrRadius, [`Json` options])

Similar to world.entityQuery but only considers objects. Allows an additional option, __name__, which specifies a `String` object type name and will only return objects of that type.

---

#### `List<EntityId>` world.itemDropQuery(`Vec2F` position, `Variant<Vec2F, float` positionOrRadius, [`Json` options])

Identical to world.entityQuery but only considers item drops.

---

#### `List<EntityId>` world.playerQuery(`Vec2F` position, `Variant<Vec2F, float` positionOrRadius, [`Json` options])

Identical to world.entityQuery but only considers players.

---

#### `List<EntityId>` world.loungeableQuery(`Vec2F` position, `Variant<Vec2F, float` positionOrRadius, [`Json` options])

Similar to world.entityQuery but only considers loungeable entities. Allows an additional option, __orientation__, which specifies the `String` name of a loungeable orientation ("sit", "lay" or "stand") and only returns loungeable entities which use that orientation.

---

#### `List<EntityId>` world.entityLineQuery(`Vec2F` startPosition, `Vec2F` endPosition, [`Json` options])

Similar to world.entityQuery but only returns entities that intersect the line between the specified positions.

---

#### `List<EntityId>` world.objectLineQuery(`Vec2F` startPosition, `Vec2F` endPosition, [`Json` options])

Identical to world.entityLineQuery but only considers objects.

---

#### `List<EntityId>` world.npcLineQuery(`Vec2F` startPosition, `Vec2F` endPosition, [`Json` options])

Identical to world.entityLineQuery but only considers NPCs.

---

#### `EntityId` world.objectAt(`Vec2I` tilePosition)

Returns the entity id of any object occupying the specified tile position, or `nil` if the position is not occupied by an object.

---

#### `bool` world.entityExists(`EntityId` entityId)

Returns `true` if an entity with the specified id exists in the world and `false` otherwise.

---

#### `DamageTeam` world.entityDamageTeam(`EntityId` entityId)

Returns the current damage team (team type and team number) of the specified entity, or `nil` if the entity doesn't exist.

---

#### `bool` world.entityCanDamage(`EntityId` sourceId, `EntityId` targetId)

Returns `true` if the specified source entity can damage the specified target entity using their current damage teams and `false` otherwise.

---

#### `bool` world.entityAggressive(`EntityId` entity)

Returns `true` if the specified entity is an aggressive monster or NPC and `false` otherwise.

---

#### `String` world.entityType(`EntityId` entityId)

Returns the entity type name of the specified entity, or `nil` if the entity doesn't exist.

---

#### `Vec2F` world.entityPosition(`EntityId` entityId)

Returns the current world position of the specified entity, or `nil` if the entity doesn't exist.

---

#### `Vec2F` world.entityMouthPosition(`EntityId` entityId)

Returns the current world mouth position of the specified player, monster, NPC or object, or `nil` if the entity doesn't exist or isn't a valid type.

---

#### `Vec2F` world.entityVelocity(`EntityId` entityId)

Returns the current velocity of the entity if it is a vehicle, monster, NPC or player and `nil` otherwise.

---

#### `Vec2F` world.entityMetaBoundBOx(`EntityId` entityId)

Returns the meta bound box of the entity, if any.

---

#### `unsigned` world.entityCurrency(`EntityId` entityId, `String` currencyType)

Returns the specified player entity's stock of the specified currency type, or `nil` if the entity is not a player.

---

#### `unsigned` world.entityHasCountOfItem(`EntityId` entityId, `Json` itemDescriptor, [`bool` exactMatch])

Returns the nubmer of the specified item that the specified player entity is currently carrying, or `nil` if the entity is not a player. If exactMatch is `true` then parameters as well as item name must match.

NOTE: This function currently does not work correctly over the network, making it inaccurate when not used from client side scripts such as status.

---

#### `Vec2F` world.entityHealth(`EntityId` entityId)

Returns a `Vec2F` containing the specified entity's current and maximum health if the entity is a player, monster or NPC and `nil` otherwise.

---

#### `String` world.entitySpecies(`EntityId` entityId)

Returns the name of the specified entity's species if it is a player or NPC and `nil` otherwise.

---

#### `String` world.entityGender(`EntityId` entityId)

Returns the name of the specified entity's gender if it is a player or NPC and `nil` otherwise.

---

#### `String` world.entityName(`EntityId` entityId)

Returns a `String` name of the specified entity which has different behavior for different entity types. For players, monsters and NPCs, this will be the configured name of the specific entity. For objects or vehicles, this will be the name of the object or vehicle type. For item drops, this will be the name of the contained item.

---

#### `String` world.entityTypeName(`EntityId` entityId)

Similar to world.entityName but returns the names of configured types for NPCs and monsters.

---

#### `String` world.entityDescription(`EntityId` entityId, [`String` species])

Returns the configured description for the specified inspectable entity (currently only objects and plants support this). Will return a species-specific description if species is specified and a generic description otherwise.

---

#### `JsonArray` world.entityPortrait(`EntityId` entityId, `String` portraitMode)

Generates a portrait of the specified entity in the specified portrait mode and returns a list of drawables, or `nil` if the entity is not a portrait entity.

---

#### `String` world.entityHandItem(`EntityId` entityId, `String` handName)

Returns the name of the item held in the specified hand of the specified player or NPC, or `nil` if the entity is not holding an item or is not a player or NPC. Hand name should be specified as "primary" or "alt".

---

#### `ItemDescriptor` world.entityHandItemDescriptor(`EntityId` entityId, `String` handName)

Similar to world.entityHandItem but returns the full descriptor of the item rather than the name.


---

### `ItemDescriptor` world.itemDropItem(`EntityId` entityId)

Returns the item descriptor of an item drop's contents.

---

### `Maybe<List<MaterialId>>` world.biomeBlocksAt(`Vec2I` position)

Returns the list of biome specific blocks that can place in the biome at the specified position.

---

#### `String` world.entityUniqueId(`EntityId` entityId)

Returns the unique id of the specified entity, or `nil` if the entity does not have a unique id.

---

#### `Json` world.getNpcScriptParameter(`EntityId` entityId, `String` parameterName, [`Json` defaultValue])

Returns the value of the specified NPC's variant script config parameter, or defaultValue or `nil` if the parameter is not set or the entity is not an NPC.

---

#### `Json` world.getObjectParameter(`EntityId` entityId, `String` parameterName, [`Json` defaultValue])

Returns the value of the specified object's config parameter, or defaultValue or `nil` if the parameter is not set or the entity is not an object.

---

#### `List<Vec2I>` world.objectSpaces(`EntityId` entityId)

Returns a list of tile positions that the specified object occupies, or `nil` if the entity is not an object.

---

#### `int` world.farmableStage(`EntityId` entityId)

Returns the current growth stage of the specified farmable object, or `nil` if the entity is not a farmable object.

---

#### `int` world.containerSize(`EntityId` entityId)

Returns the total capacity of the specified container, or `nil` if the entity is not a container.

---

#### `bool` world.containerClose(`EntityId` entityId)

Visually closes the specified container. Returns `true` if the entity is a container and `false` otherwise.

---

#### `bool` world.containerOpen(`EntityId` entityId)

Visually opens the specified container. Returns `true` if the entity is a container and `false` otherwise.

---

#### `JsonArray` world.containerItems(`EntityId` entityId)

Returns a list of pairs of item descriptors and container positions of all items in the specified container, or `nil` if the entity is not a container.

---

#### `ItemDescriptor` world.containerItemAt(`EntityId` entityId, `unsigned` offset)

Returns an item descriptor of the item at the specified position in the specified container, or `nil` if the entity is not a container or the offset is out of range.

---

#### `bool` world.containerConsume(`EntityId` entityId, `ItemDescriptor` item)

Attempts to consume items from the specified container that match the specified item descriptor and returns `true` if successful, `false` if unsuccessful, or `nil` if the entity is not a container. Only succeeds if the full count of the specified item can be consumed.

---

#### `bool` world.containerConsumeAt(`EntityId` entityId, `unsigned` offset, `unsigned` count)

Similar to world.containerConsume but only considers the specified slot within the container.

---

#### `unsigned` world.containerAvailable(`EntityId` entityId, `ItemDescriptor` item)

Returns the number of the specified item that are currently available to consume in the specified container, or `nil` if the entity is not a container.

---

#### `JsonArray` world.containerTakeAll(`EntityId` entityId)

Similar to world.containerItems but consumes all items in the container.

---

#### `ItemDescriptor` world.containerTakeAt(`EntityId` entityId, `unsigned` offset)

Similar to world.containerItemAt, but consumes all items in the specified slot of the container.

---

#### `ItemDescriptor` world.containerTakeNumItemsAt(`EntityId` entityId, `unsigned` offset, `unsigned` count)

Similar to world.containerTakeAt, but consumes up to (but not necessarily equal to) the specified count of items from the specified slot of the container and returns only the items consumed.

---

#### `unsigned` world.containerItemsCanFit(`EntityId` entityId, `ItemDescriptor` item)

Returns the number of times the specified item can fit in the specified container, or `nil` if the entity is not a container.

---

#### `Json` world.containerItemsFitWhere(`EntityId` entityId, `ItemDescriptor` items)

Returns a JsonObject containing a list of "slots" the specified item would fit and the count of "leftover" items that would remain after attempting to add the items. Returns `nil` if the entity is not a container.

---

#### `ItemDescriptor` world.containerAddItems(`EntityId` entityId, `ItemDescriptor` items)

Adds the specified items to the specified container. Returns the leftover items after filling the container, or all items if the entity is not a container.

---

#### `ItemDescriptor` world.containerStackItems(`EntityId` entityId, `ItemDescriptor` items)

Similar to world.containerAddItems but will only combine items with existing stacks and will not fill empty slots.

---

#### `ItemDescriptor` world.containerPutItemsAt(`EntityId` entityId, `ItemDescriptor` items, `unsigned` offset)

Similar to world.containerAddItems but only considers the specified slot in the container.

---

#### `ItemDescriptor` world.containerItemApply(`EntityId` entityId, `ItemDescriptor` items, `unsigned` offset)

Attempts to combine the specified items with the current contents (if any) of the specified container slot and returns any items unable to be placed into the slot.

---

#### `ItemDescriptor` world.containerSwapItemsNoCombine(`EntityId` entityId, `ItemDescriptor` items, `unsigned` offset)

Places the specified items into the specified container slot and returns the previous contents of the slot if successful, or the original items if unsuccessful.

---

#### `ItemDescriptor` world.containerSwapItems(`EntityId` entityId, `ItemDescriptor` items, `unsigned` offset)

A combination of world.containerItemApply and world.containerSwapItemsNoCombine that attempts to combine items before swapping and returns the leftovers if stacking was successful or the previous contents of the container slot if the items did not stack.

---

#### `LuaValue` world.callScriptedEntity(`EntityId` entityId, `String` functionName, [`LuaValue` args ...])

Attempts to call the specified function name in the context of the specified scripted entity with the specified arguments and returns the result. This method is synchronous and thus can only be used on local master entities, i.e. scripts run on the server may only call scripted entities that are also server-side master and scripts run on the client may only call scripted entities that are client-side master on that client. For more featureful entity messaging, use world.sendEntityMessage.

---

#### `RpcPromise<Json>` world.sendEntityMessage(`Variant<EntityId, String>` entityId, `String` messageType, [`LuaValue` args ...])

Sends an asynchronous message to an entity with the specified entity id or unique id with the specified message type and arguments and returns an `RpcPromise` which can be used to receive the result of the message when available. See the message table for information on entity message handling. This function __should not be called in any entity's init function__ as the sending entity will not have been fully loaded.

---

#### `RpcPromise<Vec2F>` world.findUniqueEntity(`String` uniqueId)

Attempts to find an entity on the server by unique id and returns an `RpcPromise` that can be used to get the position of that entity if successful.

---

#### `bool` world.loungeableOccupied(`EntityId` entityId)

Checks whether the specified loungeable entity is currently occupied and returns `true` if it is occupied, `false` if it is unoccupied, or `nil` if it is not a loungeable entity.

---

#### `bool` world.isMonster(`EntityId` entityId, [`bool` aggressive])

Returns `true` if the specified entity exists and is a monster and `false` otherwise. If aggressive is specified, will return `false` unless the monster's aggressive state matches the specified value.

---

#### `String` world.monsterType(`EntityId` entityId)

Returns the monster type of the specified monster, or `nil` if the entity is not a monster.

---

#### `bool` world.isNpc(`EntityId` entityId, [`int` damageTeam])

Returns `true` if the specified entity exists and is an NPC and `false` otherwise. If damageTeam is specified, will return `false` unless the NPC's damage team number matches the specified value.

---

#### `bool` world.isEntityInteractive(`EntityId` entityId)

Returns `true` if an entity with the specified id is player interactive and `false` otherwise.

---

#### `String` world.npcType(`EntityId` entityId)

Returns the NPC type of the specified NPC, or `nil` if the entity is not an NPC.

---

#### `String` world.stagehandType(`EntityId` entityId)

Returns the stagehand type of the specified stagehand, or `nil` if the entity is not a stagehand.

---

#### `void` world.debugPoint(`Vec2F` position, `Color` color)

Displays a point visible in debug mode at the specified world position.

---

#### `void` world.debugLine(`Vec2F` startPosition, `Vec2F` endPosition, `Color` color)

Displayes a line visible in debug mode between the specified world positions.

---

#### `void` world.debugPoly(`PolyF` poly, `Color` color)

Displays a polygon consisting of the specified points that is visible in debug mode.

---

#### `void` world.debugText(`String` formatString, [`LuaValue` formatValues ...], `Vec2F` position, `Color` color)

Displays text visible in debug mode at the specified position using the specified format string and optional formatted values.

---

The following additional world bindings are available only for scripts running on the server.

---

#### `bool` world.breakObject(`EntityId` entityId, `bool` smash)

Breaks the specified object and returns `true` if successful and `false` otherwise. If smash is `true` the object will not (by default) drop any items.

---

#### `bool` world.isVisibleToPlayer(`RectF` region)

Returns `true` if any part of the specified region overlaps any player's screen area and `false` otherwise.

---

#### `bool` world.loadRegion(`RectF` region)

Attempts to load all sectors overlapping the specified region and returns `true` if all sectors are fully loaded and `false` otherwise.

---

#### `bool` world.regionActive(`RectF` region)

Returns `true` if all sectors overlapping the specified region are fully loaded and `false` otherwise.

---

#### `void` world.setTileProtection(`DungeonId` dungeonId, `bool` protected)

Enables or disables tile protection for the specified dungeon id.

---

#### `DungeonId` world.dungeonId(`Vec2F` position)

Returns the dungeon id at the specified world position.

---

#### `DungeonId` world.setDungeonId(`RectI` tileArea, `DungeonId` dungeonId)

Sets the dungeonId of all tiles within the specified area.

---

#### `Promise<Vec2I>` world.enqueuePlacement(`List<Json>` distributionConfigs, [`DungeonId` id])

Enqueues a biome distribution config for placement through world generation. The returned promise is fulfilled with the position of the placement, once it has been placed.

---

#### `bool` world.isPlayerModified(`RectI` region)

Returns `true` if any tile within the specified region has been modified (placed or broken) by a player and `false` otherwise.

---

#### `LiquidLevel` world.forceDestroyLiquid(`Vec2F` position)

Identical to world.destroyLiquid but ignores tile protection.

---

#### `EntityId` world.loadUniqueEntity(`String` uniqueId)

Forces (synchronous) loading of the specified unique entity and returns its non-unique entity id or 0 if no such unique entity exists.

---

#### `void` world.setUniqueId(`EntityId` entityId, [`String` uniqueId])

Sets the unique id of the specified entity to the specified unique id or clears it if no unique id is specified.

---

#### `ItemDescriptor` world.takeItemDrop(`EntityId` targetEntityId, [`EntityId` sourceEntityId])

Takes the specified item drop and returns an `ItemDescriptor` of its contents or `nil` if the operation fails. If a source entity id is specified, the item drop will briefly animate toward that entity.

---

#### `void` world.setPlayerStart(`Vec2F` position, [`bool` respawnInWorld])

Sets the world's default beam-down point to the specified position. If respawnInWorld is set to `true` then players who die in that world will respawn at the specified start position rather than being returned to their ships.

---

#### `List<EntityId>` world.players()

Returns a list of the entity ids of all players currently in the world.

---

#### `String` world.fidelity()

Returns the name of the fidelity level at which the world is currently running. See worldserver.config for fidelity configuration.

---

#### `String` world.flyingType()

Returns the current flight status of a ship world.

---

#### `String` world.warpPhase()

Returns the current warp phase of a ship world.

---

#### `void` world.setUniverseFlag(`String` flagName)

Sets the specified universe flag on the current universe.

---

#### `List<String>` world.universeFlags()

Returns a list of all universe flags set on the current universe.

---

#### `bool` world.universeFlagSet(`String` flagName)

Returns `true` if the specified universe flag is set and `false` otherwise.

---

#### `double` world.skyTime()

Returns the current time for the world's sky.

---

#### `void` world.setSkyTime(`double` time)

Sets the current time for the world's sky to the specified value.

---

#### `void` world.placeDungeon(`String` dungeonName, `Vec2I` position, [`DungeonId` dungeonId])

Generates the specified dungeon in the world at the specified position, ignoring normal dungeon anchoring rules. If a dungeon id is specified, it will be assigned to the dungeon.

---

#### `void` world.placeDungeon(`String` dungeonName, `Vec2I` position, [`DungeonId` dungeonId])

Generates the specified dungeon in the world at the specified position. Does not ignore anchoring rules, will fail if the dungeon can't be placed. If a dungeon id is specified, it will be assigned to the dungeon.

---

#### `void` world.addBiomeRegion(`Vec2I` position, `String` biomeName, `String` subBlockSelector, `int` width)

Adds a biome region to the world, centered on `position`, `width` blocks wide.

---

#### `void` world.expandBiomeRegion(`Vec2I` position, `int` width)

Expands the biome region currently at `position` by `width` blocks.

---

#### `void` world.pregenerateAddBiome(`Vec2I` position, `int` width)

Signals a region for asynchronous generation. The region signaled is the region that needs to be generated to add a biome region of `width` tiles to `position`.

---

#### `void` world.pregenerateExpandBiome(`Vec2I` position, `int` width)

Signals a region for asynchronous generation. The region signaled is the region that needs to be generated to expand the biome at `position` by `width` blocks.

---

#### `void` world.setLayerEnvironmentBiome(`Vec2I` position)

Sets the environment biome for a layer to the biome at `position`.

---

#### `void` world.setPlanetType(`String` planetType, `String`, primaryBiomeName)

Sets the planet type of the current world to `planetType` with primary biome `primaryBiomeName`.

---

#### `void` world.setDungeonGravity(`DungeonId` dungeonId, `Maybe<float>` gravity)

Sets the overriding gravity for the specified dungeon id, or returns it to the world default if unspecified.

---

#### `void` world.setDungeonBreathable(`DungeonId` dungeonId, `Maybe<bool>` breathable)

Sets the overriding breathability for the specified dungeon id, or returns it to the world default if unspecified.

 ---- 
