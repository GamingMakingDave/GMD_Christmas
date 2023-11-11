ESX = exports['es_extended']:getSharedObject()

xSound = exports.xsound
SantaClausSpawned = false
Musicplay = false
PlayerInSearch = false
PlayerSearching = {}

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then 
         xSound:Destroy("Xmas")
         PlayXmasMusik()
    end
end)

CreateThread(function()
    while true do
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


local EnteredRadius = false

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
                        Wait(500)
                        showsubtitle("Mir sind meine Rentiere entlaufen und mit euren geschenken abgehauen!!", 1000)
                        Wait(1500)
                        showsubtitle("Kannst du sie suchen helfen?", 1000)
                        Wait(1500)
                        showsubtitle("Ansonsten war es das mit dem Weihnachtsfest und ihr müsst ohne Geschenke auskommen", 1000)
                        Wait(1500)
                        showsubtitle("Hier hast du von mir ein Zuckerstangen Laufstock, nutze ihn wenn du eines meiner", 1000)
                        Wait(1500)
                        showsubtitle("Rehntiere siehst ich komme dann...", 1000)
                        Wait(1500)
                        TriggerServerEvent('GMD_Christmas:giveXmasSearchItem')
                        TriggerServerEvent('GMD_Christmas:SpawnPeds')
                    end
                end
            end

        if not EnteredRadius then
            Wait(1000)
        end
    end
end)

-- CreateThread(function()
--     while true do
--         Wait(0)
--         local dist = #(GetEntityCoords(PlayerPedId()) - Config.SantaClausPosition)
--         if dist <= 2.0 and not LegalPressed then
--             ESX.ShowHelpNotification((Config.Language[Config.Local]['santa_helptext']))
--             if IsControlJustPressed(0, 38) then
--                 Wait(500)
--                 showsubtitle("Mir sind meine Rentiere entlaufen und mit euren geschenken abgehauen!!", 1000)
--                 Wait(1500)
--                 showsubtitle("Kannst du sie suchen helfen?", 1000)
--                 Wait(1500)
--                 showsubtitle("Ansonsten war es das mit dem Weihnachtsfest und ihr müsst ohne Geschenke auskommen", 1000)
--             else
--                 Wait(2000)
--             end
--         end
--     end
-- end)

function showsubtitle(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end

RegisterCommand("stopmusic", function(source, args, rawCommand)
    xSound:Destroy("Xmas")
end, false)

RegisterCommand("playmusic", function(source, args, rawCommand)
    xSound:PlayUrlPos("Xmas", Config.ChristmasMusicLink, 0.1, Config.ChristmasMarket, true)
    xSound:Distance("Xmas", Config.ChristmasMarketRadius)
end, false)