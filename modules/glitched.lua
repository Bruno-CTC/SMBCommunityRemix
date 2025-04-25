
smb.Errored = SMODS.ConsumableType{
    key = "m_smb_errored",
    primary_colour = HEX('6C2325'),
    secondary_colour = HEX('090303'),
    default = "c_smb_end",
    loc_txt = {
        name = 'Errored',
        collection = 'Errored Cards'
    },
    collection_rows = { 4, 5 },
    shop_rate = 0
}

smb.ErroredCard = SMODS.Consumable:extend {
    set = "m_smb_errored",
	atlas = "smb_erroredCards",
    unlocked = true,
	discovered = true,
}

local endCard = smb.ErroredCard{
    key = "end",
    config = {cash_multiplier = 6, score_multiplier = 8},
    pos = {x = 0, y = 0},
    loc_txt = {
        name = 'Error: Unexpected end',
        text = {
            "Sets blind requirement to {C:attention}#1#x{}.",
            "Winning the blind after using this card will grant you #2#x interest."
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { self.config.cash_multiplier, self.config.score_multiplier } }
    end,
    can_use = function (self, card)
        return G.STATE == G.STATES.SELECTING_HAND
    end,
    use = function(self, card, area, copier)
        G.GAME.cry_payload = to_big((G.GAME.cry_payload or 1)) * to_big(self.config.cash_multiplier)
        G.GAME.blind.chips = G.GAME.blind.chips * to_big(self.config.score_multiplier)
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
	end
}

local NaNCard = smb.ErroredCard{
    key = "NaN",
    config = {min = 0.5, max = 2},
    pos = {x = 1, y = 0},
    loc_txt = {
        name = 'Error: NaN',
        text = {
            "Permanently multiplies all values of selected joker by #1#x to #2#x."
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.min, self.config.max } }
    end,
    can_use = function (self, card)
        return #G.jokers.highlighted == 1
			and not Card.no(G.jokers.highlighted[1], "immune_to_chemach", true)
			and not Card.no(G.jokers.highlighted[1], "immutable", true)
    end,
    use = function(self, card, area, copier)
		Cryptid.with_deck_effects(G.jokers.highlighted[1], function(card)
			Cryptid.misprintize(card, { min = self.config.min, max = self.config.max }, nil, true)
		end)
    end
}

local IndexCard = smb.ErroredCard{
    key = "index",
    config = {},
    pos = {x = 2, y = 0},
    loc_txt = {
        name = 'Error: Index out of range',
        text = {
            "All cards in your next pack are glitched."
        }
    },
    can_use = function (self, card) return true end,
    use = function(self, card, area, copier)
        G.index_amount = G.index_amount or 0
        G.index_amount = G.index_amount + 1
    end
}