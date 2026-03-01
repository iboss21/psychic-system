--[[
    ██╗     ██╗  ██╗██████╗        ██████╗ ██████╗  █████╗ ██╗  ██╗███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██████╔╝██████╔╝███████║█████╔╝ █████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██╔══██╗██╔══██╗██╔══██║██╔═██╗ ██╔══╝
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝██║  ██║██║  ██║██║  ██╗███████╗
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝

    ██████╗ ██╗███████╗██╗  ██╗    ███████╗██╗   ██╗███████╗
    ██╔══██╗██║██╔════╝██║ ██╔╝    ██╔════╝╚██╗ ██╔╝██╔════╝
    ██║  ██║██║███████╗█████╔╝     ███████╗ ╚████╔╝ ███████╗
    ██║  ██║██║╚════██║██╔═██╗     ╚════██║  ╚██╔╝  ╚════██║
    ██████╔╝██║███████║██║  ██╗    ███████║   ██║   ███████║
    ╚═════╝ ╚═╝╚══════╝╚═╝  ╚═╝    ╚══════╝   ╚═╝   ╚══════╝

    🐺 LXR Brake Disk Heat System — Server
    Heated Wheel / Brake Disc Visual Effect for Wagons & Vehicles

    ═══════════════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════

    Server:      The Land of Wolves 🐺
    Developer:   iBoss21 / The Lux Empire
    Website:     https://www.wolves.land
    Discord:     https://discord.gg/CrKcWdfd3A
    Store:       https://theluxempire.tebex.io

    ═══════════════════════════════════════════════════════════════════════════════

    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 NETWORK RELAY EVENTS
-- Receives glow state changes from the driving client and broadcasts them
-- to all nearby players (filtered client-side by the players_string list).
-- ═══════════════════════════════════════════════════════════════════════════════

RegisterServerEvent('lxr-brakedisk:add_rear')
AddEventHandler('lxr-brakedisk:add_rear', function(vehicle, players)
    TriggerClientEvent('lxr-brakedisk:add_rear', -1, vehicle, players)
end)

RegisterServerEvent('lxr-brakedisk:add_front')
AddEventHandler('lxr-brakedisk:add_front', function(vehicle, players)
    TriggerClientEvent('lxr-brakedisk:add_front', -1, vehicle, players)
end)

RegisterServerEvent('lxr-brakedisk:rem_rear')
AddEventHandler('lxr-brakedisk:rem_rear', function(vehicle)
    TriggerClientEvent('lxr-brakedisk:rem_rear', -1, vehicle)
end)

RegisterServerEvent('lxr-brakedisk:rem_front')
AddEventHandler('lxr-brakedisk:rem_front', function(vehicle)
    TriggerClientEvent('lxr-brakedisk:rem_front', -1, vehicle)
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 STARTUP BANNER
-- ═══════════════════════════════════════════════════════════════════════════════

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    print([[

        ═══════════════════════════════════════════════════════════════════════════════

            ██╗     ██╗  ██╗██████╗        ██████╗ ██████╗  █████╗ ██╗  ██╗███████╗
            ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔════╝
            ██║      ╚███╔╝ ██████╔╝█████╗██████╔╝██████╔╝███████║█████╔╝ █████╗
            ██║      ██╔██╗ ██╔══██╗╚════╝██╔══██╗██╔══██╗██╔══██║██╔═██╗ ██╔══╝
            ███████╗██╔╝ ██╗██║  ██║      ██████╔╝██║  ██║██║  ██║██║  ██╗███████╗
            ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝

        ═══════════════════════════════════════════════════════════════════════════════
        🐺 LXR BRAKE DISK HEAT SYSTEM - SUCCESSFULLY LOADED
        ═══════════════════════════════════════════════════════════════════════════════

        Version:     1.0.0
        Server:      The Land of Wolves 🐺
        Developer:   iBoss21 / The Lux Empire

        ═══════════════════════════════════════════════════════════════════════════════

        Website:     https://www.wolves.land
        Discord:     https://discord.gg/CrKcWdfd3A
        Store:       https://theluxempire.tebex.io

        ═══════════════════════════════════════════════════════════════════════════════

    ]])
end)
