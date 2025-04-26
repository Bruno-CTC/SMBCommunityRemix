SMODS.Joker {
    key = 'dreamjoker',
    loc_txt = {
        name = 'Dream Joker',
        text = {
            "Played {C:attention}Polychrome{} cards give {C:attention}+80 Chips{} when scored"
        }
    },
    config = { extra = { chips = 80 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    rarity = 2,
    atlas = 'jokers',
    pos = { x = 0, y = 0 },
    cost = 3,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and (context.other_card.edition or {}).key == 'e_polychrome' then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}