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
            "Permanently applies a ^#1# multiplier to hand score",
            "\"The soul of the sluggard craves and gets nothing",
            "while the soul of the diligent is richly supplied",
            "The desire of the sluggard kills him,",
            "for his hands refuse to labor.\""
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