-----------------------------------
-- Extremely Bad Breath
-- A horrific case of halitosis instantly K.O.'s any players in a fan-shaped area of effect.
--
-- Description
-- Family: Morbol
-- Type: Breath
-- Can be dispelled: N/A
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown cone
-- Notes: Only used by Evil Oscar, Cirrate Christelle, Lividroot Amooshah, Eccentric Eve, Deranged Ameretat, and Melancholic Moira.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Lividroot Amooshah won't use this skill until phase 4
    if mob:getID() == 16990473 and mob:getLocalVar('phase') < 4 then
        return 1
    end

    return 0
end


mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmg = target:getHP()
    target:setHP(0)
    return dmg
end

return mobskillObject
