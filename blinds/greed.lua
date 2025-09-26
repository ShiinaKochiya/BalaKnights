SMODS.Blind {
    key = "greed",
    atlas = "Blind",
    pos = { x = 0, y = 0 },
    discovered = true,
    dollars = 5,
    mult = 2,

    boss = {
        min = 1,
        showdown = false,
    },

    --shit broke, am figuring out
    set_blind = function(self)
        if self._greed_hooked then return end
        self._greed_hooked = true

        -- Hook discard_hand instead of discard_cards
        self._orig_discard_hand = G.FUNCS.discard_hand

        G.FUNCS.discard_hand = function(button)
            -- Call original discard handler
            local ok, res = pcall(self._orig_discard_hand, button)
            if not ok then
                error(res)
            end

            -- Apply penalty: reduce hands_left by 1
            if G and G.GAME and type(G.GAME.hands_left) == "number" then
                G.GAME.hands_left = math.max(G.GAME.hands_left - 1, 0)

                -- Feedback message + sound
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("chips1")
                        G.HUD:message("Greed: -1 hand")
                        return true
                    end
                }))
            end

            return res
        end

        sendDebugMessage("[Greed] discard_hand hook active")
    end,

    disable = function(self)
        if self._greed_hooked and self._orig_discard_hand then
            G.FUNCS.discard_hand = self._orig_discard_hand
            self._orig_discard_hand = nil
        end
        self._greed_hooked = nil
    end,
}
