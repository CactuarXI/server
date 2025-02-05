-----------------------------------
-- xi.effect.UNLEASH
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local pet = target:getPet()
    target:addMod(xi.mod.TAME, 98)
    if pet then
        pet:addMod(xi.mod.SAVETP, 3000)
        pet:setTP(3000)
    end
    target:resetRecast(xi.recast.ABILITY, 102)
    target:resetRecast(xi.recast.ABILITY, 104)
end

effectObject.onEffectTick = function(target, effect)
    local pet = target:getPet()
    if pet then
        pet:setTP(3000)
    end
    target:resetRecast(xi.recast.ABILITY, 102)
    target:resetRecast(xi.recast.ABILITY, 104)
end

effectObject.onEffectLose = function(target, effect)
    local pet = target:getPet()
    if pet then
        pet:delMod(xi.mod.SAVETP, 3000)
    end
    target:delMod(xi.mod.TAME, 98)
end

return effectObject
