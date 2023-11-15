ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('GMD_Christmas:giveXmasSearchItem')
AddEventHandler('GMD_Christmas:giveXmasSearchItem', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('santas_sugar_stick', 1)
end)

RegisterServerEvent('GMD_Christmas:giveXmasStocking')
AddEventHandler('GMD_Christmas:giveXmasSearchStocking', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('christmas_stocking', 1)
    -- HIER ITEMS ZUR SOCKE HINZUFÜGEN
end)

ESX.RegisterUsableItem('christmas_stocking', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local bagItem = xPlayer.getInventoryItem('christmas_stocking')
    
    if bagItem.count > 0 then
        for i, item in ipairs(DeerFinishedItems) do
            if item.identifier == source then
                if xPlayer.canCarryItem("HIER ITEMS AUS SOCKE") then
                    -- xPlayer.addInventoryItem(item.name, item.quantity)
                    -- table.remove(Playeritems, i)
                    xPlayer.removeInventoryItem('christmas_stocking', 1)
                    -- TriggerClientEvent('GMD_Shops:RemoveShoppingBag', source)
                else
                    xPlayer.showNotification("You can't carry all the items from the shopping bag.", "error", 3000)
                end
            end
        end
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
    MySQL.Async.fetchScalar('SELECT * FROM xmas WHERE identifier = @identifier', 
    {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(result)
        local existsInDatabase = tonumber(result) > 0

        if not existsInDatabase then
            MySQL.Async.execute('INSERT INTO xmas (identifier, hasFinishedDeerGame) VALUES (@identifier, 0)',
            {
                ['@identifier'] = xPlayer.getIdentifier()
            })
        end

        MySQL.Async.fetchScalar('SELECT hasFinishedDeerGame FROM xmas WHERE identifier = @identifier', 
        {
            ['@identifier'] = xPlayer.getIdentifier()
        }, function(hasFinishedDeerGame)
            cb(hasFinishedDeerGame == 1)
        end)
    end)
end)



