-----------------------------------
-- Healing Ruby II
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    if target:hasStatusEffect(xi.effect.CURSE_II) then
        petskill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
        return 1
    end

    local base = 28 + pet:getMainLvl() * 4

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    if target:getHP() + base > target:getMaxHP() then
        base = target:getMaxHP() - target:getHP() --cap it
    end

    petskill:setMsg(xi.msg.basic.SELF_HEAL_SECONDARY)
    target:addHP(base)
    pet:updateEnmityFromCure(pet, base)
    return base
end

return abilityObject
