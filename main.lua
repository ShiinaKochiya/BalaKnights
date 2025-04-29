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
            'This Donke gives {X:mult,C:white}X#1#{} Mult.',
            "I'm learning how to make mods bruh"
        }
    },
    atlas = 'Jokers',
    pos = { x=0, y=0 },
    config = {
        extra = {
            Xmult = 30
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,

    calculate = function(self,card,context)
        if context.joker_main then
        return{
            card = card,
            Xmult_mod = card.ability.extra.Xmult,
            message = 'X' .. card.ability.extra.Xmult,
            colour = G.C.MULT,
        }
        end
    end
}


-- Joker: Theresa/Queen of Babel

SMODS.Joker{
    key = 'theresa',
    loc_txt = {
        name = 'Queen of Babel',
        text = {
            '{C:mult}+#1#{} Mult, each Queen held in',
            "hand gave extra {C:mult}+#2#{} Mult",
            "permanently. If held in hand is",
            "Queen of {C:mult}Hearts{}, double Mult instead"
        }
    },
    atlas = 'Jokers',
    pos = { x=2, y=0 },
    config = {
        extra = {
            mult = 4,
            qmult = 2
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult, center.ability.extra.qmult}}
    end,

    calculate = function(self,card,context) 
    if context.before then
        for i = 1, #G.hand.cards do
             if G.hand.cards[i]:get_id() == 12 then
                --[[if G.hand.cards[i]:is_suit("Hearts") then
                    card.ability.extra.mult = card.ability.extra.mult * 2
                    return {
                        message = "Live"
                   }
                else--]]
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.qmult
                    return {
                         message = "Served"
                    }
                --end
            end
        end
    end

    if context.joker_main then
        return{
            card = card,
            mult_mod = card.ability.extra.mult,
            message = '+' .. card.ability.extra.mult,
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
            'When a King or Queen get scored',
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
	key = "oops",
	
	config = {only_one_rank = '6', ante_scaling = 1.6},
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
	pos = { x = 3, y = 0},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
            	local newcards = {}
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


function values(t)
    local i = 0
    return function() i = i + 1; return t[i] end
  end
----------------------------------------------
------------MOD CODE END----------------------