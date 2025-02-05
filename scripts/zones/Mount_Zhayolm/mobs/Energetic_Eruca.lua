-----------------------------------
-- Area: Mount Zhayolm
--   NM: Energetic Eruca
-- !pos 176.743 -14.210 -180.926 61
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 75)
    mob:setMod(xi.mod.LULLABYRESBUILD, 25)
    mob:setMod(xi.mod.SLASH_SDT, 0) -- Immune to slashing damage
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 455)
end

return entity
