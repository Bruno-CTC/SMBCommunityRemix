local ChesedSleeve = CardSleeves.Sleeve({
    key = "chesed",
    name = "Page of Chesed",
    atlas = "cardSleeves",
    pos = { x = 3, y = 0 },
    unlocked = true,
    discovered = true,
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_ruina_chesed" then
            key = self.key .. "_alt"
            return { key = key, vars = {} }
        end
        return { vars = {} }
    end,
    config = { common = 25, uncommon = 50, rare = 100, cmult = 1.05, umult = 1.1, rmult = 1.25 },
    apply = function(self)
    end,
    calculate = function(self, back, context)
        if self.get_current_deck_key() ~= "b_ruina_chesed" then
            if context.other_joker then
                local chips = 0
                if (context.other_joker.config.center.rarity == 1 or context.other_joker.config.center.rarity == "Common") then
                    chips = self.config.common
                elseif (context.other_joker.config.center.rarity == 2 or context.other_joker.config.center.rarity == "Uncommon") then
                    chips = self.config.uncommon
                elseif (context.other_joker.config.center.rarity == 3 or context.other_joker.config.center.rarity == "Rare") then
                    chips = self.config.rare
                end
                if chips > 0 then
                    card_eval_status_text(context.other_joker, 'extra', nil, nil, nil,
                        {
                            message = localize { type = 'variable', key = 'a_chips', vars = { chips } },
                            colour = G.C.CHIPS,
                        })
                    return {
                        chips = chips,
                        remove_default_message = true
                    }
                end
            end
        else
            if context.other_joker then
                local chip_mult = 1
                if (context.other_joker.config.center.rarity == 1 or context.other_joker.config.center.rarity == "Common") then
                    chip_mult = chip_mult * self.config.cmult
                elseif (context.other_joker.config.center.rarity == 2 or context.other_joker.config.center.rarity == "Uncommon") then
                    chip_mult = chip_mult * self.config.umult
                elseif (context.other_joker.config.center.rarity == 3 or context.other_joker.config.center.rarity == "Rare") then
                    chip_mult = chip_mult * self.config.rmult
                end
                if chip_mult > 0 then
                    card_eval_status_text(context.other_joker, 'extra', nil, nil, nil,
                        { 
                            message = localize({ type = "variable", key = "a_xchips", 
                            vars = { chip_mult },
                            colour = G.C.XCHIPS
                        }), 
                    }
                    )
                    return {
                        Xchips = chip_mult,    
                        remove_default_message = true
                    }
                end
            end
        end
    end
})