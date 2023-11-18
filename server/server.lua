ESX = exports['es_extended']:getSharedObject()

ESX.RegisterUsableItem('christmas_stocking', function(source)
    TriggerClientEvent('GMD_Christmas:usedDeerItem', source)
end)


RegisterServerEvent('GMD_Christmas:giveXmasSearchItem')
AddEventHandler('GMD_Christmas:giveXmasSearchItem', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('santas_sugar_stick', 1)
end)

RegisterServerEvent('GMD_Christmas:giveXmasSearchStocking')
AddEventHandler('GMD_Christmas:giveXmasSearchStocking', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    MySQL.Async.execute('UPDATE xmas SET hasFinishedDeerGame = @hasFinishedDeerGame WHERE identifier = @identifier', {
        ['@hasFinishedDeerGame'] = 1,
        ['@identifier'] = xPlayer.getIdentifier()
    })
    xPlayer.addInventoryItem('christmas_stocking', 1)

end)

-- ESX.RegisterUsableItem('christmas_stocking', function(source)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local CanCarryItems = true
--     local Items = {}

--     for i, item in pairs(Config.DeerZones[1].DeerFinishedItems) do
        
--         local random = math.random(1, Config.DeerZones[1].DeerFinishedSugarItems)

--         if xPlayer.canCarryItem(item, random) then
--             table.insert(Items, {item, random})
--         else
--             CanCarryItems = false
--             break
--         end
--     end

--     if not CanCarryItems then
--         print("dein Inventar ist zu voll für die items lol")
--     else
--         for k, v in ipairs(Items) do
--             xPlayer.addInventoryItem(v.item, v.random)
--         end

--         xPlayer.addInventoryItem(Config.DeerZones[1].GoldTicker, Config.DeerZones[1].DeerRandomTicketCount)
--         xPlayer.removeInventoryItem('christmas_stocking', 1)
--     end
-- end)

-- ESX.RegisterServerCallback('GMD_Christmas:HasSearchItem', function(source, cb)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     if xPlayer.getInventoryItem('christmas_stocking') ~= nil and xPlayer.getInventoryItem('christmas_stocking').count >= 1 then
--         cb(true)
--     else
--         cb(false)
--     end
-- end)

ESX.RegisterServerCallback('GMD_Christmas:HasMissionFinished', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchScalar('SELECT hasFinishedDeerGame FROM xmas WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(hasFinishedDeerGame)
        if hasFinishedDeerGame == nil then
            MySQL.Async.execute('INSERT INTO xmas (identifier, hasFinishedDeerGame) VALUES (@identifier, 0)', {
                ['@identifier'] = xPlayer.getIdentifier()
            })
            cb(false)
            
        else
            print(hasFinishedDeerGame)
            if hasFinishedDeerGame then
                cb(true)
            else
                cb(false)
            end
        end
    end)
end)

