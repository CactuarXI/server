-----------------------------------
-- Zone: Toraimarai Canal (169)
-----------------------------------
local ID = zones[xi.zone.TORAIMARAI_CANAL]
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.ONI_CARCASS)

    xi.treasure.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-259.98, 21.794, 81.887, 66)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
