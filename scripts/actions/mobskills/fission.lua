-----------------------------------
-- Gorger NM Fission Skill
-- Checks eligibility to use
-- maxBabies set by NM lua
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local id = mob:getID()

    for i = id + 1, id + mob:getLocalVar('maxBabies') do
        local baby = GetMobByID(i)
        if baby and not baby:isSpawned() then
            fam = 0
            break
        end
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local id    = mob:getID()
    local pos   = mob:getPos()
    local momma = mob:getID()
    -- Ingester - ENM: You are what you eat
    if mob:getPool() == 2080 then
        for i = 4, 1, -1 do
            if not GetMobByID(id + i):isSpawned() then
                GetMobByID(id + i):setSpawn(pos.x, pos.y, pos.z)
                SpawnMob(id + i):updateEnmity(target)
                break
            end
        end
    else
        for babyID = momma + 1, momma + mob:getLocalVar('maxBabies') do
            local baby = GetMobByID(babyID)
            if baby and not baby:isSpawned() then
                SpawnMob(babyID)

                local mobTarget = mob:getTarget()
                if mobTarget then
                    baby:updateEnmity(mobTarget)
                end

                baby:setPos(pos.x, pos.y, pos.z)
                break
            end
        end
    end
end

return mobskillObject
