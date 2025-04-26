local CryptidSleeve = CardSleeves.Sleeve({
    key = "cryptid",
    name = "Ritual Cryptidae",
    atlas = "cardSleeves",
    pos = { x = 2, y = 0 },
    unlocked = true,
    discovered = true,
    loc_vars = function(self)
        return { vars = {} }
    end,
    apply = function(self)
        G.GAME.cryptid_sleeve_enabled = true
    end,
})