---------------------------------------------------------------------------------------------------
-- func: flip
-- desc: Temporarily flips the user's main job and subjob to allow equipping items usable only by subjob.
---------------------------------------------------------------------------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = ''
};

local function error(player, msg)
    player:printToPlayer(msg);
    player:printToPlayer('!flip');
end;

commandObj.onTrigger = function(player, arg)

	--if player:isCustomizationEnabled(1) == false then
	--	player:printToPlayer("Job flip is not enabled on this server.")
	--	return
	--end
	
    ret = player:flip(1);
	
	if (ret == 0) then
		error(player, "... an error occurred.");
	end
end

return commandObj
