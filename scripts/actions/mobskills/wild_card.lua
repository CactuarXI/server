-----------------------------------
-- Wild Card
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)

    skill:setMsg(xi.msg.basic.TP_INCREASE)

    target:addTP(3000)

    return target:getTP()
end

return mobskillObject
