-----------------------------------
-- Area: Spire of Mea
--  Mob: Delver
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:addMod(xi.mod.DEFP, 35)
    mob:setMod(xi.mod.STORETP, 0)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() <= 25 then
        mob:setMod(xi.mod.STORETP, 50)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
