-----------------------------------
-- Wild Carrot
-- Description: Restores HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local potency = skill:getParam()

    if potency == 0 then
        potency = 13
    end

    local master = mob:getMaster()
    local skillID = skill:getID()
    potency = potency - math.random(0, potency / 4)

    -- Jug pet rabbits' Wild Carrot is an AOE party heal. Heal varies with pet TP. 10 Yalm Range.
    if mob:isPet() then
        if master and master:hasJugPet() then
            local tp = skill:getTP()
            --duration = math.max(270, duration * (tp/1000)) -- Minimum 4.5 minutes. Maximum 9 minutes.
            master:forMembersInRange(10, function(member)
                local ftp100 = 1
                local ftp200 = 1.5
                local ftp300 = 2.0
                local healAmount = target:getMaxHP() * (potency / 150 * xi.mobskills.fTP(tp, ftp100, ftp200, ftp300))
                local memberID = member:getID()

                healAmount = healAmount + (healAmount * (member:getMod(xi.mod.CURE_POTENCY_RCVD) / 100))
                healAmount = healAmount * xi.settings.main.CURE_POWER
        
                local diff = (member:getMaxHP() - member:getHP())
                if healAmount > diff then
                    healAmount = diff
                end
                -- mob:injectActionPacket(memberID, 4, 640, 0, 0, 0, 10, 1)
                mob:injectActionPacket(memberID, 11, 37, 0, 0, 0, 10, 1)
                member:addHP(healAmount)
                member:messageBasic(xi.msg.basic.RECOVERS_HP, 0, healAmount)
                skill:setMsg(xi.msg.basic.SELF_HEAL)
            end)
        end
    else
        -- Rabbits in Dynamis have an erase effect added to their Wild Carrot. Does not apply to Jug Pets.
        if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS then
        local erase = target:eraseStatusEffect()

            if erase == xi.effect.NONE then
                -- Nothing erased, no message. Only heal.
            else
                -- Status Effect debuff erased, send a message.
                if erase then
                    mob:messageBasic(xi.msg.basic.SKILL_ERASE, 323, erase)
                end
            end
        end
        skill:setMsg(xi.msg.basic.SELF_HEAL)
    end
    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency / 100)
end

return mobskillObject
