-----------------------------------
-- ??? Needles
-- Description: Shoots multiple needles at enemies within range.
-- 'The Amigo Sabotender's special ability 1000 Needles has been renamed ??? Needles.''
-- https://forum.square-enix.com/ffxi/threads/46068-Feb-19-2015-(JST)-Version-Update
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
        -- from http://ffxiclopedia.wikia.com/wiki/%3F%3F%3F_Needles
        -- "Seen totals ranging from 15, 000 to 55, 000 needles."

        
    local master = mob:getMaster()
    if mob:isPet() then
        if master and master:hasJugPet() then
            skill:setSkillchainProps(xi.skillchainType.DARKNESS, xi.skillchainType.FRAGMENTATION, xi.skillchainType.NONE)
        end
    end
    
    if mob:getID() == zones[xi.zone.ABYSSEA_ALTEPA].mob.CUIJATENDER then
        local needles = math.random(15000, 55000) / skill:getTotalTargets()
        local dmg     = xi.mobskills.mobFinalAdjustments(needles, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

        return dmg
    else
        local needles = math.random(1000, 10000) / skill:getTotalTargets()
        if target:isNM() then
            needles = math.random(1000, 10000) / skill:getTotalTargets() * 0.25
        end
        
        local dmg     = xi.mobskills.mobFinalAdjustments(needles, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

        return dmg
    end
end

return mobskillObject
