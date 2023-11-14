ESX = exports['es_extended']:getSharedObject()

xSound = exports.xsound
SantaClausSpawned = false
Musicplay = false
PlayerInSearch = false
PlayerSearching = {}
local PedCoords = {}
local EnteredRadius = false

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then 
         xSound:Destroy("Xmas")
         PlayXmasMusik()
    end
end)

CreateThread(function()
    while Config.UseXmasWeather do
		SetWeatherTypePersist("XMAS")
        SetWeatherTypeNowPersist("XMAS")
        SetWeatherTypeNow("XMAS")
        SetOverrideWeather("XMAS")
		Wait(60000)
	end
end)

function PlayXmasMusik()
    MusicPlay = true
    xSound:PlayUrlPos("Xmas", Config.ChristmasMusicLink, Config.ChristmasMusicVolume , Config.ChristmasMarket)
    xSound:Distance("Xmas", Config.ChristmasMarketRadius)
end

CreateThread(function()
    while true do
        Wait(0)
        if not SantaClausSpawned then
            modelHash = Config.SantaClausModel

            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                print("lade")
                Wait(200)
            end
        
            RequestAnimDict("random@drunk_driver_1")

            while not HasAnimDictLoaded("random@drunk_driver_1") do
                Wait(100)
            end

            local santa = CreatePed(5, modelHash, Config.SantaClausPosition, false, true)
            SetEntityInvincible(santa, true)
            SetEntityHeading(santa, Config.SantaClausHeading)
            FreezeEntityPosition(santa, true)
            SetPedCanBeTargetted(santa, false)
            FreezeEntityPosition(santa, true)
            SetEntityInvincible(santa, true)
            SetBlockingOfNonTemporaryEvents(santa, true)
            SetEveryoneIgnorePlayer(PlayerPedId(), true)
            SetPedCanBeTargettedByPlayer(santa, PlayerPedId(), false)
            SetPedCombatAttributes(santa, 46, true)
            SetPedCombatAttributes(santa, 17, true)
            SetPedCombatAttributes(santa, 5, true)
            SetPedCombatAttributes(santa, 20, true)
            SetPedCombatAttributes(santa, 52, true)
            SetPedFleeAttributes(santa, 0, false)
            SetPedFleeAttributes(santa, 128, false)
            SetPedAccuracy(santa, 70)
            SetPedDropsWeaponsWhenDead(santa, false)
            TaskPlayAnim(santa, "random@drunk_driver_1", "drunk_driver_stand_loop_dd1", 8.0, 8.0, -1, 1, 0, false, false, false)
            SantaClausSpawned = true
        end
        break
    end
end)

CreateThread(function()
    while true do
            Wait(0)
            EnteredRadius = false
            local dist = #(GetEntityCoords(PlayerPedId()) - Config.SantaClausPosition)

            if dist <= 3.0 then
                EnteredRadius = true
                if not PlayerInSearch then
                    ESX.ShowHelpNotification((Config.Language[Config.Local]['santa_helptext']))
                    if IsControlJustReleased(0, 38) then
                        ESX.TriggerServerCallback('GMD_Christmas:HasMissionFinished', function(check)
                            if check then
                                OpenFullMenu()
                            else
                                OpenDeerMenu()
                            end
                        end)
                        -- Wait(500)
                        -- showsubtitle("Mir sind meine Rentiere entlaufen und mit euren geschenken abgehauen!!", 1000)
                        -- Wait(1500)
                        -- showsubtitle("Kannst du sie suchen helfen?", 1000)
                        -- Wait(1500)
                        -- showsubtitle("Ansonsten war es das mit dem Weihnachtsfest und ihr müsst ohne Geschenke auskommen", 1000)
                        -- Wait(1500)
                        -- showsubtitle("Hier hast du von mir ein Zuckerstangen Laufstock, nutze ihn wenn du eines meiner", 1000)
                        -- Wait(1500)
                        -- showsubtitle("Rehntiere siehst ich komme dann...", 1000)
                        -- Wait(1500)
                        -- TriggerServerEvent('GMD_Christmas:giveXmasSearchItem')
                    end
                end
            end

        if not EnteredRadius then
            Wait(1000)
        end
    end
end)

function OpenFullMenu()
    lib.registerContext({
        id = 'FullMenu',
        title = 'Santa Claus',
        options = {
            {
                title = 'Deer Searching',
                description = 'Help Santa find his reindeer',
                icon = 'image-portrait',
                arrow = true,
                onSelect = function()
                    Wait(500)
                    showsubtitle("Mir sind meine Rentiere entlaufen und mit euren geschenken abgehauen!!", 1000)
                    Wait(1500)
                    showsubtitle("Kannst du sie suchen helfen?", 1000)
                    Wait(1500)
                    showsubtitle("Ansonsten war es das mit dem Weihnachtsfest und ihr müsst ohne Geschenke auskommen", 1000)
                    Wait(1500)
                    showsubtitle("Hier hast du von mir ein Zuckerstangen Laufstock, nutze ihn wenn du eines meiner", 1000)
                    Wait(1500)
                    showsubtitle("Rentiere siehst ich komme dann...", 1000)
                    Wait(1500)
                    TriggerServerEvent('GMD_Christmas:giveXmasSearchItem')
                    SpawnSearchDears()
                end,
            },
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
                    CreateGiftBlips()
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
                    showsubtitle("Mir sind meine Rentiere entlaufen und mit euren geschenken abgehauen!!", 1000)
                    Wait(1500)
                    showsubtitle("Kannst du sie suchen helfen?", 1000)
                    Wait(1500)
                    showsubtitle("Ansonsten war es das mit dem Weihnachtsfest und ihr müsst ohne Geschenke auskommen", 1000)
                    Wait(1500)
                    showsubtitle("Hier hast du von mir ein Zuckerstangen Laufstock, nutze ihn wenn du eines meiner", 1000)
                    Wait(1500)
                    showsubtitle("Rentiere siehst ich komme dann...", 1000)
                    Wait(1500)
                    TriggerServerEvent('GMD_Christmas:giveXmasSearchItem')
                    SpawnSearchDears()
                end,
            }
        }
    })

    lib.showContext('DeerMenu')
end

function SpawnSearchDears()
    for _, v in ipairs(Config.DeerZones) do
        local shuffled = {}

        for i = 1, v.DeerCount do
            local randIndex = math.random(1, #v.Coords)
            table.insert(shuffled, v.Coords[randIndex])
            table.remove(v.Coords, randIndex)
        end

        for i, Coords in ipairs(shuffled) do
            RequestModel(GetHashKey(v.DeerPedModel))
            while not HasModelLoaded(v.DeerPedModel) do
                Wait(15)
            end

            PedSpawn = CreatePed(4, GetHashKey(v.DeerPedModel), Coords.x, Coords.y, Coords.z, Coords.h, false, true)
            TriggerServerEvent('GMD_Christmas:SyncPeds', PedSpawn)
            SetPedArmour(PedSpawn, 200)
            SetEntityMaxHealth(PedSpawn, 500)
            SetEntityHealth(PedSpawn, 500)
            TaskWanderInArea(PedSpawn, Coords.x, Coords.y, Coords.z, v.DeerZonesRadius, 1, 5.0)

            local blip = AddBlipForEntity(PedSpawn)
            SetBlipSprite(blip, 141)
            SetBlipColour(blip, 1)
            SetBlipScale(blip, 0.8)
            SetBlipAsShortRange(blip, true)

            local blipLabel = "Santas Spur"
            AddTextEntry("BLIP_NAME", blipLabel)
            BeginTextCommandSetBlipName("BLIP_NAME")
            AddTextComponentSubstringPlayerName(blipLabel)
            EndTextCommandSetBlipName(blip)
        end
    end
end

function CreateGiftBlips()
    for _, v in ipairs(Config.GiftJob) do
        local shuffled = {}

        for i = 1, math.random(1, 15) do
            local randIndex = math.random(1, #v.Coords)
            table.insert(shuffled, v.Coords[randIndex])
            table.remove(v.Coords, randIndex)
        end

        for i, Coords in ipairs(shuffled) do
            if v.EnableChristmasDoorAnim then
                RequestModel(GetHashKey(v.DeerPedModel))
                while not HasModelLoaded(v.DeerPedModel) do
                    Wait(15)
                end

                PedSpawn = CreatePed(4, GetHashKey(v.DeerPedModel), Coords.x, Coords.y, Coords.z, Coords.h, false, true)
            else
                local blip = AddBlipForEntity(PedSpawn)
                SetBlipSprite(blip, 40)
                SetBlipColour(blip, 2)
                SetBlipScale(blip, 0.5)
                SetBlipAsShortRange(blip, true)

                local blipLabel = "Gift Delivery"
                AddTextEntry("BLIP_NAME", blipLabel)
                BeginTextCommandSetBlipName("BLIP_NAME")
                AddTextComponentSubstringPlayerName(blipLabel)
                EndTextCommandSetBlipName(blip)
            end
        end
    end
end

function showsubtitle(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end

RegisterCommand("stopmusic", function(source, args, rawCommand)
    xSound:Destroy("Xmas")
end, false)

RegisterCommand("testDeer", function(source, args, rawCommand)
    SpawnSearchDears()
end, false)

RegisterCommand("playmusic", function(source, args, rawCommand)
    xSound:PlayUrlPos("Xmas", Config.ChristmasMusicLink, 0.1, Config.ChristmasMarket, true)
    xSound:Distance("Xmas", Config.ChristmasMarketRadius)
end, false)