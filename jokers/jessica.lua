SMODS.Joker {
    key = "jessica",
    atlas = "Jokers",
    pos = { x=2, y=1 },
    rarity = 1,
    cost = 1,
    config = {
        extra = {
            reroll = 99
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.reroll,
        }}
    end,
    add_to_deck = function(self, card, from_debuff)
                SMODS.change_free_rerolls(card.ability.extra.reroll)
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
            }
        end
    end
}