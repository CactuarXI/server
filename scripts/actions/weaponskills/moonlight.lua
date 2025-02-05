-----------------------------------
-- Moonlight
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local lvl = player:getSkillLevel(11) -- get club skill
    local damage = (lvl / 9) - 1 -- 27
    local scaling = 1
    if tp == 3000 then
        scaling = ((50 + (tp * 0.20)) / 100)
    elseif tp >= 2000 then
        scaling = ((50 + (tp * 0.15)) / 100)
    elseif tp >= 1000 then
        scaling = ((50 + (tp * 0.10)) / 100)
    end
    local damagemod = damage * scaling
    damagemod = damagemod * xi.settings.main.WEAPON_SKILL_POWER
    return 1, 0, false, damagemod
end

return weaponskillObject
