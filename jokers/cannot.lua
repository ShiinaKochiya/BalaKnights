SMODS.Joker {
    key = "cannot",

	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,

	rarity = 4,
	cost = 8888,
	unlocked = true,
	discovered = true,

	atlas = "Jokers",
	pos = { x = 3, y = 0 },

	calculate = function(self, card, context)
		if context.end_of_round and context.game_over and context.main_eval then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound('tarot1')
                    return true
                end
            }))
            return {
                message = "Rigged",
                saved = true,
                colour = G.C.RED
            }
        end
	end
}