-----------------------------------
-- Zone: Giddeus (145)
-----------------------------------
local ID = zones[xi.zone.GIDDEUS]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    -- xi.mob.nmTODPersistCache(zone, ID.mob.QUU_XIJO_THE_ILLUSORY)
    
    xi.treasure.initZone(zone)
    xi.helm.initZone(zone, xi.helmType.HARVESTING)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-100, 0, 406, 59)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
