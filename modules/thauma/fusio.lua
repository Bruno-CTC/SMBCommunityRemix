SMB.ThaumaConsumable {
    key = "smb_fusio",
    config = {
        max_highlighted = 5,  -- max jokers you can merge at once
    },
    loc_txt = {
        name = "Fusio",
        text = {
            "Select up to #1# Jokers to {C:attention}Merge{} into one new joker.",
            "Resulting card rarity depends on combined rarity values."
        }
    },
    loc_vars = function(self, info_queue, card)
        -- Provide UI variables like max_selected for text display
        return {
            vars = { card.ability.max_highlighted }
        }
    end,

    can_use = function(self, card)
        local selected = G.jokers.highlighted or {}
        if #selected < 2 or #selected > card.ability.max_highlighted then
            return false
        end

        return true
    end,

    use = function(self, card, area, copier)
        local selected = G.jokers.highlighted or {}
        local total_value = 0

        for _, joker in ipairs(selected) do
            if joker.config.center and joker.config.center.rarity then
                local value = 1
                if joker.config.center.rarity == 2 then
                    value = 2
                elseif joker.config.center.rarity == 3 then
                    value = 4
                elseif joker.config.center.rarity == "cry_epic" then
                    value = 12
                elseif joker.config.center.rarity == 4 then
                    value = 20
                elseif joker.config.center.rarity == "cry_exotic" then
                    value = 50
                elseif joker.config.center.rarity == "entr_entropic" then
                    value = 60
                end
                total_value = total_value + value
            end
        end
        print("Total value: " .. total_value)

        local v1 = nil
        local v2 = nil
        if total_value < 2 then
            v1 = 0
        elseif total_value < 4 then
            v1 = 0.8
        elseif total_value < 10 then
            v1 = 0.98
        elseif total_value < 20 then
            v1 = "cry_epic"
        elseif total_value < 50 then
            v2 = true
        elseif total_value < 60 then
            v1 = "cry_exotic"
        else
            v1 = pseudorandom_element({"cry_exotic", "cry_exotic", "entr_entropic"}, pseudoseed("smb_fusio"))
        end

        G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, v2, v1, nil, nil, nil, "smb_fusio")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))

        G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
                for _, joker in ipairs(selected) do
                    joker:start_dissolve(nil, nil)
                end
				return true
			end,
		}))

        delay(0.6)
    end
}
