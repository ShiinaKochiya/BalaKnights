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

SMODS.Back {
	key = "oops",
	
	config = {only_one_rank = '6', ante_scaling = 1.6},
	atlas = "Jokers",
    loc_txt = {
        name = 'Rhodes Island',
        text = {
            "Start with 3 extra Queens",
        }
    },
	pos = { x = 3, y = 0},
	apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, card in ipairs(G.playing_cards) do
                    assert(SMODS.change_base(card, nil, self.config.only_one_rank))
                end
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
    	
    	if context.final_scoring_step then
    		hand_chips = hand_chips*6
    		mult = math.max(1, mult - (mult % 6))
    		return{
    			chips = 0,
    			mult = 0,
    			message = "Sixed!"
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