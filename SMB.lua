SMB = {}

SMODS.load_file("modules/jokers/dreamJoker.lua")
SMODS.load_file("utils/main_util.lua")()

SMODS.Atlas { key = "cardSleeves", path = "atlasSleeves.png", px = 73, py = 95}
SMODS.Atlas { key = "jokers", path = "atlasJokers.png", px = 71, py = 95}
SMODS.Atlas { key = "erroredCards", path = "atlasErrored.png", px = 65, py = 95}
SMODS.Atlas { key = "thauma", path = "atlasThauma.png", px = 65, py = 95}

-- THIS SHOULD ALWAYS BE LOADED FIRST SINCE IT CONTAINS THE BASE CARD TYPES THAT IS LOADED LATER
SMB.load_cards("modules/types")


--SMB.load_cards("modules/sins")
--SMB.load_cards("modules/errored")
--SMB.loadDirectory("modules/thauma")
SMB.load_cards("modules/jokers")
if CardSleeves then
    SMB.load_cards("modules/sleeves")
end
if Partner_API then
    SMB.load_cards("modules/partners")
end