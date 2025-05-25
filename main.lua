--------------------------------------------------------------Atlas/Sprites--------------------------------------------------------------
SMODS.Atlas {
    key = "Jokers",
    path = "Joker.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "Back",
    path = "Back.png",
    px = 71,
    py = 95
}

-- Jokers
assert(SMODS.load_file("jokers/amiyi.lua"))()
--assert(SMODS.load_file("jokers/cannot.lua"))()
assert(SMODS.load_file("jokers/mudrock.lua"))()
assert(SMODS.load_file("jokers/phoebe.lua"))()
assert(SMODS.load_file("jokers/jessica.lua"))()
assert(SMODS.load_file("jokers/prts.lua"))()
assert(SMODS.load_file("jokers/theresa.lua"))()
assert(SMODS.load_file("jokers/swire.lua"))()
-- Decks
assert(SMODS.load_file("decks/haimao.lua"))()
assert(SMODS.load_file("decks/rhodes.lua"))()
