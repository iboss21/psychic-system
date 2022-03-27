local QBCore = exports['qb-core']:GetCoreObject()

--all 4th side of vehicles | registring evenets
RegisterServerEvent("lux-brake:add_rear")
AddEventHandler("lux-brake:add_rear", function(vehicle, players)
	TriggerClientEvent("lux-brake:add_rear", -1, vehicle, players)
end)
RegisterServerEvent("lux-brake:add_front")
AddEventHandler("lux-brake:add_front", function(vehicle, players)
	TriggerClientEvent("lux-brake:add_front", -1, vehicle, players)
end)
RegisterServerEvent("lux-brake:rem_rear")
AddEventHandler("lux-brake:rem_rear", function(vehicle)
	TriggerClientEvent("lux-brake:rem_rear", -1, vehicle)
end)
RegisterServerEvent("lux-brake:rem_front")
AddEventHandler("lux-brake:rem_front", function(vehicle)
	TriggerClientEvent("lux-brake:rem_front", -1, vehicle)
end)