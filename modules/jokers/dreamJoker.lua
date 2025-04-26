SMODS.Joker {
    key = 'dreamjoker',
    loc_txt = {
        name = 'Dream Joker',
        text = {
            "Played {C:attention,T:e_polychrome}Polychrome{} cards give",
            "{X:chips,C:white}x#1#{} Chips when scored"
        }
    },
    config = { extra = { x_chips = 1.25 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_chips } }
    end,
    rarity = 2,
    atlas = 'jokers',
    pos = { x = 0, y = 0 },
    cost = 3,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and (context.other_card.edition or {}).key == 'e_polychrome' then
            return {
                x_chips = card.ability.extra.x_chips
            }
        end
    end
}