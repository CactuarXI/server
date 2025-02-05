-----------------------------------
-- xi.effect.NETHER_VOID
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AUGMENTS_ABSORB, effect:getPower())
    target:addMod(xi.mod.ENH_DRAIN_ASPIR, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AUGMENTS_ABSORB, effect:getPower())
    target:delMod(xi.mod.ENH_DRAIN_ASPIR, effect:getPower())
end

return effectObject
