-----------------------------------
-- xi.effect.MAGIC_DEF_DOWN
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MDEF, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MDEF, -effect:getPower())
end

return effectObject
