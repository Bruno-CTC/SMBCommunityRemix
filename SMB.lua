smb = {}
SMODS.Atlas { key = "cardSleeves", path = "atlasSleeves.png", px = 73, py = 95}
assert(load(NFS.read(SMODS.current_mod.path .. "modules/sleeves.lua")))()
SMODS.Atlas { key = "jokers", path = "Jokers.png", px = 71, py = 95}
assert(load(NFS.read(SMODS.current_mod.path .. "modules/jokers.lua")))()

SMODS.Atlas { key = "erroredCards", path = "atlasErrored.png", px = 65, py = 95}
assert(load(NFS.read(SMODS.current_mod.path .. "modules/glitched.lua")))()
