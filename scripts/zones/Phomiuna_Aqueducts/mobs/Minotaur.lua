-----------------------------------
-- Area: Phomiuna Aqueducts
--  Mob: Minotaur
-----------------------------------
mixins = { require('scripts/mixins/fomor_hate') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            mob:checkDistance(target) >= 15,
        },
        position = mob:getPos(),
    }
    if drawInTable.conditions[1] then
        for _, member in ipairs(target:getAlliance()) do
            utils.drawIn(member, drawInTable)
        end
    end
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('fomorHateAdj', 2)

    -- mob:setMobMod(xi.mobMod.DRAW_IN, 1) -- TODO: DRAW_IN Now Handled In Lua
    mob:setMobMod(xi.mobMod.DRAW_IN_INCLUDE_PARTY, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 10)
end

entity.onMobDrawIn = function(mob, target)
    local battleTarget = mob:getTarget()

    if target:getID() == battleTarget:getID() then
        mob:useMobAbility(({ 498,499,500,501,502 })[math.random(1,5)]) -- triclip, back_swish, mow, frightful_roar, mortal_ray
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
