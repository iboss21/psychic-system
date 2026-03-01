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

    🐺 LXR Brake Disk Heat System — Configuration
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

    Framework Support:
    - LXR Core  (Primary)
    - RSG Core  (Primary)
    - VORP Core (Supported / Legacy)
    - Standalone (Fallback)

    Version: 1.0.0

    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
    ═══════════════════════════════════════════════════════════════════════════════
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 RESOURCE NAME PROTECTION - RUNTIME CHECK
-- ═══════════════════════════════════════════════════════════════════════════════

local REQUIRED_RESOURCE_NAME = "lxr-brakedisk"
local currentResourceName = GetCurrentResourceName()

if currentResourceName ~= REQUIRED_RESOURCE_NAME then
    error(string.format([[

        ═══════════════════════════════════════════════════════════════════════════════
        ❌ CRITICAL ERROR: RESOURCE NAME MISMATCH ❌
        ═══════════════════════════════════════════════════════════════════════════════

        Expected: %s
        Got:      %s

        This resource is branded and must maintain the correct name.
        Rename the resource folder to "%s" to continue.

        🐺 wolves.land - The Land of Wolves

        ═══════════════════════════════════════════════════════════════════════════════

    ]], REQUIRED_RESOURCE_NAME, currentResourceName, REQUIRED_RESOURCE_NAME))
end

Config = {}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SERVER BRANDING & INFO ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.ServerInfo = {
    name      = 'The Land of Wolves 🐺',
    developer = 'iBoss21 / The Lux Empire',
    website   = 'https://www.wolves.land',
    discord   = 'https://discord.gg/CrKcWdfd3A',
    store     = 'https://theluxempire.tebex.io',
    github    = 'https://github.com/iBoss21',
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK CONFIGURATION ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

--[[
    Framework Priority (in order):
    1. LXR-Core  (Primary)
    2. RSG-Core  (Primary)
    3. VORP Core (Supported / Legacy)
    4. Standalone (Fallback)

    Set to 'auto' for automatic detection, or specify manually:
    'lxr-core' | 'rsg-core' | 'vorp_core' | 'standalone'
]]

Config.Framework = 'auto'

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ GENERAL SETTINGS ██████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.General = {
    -- Command to toggle the brake disk heat effect on/off
    command          = 'diskoff',

    -- Heat accumulation & dissipation
    heatIncrement    = 3,     -- How fast heat builds per tick
    heatMax          = 300,   -- Maximum heat value
    heatDecrement    = 1,     -- How fast heat dissipates per tick
    heatGlowThresh   = 30,    -- Heat value at which glow effect activates

    -- Speed threshold (m/s) below which heat won't accumulate
    speedThreshold   = 2.0,

    -- Radius (units) to broadcast the disc glow effect to nearby players
    broadcastRadius  = 80,

    -- Enable/disable the effect globally on resource start
    defaultEnabled   = true,
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ VEHICLE CONTROLS ██████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

--[[
    RedM control hashes used to detect braking / reversing.
    Adjust these if your server uses custom keybinds.

    Common RedM wagon / vehicle controls:
      Brake     — 0xAD0D1F1E  (INPUT_VEH_BRAKE)
      Accelerate — 0xFEF80614  (INPUT_VEH_ACCELERATE / reverse in gear 0)

    To find more: https://github.com/femga/rdr3_discoveries
]]

Config.Controls = {
    -- Input group (0 = all / general)
    inputGroup  = 0,

    -- Control hash for braking (forward motion)
    brake       = 0xAD0D1F1E,

    -- Control hash for reversing / accelerating while in reverse gear
    reverse     = 0xFEF80614,
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ PARTICLE EFFECTS ██████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

--[[
    Particle effects displayed on heated wheels.
    Asset / name combinations must exist in the RDR2 particle library.
    Adjust scale for visual intensity.

    Known working assets: "core", "scr_recver_heist2", etc.
    Browse particles: https://github.com/femga/rdr3_discoveries/tree/master/particles
]]

Config.Particles = {
    asset = "core",
    name  = "ent_amb_camp_fire_smoke",
    scale = 0.45,

    -- Wheel bone names for rear and front axles
    rearBones  = { "wheel_lr", "wheel_rr" },
    frontBones = { "wheel_lf", "wheel_rf" },

    -- Local offset applied to the particle origin on the bone
    offsetX = -0.03,
    offsetY = 0.0,
    offsetZ = 0.0,

    -- Rotation applied to the particle
    rotX = 0.0,
    rotY = 0.0,
    rotZ = 90.0,
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ LOCALE / MESSAGES █████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Lang = 'en'

Config.Locale = {
    en = {
        effect_off = '🐺 Heated disc animation turned ^*OFF^r.',
        effect_on  = '🐺 Heated disc animation turned ^*ON^r.',
    },
    ge = {
        effect_off = '🐺 გახურებული დისკის ანიმაცია გამოiრთო.',
        effect_on  = '🐺 გახურებული დისკის ანიმაცია ჩაirთო.',
    },
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ DEBUG SETTINGS ████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Debug = false -- Set true to enable verbose console output

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ END OF CONFIGURATION ██████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████
