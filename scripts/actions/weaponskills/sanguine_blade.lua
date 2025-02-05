-----------------------------------
-- Sanguine Blade
-- Sword weapon skill
-- Skill Level: 300
-- Drains a percentage of damage dealt to HP varies with TP.
-- Will not stack with Sneak Attack.
-- Not aligned with any 'elemental gorgets' or 'elemental belts' due to it's absence of Skillchain properties.
-- Element: Dark
-- Modifiers: STR:30%  MND:50%
-- 100%TP    200%TP    300%TP
-- 2.75      2.75      2.75
-- HP Drained by TP:
-- 100%TP    200%TP    300%TP
-- 50%       75%    100%
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local drain = 25 + math.floor(tp / 1000) * 25
    local params = {}
    params.ftpMod = { 2.65, 2.65, 2.65 }
    -- params.ftpMod = { 2.75, 2.75, 2.75 }
    params.str_wsc = 0.3 params.mnd_wsc = 0.5
    params.ele = xi.element.DARK
    params.skill = xi.skill.SWORD
    params.includemab = true

    params.useStatCoefficient = true
    params.dStat1             = xi.mod.INT
    params.dStat2             = xi.mod.INT
    params.dStatMultiplier    = 2

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        if tp >= 1000 and tp <= 1999 then
            drain = (80 + (tp - 1000) * (120 - 80) / (1999 - 1000)) / 100
        elseif (tp >= 2000 and tp <= 2999) then
            drain = (125 + (tp - 1000) * (140 - 125) / (1999 - 1000)) / 100
        elseif (tp == 3000) then
            drain = 150 / 100
        end
    end

    local drainMod = 1 + (player:getMod(xi.mod.ENH_DRAIN_ASPIR) / 100)
    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    local HPDrained = (damage * drain) * drainMod

    if not target:isUndead() then
        local diff = (player:getMaxHP() - player:getHP())
        if HPDrained > diff then
            HPDrained = diff
        end
        player:addHP(HPDrained)
        player:timer(3500, function(playerArg)
            playerArg:messagePublic(xi.msg.basic.RECOVERS_HP, player, 0, HPDrained)
        end)
    end
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
