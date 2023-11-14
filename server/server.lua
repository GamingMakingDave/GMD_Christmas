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