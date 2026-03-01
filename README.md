# 🐺 LXR Brake Disk Heat System

> **wolves.land** — The Land of Wolves | Developed by [iBoss21](https://github.com/iboss21) / The Lux Empire

---

## Overview

**LXR Brake Disk Heat System** is a production-grade RedM resource that renders a glowing heat / smoke particle effect on wagon and vehicle wheels when the player brakes hard or uses the handbrake at speed. The effect is visible to all nearby players within a configurable radius.

### Features

- 🔥 Heated wheel particle effect on hard braking / handbrake
- 🌐 Visible to nearby players (server-relayed, client-filtered)
- ⚙️ Fully configurable heat thresholds, particle effects, controls & broadcast radius
- 🏗️ Multi-framework auto-detection: **LXR-Core → RSG-Core → VORP Core → Standalone**
- 🔒 Resource name protection (Tebex escrow compatible)
- 🐺 Land of Wolves branded, `lua54` enabled

---

## Installation

1. Rename the folder to `lxr-brakedisk`
2. Drop into your server's `resources` directory
3. Add `ensure lxr-brakedisk` to your `server.cfg`
4. Restart the server

---

## Configuration

All settings live in **`config.lua`**:

| Key | Default | Description |
|-----|---------|-------------|
| `Config.Framework` | `'auto'` | Framework detection (`'auto'`, `'lxr-core'`, `'rsg-core'`, `'vorp_core'`, `'standalone'`) |
| `Config.General.command` | `'diskoff'` | In-game toggle command |
| `Config.General.heatMax` | `300` | Maximum heat value |
| `Config.General.broadcastRadius` | `80` | Radius (units) for nearby player broadcast |
| `Config.Particles.asset` | `'core'` | RDR2 particle asset |
| `Config.Particles.name` | `'ent_amb_camp_fire_smoke'` | Particle effect name |
| `Config.Controls.brake` | `0xAD0D1F1E` | Braking control hash |
| `Config.Controls.reverse` | `0xFEF80614` | Reverse/accelerate control hash |

---

## Screenshots

![Brake Disk Heat Effect](https://cdn.discordapp.com/attachments/899567545357574144/957547755268624384/unknown.png)

---

## Credits

- **Script Author:** iBoss21 / The Lux Empire  
- **Original Concept:** nzkfc  
- **Server:** The Land of Wolves 🐺

---

## Links

| | |
|--|--|
| 🌐 Website | https://www.wolves.land |
| 💬 Discord | https://discord.gg/CrKcWdfd3A |
| 🛒 Store | https://theluxempire.tebex.io |
| 🐙 GitHub | https://github.com/iboss21 |

---

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
