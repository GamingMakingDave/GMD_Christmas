ESX = exports['es_extended']:getSharedObject()

xSound = exports.xsound
SantaClausSpawned = false
Musicplay = false
PlayerInSearch = false
PlayerSearching = {}

PlayerInGriftjob = false

local PedCoords = {}
local blips = {}
local EnteredRadius = false
local showHelp = true
local DeerCount = 0
local HelpDistance = 15
local DeerFinished = false
local HasUsedItem = false

local availablePeds = {
    "a_m_m_acult_01",
    "a_m_o_acult_02",
    "a_m_y_acult_01"
}

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then 
        xSound:Destroy("Xmas")
        PlayXmasMusik()
    end
end)

-- Xmas Weather
CreateThread(function()
    while Config.UseXmasWeather do
		SetWeatherTypePersist("XMAS")
        SetWeatherTypeNowPersist("XMAS")
        SetWeatherTypeNow("XMAS")
        SetOverrideWeather("XMAS")
		Wait(60000)
	end
end)

-- Xmas Market Music + Ped
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


-- Deer searching
RegisterNetEvent('GMD_Christmas:usedDeerItem')
AddEventHandler('GMD_Christmas:usedDeerItem', function()
    HasUsedItem = true
end)

function SpawnSearchDears()
    PlayerInSearch = true
    for _, v in ipairs(Config.DeerZones) do
        local shuffled = {}

        for i = 1, v.DeerCount do
            print(#v.Coords)
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
                                RemoveBlip(blip)
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

-- Scaleform Deer Mission
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

function showsubtitle(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end

-- Commands
RegisterCommand("playmusic", function(source, args, rawCommand)
    xSound:PlayUrlPos("Xmas", Config.ChristmasMusicLink, 0.1, Config.ChristmasMarket, true)
    xSound:Distance("Xmas", Config.ChristmasMarketRadius)
end, false)

RegisterCommand("stopmusic", function(source, args, rawCommand)
    xSound:Destroy("Xmas")
end, false)

RegisterCommand("scale", function(source, args, rawCommand)
    ShowCustomScaleform('MISSION PASSED', 'YOU FIND ALL DEERS', 6000)
end, false)


RegisterCommand("debugDeer", function(source, args, rawCommand)
    SpawnSearchDears()
end, false)

RegisterCommand("debugGift", function(source, args, rawCommand)
    GiftJob()
end, false)

-- Giftjob
function GiftJob()
    for _, v in ipairs(Config.GiftJob) do
        local shuffled = {}

        for i = 1, v.GiftEntryRandom do
            print(#v.CoordsGift)
            local randIndex = math.random(1, #v.CoordsGift)
            table.insert(shuffled, v.CoordsGift[randIndex])
            table.remove(v.CoordsGift, randIndex)
        end

        for i, CoordsGift in ipairs(shuffled) do
            if v.EnableChristmasDoorAnim then
                -- HIER ERROR FIXED COORDS NIL!!
                local player = GetPlayerPed(-1)
                FreezeEntityPosition(player, true)
                SetEntityCoords(player, Coords.x, Coords.y, Coords.z, 0.0,0.0,0.0, false)
                playAnim("timetable@jimmy@doorknock@", "knockdoor_idle", 3000)
                Wait(1000)
                SetEntityCoords(player, Coords.x + 1.0, Coords.y + 1.0, Coords.z, 0.0,0.0,0.0, false)
                GiftPed = CreatePed(4, GetRandomPedHash(), Coords.x, Coords.y, Coords.z, Coords.h, false, true)
                Wait(500)
                playAnim()
            else

                local blip = AddBlipForEntity(v.Coords)
                SetBlipSprite(blip, 492)
                SetBlipColour(blip, 1)
                SetBlipScale(blip, 0.8)
                SetBlipAsShortRange(blip, true)

                local blipLabel = "Santas Giftjob"
                AddTextEntry("BLIP_NAME", blipLabel)
                BeginTextCommandSetBlipName("BLIP_NAME")
                AddTextComponentSubstringPlayerName(blipLabel)
                EndTextCommandSetBlipName(blip)
                table.insert(blips, blip)
                RandomCount = #shuffled
            end
        end
    end
end


-- function GiftJob()
--     PlayerInGriftjob = true
    

--         -- for i, Coords in ipairs(shuffled) do
--         --     if v.EnableChristmasDoorAnim then
--         --         Convert4to3(Coords)
--         --         local player = GetPlayerPed(-1)
--         --         FreezeEntityPosition(player, true)
--         --         SetEntityCoords(player, Coords.x, Coords.y, Coords.z, 0.0,0.0,0.0, false)
--         --         playAnim("timetable@jimmy@doorknock@", "knockdoor_idle", 3000)
--         --         Wait(1000)
--         --         SetEntityCoords(player, Coords.x + 1.0, Coords.y + 1.0, Coords.z, 0.0,0.0,0.0, false)
--         --         GiftPed = CreatePed(4, GetRandomPedHash(), Coords.x, Coords.y, Coords.z, Coords.h, false, true)
--         --         Wait(500)
--         --         playAnim()
--         --     else

--         --         local blip = AddBlipForEntity(v.Coords)
--         --         SetBlipSprite(blip, 492)
--         --         SetBlipColour(blip, 1)
--         --         SetBlipScale(blip, 0.8)
--         --         SetBlipAsShortRange(blip, true)

--         --         local blipLabel = "Santas Giftjob"
--         --         AddTextEntry("BLIP_NAME", blipLabel)
--         --         BeginTextCommandSetBlipName("BLIP_NAME")
--         --         AddTextComponentSubstringPlayerName(blipLabel)
--         --         EndTextCommandSetBlipName(blip)
--         --         table.insert(blips, blip)
--         --         RandomCount = #shuffled
--         --     end
--         -- end
--     end
-- end

function GetRandomPedHash()
    local randomIndex = math.random(1, #availablePeds)
    return GetHashKey(availablePeds[randomIndex])
end


-- RegisterCommand("vecconv", function(source, args, rawCommand)
--     for _, v in ipairs(Config.GiftJob) do
--     print("Vector4")
--     print(v.Coords)
--         for k, x in pairs(v.Coords) do
--             print(x)
--             print(Convert4to3(x))
           
--         end
--     end
-- end, false)

-- function Convert4to3(Coords)
--     return vector3(Coords.x, Coords.y, Coords.z)
-- end


function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
        Wait(0) 
    end
    TaskPlayAnim(GiftPed, animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end
