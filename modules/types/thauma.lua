SMB.Thauma = SMODS.ConsumableType{
    key = "m_smb_thauma",
    primary_colour = HEX('BB9A39'),
    secondary_colour = HEX('2F0E4F'),
    -- default = "c_smb_end",
    loc_txt = {
        name = 'Thauma',
        collection = 'Thauma Cards'
    },
    collection_rows = { 4, 5 },
    shop_rate = 0
}

SMB.ThaumaConsumable = SMODS.Consumable:extend {
    set = "m_smb_thauma",
	atlas = "smb_thauma",
    unlocked = true,
	discovered = true,
}