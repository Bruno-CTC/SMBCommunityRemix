SMB.SinConsumable{
    key = "greed",
    config = {cash_multiplier = 1.5},
    pos = {x = 0, y = 0},
    loc_txt = {
        name = 'Greed',
        text = {
            "Multiplies all future money gain by #1#x",
            "\"Therefore I will give their wives to other men and their fields to new owners.",
            "From the least to the greatest, all are greedy for gain;",
            "prophets and priests alike, all practice deceit.\""
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { self.config.cash_multiplier } }
    end,
    can_use = function (self, card)
        return G.GAME.smb_greed == nil or G.GAME.smb_greed == 1
    end,
    use = function(self, card, area, copier)
        G.GAME.smb_greed = (G.GAME.smb_greed or 1) * self.config.cash_multiplier
        G.GAME.smb_blindness = (G.GAME.smb_blindness or 0) + 1
        
        local has_rerolled = G.GAME.round_resets.boss_rerolled
        G.from_boss_tag = true
        G.FUNCS.reroll_boss()
        G.GAME.round_resets.boss_rerolled = has_rerolled
	end
}