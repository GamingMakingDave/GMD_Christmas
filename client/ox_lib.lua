function OpenGiftMenu()
    lib.registerContext({
        id = 'FullMenu',
        title = 'Santa Claus',
        options = {
            {
                title = 'Gift Job',
                description = 'Earn additional Golden Tickets',
                icon = 'user',
                arrow = true,
                onSelect = function()
                    Wait(500)
                    showsubtitle((Config.Language[Config.Local]['thanks_oxlib']), 2000)
                    Wait(2500)
                    showsubtitle((Config.Language[Config.Local]['thanks_1_oxlib']), 3000)
                    Wait(3500)
                    showsubtitle((Config.Language[Config.Local]['thanks_3_oxlib']), 2000)
                    Wait(2500)
                    GiftJob()
                end,
            }
        }
    })
    lib.showContext('FullMenu')
end

function OpenDeerMenu()
    lib.registerContext({
        id = 'DeerMenu',
        title = 'Santa Claus',
        options = {
            {
                title = 'Deer Searching',
                description = 'Help Santa find his reindeer',
                icon = 'image-portrait',
                arrow = true,
                onSelect = function()
                    Wait(500)
                    showsubtitle((Config.Language[Config.Local]['DeerSearch_1']), 2500)
                    Wait(3500)
                    showsubtitle((Config.Language[Config.Local]['DeerSearch_2']), 2500)
                    Wait(3000)
                    showsubtitle((Config.Language[Config.Local]['DeerSearch_3']), 4500)
                    Wait(5000)
                    showsubtitle((Config.Language[Config.Local]['DeerSearch_4'])"Hier hast du von mir ein Zuckerstangen Laufstock, nutze ihn wenn du eines meiner", 4500)
                    Wait(5000)
                    TriggerServerEvent('GMD_Christmas:giveXmasSearchItem')
                    SpawnSearchDears()
                end,
            }
        }
    })
    lib.showContext('DeerMenu')
end