-----------------------------------
-- Kings Justice
-- Great Axe weapon skill
-- Skill Level: N/A
-- Delivers a threefold attack. Damage varies with TP. Conqueror: Aftermath effect varies with TP.
-- Available only after completing the Unlocking a Myth (Warrior) quest.
-- Aligned with the Breeze Gorget, Thunder Gorget & Soil Gorget.
-- Aligned with the Breeze Belt, Thunder Belt & Soil Belt.
-- Element: None
-- Modifiers: STR:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.25      1.50
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 3
    params.ftpMod = { 1.0, 1.25, 1.5 }
    params.atkVaries = { 1.5, 1.5, 1.5 } --REMA attack bonus to flatten the damage curve for REMA WSs
    params.str_wsc = 0.5

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 2.25, 3.75, 5.0 } --Reduced fTP to curb top end damage slightly
        -- params.ftpMod = { 1.0, 3.0, 5.0 }
        params.multiHitfTP = true
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
