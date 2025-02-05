-----------------------------------
-- Area: Dynamis-Tavnazia
--  Mob: Diabolos Heart
-- Note: Mega Boss
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen')
}
-----------------------------------
---@type TMobEntity
local entity = {}
entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DMGPHYS, 5000)
    mob:setMod(xi.mod.MDEF, 25)
    mob:setMod(xi.mod.REGAIN, 50)
    mob:setLocalVar('[isDynamis_Megaboss]', 1)
end

entity.onMobFight = function(mob, target)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 239)
        member:changeMusic(3, 239)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
    player:addTitle(xi.title.NIGHTMARE_AWAKENER)
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
