local IndexCard = SMB.ErroredCard{
    key = "index",
    config = {},
    pos = {x = 2, y = 0},
    loc_txt = {
        name = 'Error: Index out of range',
        text = {
            "All cards in your next pack are glitched."
        }
    },
    can_use = function (self, card) return true end,
    use = function(self, card, area, copier)
        G.index_amount = G.index_amount or 0
        G.index_amount = G.index_amount + 1
    end
}