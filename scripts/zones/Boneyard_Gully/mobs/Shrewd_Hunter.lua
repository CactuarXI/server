-----------------------------------
-- Area: Boneyard Gully
--  Mob: Shrewd Hunter
-----------------------------------
local ID = zones[xi.zone.BONEYARD_GULLY]
mixins = { require('scripts/mixins/families/antlion_ambush') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    -- Aggros via ambush, not superlinking
    mob:setMobMod(xi.mobMod.SUPERLINK, 0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

entity.onMobEngage = function(mob, target)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    for _, v in pairs(mob:getBattlefield():getPlayers()) do
        v:messageSpecial(ID.text.SMALL_ANTLION)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
