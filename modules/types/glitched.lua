
--[[SMB.Errored = SMODS.ConsumableType{
    key = "m_smb_errored",
    primary_colour = HEX('6C2325'),
    secondary_colour = HEX('090303'),
    default = "c_smb_end",
    loc_txt = {
        name = 'Errored',
        collection = 'Errored Cards'
    },
    collection_rows = { 4, 5 },
    shop_rate = 0
}

SMB.ErroredCard = SMODS.Consumable:extend {
    set = "m_smb_errored",
	atlas = "smb_erroredCards",
    unlocked = true,
	discovered = true,
}]]