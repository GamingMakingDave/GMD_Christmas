ESX = exports['es_extended']:getSharedObject()

xSound = exports.xsound
SantaClausSpawned = false
Musicplay = false
PlayerInSearch = false
PlayerInGiftJob = false
PlayerSearching = {}

EnteredRadius = false

DeleteNearBlip = false


local PedCoords = {}
local blips = {}
local blipsGift = {}
local GiftCoordsTbl = {}
local EnteredRadius = false
local EnteredGiftRadius = false
local showHelp = true
local DeerCount = 0
local GiftCount = 0
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
    xSound:PlayUrlPos("Xmas", Config.ChristmasMusicLink, Config.ChristmasMusicVolume, Config.ChristmasMarket)
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
        TaskPlayAnim(santa, "random@drunk_driver_1", "drunk_driver_stand_loop_dd1", 8.0, 8.0, -1, 1, 0, false, false,
            false)
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

            local blipLabel = "Santas Deer"
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
                showsubtitle((Config.Language[Config.Local]['santa_distance_massage']), 2000)

                if dist <= 10.0 then
                    showsubtitle((Config.Language[Config.Local]['has_found_deer']), 2000)
                    if PlayerInSearch and HasUsedItem then
                        DeleteNearBlip =true
                        if DeerCount == 1 then
                            DeerCount = 0
                            PlayerInSearch = false

                            local playerPos = GetEntityCoords(PlayerPedId(), false)

                            if DeleteNearBlip then
                                for _, blip in ipairs(blips) do
                                    local blipPos = GetBlipCoords(blip)
                                    local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, blipPos.x, blipPos.y, blipPos.z)
                                    if distance < 10.0 then
                                        local entity = GetBlipInfoIdEntityIndex(blip)
                                        RemoveBlip(blip)
                                        Wait(500)
                                        RequestNamedPtfxAsset("scr_rcbarry1")
                                        while not HasNamedPtfxAssetLoaded("scr_rcbarry1") do
                                            Wait(1)
                                        end

                                        UseParticleFxAsset("scr_rcbarry1")
                                        StartParticleFxLoopedOnEntity("scr_alien_teleport", Ped, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, false, false, false, false)
                                        Wait(2000)
                                        DeleteEntity(entity)
                                        DeleteNearBlip = false
                                        HasUsedItem = false
                                        break
                                    end
                                end
                            end
                            ShowCustomScaleform()
                            Wait(1000)
                            TriggerServerEvent('GMD_Christmas:giveXmasSearchStocking')
                        else

                            DeerCount = DeerCount - 1

                            local playerPos = GetEntityCoords(PlayerPedId(), false)

                            for _, blip in ipairs(blips) do
                                local blipPos = GetBlipCoords(blip)
                                local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, blipPos.x, blipPos.y, blipPos.z)
                                if DeleteNearBlip then
                                    if distance < 10.0 then
                                        local entity = GetBlipInfoIdEntityIndex(blip)
                                        RemoveBlip(blip)
                                        Wait(500)
                                        RequestNamedPtfxAsset("scr_rcbarry1")
                                        while not HasNamedPtfxAssetLoaded("scr_rcbarry1") do
                                            Wait(1)
                                        end

                                        UseParticleFxAsset("scr_rcbarry1")
                                        StartParticleFxLoopedOnEntity("scr_alien_teleport", Ped, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, false, false, false, false)
                                        Wait(2000)
                                        DeleteEntity(entity)
                                        showsubtitle(Config.Language[Config.Locale]['santa_found_massage']:format(DeerCount), 2000)
                                        Wait(2500)
                                        DeleteNearBlip = false
                                        HasUsedItem = false
                                        break
                                    end
                                end
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
    PushScaleformMovieMethodParameterString((Config.Language[Config.Local]['scaleform_big_text']))
    PushScaleformMovieMethodParameterString((Config.Language[Config.Local]['scaleform_small_text']))
    PushScaleformMovieMethodParameterInt(5)
    EndScaleformMovieMethod()

    CreateThread(function()
        while eventActive do
            Wait(0)
            DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255)
        end
    end)

    local pedCoords = GetEntityCoords(PlayerPedId())
    PlaySoundFrontend(-1, "HUD_AWARDS", "FLIGHT_SCHOOL_LESSON_PASSED", 1)

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

if Config.Debug then
    RegisterCommand("debugDeer", function(source, args, rawCommand)
        SpawnSearchDears()
    end, false)

    RegisterCommand("debugGift", function(source, args, rawCommand)
        GiftJob()
        PlayerInGiftJob = true
    end, false)
end

-- Giftjob
function GiftJob()
    for _, v in ipairs(Config.GiftJob) do
        local shuffled = {}

        for i = 1, v.GiftCount do
            local randIndex = math.random(1, #v.CoordsGift)
            print(randIndex)
            table.insert(shuffled, v.CoordsGift[randIndex])
            table.remove(v.CoordsGift, randIndex)
        end

        for i, CoordsGift in ipairs(shuffled) do
            GiftCoordsTbl = shuffled
            local veccoords = Convert4to3(CoordsGift)
            local blipGift = AddBlipForCoord(veccoords)
            PlayerInGiftJob = true
            SetBlipSprite(blipGift, 40)
            SetBlipDisplay(blipGift, 4)
            SetBlipScale(blipGift, 1.0)
            SetBlipColour(blipGift, 2)
            SetBlipAsShortRange(blipGift, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Santas Giftjob")
            EndTextCommandSetBlipName(blipGift)
            table.insert(blipsGift, blipGift)
            GiftCount = #shuffled
        end
    end
end

CreateThread(function()
    while true do
        Wait(5)
        EnteredGiftRadius = false
        local pedCoords = GetEntityCoords(PlayerPedId())
        local Ped = ESX.Game.GetClosestPed(pedCoords)
        if PlayerInGiftJob then
            for k, v in pairs(GiftCoordsTbl) do
                local dist = #(pedCoords - vector3(v.x, v.y, v.z))
                if dist <= 5.0 then
                    EnteredGiftRadius = true

                    ESX.ShowHelpNotification('Drück mal E du lelek')
                    if IsControlJustReleased(0, 38) then
                        print("lol")

                        GiftScense(v)
                        table.remove(GiftCoordsTbl, k)
                        Wait(2000)
                    end
                end
            end

            if not EnteredGiftRadius then
                Wait(1000)
            end
        else
            Wait(5000)
        end
    end
end)

function GiftScense(v)

    local pedCoords = GetEntityCoords(PlayerPedId())

    RequestModel(GetHashKey("a_f_m_prolhost_01"))
    while not HasModelLoaded("a_f_m_prolhost_01") do
        Wait(15)
    end

    local player = PlayerPedId()
    local heading = v[4]
    local PedoffsetX = 1.0 * math.sin(math.rad(heading))
    local PedoffsetY = 1.0 * math.cos(math.rad(heading))
    local PlayeroffsetX = 1.0 * math.sin(math.rad(heading))
    local PlayoffsetY = 1.0 * math.cos(math.rad(heading))

    FreezeEntityPosition(player, true)
    SetEntityCoords(player, v.x, v.y, v.z - 1, 0.0, 0.0, 0.0, false)
    SetEntityHeading(player, v[4])
    playAnimGift("timetable@jimmy@doorknock@", "knockdoor_idle", 3000)
    Wait(4000)
    SetEntityCoords(player, v.x + PlayeroffsetX, v.y - PlayoffsetY, v.z - 1, 0.0, 0.0, 0.0, false)
    local giftPed = CreatePed(4, GetHashKey("a_f_m_prolhost_01"), v.x, v.y, v.z - 1.0, heading, false,
        true)
    TaskLookAtEntity(giftPed, player, -1, 0, 2, 1)
    TaskTurnPedToFaceEntity(giftPed, player, -1)
    Wait(500)

    PlayPedAmbientSpeechNative(giftPed, "GENERIC_HI", "Speech_Params_Force", 1)

    showsubtitle((Config.Language[Config.Local]['npc_hello']), 1000)
    Wait(1500)
    local GiftmodelHash = GetHashKey("bz_prop_gift2")
    local bone = GetPedBoneIndex(PlayerPedId(), 57005)

    RequestModel(GiftmodelHash)
    while not HasModelLoaded(GiftmodelHash) do
        Wait(500)
    end

    playAnimGiveGift("bz@give_love@anim", "bz_give", 1500)
    Wait(500)
    GiftProp = CreateObject(GiftmodelHash, 0, 0, 0, 1, 1, 0)

    AttachEntityToEntity(GiftProp, PlayerPedId(), bone, 0.15, -0.08, -0.08, 10.0, -130.0, -80.0, 1, 1,
        0, 0, 2, 1)
    FreezeEntityPosition(player, false)
    showsubtitle((Config.Language[Config.Local]['npc_thanks_for_gift']), 2000)
    Wait(500)
    PlayPedAmbientSpeechNative(giftPed, "GENERIC_THANKS", "Speech_Params_Force", 1)
    Wait(500)
    Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(GiftProp))
    GiftProp = CreateObject(GiftmodelHash, 0, 0, 0, 1, 1, 0)
    AttachEntityToEntity(GiftProp, giftPed, GetPedBoneIndex(giftPed, 57005), 0.15, -0.08, -0.08, 10.0,
        -130.0, -80.0, 1, 1, 0, 0, 2, 1)
    TaskPlayAnim(giftPed, "bz@give_love@anim", "bz_give", 1.0, -1.0, 3000, 49, 1, false, false, false)
    Wait(3500)
    Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(GiftProp))
    Wait(500)
    ClearPedTasks(giftPed)
    SetEntityHeading(giftPed, v[4])
    Wait(500)
    ClearPedTasks(PlayerPedId())
    DeleteEntity(giftPed)
    if GiftCount == 1 then
        GiftCount = 0
        for _, blipGift in ipairs(blipsGift) do
            local blipPos = GetBlipCoords(blipGift)
            local distance = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, blipPos.x, blipPos.y,
                blipPos.z)

            if distance < 10.0 then
                local entity = GetBlipInfoIdEntityIndex(blipGift)
                RemoveBlip(blipGift)
                TriggerServerEvent('GMD_Christmas:giveXmasGiftTicket')
                break
            end
        end
    else
        GiftCount = GiftCount - 1
        for _, blipGift in ipairs(blipsGift) do
            local blipPos = GetBlipCoords(blipGift)
            local distance = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, blipPos.x, blipPos.y,
                blipPos.z)

            if distance < 10.0 then
                local entity = GetBlipInfoIdEntityIndex(blipGift)
                RemoveBlip(blipGift)
                TriggerServerEvent('GMD_Christmas:giveXmasGiftTicket')
                break
            end
        end
    end
end

function Convert4to3(Coords)
    return vector3(Coords.x, Coords.y, Coords.z)
end

function playAnimGift(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end

function playAnimGiveGift(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end
