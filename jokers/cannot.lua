SMODS.Joker {
    key = "cannot",

    blueprint_compat = false,
    perishable_compat = true,
    eternal_compat = true,

    rarity = 2,
    cost = 4,

    unlocked = false,
    discovered = false,
    no_collection = true,

    atlas = "Jokers",
    pos = { x = 3, y = 0 },

    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = 1,
                denominator = 2
            }
        end
    end,
}
