function randomSelect(table)
    for i = 1, 5 do
        math.random()
    end
    if #table == 0 then
        return nil -- Table is empty
    end
    local randomIndex = math.random(1, #table)
    return table[randomIndex]
end

-- Haimao Deck
SMODS.Back {
	key = "haimao",
	atlas = "Back",
    unlocked = true,
    pos = { x = 0, y = 0 },

	config = {
		extra = {
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
                -- Spectrals 
                "c_cryptid", "c_ankh", "c_familiar", "c_grim", "c_incantation",
                "c_talisman", "c_aura", "c_wraith", "c_sigil", "c_ouija",
                "c_ectoplasm", "c_immolate", "c_hex", "c_trance", "c_medium",
                "c_soul", "c_black_hole", "c_deja_vu",
                -- Tarots
                "c_fool", "c_magician", "c_high_priestess", "c_empress", "c_emperor",
                "c_heirophant", "c_lovers", "c_chariot", "c_justice", "c_hermit",
                "c_wheel_of_fortune", "c_strength", "c_hanged_man", "c_death", "c_temperance",
                "c_devil", "c_tower", "c_star", "c_moon", "c_sun",
                "c_judgement", "c_world",
                -- Planets
                "c_pluto", "c_mercury", "c_uranus", "c_venus", "c_saturn",
                "c_jupiter", "c_earth", "c_mars", "c_neptune", "c_planet_x",
                "c_eris", "c_ceres"
            }
		}
	},

    apply = function(self, back)
        -- G.GAME.starting_params.ante_scaling = 200000
        -- G.GAME.starting_params.hands = 1

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

		-- add consumables
		G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in ipairs(self.config.extra.consumables) do
                    SMODS.add_card({ key = v })
                end
                return true
            end
        }))

		-- add cannot goodenough
		G.E_MANAGER:add_event(Event({
            func = function ()
				--U.M.I. created
				local card = SMODS.create_card({
					set = "Joker",
					area = G.jokers,    
					key = "j_blk_cannot",
				})

				card:add_to_deck()
				G.jokers:emplace(card)

				return true
			end
		}))

		-- add cards.
        G.E_MANAGER:add_event(Event({
            func = function()
                local trandom_m = {
                    -- G.P_CENTERS.m_stone,
                    -- G.P_CENTERS.m_steel,
                    -- G.P_CENTERS.m_glass,
                    -- G.P_CENTERS.m_gold,
                    -- G.P_CENTERS.m_bonus,
                    -- G.P_CENTERS.m_mult,
                    -- G.P_CENTERS.m_wild,
                    G.P_CENTERS.m_lucky,
                    -- "NOTHING"
                }
                local trandom_e = {
                    -- {foil = true},
                    -- {holo = true},
                    {polychrome = true},
                    -- "NOTHING"
                }
                local trandom_r = {
                    "A",
                    -- "K",
                    -- "Q",
                    -- "J",
                    -- "T",
                    -- "9",
                    -- "8",
                    -- "7",
                    -- "6",
                    -- "5",
                    -- "4",
                    -- "3",
                    -- "2"
                }
                local trandom_s = {
                    -- "C",
                    -- "D",
                    "H",
                    -- "S"
                }
                local trandom_g = {
                    "Red",
                    -- "Blue",
                    -- "Gold",
                    -- "Purple",
                    -- "NOTHING"
                }
                for i = #G.playing_cards, 1, -1 do
                    local random_m = randomSelect(trandom_m)
                    local random_e = randomSelect(trandom_e)
                    local random_r = randomSelect(trandom_r)
                    local random_s = randomSelect(trandom_s)
                    local random_g = randomSelect(trandom_g)

                    G.playing_cards[i]:set_base(G.P_CARDS[random_s .. "_" .. random_r])
                    if random_m  ~= "NOTHING" then
                        G.playing_cards[i]:set_ability(random_m)
                    end
                    if random_e ~= "NOTHING" then
                        G.playing_cards[i]:set_edition(random_e, true, true)
                    end
                    if random_g ~= "NOTHING" then
                        G.playing_cards[i]:set_seal(random_g, true, true)
                    end
                end

                return true
            end
        }))
    end,
}
