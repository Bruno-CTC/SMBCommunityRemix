SMB.Sin = SMODS.ConsumableType{
    key = "m_smb_sin",
    primary_colour = HEX('090303'),
    secondary_colour = HEX('6C2325'),
    -- default = "c_smb_end",
    loc_txt = {
        name = 'Sin',
        collection = 'Sin Cards'
    },
    collection_rows = { 4, 5 },
    shop_rate = 0
}

SMB.SinConsumable = SMODS.Consumable:extend {
    set = "m_smb_sin",
	atlas = "smb_erroredCards",
    unlocked = true,
	discovered = true,
}