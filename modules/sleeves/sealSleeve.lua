local SealSleeve = CardSleeves.Sleeve({
    key = "seals",
    name = "Seal Sleeve",
    atlas = "cardSleeves",
    pos = { x = 4, y = 0 },
    unlocked = true,
    discovered = true,
    loc_vars = function(self)
        return { vars = {} }
    end,
    apply = function(self)
    end,
    calculate = function(self, back, context)
        if context.final_scoring_step and math.random(1,3) == 2 then
            return {level_up = 1}
        end
    end
})