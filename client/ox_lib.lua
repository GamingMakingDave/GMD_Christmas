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
                    showsubtitle("Danke dir nochmals für deine Hilfe!!", 1000)
                    Wait(1500)
                    showsubtitle("Wenn du magst könntest du mir helfen Geschenke auszuliefern?", 1000)
                    Wait(1500)
                    showsubtitle("Ich Belohne dich mit Goldene Tickets die du denn bei meinem Wichtel", 1000)
                    Wait(1500)
                    showsubtitle("eintauschen desso mehr du mir Hilfst desso ein besseres Geschenk erhältst du von mir", 1500)
                    Wait(2000)
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
                    showsubtitle("Mir sind meine Rentiere entlaufen und mit euren geschenken abgehauen!!", 2500)
                    Wait(3500)
                    showsubtitle("Kannst du sie suchen helfen?", 2500)
                    Wait(3000)
                    showsubtitle("Ansonsten war es das mit dem Weihnachtsfest und ihr müsst ohne Geschenke auskommen", 4500)
                    Wait(5000)
                    showsubtitle("Hier hast du von mir ein Zuckerstangen Laufstock, nutze ihn wenn du eines meiner", 4500)
                    Wait(5000)
                    showsubtitle("Rentiere siehst ich komme dann...", 3000)
                    Wait(3500)
                    TriggerServerEvent('GMD_Christmas:giveXmasSearchItem')
                    SpawnSearchDears()
                end,
            }
        }
    })
    lib.showContext('DeerMenu')
end