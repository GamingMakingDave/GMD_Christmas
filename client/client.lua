ESX = exports['es_extended']:getSharedObject()

xSound = exports.xsound
SantaClausSpawned = false
Musicplay = false
PlayerInSearch = false
PlayerSearching = {}

local PedCoords = {}
local EnteredRadius = false
local showHelp = true
local DeerCount = 0
local HelpDistance = 15

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
    if not SantaClausSpawned then
        local modelHash = Config.SantaClausModel

        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
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
end)

CreateThread(function()
    while true do
        Wait(0)
        EnteredRadius = false
        local dist = #(GetEntityCoords(PlayerPedId()) - Config.SantaClausPosition)

        if dist <= 3.0 and not PlayerInSearch then
            EnteredRadius = true

            if showHelp then
                ESX.ShowHelpNotification((Config.Language[Config.Local]['santa_helptext']))
            end

            if IsControlJustReleased(0, 38) then
                showHelp = false
                ESX.TriggerServerCallback('GMD_Christmas:HasMissionFinished', function(hasFinishedDeerGame)
                    if hasFinishedDeerGame then
                        OpenFullMenu()
                    else
                        OpenDeerMenu()
                    end
                end)
            end
        end

        if not EnteredRadius then
            Wait(1000)
            showHelp = true
        end
    end
end)

function SpawnSearchDears()
    PlayerInSearch = true
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

            DeerCount = #shuffled
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

CreateThread(function()
    while true do
        Wait(5)

        local pedCoords = GetEntityCoords(PlayerPedId())
        local Ped = ESX.Game.GetClosestPed(pedCoords)
        
        if GetEntityModel(Ped) == GetHashKey('a_c_deer') then
            local dist = #(pedCoords - GetEntityCoords(Ped))
            if dist <= HelpDistance then
                showsubtitle('Du bist in der Nähe eines meines Rentiers halte deine Augen offen', 2000)

                if dist <= 3.0 then
                    ESX.ShowHelpNotification(Config.Language[Config.Locale]['has_found_deer'])
                    ESX.TriggerServerCallback('GMD_Christmas:HasSearchItem',
                    function(check)
                        if check and PlayerInSearch then
                            if DeerCount == 1 then
                                DeerCount = 0
                                Wait(500)
                                showsubtitle('Danke du hast all meine Rentiere gefunden!', 2000)
                                Wait(2500)
                                showsubtitle('Komme doch bitte erneut zu mir ich brauche weiterhin deine hilfe', 3500)
                                Wait(4000)
                                local scaleformHandle = RequestScaleformMovie("mp_big_message_freemode")
                                while not HasScaleformMovieLoaded(scaleformHandle) do
                                  Citizen.Wait(0)
                                end
                              
                                BeginScaleformMovieMethod(scaleformHandle, "SHOW_SHARD_WASTED_MP_MESSAGE")
                                PushScaleformMovieMethodParameterString("MISSION PASSED")
                                PushScaleformMovieMethodParameterString("Danke dir für deine Hilfe")
                                PushScaleformMovieMethodParameterInt(5)
                                EndScaleformMovieMethod()
                              
                                while true do
                                  Citizen.Wait(0)
                                  DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255)
                                end
                                TriggerServerEvent('GMD_Christmas:giveXmasSearchStocking')
                            else 
                                DeerCount = DeerCount - 1
                            end
                        end
                    end)
                else
                    Wait(500)
                end
            end
        else
            Wait(1000)
        end
    end
end)


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