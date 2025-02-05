-----------------------------------
-- Ranged Attack
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params =
    {
        numHits = 1,
        atkmulti = 1.5,
        ftpMod = { 1.0, 1.0, 1.0 },
        str_wsc = 0.5,
        dex_wsc = 0.25,
    }

    if automaton:getMod(xi.mod.AUTOMATON_CAN_BARRAGE) == 1 and master:getLocalVar('lastAutoBarrageUsed') + 180 < os.time() and math.random() < 0.6 then
        local maneuvers = master:countEffect(xi.effect.WIND_MANEUVER)
        if maneuvers > 0 then
            params.numHits = maneuvers + 2
            for i = 1, maneuvers do
                master:delStatusEffect(xi.effect.WIND_MANEUVER)
            end
            master:setLocalVar('lastAutoBarrageUsed',os.time())
        end
    end

    local damage = xi.autows.doAutoRangedWeaponskill(automaton, target, 0, params, 1000, true, skill, action)

    return damage
end

return abilityObject
