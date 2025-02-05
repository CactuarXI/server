-----------------------------------
-- xi.effect.YAEGASUMI
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.YAEGASUMI_EFFECT)
    target:addMod(xi.mod.YAEGASUMI_BONUS, effect:getPower() * 20)
    target:addMod(xi.mod.TP_BONUS, 30 * jpValue)
end

effectObject.onEffectTick = function(target, effect)
    local power = utils.clamp(effect:getPower() * 20, 0, 60)
    target:setMod(xi.mod.YAEGASUMI_BONUS, power) -- Caps at 60% WS Damage Bonus
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.YAEGASUMI_EFFECT)
    local power = utils.clamp(effect:getPower() * 20, 0, 60)
    target:delMod(xi.mod.YAEGASUMI_BONUS, power)
    target:delMod(xi.mod.TP_BONUS, 30 * jpValue)
end

return effectObject
