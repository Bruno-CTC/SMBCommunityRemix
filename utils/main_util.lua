function SMB.loadDirectory(path)
    files = NFS.getDirectoryItems(SMODS.current_mod.path .. path)
    print("[SMB] Loading module: " .. path)
    for i = 1, #files do
        SMODS.load_file(path .. "/" .. files[i])()
    end 
end

function SMB.HandleXMult(amount, card)
    SMODS.calculate_effect({
        x_mult = amount
    }, card)
end

function SMB.HandleXChips(amount, card)
    SMODS.calculate_effect({
        message = localize({ type = "variable", key = "a_xchips", vars = { amount } }),
        Xchip_mod = amount
    }, card)
end

function SMB.HandleDollars(amount, card)
    SMODS.calculate_effect({
        dollars = amount
    }, card)
end

function SMB.HandleExponent(amount, card)
    SMODS.calculate_effect({
        message = localize({
            type = "variable",
            key = "a_powmult",
            vars = {
                number_format(amount),
            },
        }),
        Emult_mod = amount,
        colour = G.C.DARK_EDITION,
    }, card)
end

function SMB.HandleAscensionAdd(amount, card)
    SMODS.calculate_effect({
        plus_asc = amount
    }, card)
end

-- Taken from entropy, dont mind me lmao
function SMB.FlipThen(cardlist, func, before, after)
    for i, v in ipairs(cardlist) do
        local card = cardlist[i]
        if card then
            G.E_MANAGER:add_event(
                Event(
                    {
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            if before then
                                before(card)
                            end
                            if card.flip then
                                card:flip()
                            end
                            return true
                        end
                    }
                )
            )
        end
    end
    for i, v in ipairs(cardlist) do
        local card = cardlist[i]
        if card then
            G.E_MANAGER:add_event(
                Event(
                    {
                        trigger = "after",
                        delay = 0.15,
                        func = function()
                            func(card, cardlist, i)
                            return true
                        end
                    }
                )
            )
        end
    end
    for i, v in ipairs(cardlist) do
        local card = cardlist[i]
        if card then
            G.E_MANAGER:add_event(
                Event(
                    {
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            if card.flip then
                                card:flip()
                            end
                            if after then
                                after(card)
                            end
                            return true
                        end
                    }
                )
            )
        end
    end
end