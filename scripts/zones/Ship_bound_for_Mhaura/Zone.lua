-----------------------------------
-- Zone: Ship_bound_for_Mhaura (221)
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1
    local zoneID = 221

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.random(-2, 2) + 0.150
        player:setPos(position, -2.100, 3.250, 64)
        if
            player:getGMLevel() == 0 and
            GetZone(zoneID):getLocalVar('stateSet') == 0
        then
            GetZone(zoneID):setLocalVar('stateSet', 1)
            GetZone(zoneID):setLocalVar('state', 2)
            GetZone(zoneID):setLocalVar('transportTime', os.time())
        end
    end

    return cs
end

zoneObject.onTransportEvent = function(player, transport)
    player:getZone():setLocalVar('stateSet', 0)
    player:getZone():setLocalVar('state', 1)
    player:startEvent(512)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 512 then
        player:setPos(0, 0, 0, 0, 249)
    end
end

return zoneObject
