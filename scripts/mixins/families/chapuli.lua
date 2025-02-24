-----------------------------------
-- Chapuli
-----------------------------------

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.chapuli = function(chapuliMob)

    chapuliMob:addListener('WEAPONSKILL_STATE_ENTER', 'CHAPULI_WEAPONSKILL_STATE_ENTER', function(mob, skill)
        mob:addStatusEffect(xi.effect.PHYSICAL_SHIELD, 1, 0, 10)
        mob:getStatusEffect(xi.effect.PHYSICAL_SHIELD):delEffectFlag(xi.effectFlag.DISPELABLE) -- Cannot be dispelled
    end)

    chapuliMob:addListener('WEAPONSKILL_STATE_EXIT', 'CHAPULI_WEAPONSKILL_STATE_EXIT', function(mob, skillID)
        mob:delStatusEffectSilent(xi.effect.PHYSICAL_SHIELD)
    end)

    chapuliMob:addListener('WEAPONSKILL_TAKE', 'CHAPULI_WEAPONSKILL_TAKE', function(mob, attacker, wsid, tp, action)
        local chance = math.random(1, 100)

        if
            chance >= 75 and
            utils.canUseAbility(mob) == true
        then
            mob:useMobAbility(2945) -- Natures Meditation
        end
    end)
end

return g_mixins.families.chapuli
