--- STEAMODDED HEADER
--- MOD_NAME: BalaKnights
--- MOD_ID: balaknights
--- MOD_AUTHOR: [Shiina Kochiya]
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
--Random Rarity Pool
SMODS.Rarity {
    key = "3_star",
    loc_txt = {
        name = "3 Star"
    },
    badge_colour = G.C.UI.TEXT_DARK,
{
    ["Joker"] = { rate = 1.7 },
},
--Testing with ObjectPool
SMODS.ObjectType{
    key = "pool",
    rarities = {
        key = "j_blk_amiyi",
        rate = 2.0
    }
}
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
    rarity = "blk_3_star",
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
            "multiply the Mult amount by x1.5 instead",
            "{C:inactive, C:grey}(Currently {C:mult}+#3#{C:inactive} Mult)"
        }
    },
    rarity = 3,
    atlas = 'Jokers',
    pos = { x=2, y=0 },
    cost = 8,
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

-- Joker: Mr.Cannot
SMODS.Joker{
    key = 'cannot',
    loc_txt = {
        name = 'Terra Investment Masterclass',
        text = {
            '{s:1.4,E:1}It cannot get any better than this!{}',
            'If you have {C:gold}25${}, gain {C:attention}1{} free {C:green}reroll{}',
            '{C:inactive, C:grey}Currently having #1# free reroll{}'
        }
    },
    atlas = 'Jokers',
    pos = { x=4, y=0 },
    config = {
        extra = {
            current_reroll = 0,
            odds = 2,
            thres1 = 25,
            reroll = 1,
            check_reroll = false,
            thres2 = 100,

        }
    },
        loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.current_reroll,
            center.ability.extra.odds,
            center.ability.extra.thres1,
            center.ability.extra.reroll,
            center.ability.extra.check_reroll,
            center.ability.extra.thres2
        }}
    end,
    add_to_deck = function(self, card, from_debuff)
        if not check_reroll then
            if G.GAME.dollars >= card.ability.extra.thres1 then 
                check_reroll = true
                card.ability.extra.current_reroll = card.ability.extra.current_reroll + 1
                SMODS.change_free_rerolls(card.ability.extra.reroll)
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME.dollars >= card.ability.extra.thres1 then 
            card.ability.extra.current_reroll = card.ability.extra.current_reroll - 1
            SMODS.change_free_rerolls(-card.ability.extra.reroll)
        end
    end,
    calculate = function(self,card,context)
        if context.reroll_shop then
            --check if enough money to have free reroll
            if not check_reroll then
                if G.GAME.dollars >= card.ability.extra.thres1 then 
                    check_reroll = true
                    card.ability.extra.current_reroll = card.ability.extra.current_reroll + 1
                    SMODS.change_free_rerolls(card.ability.extra.reroll)
                end
            end
            --check if not enough money to have free reroll
            if check_reroll and G.GAME.dollars < card.ability.extra.thres1 then 
                    check_reroll = false
                    card.ability.extra.current_reroll = card.ability.extra.current_reroll - 1
                    SMODS.change_free_rerolls(-card.ability.extra.reroll)
                end
        end

        if context.end_of_round then
            --check if enough money to have free reroll
            if not check_reroll then
                if G.GAME.dollars >= card.ability.extra.thres1 then 
                    check_reroll = true
                    card.ability.extra.current_reroll = card.ability.extra.current_reroll + 1
                    SMODS.change_free_rerolls(card.ability.extra.reroll)
                end
            end
            --check if not enough money to have free reroll
            if check_reroll and G.GAME.dollars < card.ability.extra.thres1 then 
                    check_reroll = false
                    card.ability.extra.current_reroll = card.ability.extra.current_reroll - 1
                    SMODS.change_free_rerolls(-card.ability.extra.reroll)
                end
        end
    --end of calc funct
    end
}
--Joker: Mudrock
SMODS.Joker{
    key = 'Mudrock',
    loc_txt = {
        name = 'Mudrock',
        text = {
            '{C:green}#1# in #2#{} chance for Stone',
            'cards to permanently gain',
            'extra {C:chips}+#3# chips{} and {C:mult}+#4#{} Mult',
            'after being scored',
        }
    },
    atlas = 'Jokers',
    pos = { x=5, y=0 },
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
        return {vars = {
            G.GAME.probabilities.normal,
            center.ability.extra.odds,
            center.ability.extra.achip,
            center.ability.extra.amult
        }}
    end,

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and pseudorandom('mudrock') < G.GAME.probabilities.normal/card.ability.extra.odds then
            if context.other_card.config.center == G.P_CENTERS.m_stone then
                context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.achip
                context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.amult
            return {
                message = "Desecrated",
                card = card
            }
            end
        end
    --end of calc funct
    end
}
--Joker: uhh, Phoebe?
SMODS.Joker{
    key = 'Phoebe',
    loc_txt = {
        name = 'Sentinel Acolyte',
        text = {
            '{s:0.8}Uhh, Phoebe?{}',
            'idk this Joker definitely',
            'does something.',
            'Actually, give{C:mult, s:0.4} +#1# mult{}'
        }
    },
    atlas = 'Jokers',
    pos = { x=0, y=1 },
    rarity = 3,
    cost = 99,
    config = {
        extra = {
            mults = 1
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.mults,
        }}
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mults,
                message = "Believe"
            }
        end
    --end of calc funct
    end
}
--Joker: IS3 dices
SMODS.Joker{
    key = 'dice',
    loc_txt = {
        name = 'Die roll of Fate',
        text = {
            '1 in 6 chance to permanently give +2 mult',
            '1 in 6 chance to ruin the run',
            'This joker is not working, because I havent make it work yet'
        }
    },
    atlas = 'Jokers',
    pos = { x=1, y=1 },
    config = {
        extra = {
            mults = 10
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.mults,
        }}
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return {
                message = "KILL ALL SEABORNS"
            }
        end
    --end of calc funct
    end
}
-- Rhodes Island back
SMODS.Back {
	key = "rhodes",
	atlas = "Jokers",
    loc_txt = {
        name = 'Rhodes Island',
        text = {
            "Start with triple {C:attention}Face{}",
            "{C:attention}cards{} in your hand",
            "along with an",
            "{C:legendary}Eternal{} {C:dark_edition}Negative{} PRTS Joker",
            "and {C:attention}Magic Trick{} voucher",
        }
    },
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

                G.GAME.used_vouchers["v_magic_trick"] = true
                G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
                Card.apply_to_run(nil, G.P_CENTERS["v_magic_trick"])

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
                
                --for k, v in pairs(back.effect.config.vouchers) do
                    G.GAME.used_vouchers["v_magic_trick"] = true
                    G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
                    Card.apply_to_run(nil, G.P_CENTERS["v_magic_trick"])
                --end
                --[[
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