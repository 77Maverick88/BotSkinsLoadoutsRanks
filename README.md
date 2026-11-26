# Bot Skins, Loadouts & Ranks v1.0.0

A Kronos mod for **Black Ops 7 multiplayer with bots**. Bots stop looking like bots:

- **Operator skins.** Bots wear BO7 operator skins, always from their own side (JSOC or Guild).
- **Loadouts.** Bots carry BO7 blueprint weapons, or plain guns with real attachment builds. Bots in store-bundle
  skins can use the matching bundle blueprint.
- **Levels and prestige.** Bots get varied levels and prestiges (Prestige 1–10 and Prestige Master up to level
  1000). The scoreboard shows each bot's real level and the right prestige emblem.

It changes **bots only**. Your own class, operator, level and emblem are never touched.

## Requirements

- Black Ops 7 running through the **Kronos launcher, v1.41**.
- Multiplayer matches with bots (private matches or bot lobbies).

## Install

1. Close the game.
2. Extract the zip into your game folder (the folder that contains `kronos`), keeping the folders. You should end
   up with `kronos\mods\bot_bundles\` (including `bot_skins.txt`).
3. Start the game through Kronos. The mod shows in Kronos' **Library** as *Bot Skins, Loadouts & Ranks* and is on
   by default.

**Upgrading from an older loose-file version?** Delete these if you have them, or the bot script runs twice:
`kronos\custom_scripts\mp_bot_bundles.gsc`, `kronos\custom_scripts\compiled\mp_bot_bundles.gscc`,
`kronos\Assets\Lua\bot_factions_post.lua` and `kronos\Assets\Lua\bot_levels_post.lua`.

## Settings

Open `kronos\mods\bot_bundles\scripts\mp_bot_bundles.gsc` in a text editor. The **SETTINGS** block is near the
top, and every option is explained there. Edit, save, and restart the game. Kronos recompiles the script when the
file changes.

| Setting | Default | What it does |
|---|---|---|
| `botbb_cfg_mode` | -1 | -1 automatic (skins + weapons in create-a-class modes, skins only where the mode hands out guns), 2 skins + weapons everywhere, 1 skins only, 0 off |
| `botbb_cfg_skin_chance` | 70 | % of bots that get a random operator skin |
| `botbb_cfg_skin_pool` | 2 | 0 every skin, 1 no plain/ranked skins, 2 also no CDL jerseys, 3 store-bundle skins only |
| `botbb_cfg_blueprint_chance` | 60 | % of bots with full blueprint weapons |
| `botbb_cfg_plain_attachments` | 1 | other bots: 1 random gun with a blueprint's attachments, 0 the game's gun |
| `botbb_cfg_bundle_chance` | 75 | % chance a bundle-skin bot uses that bundle's blueprint |
| `botbb_cfg_levels` | 1 | 0 game levels, 1 mixed lobby, 2 sweaty lobby, 3 custom range, 4 everyone Prestige Master |
| `botbb_cfg_bot_levels` / `_bot_skins` | empty | per-bot levels ("P3 40", "PM 750") and skins, in join order |
| `botbb_cfg_jsoc_*` / `botbb_cfg_guild_*` | empty | the same, per team |

Every skin name the settings accept is listed in `kronos\mods\bot_bundles\bot_skins.txt`.

Console: `set kronos_botbundles 0` turns the bot script off from the next match on; `set kronos_botbundles_mode
0/1/2` overrides the mode setting.

## Turning it off / uninstalling

Switch it off in Kronos' Library, or delete `kronos\mods\bot_bundles\` (and `kronos\botbundles\` if you want the
log gone too).

## Troubleshooting

- `kronos\botbundles\log.json` shows what the script read and did each match: the settings, the mode, each
  bot's level, weapons and skin, and any skin the engine refused.
- In `poi_reg.log` (game folder), lines starting `lua: botlevel` come from the scoreboard part. Each
  `botlevel aggicon NAME ... -> prestige N` line is a bot's prestige emblem being shown.
- The settings can also name MWII/MWIII operator skins, but those only work with an operators mod that adds them.
  Random picks never use them.

## What's inside

```
kronos\mods\bot_bundles\
  mod.json
  lua\bot_factions_post.lua           reads each operator's side (JSOC/Guild) for the bot script
  lua\bot_levels_post.lua             bot levels and prestige emblems on the scoreboard
  scripts\mp_bot_bundles.gsc          the bot script, with the SETTINGS block
  scripts\compiled\mp_bot_bundles.gscc
  bot_skins.txt                        every skin name the settings accept
```

`SHA256SUMS.txt` lists a checksum for each file.
