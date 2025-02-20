-----------------------------------
-- PET: Automaton
-----------------------------------
xi = xi or {}
xi.pets = xi.pets or {}
xi.pets.automaton = {}

xi.pets.automaton.onMobSpawn = function(mob)
    local petID = mob:getPetID()

    -- Automaton frame resistances
    if petID == xi.petId.HARLEQUINFRAME then
        mob:addMod(xi.mod.DMG, -625) -- -6% phys and -6% magical per http://wiki.ffo.jp/html/8477.html
    elseif petID == xi.petId.VALOREDGEFRAME then
        mob:addMod(xi.mod.DMGPHYS, -1250) -- -12.5% phys dmg taken per http://wiki.ffo.jp/html/8478.html#comment_1
    elseif petID == xi.petId.SHARPSHOTFRAME then
        mob:addMod(xi.mod.PIERCE_SDT, 125) -- -12.5% pierce dmg taken per http://wiki.ffo.jp/html/8481.html
        mob:addMod(xi.mod.DMGMAGIC, -1250)
        mob:addMod(xi.mod.DMGBREATH, -1250)
    elseif petID == xi.petId.STORMWAKERFRAME then
        mob:addMod(xi.mod.DMGMAGIC, -2420) -- -24.2% magic dmg taken per http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=133971&id=8502
        mob:addMod(xi.mod.DMGBREATH, -2420)
    end

    mob:setLocalVar('MANEUVER_DURATION', 60)
    mob:addListener('EFFECTS_TICK', 'MANEUVER_DURATION', function(automaton)
        if automaton:getTarget() then
            local dur = automaton:getLocalVar('MANEUVER_DURATION')
            automaton:setLocalVar('MANEUVER_DURATION', math.min(dur + 3, 300))
        end
    end)

    -- Barrage Turbine cannot be used unless the automaton has been active for at least 3 minutes.
    mob:addRecast(xi.recast.ABILITY, xi.automaton.abilities.BARRAGE_TURBINE, 60 * 3)
end

xi.pets.automaton.onMobDeath = function(mob)
    mob:removeListener('MANEUVER_DURATION')
end
