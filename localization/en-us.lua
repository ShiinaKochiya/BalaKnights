return {
    descriptions = {
        Back = {
            b_blk_corrupted_prts = {
                name = "Don't fight with PRTS.",
                text = {
                    "{C:mult}WHAT IS YOUR PLAN AGAINST ME NOW,{}",
                    "{C:mult}DEAR{} MY {C:attention}DOCTOR{}?",
                }
            },
            b_blk_rhodes = {
                name = "Rhodes Island",
                text = {
                    "Start with {C:attention}tripled face cards{},",
                    "{C:legendary}Eternal{} {C:dark_edition}Negative{} PRTS Joker,",
                    "{C:attention}Magic Trick{} and {C:attention}Illusion{} Vouchers."
                }
            },
        },
        Joker = {
            j_blk_theresa = {
                name = "King of Sarkaz",
                text = {
                    "{C:mult}+#1#{} Mult, each Queen held in",
                    "hand give {C:mult}+#2#{} Mult permanently.",
                    "If the card is {C:attention}Queen{} of {C:mult}Hearts{},",
                    "multiply the current Mult by 1.5 instead",
                    "{C:inactive, C:grey}(Currently {C:mult}+#3#{C:inactive} Mult)"
                }
            },
            j_blk_amiyi = {
                name = "Amiya",
                text = {
                    "{C:chips}+60{} Chips. This Donke gain",
                    "{C:chips}+20{} Chips per Kings discarded.",
                    "If the first discarded hand",
                    "only contains a single King,",
                    "add a permanent copy of that",
                    "card and draw into hand",
                    "{C:inactive, C:grey}(Currently {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            j_blk_prts = {
                name = "PRTS",
                text = {
                    "{C:attention}Destroy{} all scored {C:attention}Kings{} and {C:attention}Queen{},",
                    'gain {X:mult,C:white}X#2#{} Mult each.',
                    "{C:inactive, C:grey}(Currently {X:mult,C:white}X#1#{}{C:inactive} Mult){}"
                }
            },
            j_blk_mudrock = {
                name = 'Mudrock',
                text = {
                    '{C:green}#1# in #2#{} chance for Stone',
                    'cards to permanently gain',
                    'extra {C:chips}+#3# chips{} and {C:mult}+#4#{} Mult',
                    'after being scored',
                }
            },
            j_blk_phoebe = {
                name = 'Sentinel Acolyte',
                text = {
                    '{s:0.8}Uhh, Phoebe?{}',
                    'idk this Joker definitely',
                    'does something.',
                    'Actually, give{C:mult, s:0.4} +#1# mult{}'
                }
            }
        },
    },
}