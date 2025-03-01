-----------------------------------
-- Natures Meditation
--
-- Description: Attack Boost
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: 50% Attack Boost.
-----------------------------------



-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power         = 10
    local duration      = 0
    local previousPower = 0

    -- Attack Boost stacks up
    if mob:hasStatusEffect(xi.effect.ATTACK_BOOST) then
        previousPower = mob:getStatusEffect(xi.effect.ATTACK_BOOST):getPower()
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ATTACK_BOOST, power + previousPower, 0, duration))
    return xi.effect.ATTACK_BOOST
end

return mobskillObject
