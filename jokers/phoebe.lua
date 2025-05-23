SMODS.Joker {
    key = "phoebe",
    atlas = "Jokers",
    pos = { x=0, y=1 },
    rarity = 3,
    cost = 999,
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
    end
}