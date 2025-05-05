SMB.SinConsumable{
    key = "sloth",
    config = {
        score_multiplier = 2,
        debuff_chance = .2,
    },
    pos = {x = 0, y = 0},
    loc_txt = {
        name = 'Sloth',
        text = {
            "Does something funny (#1#x to multiplier permanently but 1/#2# chance not to score)",
            "\"Therefore I will give their wives to other men and their fields to new owners.",
            "From the least to the greatest, all are greedy for gain;",
            "prophets and priests alike, all practice deceit.\""
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { self.config.score_multiplier, 1/self.config.debuff_chance } }
    end,
    can_use = function (self, card)
        return G.GAME.smb_sloth == nil or G.GAME.smb_sloth == 1
    end,
    use = function(self, card, area, copier)
        G.GAME.smb_sloth = (G.GAME.smb_sloth or 1) * self.config.score_multiplier
        G.GAME.smb_sloth_falter = (G.GAME.smb_sloth_falter or 0) + 1
        G.GAME.smb_sloth_chance = self.config.debuff_chance
        G.GAME.smb_sloth_mult = self.config.score_multiplier
	end
}