--- STEAMODDED HEADER
--- MOD_NAME: BalaKnights
--- MOD_ID: balaknights
--- MOD_AUTHOR: [ShiinaKochiya]
--- MOD_DESCRIPTION: Balatro but Arknights
--- PREFIX: blk
----------------------------------------------
------------MOD CODE -------------------------


-- Sprites
SMODS.Atlas{
    key = 'Jokers',
    path = 'Joker.png',
    px = 71, 
    py = 95 
}

-- Joker: Amiya
SMODS.Joker{
    key = 'amiyi',
    loc_txt = {
        name = 'Amiya',
        text = {
            '{C:chips}+60{} Chips. This Donke gain',
            '{C:chips}+20{} Chips per Kings discarded.',
            "If the first discarded hand",
            'only contains a single King,',
            "add a permanent copy of that",
            "card and draw into hand",
            "{C:inactive, C:grey}(Currently {C:chips}+#1#{C:inactive} Chips)"
        }
    },
    atlas = 'Jokers',
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


-- Joker: Theresa/King of Sarkaz

SMODS.Joker{
    key = 'theresa',
    loc_txt = {
        name = 'King of Sarkaz',
        text = {
            '{C:mult}+#1#{} Mult, each Queen held in',
            "hand give {C:mult}+#2#{} Mult permanently.",
            "If the card is {C:attention}Queen{} of {C:mult}Hearts{},",
            "double the current Mult amount instead",
            "{C:inactive, C:grey}(Currently {C:mult}+#3#{C:inactive} Mult)"
        }
    },
    atlas = 'Jokers',
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
            message = '+' .. card.ability.extra.tmult,
            colour = G.C.MULT,
        }
        end
    end
}

-- Joker: PRTS
SMODS.Joker{
    key = 'prts',
    loc_txt = {
        name = 'PRTS',
        text = {
            'When a {C:attention}King{} or {C:attention}Queen{} get scored',
            "immediately destroy that card and",
            "this Joker gain {X:mult,C:white}X#1#{} Mult",
            "{C:inactive, C:grey}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
        }
    },
    atlas = 'Jokers',
    rarity = 4,
    pos = { x=1, y=0 },
    config = {
        extra = {
            Xmult = 2.5,
            mult = 0
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.Xmult,
            center.ability.extra.mult
            }
        }
    end,

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 12 or context.other_card:get_id() == 13 then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.Xmult
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
            return{
                card = card,
                Xmult_mod = card.ability.extra.mult,
                message = 'X' .. card.ability.extra.mult,
                colour = G.C.MULT,
                --print(context.poker_hands)
                }
            end
        end
}

SMODS.Back {
	key = "rhodes",
	atlas = "Jokers",
    loc_txt = {
        name = 'Rhodes Island',
        text = {
            "Start with triple {C:attention}Face{}",
            "{C:attention}cards{} in your hand",
            "along with an",
            "{C:legendary}Eternal{} {C:dark_edition}Negative{} PRTS Joker"
        }
    },
    loc_args = {localize{type = 'name_text', key = 'v_magic_trick', set = 'Voucher'}, localize{type = 'name_text', key = 'v_illusion', set = 'Voucher'}},
	pos = { x = 3, y = 0},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
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
                    set = 'Joker',
                    area = G.jokers,
                    key = 'j_blk_prts',
                    stickers = { 'eternal' },
                })
                card:set_edition({negative = true}, true)
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end
}

SMODS.Back {
	key = "debug",
	atlas = "Jokers",
    loc_txt = {
        name = 'Debug Deck',
        text = {
            "Same as RI Deck but",
            "also add Theresa and Amiya"
        }
    },
    loc_args = {
        localize{type = 'name_text', key = 'v_magic_trick', set = 'Voucher'}, 
        localize{type = 'name_text', key = 'v_illusion', set = 'Voucher'}
    },
	pos = { x = 3, y = 0},
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
            	local newcards = {}
                --Tripples the face cards
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
                    set = 'Joker',
                    area = G.jokers,
                    key = 'j_blk_prts',
                    stickers = { 'eternal' },
                })
                card:set_edition({negative = true}, true)
                card:add_to_deck()
                G.jokers:emplace(card)

                --Amiya created
                local card = SMODS.create_card({
                    set = 'Joker',
                    area = G.jokers,
                    key = 'j_blk_amiyi',
                })
                card:add_to_deck()
                G.jokers:emplace(card)

                --Theresa created
                local card = SMODS.create_card({
                    set = 'Joker',
                    area = G.jokers,
                    key = 'j_blk_theresa',
                })
                card:add_to_deck()
                G.jokers:emplace(card)
                
                --[[for k, v in pairs(back.effect.config.vouchers) do
                    G.GAME.used_vouchers[v ] = true
                    G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
                    Card.apply_to_run(nil, G.P_CENTERS[v])
                end
                
                Commenting this until I found a way to add vouchers
                --]]
                
                return true
            end
        }))
    end
}

function values(t)
    local i = 0
    return function() i = i + 1; return t[i] end
  end
----------------------------------------------
------------MOD CODE END----------------------