-----------------------------------
-- Area: Dynamis - Windurst
--  Mob: Arch Tzee Xicu Idol
-- Note: Mega Boss
-----------------------------------
require('scripts/globals/dynamis')
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_SCALE, 800)
end

entity.onMobSpawn = function(mob)
    mob:setSpellList(5079)
    mob:setMod(xi.mod.REFRESH, 25)
    xi.mix.jobSpecial.config(mob, {
        between = 180,
        delay = 60,
        duration = 20,
        specials =
        {
            { id = xi.jsa.MANAFONT, cooldown = 300, hpp = 100 },
        },
    })
end

entity.onMobEngaged = function(mob, target)
end

entity.onMobFight = function(mob, target)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 88)
        member:changeMusic(3, 88)
        end
    end

    if mob:hasStatusEffect(xi.effect.MANAFONT) then
        mob:setSpellList(50)
    else
        mob:setSpellList(5079)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)

    local gaSpells =
{
    176, -- Firaga III
    181, -- Blizzaga III
    186, -- Aeroga III
    191, -- Stonega III
    196, -- Thundaga III
    201, -- Waterga III
}

    if skill:getID() == 1112 then
        local stompCounter = mob:getLocalVar('stompCounter')
        local spell = gaSpells[math.random(#gaSpells)]

        stompCounter = stompCounter + 1
        mob:setLocalVar('stompCounter', stompCounter)

        if stompCounter > 2 then
            mob:setLocalVar('stompCounter', 0)
        elseif mob:checkDistance(target) < 6 then
            mob:useMobAbility(1112)
            mob:castSpell(spell, target)
            mob:castSpell(spell, target)
            mob:resetEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
