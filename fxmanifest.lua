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

    🐺 LXR Brake Disk Heat System
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

fx_version 'cerulean'
game       'gta5'

name        'lxr-brakedisk'
description '🐺 LXR Brake Disk Heat System | Heated Brake Disc Visual FX | wolves.land'
author      'iBoss21 / The Lux Empire'
version     '1.0.0'
repository  'https://github.com/iboss21/psychic-system'

lua54 'yes'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_script 'server.lua'