-----------------------------------
-- Spirit Taker
-- Staff weapon skill
-- Skill Level: 215
-- Delivers an unavoidable attack. Damage varies with MP and TP.
-- Will stack with Sneak Attack.
-- Not aligned with any 'elemental gorgets' or 'elemental belts' due to it's absence of Skillchain properties.
-- It is a physical weapon skill, and is affected by the user's params.accuracy and the enemy's evasion. It may miss completely.
-- Element: None
-- Modifiers: INT:50%  MND:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.50      2.00
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local attack =
    {
        ['type'] = xi.attackType.BREATH,
        ['slot'] = xi.slot.MAIN,
        ['weaponType'] = player:getWeaponSkillType(xi.slot.MAIN),
        ['damageType'] = xi.damageType.ELEMENTAL
    }
    local calcParams =
    {
        wsID = wsID, -- need 'calcParams.wsID' passed to global
        criticalHit = false,
        tpHitsLanded = 0,
        extraHitsLanded = 0,
        shadowsAbsorbed = 0,
        bonusTP = 0
    }

    local playerMP = player:getMP()
    local wsc = 0
    -- Damage calculations based on https://www.bg-wiki.com/index.php?title=Spirits_Within&oldid=269806
    if tp == 3000 then
        wsc = math.floor(playerMP * 120 / 256)
    elseif tp >= 2000 then
        wsc = math.floor(playerMP * (math.floor(0.072 * tp) - 96) / 256)
    elseif tp >= 1000 then
        wsc = math.floor(playerMP * (math.floor(0.016 * tp) + 16) / 256)
    end

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        -- Damage calculations changed based on: http://www.bg-wiki.com/bg/Spirits_Within http://www.bluegartr.com/threads/121610-Rehauled-Weapon-Skills-tier-lists?p=6142188&viewfull=1#post6142188
        if tp == 3000 then
             wsc = math.floor(playerMP * .65)
        elseif tp >= 2000 then
            -- wsc = math.floor(playerHP * .35)
            wsc = math.floor(playerMP * (math.floor(0.08 * tp) - 96) / 256)
        elseif tp >= 1000 then
            -- wsc = math.floor(playerHP * .125)
            wsc = math.floor(playerMP * (math.floor(0.03 * tp) + 16) / 256)
        end
    end

    local damage = target:breathDmgTaken(wsc)
    if damage > 0 then
            calcParams.tpHitsLanded = 1
    end

    if player:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0 then
        damage = damage * (100 + player:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID)) / 100
    end

    damage = damage * xi.settings.main.WEAPON_SKILL_POWER
    calcParams.finalDmg = damage

    -- Todo: xi.weaponskills.doBreathWeaponskill() instead of all this.
    damage = xi.weaponskills.takeWeaponskillDamage(target, player, {}, primary, attack, calcParams, action)

    player:addMP(damage)
    player:messagePublic(xi.msg.basic.RECOVERS_MP, player, 0, damage)
    local leftOver = (player:getMP() + damage) - player:getMaxMP()

    if leftOver > 0 then
        player:addStatusEffect(xi.effect.MAX_MP_BOOST, (leftOver / player:getMaxMP()) * 50, 0, 180)
    end

    return calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.criticalHit, damage
end

return weaponskillObject
