to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end

if CardSleeves then
    local BinahSleeve = CardSleeves.Sleeve({
        key = "binah",
		name = "Page of Binah",
		atlas = "cardSleeves",
		pos = { x = 0, y = 0 },
		unlocked = true,
        discovered = true,
		loc_vars = function(self)
			local key
			if self.get_current_deck_key() == "b_ruina_binah" then
				key = self.key .. "_alt"
				return { key = key, vars = {} }
			end
			return { vars = {} }
		end,
        config = { extra_options = 1, extra_choices = 1 },
        apply = function(self)
            if self.get_current_deck_key() ~= "b_ruina_binah" then
                self.config.extra_options = 1
                self.config.extra_choices = 1
            else
                self.config.extra_options = 2
                self.config.extra_choices = 0
            end
		end,
		calculate = function(self, back, context)
            if context.open_booster then
                context.card.ability.extra = context.card.ability.extra + self.config.extra_options
                -- Give the extra choices
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0,
                    blockable = false,
                    blocking = false,
                    func = function()
                        if G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and (G.pack_cards.VT.y < G.ROOM.T.h) then
                            G.GAME.pack_choices = G.GAME.pack_choices + self.config.extra_choices
                            if G.GAME.pack_choices > #G.pack_cards.cards then
                                G.GAME.pack_choices = #G.pack_cards.cards
                            end
                            return true
                        end
                    end
                }))
            end
        end
    })
    local GeburaSleeve = CardSleeves.Sleeve({
        key = "gebura",
		name = "Page of Gebura",
		atlas = "cardSleeves",
		pos = { x = 1, y = 0 },
		unlocked = true,
        discovered = true,
		loc_vars = function(self)
			local key
			if self.get_current_deck_key() == "b_ruina_gebura" then
				key = self.key .. "_alt"
				return { key = key, vars = {} }
			end
			return { vars = {} }
		end,
        config = {},
        apply = function(self)
            if self.get_current_deck_key() ~= "b_ruina_gebura" then
                G.GAME.mist_chips = 1000
            else
                G.GAME.mist_chips = 0
            end
		end,
		calculate = function(self, back, context)
            if self.get_current_deck_key() ~= "b_ruina_gebura" then
                if context.end_of_round and context.game_over ~= true then
                    G.GAME.mist_chips = G.GAME.chips - G.GAME.blind.chips
                end
            elseif context.end_of_round and context.game_over ~= true and G.GAME.cut_blind then
                G.GAME.mist_chips = G.GAME.mist_chips / 2
                G.GAME.cut_blind = false
            end

            if context.setting_blind then
                local Kali = G.GAME.mist_chips
                if self.get_current_deck_key() ~= "b_ruina_gebura" then
                    ease_chips(Kali)
                    G.E_MANAGER:add_event(Event({
                        blockable = false,
                        blocking = true,
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            local text = "Onrush"
                            play_sound('ruina_snap', 1, 0.5)
                            attention_text({
                                scale = 1.6,
                                text = text,
                                hold = 3,
                                align = 'cm',
                                offset = { x = 0, y = -2.7 },
                                major = G.play,
                                colour =
                                    G.C.MIST_RED
                            })
                            return true
                        end
                    }))
                elseif to_number(G.GAME.blind.chips) <= to_number(Kali) then
                    local type = G.GAME.blind:get_type()
                    if type ~= "Boss" then
                        tag = Tag(G.GAME.round_resets.blind_tags[type])
                        add_tag(tag)
                        G.GAME.cut_blind = true
                    end
                end
            end
        end
    })
    local CryptidSleeve = CardSleeves.Sleeve({
        key = "cryptid",
        name = "Ritual Cryptidae",
        atlas = "cardSleeves",
        pos = { x = 2, y = 0 },
        unlocked = true,
        discovered = true,
        loc_vars = function(self)
            return { vars = {} }
        end,
        apply = function(self)
            G.GAME.cryptid_sleeve_enabled = true
        end,
    })
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
end