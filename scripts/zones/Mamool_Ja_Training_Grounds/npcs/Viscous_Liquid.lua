-----------------------------------
-- Area: Mamool Ja Training Grounds (Breaking Morale)
--  Mob: Viscous Liquid
-- Note: Turns the player into a mamool with a heavy negative HP effect.
-----------------------------------
local ID = zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS]
local entity = {}

local lootTable =
{
    [17047813] = xi.item.FIGHTING_FISH_TANK,
    [17047814] = xi.item.GOBLIN_DIE,
    [17047815] = xi.item.PIECE_OF_ATTOHWA_GINSENG,
    [17047816] = xi.item.MAMOOL_JA_COLLAR,
    [17047817] = xi.item.DIVINATION_SPHERE,
    [17047818] = xi.item.TORN_EPISTLE,
    [17047819] = xi.item.GILT_GLASSES,
    [17047820] = xi.item.WILD_RABBIT_TAIL,
}

entity.onTrigger = function(player, npc)
    local flag = true

    for i = 1, #lootTable do
        local item = lootTable[i]

        if xi.assault.hasTempItem(player, item) then
            flag = false
        end
    end

    if flag then
        player:startEvent(103)
    end
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 103 and
        option == 1
    then
        player:addStatusEffect(xi.effect.COSTUME, 1602, 0, 900)
        player:messageSpecial(ID.text.PECULIAR_SENSATION)
    end
end

return entity
