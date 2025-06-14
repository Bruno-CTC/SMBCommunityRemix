return {
    descriptions = {
        Back = {

        },
        Partner={
            pnr_partner_trace={
                name = "Trace",
                text = {
                    "{C:xmult}x1{} Mult for each empty {c:attention}Consumable{} slot."
                },
                unlock={
                    "Used {C:attention}Joker",
                    "to win on {C:attention}Gold",
                    "{C:attention}Stake{} difficulty",
                },
            }
        },
        Sleeve = {
            sleeve_smb_binah = {
                name = "Page of Binah",
                text = {
                    "{C:attention}+1{} Booster Pack {C:attention}Size",
                    "{C:attention}+1{} Booster Pack {C:attention}Choice"
                }
            },
            sleeve_smb_binah_alt = {
                name = "Page of Binah",
                text = {
                    "{C:attention}+2{} Booster Pack {C:attention}Size"
                }
            },
            sleeve_smb_gebura = {
                name = "Page of Gebura",
                text = { 
                    '{C:dark_edition}Overscored {C:chips}Chips{} carry',
                    'over to the {C:attention}next round{},',
                    'Start with {C:dark_edition}+1,000 {C:chips}Chips' 
                }
            },
            sleeve_smb_gebura_alt = {
                name = "Page of Gebura",
                text = {
                    '{C:attention}Removes starting {C:chips}Chips',
                    'If you {C:dark_edition}overscored{} enough to win the blind,',
                    'you will gain the tag for that blind.',
                    'Does not work on Boss blinds.'
                }
            },
            sleeve_smb_cryptid = {
                name = "Ritual Cryptidae",
                text = { 
                    '{C:dark_edition}Cryptid{} cards are {C:attention}2x{}',
                    'more likely to appear',
                }
            },
            sleeve_smb_chesed = {
                name = "Page of Chesed",
                text = { 
                    '{C:common}Common{} Jokers give {C:chips}+25 Chips',
                    '{C:uncommon}Uncommon{} Jokers give {C:chips}+50 Chips',
                    '{C:rare}Rare{} Jokers give {C:chips}+100 Chips'
                }
            },
            sleeve_smb_seals = {
                name = "Stamped",
                text = { 
                    '{C:uncommon}1/3{} chance to {C:uncommon}level up{} played hand'
                }
            },
            sleeve_smb_chesed_alt = {
                name = "Page of Chesed",
                text = { 
                    '{C:common}Common{} Jokers give {C:chips}+10 and {X:chips,C:white}x1.05 Chips',
                    '{C:uncommon}Uncommon{} Jokers give {C:chips}+25 and {X:chips,C:white}x1.1 Chips',
                    '{C:rare}Rare{} Jokers give {C:chips}+100 Chips and and {X:chips,C:white}x1.25 Chips'
                }
            },
        },
        Other = {
            smb_crux = {
                name = "Crux",
                text = {
                    "When scored, {C:attention}Crux{} cards permanently",
                    "gain one of the following effects:",
                    "{X:mult,C:white}×1.1{}, {X:chips,C:white}x1.1{}, {C:gold}+$1{}, {X:purple,C:white}^1.01{}",
                    "or {C:gold}+0.25{} Ascension Power"
                }
            },
            smb_crux_effects = {
                name = "Crux Effects",
                text = {
                    "Currently: {X:mult,C:white}×#1#{}, {X:chips,C:white}x#2#{}, {C:gold}+$#3#{},",
                    "{X:purple,C:white}^#4#{} and {C:gold}+#5#{}"
                }
            },
        },
    },
    misc = {
        labels = {
            smb_crux = "Crux"
        }
    }
}