SMB.ThaumaConsumable{
    key = "augur",
    config = {
        max_highlighted = 1
    },
    loc_txt = {
        name = "Augur",
        text = {
            "Grants #1# card(s) a {C:attention}Crux{} Augment.",
            "Destroys all other cards in hand."
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {
            key = "smb_crux",
            set = "Other",
            vars = {}
        }
        return {
            vars = { card.ability.max_highlighted }
        }
    end,
    can_use = function(self, card)
        return #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted > 0
    end,
    use = function(self, card, area, copier)
        SMB.FlipThen(G.hand.highlighted, function(card)
            card.ability.smb_crux = true
            card.ability.crux_effects = {
                base_multiplier = 1.1,
                base_chip_multiplier = 1.1,
                gold_bonus = 1,
                power_scaling = 0.01,
                ascension_bonus = 0.25,

                total_multiplier = 1.0,
                total_chip_multiplier = 1.0,
                total_gold_bonus = 0,
                total_power_multiplier = 1.00,
                total_ascension_bonus = 0
            }
        end, nil, function (card)
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    for _, card2 in ipairs(G.hand.cards) do
                        if not card2.ability.smb_crux then
                            card2:start_dissolve(nil, nil)
                        end
                    end
                    return true
                end,
            }))
        end)
    end
}


SMODS.Sticker {
    key = "smb_crux",
    badge_colour = HEX("2F0E4F"),

    loc_vars = function(self, info_queue, card)
        if card and card.ability and card.ability.crux_effects then
            info_queue[#info_queue + 1] = {
                key = "smb_crux_effects",
                set = "Other",
                vars = {
                    card.ability.crux_effects.total_multiplier,
                    card.ability.crux_effects.total_chip_multiplier,
                    card.ability.crux_effects.total_gold_bonus,
                    card.ability.crux_effects.total_power_multiplier,
                    card.ability.crux_effects.total_ascension_bonus
                }
            }
        end
    end,

    apply = function(self, card, val)
        card.ability.crux_effects = {
            base_multiplier = 1.1,
            base_chip_multiplier = 1.1,
            gold_bonus = 1,
            power_scaling = 0.01,
            ascension_bonus = 0.25,

            total_multiplier = 1.0,
            total_chip_multiplier = 1.0,
            total_gold_bonus = 0,
            total_power_multiplier = 1.00,
            total_ascension_bonus = 0,
            total_ascension_scaling = 1.00,
        }
    end,

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play and card.ability.crux_effects then
            local ce = card.ability.crux_effects

            if ce.total_multiplier > 1 then
                SMB.HandleXMult(ce.total_multiplier, card)
            end
            if ce.total_chip_multiplier > 1 then
                SMB.HandleXChips(ce.total_chip_multiplier, card)
            end
            if ce.total_gold_bonus > 0 then
                SMB.HandleDollars(ce.total_gold_bonus, card)
            end
            if ce.total_power_multiplier > 1 then
                SMB.HandleExponent(ce.total_power_multiplier, card)
            end
            if ce.total_ascension_bonus > 0 then
                SMB.HandleAscensionAdd(ce.total_ascension_bonus, card)
            end

            -- Gain a random permanent upgrade
            local effect = math.floor(pseudorandom("smb_crux") * 5) + 1
            if effect == 1 then
                ce.total_multiplier = ce.total_multiplier * ce.base_multiplier
            elseif effect == 2 then
                ce.total_chip_multiplier = ce.total_chip_multiplier * ce.base_chip_multiplier
            elseif effect == 3 then
                ce.total_gold_bonus = ce.total_gold_bonus + ce.gold_bonus
            elseif effect == 4 then 
                ce.total_power_multiplier = ce.total_power_multiplier + ce.power_scaling
            elseif effect == 5 then
                ce.total_ascension_bonus = ce.total_ascension_bonus + ce.ascension_bonus
            end
        end
    end
}
