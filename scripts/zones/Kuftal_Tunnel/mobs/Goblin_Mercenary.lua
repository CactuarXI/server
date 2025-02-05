-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Goblin Mercenary
-- Note: Place Holder for Bloodthirster Madkix
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

local bloodthirsterPHTable =
{
    [ID.mob.BLOODTHIRSTER_MADKIX - 13] = ID.mob.BLOODTHIRSTER_MADKIX, -- 260.000 11.000 37.000
    [ID.mob.BLOODTHIRSTER_MADKIX - 1] = ID.mob.BLOODTHIRSTER_MADKIX, -- 257.000 10.000 44.000
}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 740, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, bloodthirsterPHTable, 5, 7200) -- 2 hours minimum.
end

return entity
