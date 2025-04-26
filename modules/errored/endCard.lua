local endCard = SMB.ErroredCard{
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