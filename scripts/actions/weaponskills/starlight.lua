-----------------------------------
-- Starlight
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local lvl = player:getSkillLevel(11) -- get club skill
    local damage = (lvl - 10) / 9
    local scaling = 1
    if tp == 3000 then
        scaling = ((tp / 1000) * 2.75)
    elseif tp >= 2000 then
        scaling = ((tp / 1000) * 2.25)
    elseif tp >= 1000 then
        scaling = ((tp / 1000) * 2.0)
    end
    local damagemod = damage * scaling
    damagemod = damagemod * xi.settings.main.WEAPON_SKILL_POWER
    return 1, 0, false, damagemod
end

return weaponskillObject
