-----------------------------------
-- xi.effect.COUNTERSTANCE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if effect:getSubPower() == 2 then -- Raaz Zealous Snort
        local mobLevel = utils.getActiveJobLevel(target, xi.job.MNK)
        effect:addMod(xi.mod.ADDITIVE_GUARD, math.floor((mobLevel + 1) * 0.2))
        effect:addMod(xi.mod.MDEF, effect:getPower())
        effect:addMod(xi.mod.HASTE_MAGIC, (effect:getPower() * 100))
        effect:addMod(xi.mod.COUNTER, effect:getPower())
    else
        effect:addMod(xi.mod.COUNTER, effect:getPower())
        effect:addMod(xi.mod.DEFP, -effect:getSubPower())
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
