SMODS.Atlas {
    key = "Jokers",
	path = "Joker.png",
    px = 71,
    py = 95
}

-- Amiya
SMODS.Joker{
    key = "amiyi",
    atlas = "Jokers",
    pos = { x=0, y=0 },
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

-- Theresa
SMODS.Joker{
    key = "theresa",
    loc_txt = {
        
    },
    atlas = "Jokers",
    pos = { x=2, y=0 },
    config = {
        extra = {
            mult = 4,
            amult = 2,
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
                    card.ability.extra.tmult = card.ability.extra.tmult * 2
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

-- PRTS
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

-- Corrupted PRTS deck
SMODS.Back {
	key = "corrupted_prts",
	atlas = "Jokers",
    unlocked = true,
    pos = { x = 1, y = 0 },

	config = {
		extra = {
			ante_scaling = 2,
			spectral_rate = 2,
			vouchers = { 
                "v_overstock_norm", "v_overstock_plus",
                "v_clearance_sale", "v_liquidation",
                "v_hone", "v_glow_up",
                "v_reroll_surplus", "v_reroll_glut",
                "v_crystal_ball", "v_omen_globe",
                "v_telescope", "v_observatory",
                "v_grabber", "v_nacho_tong",
                "v_wasteful", "v_recyclomancy",
                "v_tarot_merchant", "v_tarot_tycoon",
                "v_planet_merchant", "v_planet_tycoon",
                "v_seed_money", "v_money_tree",
                "v_blank", "v_antimatter",
                "v_magic_trick", "v_illusion",
                "v_paint_brush", "v_palette",
                "v_retcon", "v_directors_cut"
            },
			consumables = { 
                "c_cryptid", "c_cryptid", "c_cryptid", "c_cryptid", "c_cryptid",
            }
		}
	},

    apply = function(self, back)
        G.GAME.starting_params.ante_scaling = self.config.extra.ante_scaling
        G.GAME.spectral_rate = self.config.extra.spectral_rate
        G.GAME.starting_params.dollars = 150
        G.GAME.starting_params.consumable_slots = 10

		-- add vouchers
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

		-- consumables
		G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in ipairs(self.config.extra.consumables) do
                    SMODS.add_card({ key = v })
                end
                return true
            end
        }))

		-- jokers
		G.E_MANAGER:add_event(Event({
			func = function ()
				--U.M.I. created
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

		-- Polychrome queen of hearts.
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    local modifier = G.P_CENTERS.m_glass
                    local edition = {polychrome = true}
                    local rank = "Q"
                    local suit = "H"
                    local seal = "Red"

                    G.playing_cards[i]:set_base(G.P_CARDS[suit .. "_" .. rank])
                    G.playing_cards[i]:set_ability(modifier)
                    G.playing_cards[i]:set_edition(edition, true, true)
                    G.playing_cards[i]:set_seal(seal, true, true)
                end

				return true
            end
        }))
    end,
}

-- RI deck
SMODS.Back {
	key = "rhodes",
	atlas = "Jokers",
    config = {
		extra = {
			vouchers = { 
                "v_magic_trick", "v_illusion",
            }
		}
	},

    pos = { x = 3, y = 0},
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