SMODS.Joker {
    key = "prts",

	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,

	rarity = 4,
	cost = 999,
	unlocked = true,
	discovered = true,

	config = { extra = { xmult = 1, xmult_add = 1 } },

	atlas = "Jokers",
	pos = { x = 1, y = 0 },

	loc_vars = function(_, _, card)
		return {
			vars = {
				card.ability.extra.xmult,
				card.ability.extra.xmult_add,
			}
		}
	end,

	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 12 or context.other_card:get_id() == 13 then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_add
                return {
                    message = "Upgraded"
                }
            end
        end 
        
        if context.destroy_card and context.cardarea == G.play then
            if context.destroy_card:get_id() == 12 or context.destroy_card:get_id() == 13 then
                return {
                    message = "Destroyed",
                    delay = 0.45,
                    remove = true
                }
            end
        end

        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.xmult,
                message = "X" .. card.ability.extra.xmult,
                colour = G.C.MULT,
            }
        end
	end
}
