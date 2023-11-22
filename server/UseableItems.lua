ESX = exports['es_extended']:getSharedObject()

ESX.RegisterUsableItem('santas_sugar_stick', function(source)
    TriggerClientEvent('GMD_Christmas:usedDeerItem', source)
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
            xPlayer.addInventoryItem(v[1], v[2])
        end
        local randomTicket = math.random(1, Config.DeerZones[1].DeerRandomTicketCount)
        xPlayer.addInventoryItem(Config.DeerZones[1].GoldTicker, randomTicket)
        xPlayer.removeInventoryItem('christmas_stocking', 1)
    end
end)

-- FOOD
ESX.RegisterUsableItem('sugar_cone', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sugar_cone', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	xPlayer.showNotification((Config.Language[Config.Local]['used_sugar_cone']))
end)

ESX.RegisterUsableItem('gingerbread', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('gingerbread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	xPlayer.showNotification((Config.Language[Config.Local]['used_gingerbread']))
end)

-- DRINKS
ESX.RegisterUsableItem('santas_coffee', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('santas_coffee', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	xPlayer.showNotification((Config.Language[Config.Local]['santas_coffee']))
end)

ESX.RegisterUsableItem('santas_wine', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('santas_wine', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	xPlayer.showNotification((Config.Language[Config.Local]['santas_wine']))
end)