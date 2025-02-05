-----------------------------------
-- Gale Axe
-- Axe weapon skill
-- Skill level: 70
-- Chokes enemy. Duration of effect varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Breeze Gorget.
-- Aligned with the Breeze Belt.
-- Element: Wind
-- Modifiers: STR:30%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.3

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.25, 1.25, 1.25 }
        params.str_wsc = 1.0
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and not target:hasStatusEffect(xi.effect.CHOKE) then
        local duration = (120 + (tp/1000 * 60)) applyResistanceAddEffect(player, target, xi.element.WIND, 0)
        target:addStatusEffect(xi.effect.CHOKE, 20, 0, duration)
        player:messagePublic(xi.msg.basic.SKILL_ENFEEB, target, wsID, xi.effect.CHOKE)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
