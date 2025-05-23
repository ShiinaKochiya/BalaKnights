-- Joker: Mudrock
SMODS.Joker {
    key = "mudrock",
    atlas = "Jokers",
    pos = { x=4, y=0 },
    config = {
        extra = {
            odds = 5,
            achip = 25,
            amult = 2,
        }
    },
    rarity = 2,
    cost = 5,

    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                G.GAME.probabilities.normal,
                center.ability.extra.odds,
                center.ability.extra.achip,
                center.ability.extra.amult
            }
        }
    end,

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and pseudorandom("mudrock") < G.GAME.probabilities.normal/card.ability.extra.odds then
            if context.other_card.config.center == G.P_CENTERS.m_stone then
                context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.achip
                context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.amult
            return {
                message = "Desecrated",
                card = card
            }
            end
        end
    end
}
