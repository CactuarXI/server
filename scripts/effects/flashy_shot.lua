-----------------------------------
-- xi.effect.FLASHY_SHOT
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local merit = target:getMerit(xi.merit.FLASHY_SHOT)
    local power = merit * 5
    target:addMod(xi.mod.RATTP, power)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local merit = target:getMerit(xi.merit.FLASHY_SHOT)
    local power = merit * 5
    target:delMod(xi.mod.RATTP, power)
end

return effectObject
