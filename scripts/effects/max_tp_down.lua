-----------------------------------
-- xi.effect.MAX_TP_DOWN
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
    if target:getTP() > effect:getPower() then
        target:setTP(effect:getPower())
    end
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
