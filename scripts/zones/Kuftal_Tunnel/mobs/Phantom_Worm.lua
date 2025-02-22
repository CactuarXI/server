-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Phantom Worm
-----------------------------------
local kuftalGlobal = require('scripts/zones/Kuftal_Tunnel/globals')
local ID = zones[xi.zone.KUFTAL_TUNNEL]

-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addMod(xi.mod.REGEN, 50)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addMod(xi.mod.REGEN, 35)
    local npc = GetNPCByID(ID.npc.PHANTOM_WORM_QM)
    npc:clearTimerQueue()
    npc:setStatus(xi.status.DISAPPEAR)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local npc = GetNPCByID(ID.npc.PHANTOM_WORM_QM)
    npc:timer(900000, function()
        kuftalGlobal.movePhantomWormQM()
        npc:setStatus(xi.status.NORMAL)
    end)
end

return entity
