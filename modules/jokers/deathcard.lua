SMODS.Joker {
    key = 'deathcard',
    loc_txt = {
        name = 'Death Card',
        text = {
            "Each ante is {c:important}x#1#{} of its size",
        }
    },
    config = { extra = {ante_scaling = .75 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.ante_scaling
         } }
    end,
    rarity = 3,
    atlas = 'jokers',
    pos = { x = 3, y = 0 },
    cost = 8,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.GAME.modifiers.scaling = card.ability.extra.ante_scaling
        end
    end
}