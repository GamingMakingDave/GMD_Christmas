ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('GMD_Christmas:giveXmasSearchItem')
AddEventHandler('GMD_Christmas:giveXmasSearchItem', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('santas_sugar_stick', 1)
end)

RegisterServerEvent('GMD_Christmas:SpawnPeds')
AddEventHandler('GMD_Christmas:SpawnPeds', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    -- hier Spawn Rehntiere in zone
end)

RegisterServerEvent('GMD_Christmas:SyncPeds')
AddEventHandler('GMD_Christmas:SyncPeds', function()
    TriggerClientEvent('GMD_Christmas:SyncPedsByPlayer', -1)
end)


ESX.RegisterServerCallback('GMD_Christmas:HasMissionFinished', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        local identifier = xPlayer.identifier

        MySQL.Async.fetchAll('SELECT hasFinishedDeerGame FROM users WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(result)
            if result[1] and result[1].hasFinishedDeerGame then
                cb(true)
            else
                cb(false)
            end
        end)
    else
        cb(false)
    end
end)

