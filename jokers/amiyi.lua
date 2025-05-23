SMODS.Joker {
    key = "amiyi",
    atlas = "Jokers",
    pos = { x=0, y=0 },
    blueprint_compat = true,
    config = {
        extra = {
            chips = 60,
            achip = 20,
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.chips,
            center.ability.extra.achips
        }}
    end,

    calculate = function(self,card,context)

        if context.discard then
            
            if context.other_card:get_id() == 13 then
                if G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
                        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.achip
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.hand:emplace(_card)
                        _card.states.visible = nil

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                _card:start_materialize()
                                return true
                            end
                        })) 
                        
                        return{
                            message = "Re-live"
                        }
                end

                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.achip
                return{
                    message = "Grow"
                }

            end
            --print(context.other_card)
        end

        if context.joker_main then
        return{
            card = card,
            chips = card.ability.extra.chips,
            colour = G.C.CHIPS
        }
        end
    end
}
