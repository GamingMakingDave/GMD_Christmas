ESX = exports['es_extended']:getSharedObject()

xSound = exports.xsound
SantaClausSpawned = false
Musicplay = false
PlayerInSearch = false
PlayerSearching = {}

local PedCoords = {}
local blips = {}
local EnteredRadius = false
local showHelp = true
local DeerCount = 0
local HelpDistance = 15
local DeerFinished = false
local HasUsedItem = false

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
                    if hasFinishedDeerGame == true then
                        OpenGiftMenu()
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

RegisterNetEvent('GMD_Christmas:usedDeerItem')
AddEventHandler('GMD_Christmas:usedDeerItem', function()
    HasUsedItem = true
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
            table.insert(blips, blip)
            DeerCount = #shuffled
        end
    end
end

-- function CreateGiftBlips()
--     for _, v in ipairs(Config.GiftJob) do
--         local shuffled = {}

--         for i = 1, math.random(1, 15) do
--             local randIndex = math.random(1, #v.Coords)
--             table.insert(shuffled, v.Coords[randIndex])
--             table.remove(v.Coords, randIndex)
--         end

--         for i, Coords in ipairs(shuffled) do
--             if v.EnableChristmasDoorAnim then
--                 RequestModel(GetHashKey(v.DeerPedModel))
--                 while not HasModelLoaded(v.DeerPedModel) do
--                     Wait(15)
--                 end

--                 PedSpawn = CreatePed(4, GetHashKey(v.DeerPedModel), Coords.x, Coords.y, Coords.z, Coords.h, false, true)
--             else
--                 local blip = AddBlipForEntity(PedSpawn)
--                 SetBlipSprite(blip, 40)
--                 SetBlipColour(blip, 2)
--                 SetBlipScale(blip, 0.5)
--                 SetBlipAsShortRange(blip, true)

--                 local blipLabel = "Gift Delivery"
--                 AddTextEntry("BLIP_NAME", blipLabel)
--                 BeginTextCommandSetBlipName("BLIP_NAME")
--                 AddTextComponentSubstringPlayerName(blipLabel)
--                 EndTextCommandSetBlipName(blip)
--             end
--         end
--     end
-- end

CreateThread(function()
    while true do
        Wait(5)

        local pedCoords = GetEntityCoords(PlayerPedId())
        local Ped = ESX.Game.GetClosestPed(pedCoords)
        
        if GetEntityModel(Ped) == GetHashKey('a_c_deer') then
            local dist = #(pedCoords - GetEntityCoords(Ped))
            if dist <= HelpDistance then
                showsubtitle('Du bist in der Nähe eines meines Rentiers halte deine Augen offen', 2000)

                if dist <= 5.0 then
                    showsubtitle('Du siehst mein Rentrier nutze das ITEM was ich dir gegeben habe!', 2000)
                    if PlayerInSearch and HasUsedItem then
                        if DeerCount == 1 then
                            DeerCount = 0
                            PlayerInSearch = false
                                for _, blip in ipairs(blips) do
                                    RemoveBlip(blip)
                                    DeleteEntity(Ped)
                                end
                            ShowCustomScaleform()
                            Wait(1000)
                            TriggerServerEvent('GMD_Christmas:giveXmasSearchStocking')
                        else 
                            DeerCount = DeerCount - 1
                            for _, blip in ipairs(blips) do
                                RemoveBlip(blip)  -- Lösche den Blip
                                DeleteEntity(Ped)
                            end
                        end
                    end
                    Wait(1000)
                else
                    Wait(500)
                end
                Wait(1000)
            end
        else
            Wait(1000)
        end
    end
end)



function ShowCustomScaleform()
    local scaleformHandle = RequestScaleformMovie("mp_big_message_freemode")
    local eventActive = true

    while not HasScaleformMovieLoaded(scaleformHandle) do
        Wait(1000)
    end

    BeginScaleformMovieMethod(scaleformHandle, "SHOW_SHARD_WASTED_MP_MESSAGE")
    PushScaleformMovieMethodParameterString("MISSION PASSED")
    PushScaleformMovieMethodParameterString("HO ho HO... Du hast all meine Rentiere gefunden, hier ein Dankeschön für deine Mühe!")
    PushScaleformMovieMethodParameterInt(5)
    EndScaleformMovieMethod()

    CreateThread(function()
        while eventActive do  -- Schleife läuft nur, wenn das Ereignis aktiv ist
            Wait(0)
            DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255)
        end
    end)

    local pedCoords = GetEntityCoords(PlayerPedId())
    xSound:PlayUrlPos("Xmas1", "https://www.youtube.com/watch?v=maZQ3vURGVs", 1.0, pedCoords, false)

    Wait(5000)
    SetScaleformMovieAsNoLongerNeeded(scaleformHandle)
    eventActive = false
end


-- CreateThread(function()
--     while true do
--         Wait(500)
--         if DeerFinished then
--             local scaleformHandle = RequestScaleformMovie("mp_big_message_freemode") -- The scaleform you want to use
--             while not HasScaleformMovieLoaded(scaleformHandle) do -- Ensure the scaleform is actually loaded before using
--             Wait(0)
--             end
        
--             BeginScaleformMovieMethod(scaleformHandle, "SHOW_SHARD_WASTED_MP_MESSAGE") -- The function you want to call from the AS file
--             PushScaleformMovieMethodParameterString("Big Text") -- bigTxt
--             PushScaleformMovieMethodParameterString("Smaller Text") -- msgText
--             PushScaleformMovieMethodParameterInt(5) -- colId
--             EndScaleformMovieMethod() -- Finish off the scaleform, it returns no data, so doesnt need "EndScaleformMovieMethodReturn"
    
--             while true do -- Draw the scaleform every frame
--             Wait(0)
--             DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255) -- Draw the scaleform fullscreen
--             end
--             Wait(6000)
--             DeerFinished = false
--             break
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

RegisterCommand("scale", function(source, args, rawCommand)
    ShowCustomScaleform('MISSION PASSED', 'YOU FIND ALL DEERS', 6000)
end, false)


RegisterCommand("testDeer", function(source, args, rawCommand)
    SpawnSearchDears()
end, false)

RegisterCommand("playmusic", function(source, args, rawCommand)
    xSound:PlayUrlPos("Xmas", Config.ChristmasMusicLink, 0.1, Config.ChristmasMarket, true)
    xSound:Distance("Xmas", Config.ChristmasMarketRadius)
end, false)


RegisterCommand("playmusic1", function(source, args, rawCommand)
    local pedCoords = GetEntityCoords(PlayerPedId())
    xSound:PlayUrlPos("Xmas1", "https://www.youtube.com/watch?v=ndgsWcd3yUs", 1.0, pedCoords, false)
end, false)