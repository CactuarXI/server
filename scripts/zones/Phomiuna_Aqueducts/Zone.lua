-----------------------------------
-- Zone: Phomiuna_Aqueducts (27)
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
require('scripts/globals/exp_controller')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)

    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.TRES_DUENDES)
    -- Mahisha and Eba share a respawn, random to see who spawns
    if GetServerVariable('EBA_MAHISHA') == 1 then
        xi.mob.nmTODPersistCache(zone, ID.mob.MAHISHA)
    else
        xi.mob.nmTODPersistCache(zone, ID.mob.EBA)
    end
    -- FFXI wiki has some info stating ~10mins realtime for Phomiuna Aqueducts
    GetNPCByID(ID.npc.QM_TAVNAZIAN_COOKBOOK):addPeriodicTrigger(0, 250, 0)

    xi.exp_controller.onInitialize(zone)

end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(260.02, -2.12, -290.461, 192)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
