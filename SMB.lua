SMB = {}

SMODS.load_file("utils/main_util.lua")()

SMB.load_cards("modules/jokers")
if CardSleeves then
    SMB.load_cards("modules/sleeves")
end

SMODS.Atlas { key = "cardSleeves", path = "atlasSleeves.png", px = 73, py = 95}
SMODS.Atlas { key = "jokers", path = "Jokers.png", px = 71, py = 95}