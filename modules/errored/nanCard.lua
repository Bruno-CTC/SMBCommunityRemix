local NaNCard = SMB.ErroredCard{
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