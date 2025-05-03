SMODS.Joker {
    key = 'deathcard',
    loc_txt = {
        name = 'Death Card',
        text = {
            "Each ante is {c:important}x#1#{} of its size",
        }
    },
    config = { extra = {score_mult = .75 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.score_mult
         } }
    end,
    rarity = 3,
    atlas = 'jokers',
    pos = { x = 3, y = 0 },
    cost = 8,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.GAME.blind.chips = G.GAME.blind.chips * to_big(card.ability.extra.score_mult)
        end
    end
}