-----------------------------------
-- xi.effect.AVATARS_FAVOR
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    xi.avatarsFavor.applyAvatarsFavorAuraToPet(target, effect)
    -- xi.avatarsFavor.applyAvatarsFavorDebuffsToPet(target)
end

effectObject.onEffectTick = function(target, effect)
    -- Perform tick power upgrade to max
    if effect:getPower() <= 20 then
        effect:setPower(effect:getPower() + 1)
    end

    local summoningSkill = target:getSkillLevel(xi.skill.SUMMONING_MAGIC)

    for i = 1, 15 do
        if
            summoningSkill <= xi.avatarsFavor.skillLevelBreakpoints[i] and
            effect:getPower() > i
        then
            effect:setPower(i)
            break
        elseif
            summoningSkill > 735 and
            effect:getPower() > 15
        then
            effect:setPower(15) -- Making sure we set a power if we are over 735 skill
        end
    end

    -- Applying gear bonus
    effect:setPower(effect:getPower() + target:getMaxGearMod(xi.mod.AVATARS_FAVOR_ENHANCE))

    -- TODO add Job Point Gift Bonus
    -- if GET PLAYERS JP TOTAL >= 550 then
    --    effect:setPower(effect:getPower() + 1)
    -- end

    xi.avatarsFavor.applyAvatarsFavorAuraToPet(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    -- xi.avatarsFavor.removeAvatarsFavorAuraFromPet(target)
end

return effectObject
