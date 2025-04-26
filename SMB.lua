SMB = {}

SMODS.load_file("modules/jokers/dreamJoker.lua")
SMODS.load_file("utils/main_util.lua")()

SMODS.Atlas { key = "cardSleeves", path = "atlasSleeves.png", px = 73, py = 95}
SMODS.Atlas { key = "jokers", path = "Jokers.png", px = 71, py = 95}
SMODS.Atlas { key = "erroredCards", path = "atlasErrored.png", px = 65, py = 95}

-- THIS SHOULD ALWAYS BE LOADED FIRST SINCE IT CONTAINS THE BASE CARD TYPES THAT IS LOADED LATER
SMB.load_cards("modules/types")


SMB.load_cards("modules/errored")
SMB.load_cards("modules/jokers")
if CardSleeves then
    SMB.load_cards("modules/sleeves")
end