-----------------------------------
--  Voidsong
--  Description: Removes all status effects in an area of effect.
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 20' radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getName() == 'Aitvaras' or
        mob:getName() == 'Lost_Aitvaras' or
        mob:getName() == 'Apocalyptic_Beast' and
        not mob:hasStatusEffect(xi.effect.SILENCE) and
        mob:getLocalVar('debuff_Heart') == 0
    then
        return 0
    elseif
        -- can only use if not silenced
        mob:getMainJob() == xi.job.BRD or
        mob:getName() == 'Arch_Angra_Mainyu' and
        not mob:hasStatusEffect(xi.effect.SILENCE)
    then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:eraseAllStatusEffect()
    local count = target:dispelAllStatusEffect()
    count = count + target:eraseAllStatusEffect()

    if count == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    end

    return count
end

return mobskillObject
