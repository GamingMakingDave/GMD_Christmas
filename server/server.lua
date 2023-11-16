ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('GMD_Christmas:giveXmasSearchItem')
AddEventHandler('GMD_Christmas:giveXmasSearchItem', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('santas_sugar_stick', 1)
end)

RegisterServerEvent('GMD_Christmas:giveXmasSearchStocking')
AddEventHandler('GMD_Christmas:giveXmasSearchStocking', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('christmas_stocking', 1)
end)

ESX.RegisterUsableItem('christmas_stocking', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local CanCarryItems = true
    local Items = {}

    for i, item in pairs(Config.DeerZones[1].DeerFinishedItems) do
        
        local random = math.random(1, Config.DeerZones[1].DeerFinishedSugarItems)

        if xPlayer.canCarryItem(item, random) then
            table.insert(Items, {item, random})
        else
            CanCarryItems = false
            break
        end
    end

    if not CanCarryItems then
        print("dein Inventar ist zu voll für die items lol")
    else
        for k, v in ipairs(Items) do
            xPlayer.addInventoryItem(v.item, v.random)
        end

        xPlayer.addInventoryItem(Config.DeerZones[1].GoldTicker, Config.DeerZones[1].DeerRandomTicketCount)
        xPlayer.removeInventoryItem('christmas_stocking', 1)
    end
end)

-- RegisterServerEvent('GMD_Christmas:SpawnPeds')
-- AddEventHandler('GMD_Christmas:SpawnPeds', function(source)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     -- hier Spawn Rehntiere in zone
-- end)

RegisterServerEvent('GMD_Christmas:SyncPeds')
AddEventHandler('GMD_Christmas:SyncPeds', function()
    TriggerClientEvent('GMD_Christmas:SyncPedsByPlayer', -1)
end)

ESX.RegisterServerCallback('GMD_Christmas:HasMissionFinished', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    -- Überprüfen, ob der Spieler in der Datenbank existiert
    MySQL.Async.fetchScalar('SELECT * FROM xmas WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(result)

        if result == nil then
            MySQL.Async.execute('INSERT INTO xmas (identifier, hasFinishedDeerGame) VALUES (@identifier, 0)', {
                ['@identifier'] = xPlayer.getIdentifier()
            })
            cb(false)
        else
            if tonumber(result[1].hasFinishedDeerGame) == 1 then
                cb(true)
            else
                cb(false)
            end
        end
    end)
end)
