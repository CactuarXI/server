-- Lynx family mixin
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.lynx = function(lynxMob)
    lynxMob:addListener('TAKE_DAMAGE', 'LYNX_TAKE_DAMAGE', function(mob, amount, attacker, attackType, damageType)
        -- Ignoring attackType.NONE so dot ticks dont trigger
        if
            attackType ~= xi.attackType.NONE and
            xi.damageType.THUNDER == damageType
        then
            mob:addTP(500)
        end
    end)
end

return g_mixins.families.lynx
