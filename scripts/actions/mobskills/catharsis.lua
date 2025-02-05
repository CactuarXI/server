-----------------------------------
-- Catharsis
-- Description: Restores HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- TODO: Make separate mob skill list for CoP Hecteyes
    if
        target:getCurrentRegion() == xi.region.TAVNAZIANARCH or
        mob:getPool() == 3693 -- Sobbing Eyes
    then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local potency = skill:getParam()

    if potency == 0 then
        potency = 12
    end

    potency = potency - math.random(0, potency / 4)
    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency / 100)
end

return mobskillObject
