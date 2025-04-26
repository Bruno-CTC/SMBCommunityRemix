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