-----------------------------------
-- Area: Crawlers' Nest (197)
--  Mob: Demonic Tiphia
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    local delay = mob:getLocalVar('delay')

    -- Uses Cure V repeatedly on cooldown below 50% health
    if os.time() > delay and mob:actionQueueEmpty() and mob:getHPP() <= 50 then
        mob:castSpell(5, mob) -- Cure V
        mob:setLocalVar('delay', os.time() + 15)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 236)
end

return entity
