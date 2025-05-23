SMODS.Joker{
    key = "theresa",
    blueprint_compat = true,
    atlas = "Jokers",
    pos = { x=2, y=0 },
    config = {
        extra = {
            mult = 4,
            amult = 4,
            tmult = 4
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult, center.ability.extra.amult, center.ability.extra.tmult}}
    end,

    calculate = function(self,card,context) 
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:get_id() == 12 then
                if context.other_card:is_suit("Hearts") then
                    card.ability.extra.tmult = card.ability.extra.tmult * 1.5
                    return {
                        message = "Live"
                    }
                else
                    card.ability.extra.tmult = card.ability.extra.tmult + card.ability.extra.amult
                    return {
                        message = "Served"
                    }
            end
        end
    end

    if context.joker_main then
        return{
            card = card,
            mult_mod = card.ability.extra.tmult,
            message = "+" .. card.ability.extra.tmult,
            colour = G.C.MULT,
        }
        end
    end
}
