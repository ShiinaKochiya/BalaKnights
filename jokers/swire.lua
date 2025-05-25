SMODS.Joker {
    key = "swire",
    atlas = "Jokers",
    pos = { x=1, y=1 },
    rarity = 1,
    cost = 800,
    config = {
        extra = {
            mone = 250,
            sell_val = 5,
            cost = 800
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.mone,
            center.ability.extra.sell_val,
            center.ability.extra.cost
        }}
    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra_value = -395
        card:set_cost()
    end,
    calculate = function(self,card,context)
        if context.end_of_round and context.game_over and context.main_eval and G.GAME.dollars >= card.ability.extra.mone then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound('tarot1')
                    return true
                end
            }))
            ease_dollars(-card.ability.extra.mone)
            card.ability.extra.mone = card.ability.extra.mone * 2
            return {
                message = "Saved",
                saved = 'ph_ms_swire',
                colour = G.C.RED
            }
        end
    end
}