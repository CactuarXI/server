-----------------------------------
-- Arching Arrow
-- Archery weapon skill
-- Skill level: 225
-- Delivers a single-hit attack. Chance of params.critical varies with TP.
-- Aligned with the Flame Gorget & Light Gorget.
-- Aligned with the Flame Belt & Light Belt.
-- Element: None
-- Modifiers: STR:16%  AGI:25%
-- 100%TP    200%TP    300%TP
-- 3.50      3.50      3.50
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 3.5, 3.5, 3.5 }
    params.str_wsc = 0.16 params.agi_wsc = 0.25
    params.critVaries = { 0.1, 0.3, 0.5 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        -- params.str_wsc = 0.20 params.agi_wsc = 0.50
        params.ftpMod = { 3.75, 3.75, 3.75 }
        params.str_wsc = 0.16 params.agi_wsc = 0.25
        params.critVaries = { 0.25, 0.50, 1.0 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    local duration = 25 * applyResistanceAddEffect(player, target, xi.element.WIND, 0)
    if damage > 0 and criticalHit and not target:hasImmunity(xi.immunity.GRAVITY) then
        target:addStatusEffect(xi.effect.WEIGHT, 75, 0, duration)
        player:messagePublic(xi.msg.basic.SKILL_ENFEEB, target, wsID, xi.effect.WEIGHT)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
