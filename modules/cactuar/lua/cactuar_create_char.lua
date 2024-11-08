-----------------------------------
-- Cactuar's custom changes during character creation.
-----------------------------------
require('modules/module_utils')
require('scripts/globals/player')
-----------------------------------
local m = Module:new('cactuar_create_char')

m:addOverride('xi.player.charCreate', function(player)
    player:addLinkpearl('Cactuar', true)
    player:addItem(xi.item.SPROUT_BERET)
    player:additem(xi.item.BUFF_TOKEN_SELF, 5)
    player:additem(xi.item.BUFF_TOKEN_PARTY, 5)
    super(player)
end)

return m
