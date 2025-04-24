--- STEAMODDED HEADER
--- MOD_NAME: BalaKnights
--- MOD_ID: balaknights
--- MOD_AUTHOR: [ShiinaKochiya]
--- MOD_DESCRIPTION: Balatro but Arknights
--- PREFIX: AGL2
----------------------------------------------
------------MOD CODE -------------------------
SMODS.Atlas{
    key = 'Jokers',
    path = 'Joker.png',
    px = 71, 
    py = 95 
}

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
            if #context.full_hand == 1 and context.full_hand[1]:get_id() == 12 then
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
                return {
                    message = localize('k_copied_ex'),
                    colour = G.C.CHIPS,
                    card = self,
                    playing_cards_created = {true}
                }
            end
        return{
            card = card,
            Xmult_mod = card.ability.extra.Xmult,
            message = 'X' .. card.ability.extra.Xmult,
            colour = G.C.MULT,
        }
        end
    end
}

SMODS.Joker{
    key = 'PRTS',
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

function values(t)
    local i = 0
    return function() i = i + 1; return t[i] end
  end
----------------------------------------------
------------MOD CODE END----------------------