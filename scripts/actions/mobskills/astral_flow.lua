-----------------------------------
-- Astral Flow
-----------------------------------
local mobskillObject = {}

local avatarOffsets =
{
    [17444883] = 3, -- Vermilion-eared Noberry
    [17444890] = 3, -- Vermilion-eared Noberry
    [17444897] = 3, -- Vermilion-eared Noberry
    [17453078] = 3, -- Duke Dantalian
    [17453085] = 3, -- Duke Dantalian
    [17453092] = 3, -- Duke Dantalian
    [17506670] = 5, -- Kirin
    [17543464] = 1, -- Xuu Bhoqa the Enigma
    [17330189] = 1, -- Count Haagenti
    [17539308] = 1, -- Ra'Gho Darkfount
}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.USES)

    local mobID  = mob:getID()
    local pos = mob:getPos()
    local avatar = 0

    if avatarOffsets[mobID] then
        avatar = mobID + avatarOffsets[mobID]
    elseif mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS then
        avatar = mobID + 1
    else
        avatar = mobID + 2 -- default offset
    end

    if not GetMobByID(avatar):isSpawned() then
        GetMobByID(avatar):setSpawn(pos.x + 1, pos.y, pos.z + 1, pos.rot)
        SpawnMob(avatar):updateEnmity(mob:getTarget())
    end

    xi.mobskills.mobBuffMove(mob, xi.effect.ASTRAL_FLOW, 1, 0, 25)

    return xi.effect.ASTRAL_FLOW
end

return mobskillObject
