-----------------------------------
-- xi.effect.WEIGHT
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MOVE_SPEED_WEIGHT_PENALTY, effect:getPower())
    target:addMod(xi.mod.EVA, -10)

    -- Immunobreak reset.
    target:setMod(xi.mod.GRAVITY_IMMUNOBREAK, 0)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MOVE_SPEED_WEIGHT_PENALTY, effect:getPower())
    target:delMod(xi.mod.EVA, -10)
end

return effectObject
