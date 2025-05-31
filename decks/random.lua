SMODS.Back {
	key = "random",
	atlas = "Back",
    config = {
		extra = {
			vouchers = { 
                "v_magic_trick", "v_illusion",
            }
		}
	},

    pos = { x = 1, y = 0},
    apply = function(self)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            --                                           | Leave this value as True if wanting cards to only spawn Legendary, else leave as false or nil
            --                                           V
            local card = create_card('Joker', G.jokers, true, nil, nil, nil, nil,'sou') 
            --                                                                     ^
            --                                                                     | This should either be "sou" or "jud", idk me like it  
            card:add_to_deck()
            G.jokers:emplace(card)
            local card = create_card('Joker', G.jokers, false, nil, nil, nil, nil,'sou')
            card:add_to_deck()
            G.jokers:emplace(card)
            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil,'sou')
            card:add_to_deck()
            G.jokers:emplace(card)
            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil,'jud')
            card:add_to_deck()
            G.jokers:emplace(card)
            return true 
            end 
        }))
        delay(0.6)
    end
}