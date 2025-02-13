-----------------------------------
-- Area: Halvung
--   NM: Achamoth (ZNM T3)
-----------------------------------
mixins ={require('scripts/mixins/job_special'),
require('scripts/mixins/rage')}
-----------------------------------


---@type TMobEntity
local entity = {}
local ID = zones[xi.zone.HALVUNG]

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 5000)
    mob:setMod(xi.mod.WIND_SDT, 50)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
    mob:setSpellList(707)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = xi.jsa.BENEDICTION, hpp = -1},
            
        },
    })
end

entity.onAdditionalEffect = function(mob, target, damage)
    -- xi.mob.onAddEffect was not sufficient, going rogue
    local mpRestored = math.random(20,30)
    mob:addMP(mpRestored)
    return xi.subEffect.MP_DRAIN, xi.msg.basic.ADD_EFFECT_MP_HEAL, mpRestored
end


entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 5400)                 -- 90 minutes
    mob:setLocalVar('smallAdds', 0)
    mob:setLocalVar('bigAdds', 0)      
    
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = xi.jsa.BENEDICTION, hpp = -1},
            
        },
    })
end     

local function despawnAdds(mob) 
    local mobId = mob:getID()
    for ii = mobId + 1, mobId + 4 do   -- yolo just despawn everything
        DespawnMob(ii)
    end
end


entity.onMobEngage = function(mob, target)
    mob:setLocalVar('clock', os.time() + 120) 
end


entity.onMobFight = function(mob, target)
    
    local now = os.time()
    local popTime = mob:getLocalVar('clock')
    local small = mob:getLocalVar('smallAdds')
    local big = mob:getLocalVar('bigAdds')
    
    if small+big == 2 then
        mob:setLocalVar('clock', os.time() + math.random(30,60))
    end



    if now >= popTime and (small+big < 2) then -- Time to have babies
        local mobId = mob:getID()
        local mobPos = mob:getPos()

        -- Determine which of the adds to spawn and give birth
        if GetMobByID(17031601):isSpawned() then
            local pet = GetMobByID(17031602)
            pet:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.r)
            pet:spawn(17031602)
            pet:updateEnmity(target)
        else
            local pet = GetMobByID(17031601)
            pet:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.r)
            pet:spawn(17031601)
            pet:updateEnmity(target)
        end
        
        -- Count the new baby and start a new clock
        mob:setLocalVar('smallAdds', small + 1)
        mob:setLocalVar('clock', os.time() + 60) 
    end


end


entity.onMobDeath = function(mob, player, optParams)
    despawnAdds(mob)
end

entity.onMobDespawn = function(mob)
    despawnAdds(mob)
end

return entity
