SMODS.Atlas{
    key = "partnertrace",   
    px = 46,
    py = 57,
    path = "trace.png"
}

Partner_API.Partner{
    key = "trace",
    name = "Stencil Partner",
    unlocked = true,
    discovered = true,
    pos = {x = 0, y = 0},
    loc_txt = {},
    atlas = "partnertrace",
    config = {extra = {related_card = "j_stencil"}},
    loc_vars = function(self, info_queue, card)
        local benefits = 1
        if next(SMODS.find_card("j_stencil")) then benefits = 10 end
        return { vars = {card.ability.extra.chips, card.ability.extra.chip_mod*benefits} }
    end,
    calculate = function(self, card, context)
        if (G.consumables.config.card_limit - #G.consumables.cards) > 0 then
            local benefits = 1
            if next(SMODS.find_card("j_stencil")) then benefits = 2 end
            return {
                x_mult = (G.consumables.config.card_limit-#G.consumables.cards)*benefits
            }
        end
    end,
    check_for_unlock = function(self, args)
        for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
            if v.key == "j_stencil" then
                if get_joker_win_sticker(v, true) >= 8 then
                    return true
                end
                break
            end
        end
    end,
}