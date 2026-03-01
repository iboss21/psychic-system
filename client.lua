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

    🐺 LXR Brake Disk Heat System — Client
    Heated Wheel / Brake Disc Visual Effect for Cars & Vehicles

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
-- 🐺 FRAMEWORK BRIDGE
-- ═══════════════════════════════════════════════════════════════════════════════

local Framework     = nil
local FrameworkName = 'standalone'

local function InitFramework()
    if Config.Framework ~= 'auto' then
        FrameworkName = Config.Framework
    else
        -- Auto-detect: priority → LXR-Core → QB-Core → Standalone
        if GetResourceState('lxr-core') == 'started' then
            FrameworkName = 'lxr-core'
        elseif GetResourceState('qb-core') == 'started' then
            FrameworkName = 'qb-core'
        else
            FrameworkName = 'standalone'
        end
    end

    if FrameworkName == 'lxr-core' then
        Framework = exports['lxr-core']:GetCoreObject()
    elseif FrameworkName == 'qb-core' then
        Framework = exports['qb-core']:GetCoreObject()
    end

    if Config.Debug then
        print(('[lxr-brakedisk] Framework detected: %s'):format(FrameworkName))
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 NOTIFICATION HELPER
-- ═══════════════════════════════════════════════════════════════════════════════

local function Notify(msg)
    if FrameworkName == 'lxr-core' and Framework then
        Framework.Functions.Notify(msg, 'inform')
    elseif FrameworkName == 'qb-core' and Framework then
        Framework.Functions.Notify(msg, 'primary', 4000)
    else
        -- Standalone fallback: use the game chat
        TriggerEvent('chat:addMessage', { color = { 255, 255, 255 }, multiline = true, args = { 'System', msg } })
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 LOCALE HELPER
-- ═══════════════════════════════════════════════════════════════════════════════

local function L(key)
    local lang = Config.Locale[Config.Lang] or Config.Locale['en']
    return lang[key] or key
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 STATE
-- ═══════════════════════════════════════════════════════════════════════════════

local heat_front  = 0.0
local heat_rear   = 0.0
local glow_front  = 0
local glow_rear   = 0
local enabled     = Config.General.defaultEnabled and 1 or 0

local rearvehicles  = {}
local frontvehicles = {}
local players_string

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 TOGGLE COMMAND
-- ═══════════════════════════════════════════════════════════════════════════════

TriggerEvent('chat:addSuggestion', '/' .. Config.General.command,
    'Toggle heated disc effect on/off.', {})

RegisterCommand(Config.General.command, function()
    if enabled == 1 then
        enabled = 0
        Notify(L('effect_off'))
    else
        enabled = 1
        Notify(L('effect_on'))
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 NEARBY PLAYER UTILITY
-- ═══════════════════════════════════════════════════════════════════════════════

local function GetClosestPlayers()
    local players1  = GetActivePlayers()
    local plyCoords = GetEntityCoords(PlayerPedId(), 0)
    players_string  = '-'
    local calculating = '-'

    CreateThread(function()
        for i in pairs(players1) do
            local playercoords = GetEntityCoords(GetPlayerPed(players1[i]))
            if GetDistanceBetweenCoords(
                plyCoords.x, plyCoords.y, plyCoords.z,
                playercoords.x, playercoords.y, playercoords.z, 1
            ) < Config.General.broadcastRadius then
                calculating = calculating .. GetPlayerServerId(players1[i]) .. '-'
            end
        end
        players_string = calculating
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 HEAT ACCUMULATION LOOP
-- ═══════════════════════════════════════════════════════════════════════════════

CreateThread(function()
    while true do
        Wait(10)

        local ped     = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        local cfg     = Config.General
        local ctrl    = Config.Controls

        -- Only accumulate heat when the local player is the driver
        if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == ped then

            -- Handbrake while moving — heats rear wheels
            if GetVehicleHandbrake(vehicle) and GetEntitySpeed(vehicle) > cfg.speedThreshold then
                Wait(5)
                if heat_rear < cfg.heatMax then
                    heat_rear = heat_rear + cfg.heatIncrement
                end
            end

            -- Forward motion + braking — heats both axles
            if GetEntitySpeed(vehicle) > cfg.speedThreshold
                and GetVehicleCurrentGear(vehicle) ~= 0 then
                if IsControlPressed(ctrl.inputGroup, ctrl.brake) then
                    if heat_rear  < cfg.heatMax then heat_rear  = heat_rear  + cfg.heatIncrement end
                    if heat_front < cfg.heatMax then heat_front = heat_front + cfg.heatIncrement end
                end
            end

            -- Reversing + accelerate — heats both axles
            if GetEntitySpeed(vehicle) > cfg.speedThreshold
                and GetVehicleCurrentGear(vehicle) == 0 then
                if IsControlPressed(ctrl.inputGroup, ctrl.reverse) then
                    if heat_rear  < cfg.heatMax then heat_rear  = heat_rear  + cfg.heatIncrement end
                    if heat_front < cfg.heatMax then heat_front = heat_front + cfg.heatIncrement end
                end
            end

        else
            -- Not driving — reset immediately
            glow_rear  = 0
            glow_front = 0
            heat_rear  = 0.0
            heat_front = 0.0
        end

        -- ── Rear glow state management ───────────────────────────────────────
        if glow_rear == 0 then
            if heat_rear > cfg.heatGlowThresh then
                GetClosestPlayers()
                while players_string == '-' do Wait(100) end
                glow_rear = 1
                TriggerServerEvent('lxr-brakedisk:add_rear',
                    VehToNet(GetVehiclePedIsIn(ped, false)), players_string)
            end
        else
            if heat_rear < cfg.heatGlowThresh then
                glow_rear = 0
                TriggerServerEvent('lxr-brakedisk:rem_rear',
                    VehToNet(GetVehiclePedIsIn(ped, false)))
            end
        end

        -- ── Front glow state management ──────────────────────────────────────
        if glow_front == 0 then
            if heat_front > cfg.heatGlowThresh then
                GetClosestPlayers()
                while players_string == '-' do Wait(100) end
                glow_front = 1
                TriggerServerEvent('lxr-brakedisk:add_front',
                    VehToNet(GetVehiclePedIsIn(ped, false)), players_string)
            end
        else
            if heat_front < cfg.heatGlowThresh then
                glow_front = 0
                TriggerServerEvent('lxr-brakedisk:rem_front',
                    VehToNet(GetVehiclePedIsIn(ped, false)))
            end
        end

        -- ── Passive cooling ───────────────────────────────────────────────────
        if heat_rear  > 1 then heat_rear  = heat_rear  - cfg.heatDecrement end
        if heat_front > 1 then heat_front = heat_front - cfg.heatDecrement end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 NETWORK EVENTS — receive glow updates from server
-- ═══════════════════════════════════════════════════════════════════════════════

RegisterNetEvent('lxr-brakedisk:add_rear')
AddEventHandler('lxr-brakedisk:add_rear', function(vehicle, players)
    if enabled == 1 then
        if players:find('%-' .. tostring(GetPlayerServerId(PlayerId())) .. '%-') then
            table.insert(rearvehicles, NetToVeh(vehicle))
        end
    end
end)

RegisterNetEvent('lxr-brakedisk:add_front')
AddEventHandler('lxr-brakedisk:add_front', function(vehicle, players)
    if enabled == 1 then
        if players:find('%-' .. tostring(GetPlayerServerId(PlayerId())) .. '%-') then
            table.insert(frontvehicles, NetToVeh(vehicle))
        end
    end
end)

RegisterNetEvent('lxr-brakedisk:rem_rear')
AddEventHandler('lxr-brakedisk:rem_rear', function(vehicle)
    for i in pairs(rearvehicles) do
        if rearvehicles[i] == NetToVeh(vehicle) then
            table.remove(rearvehicles, i)
            break
        end
    end
end)

RegisterNetEvent('lxr-brakedisk:rem_front')
AddEventHandler('lxr-brakedisk:rem_front', function(vehicle)
    for i in pairs(frontvehicles) do
        if frontvehicles[i] == NetToVeh(vehicle) then
            table.remove(frontvehicles, i)
            break
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 PARTICLE RENDER — REAR WHEELS
-- ═══════════════════════════════════════════════════════════════════════════════

CreateThread(function()
    while true do
        Wait(1)
        local ptcl = Config.Particles
        for IR in pairs(rearvehicles) do
            if IsVehicleSeatFree(rearvehicles[IR], -1) then
                table.remove(rearvehicles, IR)
            else
                for _, bone in ipairs(ptcl.rearBones) do
                    UseParticleFxAsset(ptcl.asset)
                    local fx = StartParticleFxLoopedOnEntityBone(
                        ptcl.name, rearvehicles[IR],
                        ptcl.offsetX, ptcl.offsetY, ptcl.offsetZ,
                        ptcl.rotX, ptcl.rotY, ptcl.rotZ,
                        GetEntityBoneIndexByName(rearvehicles[IR], bone),
                        ptcl.scale, 0.0, 0.0, 0.0
                    )
                    StopParticleFxLooped(fx, 1)
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 PARTICLE RENDER — FRONT WHEELS
-- ═══════════════════════════════════════════════════════════════════════════════

CreateThread(function()
    while true do
        Wait(1)
        local ptcl = Config.Particles
        for IF in pairs(frontvehicles) do
            if IsVehicleSeatFree(frontvehicles[IF], -1) then
                table.remove(frontvehicles, IF)
            else
                for _, bone in ipairs(ptcl.frontBones) do
                    UseParticleFxAsset(ptcl.asset)
                    local fx = StartParticleFxLoopedOnEntityBone(
                        ptcl.name, frontvehicles[IF],
                        ptcl.offsetX, ptcl.offsetY, ptcl.offsetZ,
                        ptcl.rotX, ptcl.rotY, ptcl.rotZ,
                        GetEntityBoneIndexByName(frontvehicles[IF], bone),
                        ptcl.scale, 0.0, 0.0, 0.0
                    )
                    StopParticleFxLooped(fx, 1)
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 STARTUP BOOT
-- ═══════════════════════════════════════════════════════════════════════════════

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    InitFramework()
    if Config.Debug then
        print(('[lxr-brakedisk] Client loaded | Framework: %s'):format(FrameworkName))
    end
end)
