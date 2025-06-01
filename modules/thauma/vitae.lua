SMB.ThaumaConsumable {
    key = "smb_vitae",
    loc_txt = {
        name = "Vitae",
        text = {
            "Select 2 jokers, destroy the left one but increase",
            "all values on the right one by a value dependant",
            "on the rarity of the destroyed joker.",
        }
    },

    can_use = function(self, card)
        local selected = G.jokers.highlighted or {}
        if #selected == 2 then
            return true
        end

        return false
    end,

    use = function(self, card, area, copier)
        local joker1 = nil
        local joker2 = nil
        for i, v in pairs(G.jokers.cards) do 
            if v.highlighted then 
                if not joker1 then
                    joker1 = v
                elseif not joker2 then
                    joker2 = v
                    break
                end
            end 
        end

        if not joker1 or not joker2 then
            return
        end

        local mult = 1.1
        if joker1.config.center and joker1.config.center.rarity then
            if joker1.config.center.rarity == 2 then
                mult = 1.2
            elseif joker1.config.center.rarity == 3 then
                mult = 1.5
            elseif joker1.config.center.rarity == "cry_epic" then
                mult = 2
            elseif joker1.config.center.rarity == 4 then
                mult = 4
            elseif joker1.config.center.rarity == "cry_exotic" then
                mult = 10
            elseif joker1.config.center.rarity == "entr_entropic" then
                mult = 15
            end
        end

        SMB.FlipThen({joker2}, function (card2, area)
            Cryptid.with_deck_effects(card2, function(card3)
                Cryptid.misprintize(card3, { min = mult, max = mult }, nil, true)
            end) 
        end)

        G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
                joker1:start_dissolve(nil, nil)
				return true
			end,
		}))

        delay(0.6)
    end
}
