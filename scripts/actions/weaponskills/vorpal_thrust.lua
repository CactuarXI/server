-----------------------------------
-- Vorpal Thrust
-- Polearm weapon skill
-- Skill Level: 175
-- Delivers a single-hit attack. Chance of params.critical varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Aqua Gorget & Light Gorget.
-- Aligned with the Aqua Belt & Light Belt.
-- Element: None
-- Modifiers: STR:50%  AGI:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.2 params.agi_wsc = 0.2
    params.critVaries = { 0.3, 0.6, 0.9 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.numHits = 2
        params.ftpMod = { 1.25, 1.25, 1.25 }
        params.atkVaries = { 1.0, 1.15, 1.25 }
        params.str_wsc = 0.5 params.agi_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and criticalHit then
        player:addMod(xi.mod.CRITHITRATE, 10)
        player:addMod(xi.mod.CRIT_DMG_INCREASE, 10)
        player:addMod(xi.mod.RANGED_CRIT_DMG_INCREASE, 10)
        player:timer(30000, function(playerArg)
            playerArg:delMod(xi.mod.CRITHITRATE, 10)
            playerArg:delMod(xi.mod.CRIT_DMG_INCREASE, 10)
            playerArg:delMod(xi.mod.RANGED_CRIT_DMG_INCREASE, 10)
        end)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
