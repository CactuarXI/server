-----------------------------------
-- xi.effect.CASCADE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MAGIC_DAMAGE, effect:getPower())
    -- target:addMod(xi.mod.MATT, 100)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    -- target:delMod(xi.mod.MATT, 100)
    target:delMod(xi.mod.MAGIC_DAMAGE, effect:getPower())
end

return effectObject
