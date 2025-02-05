-----------------------------------
-- xi.effect.SPUR
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SPUR_EFFECT * 3)
    local pet = target:getPet()
    if pet then
        pet:addMod(xi.mod.STORETP, 20)
        pet:addMod(xi.mod.ATT, jpValue)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local pet = target:getPet()
    local jpValue = target:getJobPointLevel(xi.jp.SPUR_EFFECT * 3)
    if pet then
        pet:delMod(xi.mod.STORETP, 20)
        pet:delMod(xi.mod.ATT, jpValue)
    end
end

return effectObject
