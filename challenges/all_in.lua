SMODS.Challenge {
    key = 'all_in',
    rules = {
        modifiers = {
            { id = "dollars",       value = 150 },
            { id = 'discards',      value = 6   },
        },
        custom = {
            { id = 'all_in_rule0' },
            { id = 'no_reward_specific', value = 'Small' },
            { id = 'no_reward_specific', value = 'Big' },
        },
    },
    jokers = {
        { id = 'j_blk_cannot',  eternal = true},
        { id = 'j_riff_raff',   eternal = true, edition = 'negative' },
        { id = 'j_campfire',    eternal = true, edition = 'negative' },
    },
    vouchers = {
        { id = 'v_clearance_sale' },
        { id = 'v_liquidation' },
        { id = 'v_reroll_surplus' },
        { id = 'v_reroll_glut' },
    },
    restrictions = {
        banned_cards = {
            -- yes
            { id = 'j_oops' },
            { id = 'j_credit_card' },
            -- all possible ways of gaining money
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_rocket' },
            { id = 'j_golden' },
            { id = 'j_satellite' },
            { id = 'j_delayed_grat' },
            { id = 'j_business' },
            { id = 'j_faceless' },
            { id = 'j_todo_list' },
            { id = 'j_ticket' },
            { id = 'j_matador' },
            { id = 'j_cloud_9' },
            { id = 'j_reserved_parking' },
            { id = 'j_mail' },
            { id = 'j_rough_gem' },
            { id = 'j_astronomer' },
            { id = 'c_magician' },
            { id = 'c_devil' },
            { id = 'c_hermit' },
            { id = 'c_temperance' },
            { id = 'c_talisman' },
            { id = 'c_immolate' },
            { id = 'c_wraith' },
        },
        banned_tags = {
            -- tags that directly gives money
            { id = 'tag_handy' },
            { id = 'tag_garbage' },
            { id = 'tag_skip' },
            { id = 'tag_investment' },
            { id = 'tag_economy' },
        },
        banned_other = {
            -- duh!
            { id = 'bl_ox', type = 'blind' },
        }
    },
    deck = {
        type = 'Challenge Deck',
    }
}

SMODS.Challenge {
    key = 'all_in_plus',
    rules = {
        modifiers = {
            { id = "dollars",       value = 100  },
            { id = 'discards',      value = 4   },

        },
        custom = {
            { id = 'all_in_rule0' },
            { id = 'no_reward_specific', value = 'Small' },
            { id = 'no_reward_specific', value = 'Big' },
            { id = 'no_extra_hand_money' },
        },
    },
    jokers = {
        { id = 'j_blk_cannot',  eternal = true},
        { id = 'j_riff_raff',   eternal = true, edition = 'negative' },
        { id = 'j_campfire',    eternal = true, edition = 'negative' },
    },
    vouchers = {
        { id = 'v_clearance_sale' },
        { id = 'v_liquidation' },
        { id = 'v_reroll_surplus' },
        { id = 'v_reroll_glut' },
    },
    restrictions = {
        banned_cards = {
            -- yes
            { id = 'j_oops' },
            { id = 'j_credit_card' },
            -- all possible ways of gaining money
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_rocket' },
            { id = 'j_golden' },
            { id = 'j_satellite' },
            { id = 'j_delayed_grat' },
            { id = 'j_business' },
            { id = 'j_faceless' },
            { id = 'j_todo_list' },
            { id = 'j_ticket' },
            { id = 'j_matador' },
            { id = 'j_cloud_9' },
            { id = 'j_reserved_parking' },
            { id = 'j_mail' },
            { id = 'j_rough_gem' },
            { id = 'j_astronomer' },
            { id = 'c_magician' },
            { id = 'c_devil' },
            { id = 'c_hermit' },
            { id = 'c_temperance' },
            { id = 'c_talisman' },
            { id = 'c_immolate' },
            { id = 'c_wraith' },
        },
        banned_tags = {
            -- tags that directly gives money
            { id = 'tag_handy' },
            { id = 'tag_garbage' },
            { id = 'tag_skip' },
            { id = 'tag_investment' },
            { id = 'tag_economy' },
        },
        banned_other = {
            -- duh!
            { id = 'bl_ox', type = 'blind' },
        }
    },
    deck = {
        type = 'Challenge Deck',
    }
}

SMODS.Challenge {
    key = 'all_in_hard',
    rules = {
        modifiers = {
            { id = 'dollars',       value = 100  },
            { id = 'hands',         value = 3   }
        },
        custom = {
            { id = 'all_in_rule0' },
            { id = 'no_reward_specific', value = 'Small' },
            { id = 'no_reward_specific', value = 'Big' },
            { id = 'no_extra_hand_money' },
            { id = 'no_interest' },
        },
    },
    jokers = {
        { id = 'j_blk_cannot',  eternal = true},
        { id = 'j_riff_raff',   eternal = true, edition = 'negative' },
        { id = 'j_campfire',    eternal = true, edition = 'negative' },
    },
    vouchers = {
        { id = 'v_clearance_sale' },
        { id = 'v_liquidation' },
        { id = 'v_reroll_surplus' },
        { id = 'v_reroll_glut' },
    },
    restrictions = {
        banned_cards = {
            -- yes
            { id = 'j_oops' },
            { id = 'j_credit_card' },
            -- all possible ways of gaining money
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_rocket' },
            { id = 'j_golden' },
            { id = 'j_satellite' },
            { id = 'j_delayed_grat' },
            { id = 'j_business' },
            { id = 'j_faceless' },
            { id = 'j_todo_list' },
            { id = 'j_ticket' },
            { id = 'j_matador' },
            { id = 'j_cloud_9' },
            { id = 'j_reserved_parking' },
            { id = 'j_mail' },
            { id = 'j_rough_gem' },
            { id = 'j_astronomer' },
            { id = 'c_magician' },
            { id = 'c_devil' },
            { id = 'c_hermit' },
            { id = 'c_temperance' },
            { id = 'c_talisman' },
            { id = 'c_immolate' },
            { id = 'c_wraith' },
        },
        banned_tags = {
            -- tags that directly gives money
            { id = 'tag_handy' },
            { id = 'tag_garbage' },
            { id = 'tag_skip' },
            { id = 'tag_investment' },
            { id = 'tag_economy' },
        },
        banned_other = {
            -- duh!
            { id = 'bl_ox', type = 'blind' },
        }
    },
    deck = {
        type = 'Challenge Deck',
    }
}

SMODS.Challenge {
    key = 'all_in_ex',
    rules = {
        modifiers = {
            { id = 'dollars',       value = 100  },
            { id = 'hands',         value = 3   }
        },
        custom = {
            { id = 'all_in_rule0' },
            { id = 'no_reward' },
            { id = 'no_extra_hand_money' },
            { id = 'no_interest' },
            { id = 'inflation' },
        },
    },
    jokers = {
        { id = 'j_blk_cannot',  eternal = true},
        { id = 'j_riff_raff',   eternal = true, edition = 'negative' },
        { id = 'j_campfire',    eternal = true, edition = 'negative' },
    },
    vouchers = {
        { id = 'v_clearance_sale' },
        { id = 'v_liquidation' },
        { id = 'v_reroll_surplus' },
        { id = 'v_reroll_glut' },
    },
    restrictions = {
        banned_cards = {
            -- yes
            { id = 'j_oops' },
            { id = 'j_credit_card' },
            -- all possible ways of gaining money
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_rocket' },
            { id = 'j_golden' },
            { id = 'j_satellite' },
            { id = 'j_delayed_grat' },
            { id = 'j_business' },
            { id = 'j_faceless' },
            { id = 'j_todo_list' },
            { id = 'j_ticket' },
            { id = 'j_matador' },
            { id = 'j_cloud_9' },
            { id = 'j_reserved_parking' },
            { id = 'j_mail' },
            { id = 'j_rough_gem' },
            { id = 'j_astronomer' },
            { id = 'c_magician' },
            { id = 'c_devil' },
            { id = 'c_hermit' },
            { id = 'c_temperance' },
            { id = 'c_talisman' },
            { id = 'c_immolate' },
            { id = 'c_wraith' },
        },
        banned_tags = {
            -- tags that directly gives money
            { id = 'tag_handy' },
            { id = 'tag_garbage' },
            { id = 'tag_skip' },
            { id = 'tag_investment' },
            { id = 'tag_economy' },
        },
        banned_other = {
            -- duh!
            { id = 'bl_ox', type = 'blind' },
        }
    },
    deck = {
        type = 'Challenge Deck',
    }
}

SMODS.Challenge {
    key = 'all_in_ex_ex',
    rules = {
        modifiers = {
            { id = 'dollars',       value = 100  },
            { id = 'discards',      value = 2   },
            { id = 'hands',         value = 3   },
        },
        custom = {
            { id = 'all_in_rule0' },
            { id = 'no_reward' },
            { id = 'no_extra_hand_money' },
            { id = 'no_interest' },
            { id = 'inflation' },
            { id = 'discard_cost', value = 1 },
            { id = 'chips_dollar_cap' },
        },
    },
    jokers = {
        { id = 'j_blk_cannot',  eternal = true},
        { id = 'j_riff_raff',   eternal = true, edition = 'negative' },
        { id = 'j_campfire',    eternal = true, edition = 'negative' },
    },
    vouchers = {
        -- { id = 'v_clearance_sale' },
        -- { id = 'v_liquidation' },
        -- { id = 'v_reroll_surplus' },
        -- { id = 'v_reroll_glut' },
    },
    restrictions = {
        banned_cards = {
            -- yes
            { id = 'j_oops' },
            { id = 'j_credit_card' },
            -- all possible ways of gaining money
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_rocket' },
            { id = 'j_golden' },
            { id = 'j_satellite' },
            { id = 'j_delayed_grat' },
            { id = 'j_business' },
            { id = 'j_faceless' },
            { id = 'j_todo_list' },
            { id = 'j_ticket' },
            { id = 'j_matador' },
            { id = 'j_cloud_9' },
            { id = 'j_reserved_parking' },
            { id = 'j_mail' },
            { id = 'j_rough_gem' },
            { id = 'j_astronomer' },
            { id = 'c_magician' },
            { id = 'c_devil' },
            { id = 'c_hermit' },
            { id = 'c_temperance' },
            { id = 'c_talisman' },
            { id = 'c_immolate' },
            { id = 'c_wraith' },
        },
        banned_tags = {
            -- tags that directly gives money
            { id = 'tag_handy' },
            { id = 'tag_garbage' },
            { id = 'tag_skip' },
            { id = 'tag_investment' },
            { id = 'tag_economy' },
        },
        banned_other = {
            -- duh!
            { id = 'bl_ox', type = 'blind' },
        }
    },
    deck = {
        type = 'Challenge Deck',
    }
}
