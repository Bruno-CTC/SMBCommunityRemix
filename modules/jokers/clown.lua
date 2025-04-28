SMODS.Joker {
    key = 'clown',
    loc_txt = {
        name = 'Clown',
        text = {
            "{C:mult}#1#{} Hand",
            "{X:mult,C:white}X#2#{} Mult",
            "{C:green}+#3#{} Discards"
        }
    },
    config = { extra = {hands = 1, x_mult = 7, discards = 2 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.hands,
            card.ability.extra.x_mult,
            card.ability.extra.discards
         } }
    end,
    rarity = 3,
    atlas = 'jokers',
    pos = { x = 2, y = 0 },
    cost = 8,
    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.current_round.hands_left ~= 1 then
            ease_discard(2)
            ease_hands_played((-G.GAME.current_round.hands_left))
            ease_hands_played(1)
        end
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end
}