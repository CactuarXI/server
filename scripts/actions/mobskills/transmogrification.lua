-----------------------------------
--  Transmogrification
--  Description: Activates a shield to absorb all incoming physical damage.
--  Type: Physical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:setMod(xi.mod.PHYS_ABSORB, 1000)
    mob:timer(1000 * math.random(28, 32), function(mobArg)
        mobArg:delMod(xi.mod.PHYS_ABSORB, 1000)
    end)
   -- xi.mobskills.mobBuffMove(mob, xi.effect.PHYSICAL_SHIELD, 2, 0, 30)
    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
