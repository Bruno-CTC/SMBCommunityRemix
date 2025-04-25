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
            elseif context.end_of_round and context.game_over ~= true then
                G.GAME.mist_chips = G.GAME.mist_chips / 2
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
                    end
                end
            end
        end
    })
end