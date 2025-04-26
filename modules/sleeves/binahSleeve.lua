to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end

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