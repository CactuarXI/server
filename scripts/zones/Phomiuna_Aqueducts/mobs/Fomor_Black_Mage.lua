-----------------------------------
-- Area: Phomiuna_Aqueducts
--  Mob: Fomor Black Mage
-----------------------------------
mixins = { require('scripts/mixins/fomor_hate') }
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobRoam = function(mob)
    local tres    = GetMobByID(ID.mob.TRES_DUENDES):getLocalVar('cooldown')
    local fomorID = ID.mob.TRES_DUENDES - 1
    if os.time() > tres and mob:getID() == fomorID then
        DisallowRespawn(mob:getID(), true)
        GetMobByID(ID.mob.TRES_DUENDES):setSpawn(mob:getXPos(),mob:getYPos(),mob:getZPos())
        DespawnMob(mob:getID())
        SpawnMob(ID.mob.TRES_DUENDES)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
