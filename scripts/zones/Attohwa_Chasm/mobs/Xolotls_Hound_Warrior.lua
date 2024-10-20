-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl's Hound Warrior
-- Note: Pet for Xolotl
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 32)
end

entity.onMobRoam = function(mob)
    local hour = VanadielHour()

    if hour >= 4 and hour < 20 then -- Despawn if its daytime
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
