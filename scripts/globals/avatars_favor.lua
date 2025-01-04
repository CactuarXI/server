-----------------------------------
-- Avatars Favor helper
-----------------------------------
require('scripts/globals/pets')
-----------------------------------
xi = xi or {}
xi.avatarsFavor = xi.avatarsFavor or {}

xi.avatarsFavor.skillLevels =
{
    [1] = 316,
    [2] = 381,
    [3] = 446,
    [4] = 511,
    [5] = 574,
    [6] = 669,
    [7] = 670,
}

xi.avatarsFavor.skillLevelBreakpoints =
{
    [1] = 84,
    [2] = 101,
    [3] = 118,
    [4] = 135,
    [5] = 152,
    [6] = 169,
    [7] = 186,
    [8] = 251,
    [9] = 316,
    [10] = 381,
    [11] = 446,
    [12] = 511,
    [13] = 574,
    [14] = 669,
    [15] = 734,
}

-- Based on BGWiki Power 8 -> 11 is only available with +Avatars Favor Gear + Job Point Gift
-- Avatar Favor buffs scale per tick (~9 seconds) to a max value based on current summoning skill
local avatarsFavorEffect =
{
    [xi.petId.CARBUNCLE] = -- Regen
    {
        scaling = { 1, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 27, 28, 29, 30, 31 },
        effect = xi.effect.CARBUNCLES_FAVOR
    },

    [xi.petId.FENRIR] = -- Magic Eva
    {
        scaling = { 1, 1, 2, 2, 3, 3, 4, 4, 5, 6, 7, 8, 9, 11, 13, 14, 16, 17, 19, 21 }, -- Needs data testing
        effect = xi.effect.FENRIRS_FAVOR
    },

    [xi.petId.IFRIT] = -- Double Attack
    {
        scaling = { 12, 12, 12, 13, 15, 15, 16, 20, 23, 23, 23, 23, 24, 24, 24, 24, 25, 25, 25, 26 },
        effect = xi.effect.IFRITS_FAVOR
    },

    [xi.petId.TITAN] = -- Defense
    {
        scaling = { 25, 31, 35, 39, 43, 47, 52, 57, 62, 67, 72, 77, 82, 87, 92, 97, 102, 107, 112, 117 },
        effect = xi.effect.TITANS_FAVOR
    },

    [xi.petId.LEVIATHAN] = -- Magic Accuracy
    {
        scaling = { 1, 2, 3, 4, 5, 7, 9, 12, 15, 18, 21, 25, 29, 33, 36, 37, 40, 41, 42, 44 }, -- Need data testing
        effect = xi.effect.LEVIATHANS_FAVOR
    },

    [xi.petId.GARUDA] = -- Evasion
    {
        scaling = { 3, 4, 4, 5, 6, 8, 10, 13, 16, 19, 22, 25, 28, 31, 35, 37, 40, 43, 46, 49 },
        effect = xi.effect.GARUDAS_FAVOR
    },

    [xi.petId.SHIVA] = -- Magic Attack
    {
        scaling = { 2, 3, 5, 6, 7, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51 },
        effect = xi.effect.SHIVAS_FAVOR
    },

    [xi.petId.RAMUH] = -- Potency (Critical Hit+%)
    {
        scaling = { 2, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 19, 21, 21, 23, 23, 24, 24, 25, 25 },
        effect = xi.effect.RAMUHS_FAVOR
    },

    [xi.petId.DIABOLOS] = -- Refresh
    {
        scaling = { 1, 1, 2, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 8, 9 },
        effect = xi.effect.DIABOLOSS_FAVOR
    },

    [xi.petId.CAIT_SITH] = -- Magic Defense
    {
        scaling = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 22, 24, 26, 28, 30, 32, 34 },
        effect = xi.effect.CAIT_SITHS_FAVOR
    },

    [xi.petId.SIREN] = -- Subtle Blow
    {
        scaling = { 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 20, 21, 22, 23, 24, 25 },
        effect = xi.effect.SIRENS_FAVOR
    },
}
-----------------------------------
-- Given a :getPetID petID (Not a getMobID)
-- Returns if Avatars Favor should be applied
-- This equates to is the pet not nil and should have avatars favor effect
-- Does not account for Siren
-----------------------------------
local shouldAvatarsFavorBeApplied = function(petId)
    local shouldApply = false

    if petId and petId >= xi.petId.CARBUNCLE and petId <= xi.petId.DIABOLOS then
        shouldApply = true
    end

    if petId and (petId == xi.petId.CAIT_SITH or petId == xi.petId.SIREN) then
        shouldApply = true
    end

    return shouldApply
end

local removeAvatarsFavorDebuffsFromPet = function(target)
    local pet = target:getPet()
    if pet then
        local petId = pet:getPetID()
        if  -- Different pet states for in and out of retail / eras
            shouldAvatarsFavorBeApplied(petId) and
            xi.settings.main.ENABLE_SOA == 0
        then
            pet:addMod(xi.mod.MATT, 20)
            pet:addMod(xi.mod.ATTP, 20)
            pet:addMod(xi.mod.ACC, 10)
            pet:addMod(xi.mod.DEFP, 10)
        end
    end
end

xi.avatarsFavor.applyAvatarsFavorAuraToPet = function(target, effect)
    local pet = target:getPet()
    if pet then
        local petId = pet:getPetID()
        if shouldAvatarsFavorBeApplied(petId) then
            local power = avatarsFavorEffect[petId].scaling[effect:getPower()]
            local avatarEffect = avatarsFavorEffect[petId].effect

            -- Useful debug message
            -- printf('Power %d, Effect %d', effect:getPower(), power)

            pet:addStatusEffectEx(avatarEffect, avatarEffect, 6, 3, 0, avatarEffect, power, xi.auraTarget.ALLIES, bit.bor(xi.effectFlag.NO_LOSS_MESSAGE, xi.effectFlag.AURA))
        end
    end
end

xi.avatarsFavor.removeAvatarsFavorAuraFromPet = function(target)
    local pet = target:getPet()
    if pet then
        local petId = pet:getPetID()
        if shouldAvatarsFavorBeApplied(petId) then
            if pet:hasStatusEffect(avatarsFavorEffect[petId].effect) then
                pet:delStatusEffect(avatarsFavorEffect[petId].effect)
            end

            removeAvatarsFavorDebuffsFromPet(target)
        end
    end
end

xi.avatarsFavor.applyAvatarsFavorDebuffsToPet = function(target)
    local pet = target:getPet()
    if pet then
        local petId = pet:getPetID()
        if  -- Different pet states for in and out of retail / eras
            shouldAvatarsFavorBeApplied(petId) and
            xi.settings.main.ENABLE_SOA == 0
        then
            pet:delMod(xi.mod.MATT, 20) -- Other than MATT most of these values are myth and guesses from multiple sources
            pet:delMod(xi.mod.ATTP, 20)
            pet:delMod(xi.mod.ACC, 10)
            pet:delMod(xi.mod.DEFP, 10)
        end
    end
end
