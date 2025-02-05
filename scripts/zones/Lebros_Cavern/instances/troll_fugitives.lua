-----------------------------------
-- Assault: Troll Fugitives
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LEBROS_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.TROLL_FUGITIVES and
        player:getCharVar('assaultEntered') == 0 and
        player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
        player:getMainLvl() > 70
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LEBROS_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.TROLL_FUGITIVES and
        player:getCharVar('assaultEntered') == 0 and
        player:getMainLvl() > 70
end

instanceObject.onInstanceCreated = function(instance)
    instance:setLocalVar('troll1', ID.mob[xi.assault.mission.TROLL_FUGITIVES].MOBS_START[math.random(1, 15)])
    instance:setLocalVar('troll2', ID.mob[xi.assault.mission.TROLL_FUGITIVES].MOBS_START[math.random(1, 15)])

    while instance:getLocalVar('troll1') == instance:getLocalVar('troll2') do
        instance:setLocalVar('troll2', ID.mob[xi.assault.mission.TROLL_FUGITIVES].MOBS_START[math.random(1, 15)])
    end
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.assault.onInstanceCreatedCallback(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    local rune     = GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance)
    local box      = GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance)

    xi.assault.afterInstanceRegister(player, xi.item.CAGE_OF_ZHAYOLM_FIREFLIES)

    if rune then
        rune:setPos(-379.000, -10.000, 86.000, 192)
    end

    if box then
        box:setPos(-381.000, -10.000, 86.000, 192)
    end
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    xi.assault.onInstanceFailure(instance)
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 14 then
        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    xi.assault.onInstanceComplete(instance, 5, 10)
end

instanceObject.onEventFinish = function(player, csid, option, npc)
    xi.assault.instanceOnEventFinish(player, csid, xi.zone.MOUNT_ZHAYOLM)
end

return instanceObject
