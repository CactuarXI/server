-----------------------------------
-- Thornsong
-- Description: Covers the user in fiery spikes. Enemies that hit it take fire damage.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)

    if 
        mob:hasStatusEffect(xi.effect.BLAZE_SPIKES)
    then 
        return 1
    end

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
    local power = mob:getMainLvl() * 2
    local typeEffect = xi.effect.BLAZE_SPIKES
    local duration = 180

    if
        mob:getName() == 'Aitvaras' or
        mob:getName() == 'Lost_Aitvaras' or 
        mob:getName() == 'Arch_Angra_Mainyu'
    then
        power = math.random(175, 200)
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BLAZE_SPIKES, power, 0, duration))
    return xi.effect.BLAZE_SPIKES
end

return mobskillObject
