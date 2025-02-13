-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Khromasoul Bhurborlor (ZNM T3)
-----------------------------------
mixins = {require('scripts/mixins/job_special'),
require('scripts/mixins/rage')}

-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
---@type TMobEntity
local entity = {}

local function despawnAdds(mob) 
    local mobId = mob:getID()
    for ii = mobId + 1, mobId + 10 do   -- yolo just despawn everything
        DespawnMob(ii)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 5000)
end


entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 5400)                 -- 90 minutes
    mob:setLocalVar('Phase', 1)   
    mob:setLocalVar('Offset', 1) 
    mob:setLocalVar('First', 0)    
    for i = ID.mob.KHROMASOUL_BHURBORLOR + 1, ID.mob.KHROMASOUL_BHURBORLOR + 3 do
        local pet = GetMobByID(i) 
            pet:setSpawn(mob:getXPos() + math.random(-2, 2), mob:getYPos(), mob:getZPos() + math.random(-2, 2))
            pet:spawn()
    end   
end    

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('clock', os.time() + 10) 
end


entity.onMobFight = function(mob, target)
    local phase = mob:getLocalVar('Phase')
    local hpp = mob:getHPP()
    local now = os.time()
    local popTime = mob:getLocalVar('clock')
    local mobId = mob:getID()
    local mobPos = mob:getPos()
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()
    local r = mob:getRotPos()

    -- Phase handeling block

    if phase == 1 and hpp <= 80 then
        despawnAdds(mob)
        mob:setLocalVar('Phase', 2)
        mob:setLocalVar('clock', os.time() + 10)
        for i = ID.mob.KHROMASOUL_BHURBORLOR + 4, ID.mob.KHROMASOUL_BHURBORLOR + 6 do
            local pet = GetMobByID(i) 
                pet:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2), r)
                pet:spawn()
        end          
    elseif phase == 2 and hpp <= 60 then
        despawnAdds(mob)
        mob:setLocalVar('Phase', 3)
        mob:setLocalVar('clock', os.time() + 10)
        for i = ID.mob.KHROMASOUL_BHURBORLOR + 7, ID.mob.KHROMASOUL_BHURBORLOR + 8 do
            local pet = GetMobByID(i) 
                pet:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2), r)
                pet:spawn()
        end           
    elseif phase == 3 and hpp <= 40 then
        despawnAdds(mob)
        mob:setLocalVar('Phase', 4)
        mob:setLocalVar('clock', os.time() + 10)
        for i = ID.mob.KHROMASOUL_BHURBORLOR + 9, ID.mob.KHROMASOUL_BHURBORLOR + 10 do
            local pet = GetMobByID(i) 
                pet:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2), r)
                pet:spawn()
        end           
    elseif phase == 4 and hpp <= 20 then
        despawnAdds(mob)
        mob:setLocalVar('Phase', 5)
    end
end

    -- Occationally, lets check to see if anyone killed adds and respawn them if needed.
    --if now > popTime and phase < 5 then
    --    for ii = (mobId + mob:getLocalVar('Offset')), (mobId + mob:getLocalVar('Offset')+ mob:getLocalVar('AddCount') - 1) do
    --        local pet = GetMobByID(ii)  
    --        pet:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.r)
    --        pet:spawn(pet) 
    --        pet:updateEnmity(target)
    --        mob:setLocalVar('clock', os.time() + 120)
    --    end
    --end
entity.onMobWeaponSkillPrepare = function(mob)
   if mob:getLocalVar('Phase') == 5 and math.random() <=.7 then
       return 1895
    end
end


entity.onMobDespawn = function(mob)
    despawnAdds(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    despawnAdds(mob)
end

return entity
