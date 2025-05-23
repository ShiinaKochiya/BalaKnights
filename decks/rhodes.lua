SMODS.Back {
	key = "rhodes",
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
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(self.config.extra.vouchers) do
                    G.GAME.used_vouchers[v] = true
                    G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 30
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            Card.apply_to_run(nil, G.P_CENTERS[v])
                            return true
                        end
                    }))
                end

                local newcards = {}
                --Triples face cards
                for i = 1, #G.playing_cards do
                    local card = G.playing_cards[i]
                    if card:get_id() == 12 or card:get_id() == 13 or card:get_id() == 11 then
                        local _card = copy_card(card, nil, nil, G.playing_card)
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        table.insert(G.playing_cards, _card)
                        G.deck:emplace(_card)
                    end
                end

                --PRTS created
                local card = SMODS.create_card({
                    set = "Joker",
                    area = G.jokers,
                    key = "j_blk_prts",
                    stickers = { "eternal" },
                })
                card:set_edition({negative = true}, true)
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end
}