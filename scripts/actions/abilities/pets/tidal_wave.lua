-----------------------------------
-- Tidal Wave
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill, summoner, action)
    local dINT = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))

    xi.job_utils.summoner.onUseBloodPact(target, skill, summoner, action)

    local level = pet:getMainLvl()
    local damage = 48 + (level * 8)
    damage = damage + (dINT * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, xi.element.WATER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.element.WATER)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, 1)

    summoner:setMP(0)
    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.WATER)
    target:updateEnmityFromDamage(pet, damage)

    local ele = xi.element.WATER
    local magicBurst = xi.mobskills.calculateMobMagicBurst(pet, ele, target)
    if (magicBurst > 1) and target:hasStatusEffect(xi.effect.SKILLCHAIN) then -- Gated as this is run per target.
        skill:setMsg(xi.msg.basic.JA_MAGIC_BURST)
    else
        skill:setMsg(xi.msg.basic.DAMAGE)
    end

    return damage
end

return abilityObject
