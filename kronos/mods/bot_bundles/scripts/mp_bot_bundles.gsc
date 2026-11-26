// mp_bot_bundles (Bot Skins, Loadouts & Ranks mod): BO7 operator skins, BO7 blueprint weapons and varied levels for bots in MP.
// Settings: the SETTINGS block just below the #using lines. Off: set kronos_botbundles 0 in the console.
// Log: kronos\botbundles\log.json
#using script_74f99c09414692fa;
#using script_124cc8e9fbd972b9;
#using script_16703a7a81b5d957;
#using script_17fba692339e28db;
#using script_191ec2bcea8f4f11;
#using script_1ad67fd5a48925d;
#using script_1ade2fa7cae9593d;
#using script_1eb8127cd5f2800f;
#using script_1f6b7243f8d72fef;
#using script_26f5997b01261edd;
#using script_2b867a98ca762b0a;
#using script_2bf5529af94c9a0;
#using script_2dc447b1dd033a26;
#using script_353e34c229ca1589;
#using script_376710f138a3aae7;
#using script_3b64eb40368c1450;
#using script_49e4a4c208f44b76;
#using script_4a6760982b403bad;
#using script_4b87f2871b6b025c;
#using script_4c770a9a4ad7659c;
#using script_4ca4a30b15eb95bb;
#using script_4d07edb4ba32d3b2;
#using script_4f69ac46e7de953a;
#using script_4f91b90299ecc61e;
#using script_4f9ce8d249a99f4a;
#using script_501664a0dffc664d;
#using script_54d0de7496fceea5;
#using script_5560f3066718e34c;
#using script_562c77a4eda834c6;
#using script_596b87215f1ff115;
#using script_5efe37e054c73937;
#using script_63a08d721a3267bc;
#using script_6899515ff500b795;
#using script_6995a3eb7d571a9f;
#using script_69ea0c12304c130;
#using script_6a3544644b02bfb7;
#using script_6a5d3bf7a5b7064a;
#using script_70ac8a06d80020b0;
#using script_724b8f06df0c96b1;
#using script_734dce84c468439b;
#using script_757f5e68bf3869d6;
#using script_762e73cd6088bff;
#using script_7897affa175bfab6;
#using script_7af4b8f37e520205;
#using script_7b1e082b2533e255;
#using script_9b5f893c39bde3a;
#using script_9cec44d3e5e2a36;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\archetypes\archassault;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\menus;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\riotshield;
#using scripts\mp\supers;
#using scripts\mp\teams;
#using scripts\mp\validation;
#using scripts\mp\weaponrank;
#using scripts\mp\weapons;

// ===================== SETTINGS START =====================
// Edit the numbers below, save, and restart the game (Kronos recompiles the script when this file changes).
// Bots only: your own class, operator and level never change.
bot_bundles_settings()
{
    // ---- Which modes ----
    // -1 = automatic (recommended):
    //      skins + weapons in create-a-class modes (TDM, Dom, Hardpoint, Kill Confirmed, S&D, Control, FFA ...),
    //      skins only where the mode hands out the guns (Gunfight, Gun Game, Sharpshooter, Sticks & Stones, OITC,
    //      Snipers/Vintage playlists), nothing in Infected, Prop Hunt and modes it doesn't know.
    //  2 = skins + weapons in every MP mode (careful: also swaps guns in Gun Game, Gunfight ...)
    //  1 = skins only in every MP mode
    //  0 = skins and weapons off (levels below still apply)
    level.botbb_cfg_mode = -1;

    // ---- Operator skins ----
    // Percent of bots (0-100) that get a random BO7 operator skin. The rest keep the skin the game gave them.
    level.botbb_cfg_skin_chance = 70;
    // Which skins random picks use (per-bot/per-team skin entries can still name any skin):
    //  0 = every skin, including the plain default and ranked-play skins
    //  1 = no plain default/ranked skins
    //  2 = also no CDL team jerseys (recommended: the skins that stand out)
    //  3 = store-bundle skins only
    level.botbb_cfg_skin_pool = 2;

    // ---- Weapons (create-a-class modes only) ----
    // Percent of bots (0-100) whose guns are full BO7 blueprints (the blueprint's look and attachments).
    level.botbb_cfg_blueprint_chance = 60;
    // What the other bots get:
    //  1 = a random BO7 gun with a blueprint's attachments, but the plain gun's look (no blueprint)
    //  0 = the gun the game gave them, unchanged
    level.botbb_cfg_plain_attachments = 1;
    // Percent chance (0-100) that a bot wearing a store-bundle skin uses that bundle's blueprint, when the bundle
    // has one and the bot rolled a blueprint above.
    level.botbb_cfg_bundle_chance = 75;

    // ---- Levels and prestige (every MP mode) ----
    //  0 = leave the game's bot levels alone
    //  1 = mixed lobby: about 25% unprestiged, 45% Prestige 1-10, 30% Prestige Master (mostly lower PM levels)
    //  2 = sweaty lobby: about 15% Prestige 6-10, 85% Prestige Master
    //  3 = custom: random between the min/max values below
    //  4 = everyone Prestige Master at level_master_max
    level.botbb_cfg_levels = 1;
    // Custom range (used by option 3). Prestige: 0 = none, 1-10 = Prestige 1-10, 11 = Prestige Master.
    level.botbb_cfg_prestige_min = 0;
    level.botbb_cfg_prestige_max = 11;
    // Level inside Prestige 0-10 (1-55).
    level.botbb_cfg_level_min = 1;
    level.botbb_cfg_level_max = 55;
    // Prestige Master level (56-1000). Also the level option 4 uses (level_master_max).
    level.botbb_cfg_level_master_min = 56;
    level.botbb_cfg_level_master_max = 1000;

    // ---- Per-bot overrides (optional) ----
    // One entry per bot, in the order the bots join the match: the first entry is the first bot to join, and so on
    // (the log, kronos\botbundles\log.json, lists "bot slot N" with each bot's name). "" or a missing entry = that
    // bot uses the odds above. These apply in every MP mode, even with the levels option at 0.
    // Levels: "40" = level 40, no prestige; "P3 40" = Prestige 3 level 40; "P3" = Prestige 3, random level;
    //         "PM 750" = Prestige Master level 750; "PM" = Prestige Master, random level (master min-max above).
    //   Example: level.botbb_cfg_bot_levels = ["PM 1000", "", "P5 30", "12"];
    level.botbb_cfg_bot_levels = [];
    // Skins: an operator name ("sat_usa_pl_jack_base") = that operator in a random one of its skins; a skin name
    //        ("sat_usa_pl_jack_base_skin") = exactly that skin; "game" = keep the skin the game gave that bot.
    //        All names: kronos\mods\bot_bundles\bot_skins.txt. Skins need the mode setting above to allow skins.
    //   Example: level.botbb_cfg_bot_skins = ["sat_usa_pl_orange_proto_skin", "sat_usa_pl_jack_base", "", "game"];
    level.botbb_cfg_bot_skins = [];

    // ---- Per-team overrides (optional, team modes) ----
    // The same kind of entries, for the bots on each team (as the scoreboard names them), in the order the bots
    // join that team. A team whose list here is empty uses the all-bots list above; free-for-all modes always use
    // the all-bots lists. The log shows each bot's team and place, e.g. "bot slot 3" = "Name (Guild 2)".
    // Every operator belongs to one side (bot_skins.txt lists each operator's side). Random skins always come from
    // the bot's own side; a skin entry here is worn as given, even an operator of the other side.
    //   Example: level.botbb_cfg_guild_levels = ["PM 1000", "PM 1000", "PM 1000"];
    level.botbb_cfg_jsoc_levels = [];
    level.botbb_cfg_jsoc_skins = [];
    level.botbb_cfg_guild_levels = [];
    level.botbb_cfg_guild_skins = [];
}
// ====================== SETTINGS END ======================

autoexec bot_bundles_init()
{
    if (getdvar("kronos_botbundles", "1") == "0")
    {
        return;
    }
    bot_bundles_settings();
    bot_bundles_check_settings();
    level thread bot_bundles_hook();
    level thread bot_bundles_loop();
}

bot_bundles_clamp(v, lo, hi)
{
    if (!isdefined(v))
    {
        return lo;
    }
    if (v < lo)
    {
        return lo;
    }
    if (v > hi)
    {
        return hi;
    }
    return v;
}

bot_bundles_check_settings()
{
    level.botbb_cfg_mode = bot_bundles_clamp(level.botbb_cfg_mode, -1, 2);
    level.botbb_cfg_skin_chance = bot_bundles_clamp(level.botbb_cfg_skin_chance, 0, 100);
    level.botbb_cfg_skin_pool = bot_bundles_clamp(level.botbb_cfg_skin_pool, 0, 3);
    level.botbb_cfg_blueprint_chance = bot_bundles_clamp(level.botbb_cfg_blueprint_chance, 0, 100);
    level.botbb_cfg_plain_attachments = bot_bundles_clamp(level.botbb_cfg_plain_attachments, 0, 1);
    level.botbb_cfg_bundle_chance = bot_bundles_clamp(level.botbb_cfg_bundle_chance, 0, 100);
    level.botbb_cfg_levels = bot_bundles_clamp(level.botbb_cfg_levels, 0, 4);
    level.botbb_cfg_prestige_min = bot_bundles_clamp(level.botbb_cfg_prestige_min, 0, 11);
    level.botbb_cfg_prestige_max = bot_bundles_clamp(level.botbb_cfg_prestige_max, level.botbb_cfg_prestige_min, 11);
    level.botbb_cfg_level_min = bot_bundles_clamp(level.botbb_cfg_level_min, 1, 55);
    level.botbb_cfg_level_max = bot_bundles_clamp(level.botbb_cfg_level_max, level.botbb_cfg_level_min, 55);
    level.botbb_cfg_level_master_min = bot_bundles_clamp(level.botbb_cfg_level_master_min, 56, 1000);
    level.botbb_cfg_level_master_max = bot_bundles_clamp(level.botbb_cfg_level_master_max, level.botbb_cfg_level_master_min, 1000);
    if (!isdefined(level.botbb_cfg_bot_levels))
    {
        level.botbb_cfg_bot_levels = [];
    }
    if (!isdefined(level.botbb_cfg_bot_skins))
    {
        level.botbb_cfg_bot_skins = [];
    }
    if (!isdefined(level.botbb_cfg_jsoc_levels))
    {
        level.botbb_cfg_jsoc_levels = [];
    }
    if (!isdefined(level.botbb_cfg_jsoc_skins))
    {
        level.botbb_cfg_jsoc_skins = [];
    }
    if (!isdefined(level.botbb_cfg_guild_levels))
    {
        level.botbb_cfg_guild_levels = [];
    }
    if (!isdefined(level.botbb_cfg_guild_skins))
    {
        level.botbb_cfg_guild_skins = [];
    }
    level.botbb_teamlists = level.botbb_cfg_jsoc_levels.size + level.botbb_cfg_jsoc_skins.size
        + level.botbb_cfg_guild_levels.size + level.botbb_cfg_guild_skins.size > 0;
    if (getdvar(@"kronos_botbb_opteam", "") == "")
    {
        setdvar(@"kronos_botbb_opteam", "");
    }
}

bot_bundles_tname(p)
{
    if (!isdefined(p.team))
    {
        return "";
    }
    if (p.team == "allies")
    {
        return "jsoc";
    }
    if (p.team == "axis")
    {
        return "guild";
    }
    return "";
}

bot_bundles_factions()
{
    if (isdefined(level.botbb_opteam))
    {
        return 1;
    }
    if (!isdefined(level.botbb_ops))
    {
        bot_bundles_data();
    }
    if (!isdefined(level.botbb_opf))
    {
        level.botbb_ft = getdvar(@"kronos_botbb_opteam", "");
        level.botbb_fsrc = "the menu's operator data";
        if (level.botbb_ft != "")
        {
            level.botbb_fparts = strtok(level.botbb_ft, "|");
            if (level.botbb_fparts.size != 2 || strtok(level.botbb_fparts[1], ",").size != level.botbb_ops.size)
            {
                level.botbb_ft = "";
            }
        }
        if (level.botbb_ft == "" && isdefined(level.botbb_opteam_default))
        {
            level.botbb_ft = level.botbb_opteam_default;
            level.botbb_fsrc = "the list built into this script";
        }
        if (level.botbb_ft == "")
        {
            if (!isdefined(level.botbb_fmiss))
            {
                level.botbb_fmiss = 1;
                bot_bundles_log("operator sides", "not known yet (bot_factions_post.lua sets them from the menu) - skins not limited by side for now");
            }
            return 0;
        }
        level.botbb_fparts = strtok(level.botbb_ft, "|");
        if (level.botbb_fparts.size != 2)
        {
            level.botbb_opf = [];
            bot_bundles_log("operator sides", "unreadable dvar value - skins not limited by side");
            return 0;
        }
        level.botbb_fcodes = strtok(level.botbb_fparts[0], ",");
        level.botbb_opf = strtok(level.botbb_fparts[1], ",");
        if (level.botbb_opf.size != level.botbb_ops.size)
        {
            bot_bundles_log("operator sides", "got " + level.botbb_opf.size + " sides for " + level.botbb_ops.size + " operators - skins not limited by side");
            level.botbb_opf = [];
            return 0;
        }
        level.botbb_votes = [];
        level.botbb_nvotes = 0;
        level.botbb_jf = "";
        if (isdefined(level.botbb_codeside))
        {
            level.botbb_jf = "map";
            level.botbb_fhow = "built into this script";
        }
        else if (isdefined(level.botbb_jsoc_code_default))
        {
            foreach (i, c in level.botbb_fcodes)
            {
                if (c == level.botbb_jsoc_code_default)
                {
                    level.botbb_jf = "" + i;
                    level.botbb_fhow = "built into this script";
                }
            }
        }
        if (level.botbb_jf == "")
        {
            bot_bundles_log("operator sides", "codes read (" + level.botbb_fparts[0] + "); learning which is JSOC from the players' operators");
        }
    }
    if (level.botbb_opf.size == 0 || level.botbb_jf == "")
    {
        return 0;
    }
    level.botbb_gf = "0";
    if (level.botbb_jf == "0")
    {
        level.botbb_gf = "1";
    }
    level.botbb_opteam = [];
    level.botbb_fj = 0;
    level.botbb_fg = 0;
    foreach (i, f in level.botbb_opf)
    {
        level.botbb_opteam[i] = "?";
        if (level.botbb_jf == "map")
        {
            if (f != "-" && isdefined(level.botbb_codeside[level.botbb_fcodes[int(f)]]))
            {
                level.botbb_opteam[i] = level.botbb_codeside[level.botbb_fcodes[int(f)]];
                if (level.botbb_opteam[i] == "J")
                {
                    level.botbb_fj = level.botbb_fj + 1;
                }
                else
                {
                    level.botbb_fg = level.botbb_fg + 1;
                }
            }
        }
        else if (f == level.botbb_jf)
        {
            level.botbb_opteam[i] = "J";
            level.botbb_fj = level.botbb_fj + 1;
        }
        else if (f == level.botbb_gf)
        {
            level.botbb_opteam[i] = "G";
            level.botbb_fg = level.botbb_fg + 1;
        }
    }
    bot_bundles_log("operator sides", "JSOC " + level.botbb_fj + " operators, Guild " + level.botbb_fg + ", either " + (level.botbb_opteam.size - level.botbb_fj - level.botbb_fg) + "; codes from "
        + level.botbb_fsrc + ", which is JSOC " + level.botbb_fhow);
    return 1;
}

bot_bundles_observe()
{
    if (isdefined(level.botbb_opteam) || !isdefined(level.botbb_opf) || level.botbb_opf.size == 0 || level.botbb_fcodes.size < 2)
    {
        return;
    }
    foreach (p in level.players)
    {
        if (!isdefined(p) || isdefined(p.botbb_seen) || !function_52d4872ae95d8bb7(p) || !isdefined(p.operatorCustomization)
            || !isdefined(p.operatorCustomization.operatorRef) || bot_bundles_tname(p) == "")
        {
            continue;
        }
        p.botbb_seen = 1;
        if (isbot(p) && isdefined(p.botbb_tries) && p.botbb_tries > 0)
        {
            continue;
        }
        level.botbb_of = "-";
        foreach (i, o in level.botbb_ops)
        {
            if (p.operatorCustomization.operatorRef == o)
            {
                level.botbb_of = level.botbb_opf[i];
                level.botbb_oname = level.botbb_opnames[i];
            }
        }
        if (level.botbb_of != "0" && level.botbb_of != "1")
        {
            continue;
        }
        level.botbb_ow = 1;
        if (!isbot(p))
        {
            level.botbb_ow = 3;
            bot_bundles_log("side vote (you)", level.botbb_oname + " on " + bot_bundles_tname(p));
        }
        level.botbb_okey = bot_bundles_tname(p) + level.botbb_of;
        if (!isdefined(level.botbb_votes[level.botbb_okey]))
        {
            level.botbb_votes[level.botbb_okey] = 0;
        }
        level.botbb_votes[level.botbb_okey] = level.botbb_votes[level.botbb_okey] + level.botbb_ow;
        level.botbb_nvotes = level.botbb_nvotes + 1;
        level.botbb_s0 = bot_bundles_votes("jsoc0") + bot_bundles_votes("guild1") - bot_bundles_votes("jsoc1") - bot_bundles_votes("guild0");
        bot_bundles_log("side votes", "JSOC in " + level.botbb_fcodes[0] + " " + bot_bundles_votes("jsoc0") + ", in " + level.botbb_fcodes[1] + " "
            + bot_bundles_votes("jsoc1") + "; Guild in " + level.botbb_fcodes[0] + " " + bot_bundles_votes("guild0") + ", in "
            + level.botbb_fcodes[1] + " " + bot_bundles_votes("guild1") + " (" + level.botbb_nvotes + " players)");
        if (level.botbb_s0 >= 5 || level.botbb_s0 <= -5)
        {
            level.botbb_jf = "1";
            if (level.botbb_s0 > 0)
            {
                level.botbb_jf = "0";
            }
            level.botbb_fhow = "learned from what the game dressed each team in";
            bot_bundles_factions();
            return;
        }
    }
}

bot_bundles_opok(op)
{
    level.botbb_oplist = operator::function_91f90d6f14a0f260();
    foreach (o in level.botbb_oplist)
    {
        if (o == op)
        {
            return 1;
        }
    }
    return 0;
}

bot_bundles_votes(key)
{
    if (!isdefined(level.botbb_votes[key]))
    {
        return 0;
    }
    return level.botbb_votes[key];
}

bot_bundles_tl()
{
    if (!bot_bundles_factions())
    {
        return "";
    }
    if (bot_bundles_tname(self) == "jsoc")
    {
        return "J";
    }
    if (bot_bundles_tname(self) == "guild")
    {
        return "G";
    }
    return "";
}

bot_bundles_randskin(tl)
{
    level.botbb_rc = [];
    level.botbb_rmin = level.botbb_cfg_skin_pool;
    while (level.botbb_rc.size == 0 && level.botbb_rmin >= 0)
    {
        foreach (i, t in level.botbb_skintier)
        {
            if (t >= level.botbb_rmin && (tl == "" || level.botbb_opteam[level.botbb_skinop[i]] == tl))
            {
                level.botbb_rc[level.botbb_rc.size] = i;
            }
        }
        level.botbb_rmin = level.botbb_rmin - 1;
    }
    if (level.botbb_rc.size == 0)
    {
        return randomint(level.botbb_skins.size);
    }
    return level.botbb_rc[randomint(level.botbb_rc.size)];
}

bot_bundles_teamskin()
{
    if (!self.botbb_wantskin || isdefined(self.botbb_forced))
    {
        return;
    }
    self.botbb_tl = self bot_bundles_tl();
    if (self.botbb_tl == "")
    {
        return;
    }
    self.botbb_have = level.botbb_opteam[level.botbb_skinop[self.botbb_k]];
    if (self.botbb_have == self.botbb_tl || self.botbb_have == "?")
    {
        return;
    }
    self.botbb_was = level.botbb_skinnames[self.botbb_k];
    self.botbb_k = bot_bundles_randskin(self.botbb_tl);
    self.botbb_skin = level.botbb_skins[self.botbb_k];
    self.botbb_op = level.botbb_ops[level.botbb_skinop[self.botbb_k]];
    self.botbb_bundle = level.botbb_skinbundle[self.botbb_k];
    self.botbb_tries = 0;
}

bot_bundles_rand(lo, hi)
{
    if (hi <= lo)
    {
        return lo;
    }
    return lo + randomint(hi - lo + 1);
}

bot_bundles_mapok()
{
    if (!isdefined(level.var_dfeae4b8b3d59217))
    {
        return 0;
    }
    level.botbb_map = strtok(level.var_dfeae4b8b3d59217, "_");
    return level.botbb_map.size > 0 && level.botbb_map[0] == "mp";
}

bot_bundles_mode()
{
    if (isdefined(level.botbb_mode))
    {
        return level.botbb_mode;
    }
    level.botbb_over = level.botbb_cfg_mode;
    level.botbb_src = "settings";
    if (getdvarint("kronos_botbundles_mode", -1) >= 0)
    {
        level.botbb_over = bot_bundles_clamp(getdvarint("kronos_botbundles_mode", -1), 0, 2);
        level.botbb_src = "kronos_botbundles_mode dvar";
    }
    if (level.botbb_over >= 0)
    {
        level.botbb_mode = level.botbb_over;
        bot_bundles_log("mode", "set to " + level.botbb_mode + " by the " + level.botbb_src + " (2 skins and weapons, 1 skins only, 0 off)");
        return level.botbb_mode;
    }
    level.botbb_gt = "";
    level.botbb_src = "none";
    if (isdefined(level.gametype))
    {
        level.botbb_gt = "" + level.gametype;
        level.botbb_src = "level.gametype";
    }
    if (level.botbb_gt == "")
    {
        level.botbb_gt = "" + getdvar("g_gametype", "");
        level.botbb_src = "g_gametype";
    }
    if (level.botbb_gt == "")
    {
        level.botbb_gt = "" + getdvar("ui_gametype", "");
        level.botbb_src = "ui_gametype";
    }
    if (level.botbb_gt == "")
    {
        if (!isdefined(level.botbb_empty_logged))
        {
            level.botbb_empty_logged = 1;
            bot_bundles_log("mode", "game mode not readable yet - skins and weapons left alone");
        }
        return 0;
    }
    level.botbb_mode = 0;
    level.botbb_tok = strtok(level.botbb_gt, "_");
    level.botbb_forced = 0;
    level.botbb_keep = [];
    foreach (t in level.botbb_tok)
    {
        if (t == "snipers" || t == "ah" || t == "vint")
        {
            level.botbb_forced = 1;
        }
        else if (t != "hc" && t != "fo" && t != "cdl" && t != "lp" && t != "casual" && t != "10v10")
        {
            level.botbb_keep[level.botbb_keep.size] = t;
        }
    }
    level.botbb_base = "";
    foreach (t in level.botbb_keep)
    {
        if (level.botbb_base != "")
        {
            level.botbb_base = level.botbb_base + "_";
        }
        level.botbb_base = level.botbb_base + t;
    }
    if (bot_bundles_mapok() && level.botbb_tok.size > 0)
    {
        if (bot_bundles_in(["war", "dom", "koth", "conf", "sd", "control", "dm", "hvt", "sabattack", "escort", "ctdm", "ctdm_dom", "dd", "freeze"], level.botbb_base))
        {
            level.botbb_mode = 2;
        }
        if (bot_bundles_in(["arena", "arena_melee", "gun", "gun_blueprint", "sharp", "sticks", "oic"], level.botbb_base))
        {
            level.botbb_mode = 1;
        }
        if (level.botbb_forced && level.botbb_mode == 2)
        {
            level.botbb_mode = 1;
        }
    }
    bot_bundles_log("mode", "'" + level.botbb_gt + "' from " + level.botbb_src + " -> " + level.botbb_mode + " (2 skins and weapons, 1 skins only, 0 off)");
    return level.botbb_mode;
}

bot_bundles_in(arr, v)
{
    foreach (a in arr)
    {
        if (a == v)
        {
            return 1;
        }
    }
    return 0;
}

bot_bundles_log(key, value)
{
    nengine_store_set("botbundles", key, value);
    nengine_store_save("botbundles", "log");
}

bot_bundles_hook()
{
    waitframe();
    waitframe();
    level.botbb_prev = level.var_1f72e89d9af3c430;
    level.var_1f72e89d9af3c430 = &bot_bundles_built;
    level.botbb_logged = 0;
    bot_bundles_log("hook", "installed (v9.5, mod skins only with the operators mod, settings skins ignore sides, built-in sides, operators-mod skins in settings, skin pool, per-team overrides, operator sides), previous hook " + isdefined(level.botbb_prev));
    bot_bundles_log("settings", "mode " + level.botbb_cfg_mode + ", skins " + level.botbb_cfg_skin_chance + "%, blueprints "
        + level.botbb_cfg_blueprint_chance + "%, others get attachments " + level.botbb_cfg_plain_attachments + ", bundle match "
        + level.botbb_cfg_bundle_chance + "%, skin pool " + level.botbb_cfg_skin_pool + ", levels option " + level.botbb_cfg_levels);
}

bot_bundles_built(struct)
{
    if (isdefined(level.botbb_prev))
    {
        self [[ level.botbb_prev ]](struct);
    }
    if (!isbot(self) || !bot_bundles_mapok())
    {
        return;
    }
    self bot_bundles_pick(1);
    self bot_bundles_level();
    if (bot_bundles_mode() < 2)
    {
        return;
    }
    if (!self.botbb_bp && !level.botbb_cfg_plain_attachments)
    {
        return;
    }
    self.botbb_note = "";
    if (isdefined(struct.loadoutPrimary) && struct.loadoutPrimary != "none")
    {
        self.botbb_w = self bot_bundles_build(self.botbb_prim, struct.loadoutPrimaryCamo, struct.loadoutPrimaryReticle);
        if (isdefined(self.botbb_w))
        {
            self.botbb_note = self.botbb_note + "primary " + bot_bundles_name(self.botbb_w) + " " + self.botbb_got + "; ";
            struct.loadoutPrimary = self.botbb_base;
            struct.loadoutPrimaryAttachments = self.botbb_w.attachments;
            struct.loadoutPrimaryVariantID = self.botbb_v;
            struct.var_94d0f8ea18599de3 = self.botbb_w;
            struct.var_de84608151bccb72 = function_8e38d1fba3026ede(self.botbb_w);
        }
    }
    if (isdefined(struct.loadoutSecondary) && struct.loadoutSecondary != "none")
    {
        self.botbb_w = self bot_bundles_build(self.botbb_sec, struct.loadoutSecondaryCamo, struct.loadoutSecondaryReticle);
        if (isdefined(self.botbb_w))
        {
            self.botbb_note = self.botbb_note + "secondary " + bot_bundles_name(self.botbb_w) + " " + self.botbb_got;
            struct.loadoutSecondary = self.botbb_base;
            struct.loadoutSecondaryAttachments = self.botbb_w.attachments;
            struct.loadoutSecondaryVariantID = self.botbb_v;
            struct.var_c817e40959fa971b = self.botbb_w;
            struct.var_b714cc31313c18ca = function_8e38d1fba3026ede(self.botbb_w);
        }
    }
    if (level.botbb_logged < 12)
    {
        level.botbb_logged = level.botbb_logged + 1;
        bot_bundles_log("bot " + level.botbb_logged + " weapons", self.botbb_note);
    }
}

bot_bundles_ok(w)
{
    return isdefined(w) && w.var_1b57e3034f84a054 != "none";
}

bot_bundles_name(w)
{
    if (!isdefined(w))
    {
        return "undefined";
    }
    return "" + w.var_1b57e3034f84a054;
}

bot_bundles_make(ref, atts, camo, reticle, variant)
{
    self.botbb_m = namespace_8f1241659942304e::function_5416d4273f081ce2(ref + "_mp", atts, camo, reticle, variant);
    if (bot_bundles_ok(self.botbb_m))
    {
        return self.botbb_m;
    }
    self.botbb_m = namespace_8f1241659942304e::function_5416d4273f081ce2(ref, atts, camo, reticle, variant);
    if (bot_bundles_ok(self.botbb_m))
    {
        return self.botbb_m;
    }
    return undefined;
}

bot_bundles_build(entry, camo, reticle)
{
    self.botbb_parts = strtok(entry, ";");
    self.botbb_base = self.botbb_parts[0];
    self.botbb_v = int(self.botbb_parts[1]);
    self.botbb_b = self bot_bundles_make(self.botbb_base, [], camo, reticle, self.botbb_v);
    if (!isdefined(self.botbb_b))
    {
        self.botbb_b = self bot_bundles_make(self.botbb_base, [], "none", "none", self.botbb_v);
    }
    if (!isdefined(self.botbb_b))
    {
        return undefined;
    }
    if (self.botbb_bp)
    {
        self.botbb_got = "(blueprint " + self.botbb_v + " " + self.botbb_parts[2] + ", " + self.botbb_b.attachments.size + " attachments)";
        return self.botbb_b;
    }
    self.botbb_atts = self.botbb_b.attachments;
    self.botbb_b = self bot_bundles_make(self.botbb_base, self.botbb_atts, camo, reticle, 0);
    if (!isdefined(self.botbb_b))
    {
        return undefined;
    }
    self.botbb_v = 0;
    self.botbb_got = "(no blueprint, " + self.botbb_b.attachments.size + " attachments)";
    return self.botbb_b;
}

bot_bundles_pick(force)
{
    if (isdefined(self.botbb_picked))
    {
        return;
    }
    if (!force && level.botbb_teamlists && bot_bundles_tname(self) == "")
    {
        return;
    }
    self.botbb_picked = 1;
    if (!isdefined(level.botbb_skins))
    {
        bot_bundles_data();
    }
    self.botbb_wantskin = randomint(100) < level.botbb_cfg_skin_chance;
    self.botbb_k = bot_bundles_randskin(self bot_bundles_tl());
    self.botbb_skin = level.botbb_skins[self.botbb_k];
    self.botbb_op = level.botbb_ops[level.botbb_skinop[self.botbb_k]];
    self.botbb_bundle = level.botbb_skinbundle[self.botbb_k];
    self bot_bundles_slot();
    self bot_bundles_force_skin();
    self bot_bundles_teamskin();
    self.botbb_bp = randomint(100) < level.botbb_cfg_blueprint_chance;
    self.botbb_prim = level.botbb_prims[randomint(level.botbb_prims.size)];
    self.botbb_sec = level.botbb_secs[randomint(level.botbb_secs.size)];
    if (self.botbb_wantskin && self.botbb_bp && self.botbb_bundle != "" && randomint(100) < level.botbb_cfg_bundle_chance)
    {
        self.botbb_match = [];
        foreach (e in level.botbb_prims)
        {
            self.botbb_et = strtok(e, ";");
            if (self.botbb_et[2] == self.botbb_bundle)
            {
                self.botbb_match[self.botbb_match.size] = e;
            }
        }
        if (self.botbb_match.size > 0)
        {
            self.botbb_prim = self.botbb_match[randomint(self.botbb_match.size)];
        }
    }
    self bot_bundles_level_pick();
    self bot_bundles_force_level();
}

bot_bundles_slot()
{
    if (isdefined(self.botbb_slot))
    {
        return;
    }
    if (!isdefined(level.botbb_slots))
    {
        level.botbb_slots = 0;
        level.botbb_tslots = [];
        level.botbb_tslots["jsoc"] = 0;
        level.botbb_tslots["guild"] = 0;
    }
    level.botbb_slots = level.botbb_slots + 1;
    self.botbb_slot = level.botbb_slots;
    self.botbb_tname = bot_bundles_tname(self);
    self.botbb_tslot = 0;
    self.botbb_tnote = "";
    if (self.botbb_tname != "")
    {
        level.botbb_tslots[self.botbb_tname] = level.botbb_tslots[self.botbb_tname] + 1;
        self.botbb_tslot = level.botbb_tslots[self.botbb_tname];
        if (self.botbb_tname == "jsoc")
        {
            self.botbb_tnote = " (JSOC " + self.botbb_tslot + ")";
        }
        else
        {
            self.botbb_tnote = " (Guild " + self.botbb_tslot + ")";
        }
    }
    if (self.botbb_slot <= 18)
    {
        bot_bundles_log("bot slot " + self.botbb_slot, "" + self.name + self.botbb_tnote);
    }
}

bot_bundles_entry(shared, jsoc, guild)
{
    if (self.botbb_tname == "jsoc" && jsoc.size > 0)
    {
        if (self.botbb_tslot <= jsoc.size)
        {
            return jsoc[self.botbb_tslot - 1];
        }
        return "";
    }
    if (self.botbb_tname == "guild" && guild.size > 0)
    {
        if (self.botbb_tslot <= guild.size)
        {
            return guild[self.botbb_tslot - 1];
        }
        return "";
    }
    if (self.botbb_slot <= shared.size)
    {
        return shared[self.botbb_slot - 1];
    }
    return "";
}

bot_bundles_force_skin()
{
    self.botbb_want = self bot_bundles_entry(level.botbb_cfg_bot_skins, level.botbb_cfg_jsoc_skins, level.botbb_cfg_guild_skins);
    if (!isdefined(self.botbb_want) || self.botbb_want == "")
    {
        return;
    }
    if (self.botbb_want == "game")
    {
        self.botbb_wantskin = 0;
        bot_bundles_log("bot slot " + self.botbb_slot + " skin", "game's skin (setting)");
        return;
    }
    self.botbb_found = -1;
    foreach (i, n in level.botbb_skinnames)
    {
        if (n == self.botbb_want)
        {
            self.botbb_found = i;
            break;
        }
    }
    if (self.botbb_found < 0)
    {
        self.botbb_cands = [];
        foreach (i, n in level.botbb_skinnames)
        {
            if (level.botbb_opnames[level.botbb_skinop[i]] == self.botbb_want)
            {
                self.botbb_cands[self.botbb_cands.size] = i;
            }
        }
        if (self.botbb_cands.size > 0)
        {
            self.botbb_found = self.botbb_cands[randomint(self.botbb_cands.size)];
        }
    }
    if (self.botbb_found < 0)
    {
        bot_bundles_log("bot slot " + self.botbb_slot + " skin", "'" + self.botbb_want + "' isn't a skin or operator name (see kronos\\mods\\bot_bundles\\bot_skins.txt); used the odds");
        return;
    }
    self.botbb_k = self.botbb_found;
    self.botbb_skin = level.botbb_skins[self.botbb_k];
    self.botbb_op = level.botbb_ops[level.botbb_skinop[self.botbb_k]];
    self.botbb_bundle = level.botbb_skinbundle[self.botbb_k];
    self.botbb_wantskin = 1;
    self.botbb_forced = 1;
    bot_bundles_log("bot slot " + self.botbb_slot + " skin", level.botbb_skinnames[self.botbb_k] + " (setting '" + self.botbb_want + "')");
}

bot_bundles_force_level()
{
    self.botbb_spec = self bot_bundles_entry(level.botbb_cfg_bot_levels, level.botbb_cfg_jsoc_levels, level.botbb_cfg_guild_levels);
    if (!isdefined(self.botbb_spec) || self.botbb_spec == "")
    {
        return;
    }
    self.botbb_tok = strtok(self.botbb_spec, " ");
    if (self.botbb_tok.size < 1)
    {
        return;
    }
    self.botbb_t0 = self.botbb_tok[0];
    self.botbb_fp = 0;
    self.botbb_fl = -1;
    if (self.botbb_t0 == "PM" || self.botbb_t0 == "pm" || self.botbb_t0 == "Pm" || self.botbb_t0 == "pM")
    {
        self.botbb_fp = 11;
    }
    else
    {
        self.botbb_pp = strtok(self.botbb_t0, "Pp");
        if (self.botbb_pp.size == 1 && self.botbb_pp[0] != self.botbb_t0)
        {
            self.botbb_fp = bot_bundles_clamp(int(self.botbb_pp[0]), 0, 10);
        }
        else if (self.botbb_tok.size == 1)
        {
            self.botbb_fl = int(self.botbb_t0);
        }
    }
    if (self.botbb_tok.size >= 2)
    {
        self.botbb_fl = int(self.botbb_tok[1]);
    }
    if (self.botbb_fp == 11)
    {
        if (self.botbb_fl < 0)
        {
            self.botbb_fl = bot_bundles_rand(level.botbb_cfg_level_master_min, level.botbb_cfg_level_master_max);
        }
        self.botbb_fl = bot_bundles_clamp(self.botbb_fl, 56, 1000);
    }
    else
    {
        if (self.botbb_fl < 0)
        {
            self.botbb_fl = bot_bundles_rand(level.botbb_cfg_level_min, level.botbb_cfg_level_max);
        }
        self.botbb_fl = bot_bundles_clamp(self.botbb_fl, 1, 55);
    }
    self.botbb_prestige = self.botbb_fp;
    self.botbb_lvl = self.botbb_fl;
    self.botbb_rank = self.botbb_lvl - 1;
    self.botbb_rank_tries = 0;
    bot_bundles_log("bot slot " + self.botbb_slot + " level", "prestige " + self.botbb_prestige + " level " + self.botbb_lvl
        + " (setting '" + self.botbb_spec + "')");
}

bot_bundles_level_pick()
{
    self.botbb_rank = -1;
    self.botbb_prestige = 0;
    self.botbb_lvl = 1;
    if (level.botbb_cfg_levels == 0)
    {
        return;
    }
    if (level.botbb_cfg_levels == 1)
    {
        self.botbb_r = randomint(100);
        if (self.botbb_r < 25)
        {
            self.botbb_prestige = 0;
            self.botbb_lvl = bot_bundles_rand(1, 55);
        }
        else if (self.botbb_r < 70)
        {
            self.botbb_prestige = bot_bundles_rand(1, 10);
            self.botbb_lvl = bot_bundles_rand(1, 55);
        }
        else
        {
            self.botbb_prestige = 11;
            self.botbb_lvl = 56 + randomint(randomint(945) + 1);
        }
    }
    else if (level.botbb_cfg_levels == 2)
    {
        if (randomint(100) < 15)
        {
            self.botbb_prestige = bot_bundles_rand(6, 10);
            self.botbb_lvl = bot_bundles_rand(1, 55);
        }
        else
        {
            self.botbb_prestige = 11;
            self.botbb_lvl = bot_bundles_rand(56, 1000);
        }
    }
    else if (level.botbb_cfg_levels == 3)
    {
        self.botbb_prestige = bot_bundles_rand(level.botbb_cfg_prestige_min, level.botbb_cfg_prestige_max);
        if (self.botbb_prestige == 11)
        {
            self.botbb_lvl = bot_bundles_rand(level.botbb_cfg_level_master_min, level.botbb_cfg_level_master_max);
        }
        else
        {
            self.botbb_lvl = bot_bundles_rand(level.botbb_cfg_level_min, level.botbb_cfg_level_max);
        }
    }
    else
    {
        self.botbb_prestige = 11;
        self.botbb_lvl = level.botbb_cfg_level_master_max;
    }
    self.botbb_rank = self.botbb_lvl - 1;
    self.botbb_rank_tries = 0;
}

bot_bundles_rank_xp(rank)
{
    if (rank < level.botbb_rankxp.size)
    {
        return level.botbb_rankxp[rank];
    }
    return level.botbb_rankxp[level.botbb_rankxp.size - 1];
}

bot_bundles_level()
{
    if (self.botbb_rank < 0 || !isdefined(self.var_8b69ecbd466a79fa))
    {
        return;
    }
    if (isdefined(self.var_8b69ecbd466a79fa["prestige"]) && self.var_8b69ecbd466a79fa["prestige"] == self.botbb_prestige
        && isdefined(self.var_8b69ecbd466a79fa["rank"]) && self.var_8b69ecbd466a79fa["rank"] >= self.botbb_rank)
    {
        return;
    }
    if (self.botbb_rank_tries >= 5)
    {
        return;
    }
    if (self.botbb_rank_tries == 0)
    {
        self.botbb_before = "game gave rank " + bot_bundles_pers(self, "rank") + " prestige " + bot_bundles_pers(self, "prestige")
            + " xp " + bot_bundles_pers(self, "rankxp");
    }
    self.botbb_rank_tries = self.botbb_rank_tries + 1;
    self.var_8b69ecbd466a79fa["rankxp"] = bot_bundles_rank_xp(self.botbb_rank);
    self.var_8b69ecbd466a79fa["rank"] = self.botbb_rank;
    self.var_8b69ecbd466a79fa["prestige"] = self.botbb_prestige;
    self function_1be70d7d37af7e50(self.botbb_rank, self.botbb_prestige);
    level.botbb_levels_set = level.botbb_levels_set + 1;
    if (level.botbb_levels_set <= 12)
    {
        bot_bundles_log("bot " + level.botbb_levels_set + " level", "prestige " + self.botbb_prestige + " level " + self.botbb_lvl + " (try "
            + self.botbb_rank_tries + "; " + self.botbb_before + "; alive " + function_52d4872ae95d8bb7(self) + ")");
    }
}

bot_bundles_pers(p, key)
{
    if (!isdefined(p.var_8b69ecbd466a79fa) || !isdefined(p.var_8b69ecbd466a79fa[key]))
    {
        return "-";
    }
    return "" + p.var_8b69ecbd466a79fa[key];
}

bot_bundles_host_log()
{
    if (isdefined(level.botbb_host_logged))
    {
        return;
    }
    foreach (p in level.players)
    {
        if (isdefined(p) && !isbot(p) && isdefined(p.var_8b69ecbd466a79fa))
        {
            level.botbb_host_logged = 1;
            bot_bundles_log("host level", "rank " + bot_bundles_pers(p, "rank") + " prestige " + bot_bundles_pers(p, "prestige")
                + " xp " + bot_bundles_pers(p, "rankxp"));
            return;
        }
    }
}

bot_bundles_skin()
{
    if (!self.botbb_wantskin || !function_52d4872ae95d8bb7(self) || !isdefined(self.operatorCustomization))
    {
        return;
    }
    self bot_bundles_teamskin();
    if (!self.botbb_wantskin)
    {
        return;
    }
    if (isdefined(self.operatorCustomization.skinRef) && self.operatorCustomization.skinRef == self.botbb_skin)
    {
        self.botbb_tries = 0;
        return;
    }
    if (!isdefined(self.botbb_tries))
    {
        self.botbb_tries = 0;
    }
    if (self.botbb_tries >= 2)
    {
        return;
    }
    if (level.botbb_skintier[self.botbb_k] < 0 && !bot_bundles_opok(self.botbb_op))
    {
        bot_bundles_log("bot slot " + self.botbb_slot + " skin", "'" + level.botbb_skinnames[self.botbb_k]
            + "' needs the operators mod (mp_bo6_operators.gsc), which hasn't added it - used a random skin");
        self.botbb_forced = undefined;
        self.botbb_k = bot_bundles_randskin(self bot_bundles_tl());
        self.botbb_skin = level.botbb_skins[self.botbb_k];
        self.botbb_op = level.botbb_ops[level.botbb_skinop[self.botbb_k]];
        self.botbb_bundle = level.botbb_skinbundle[self.botbb_k];
    }
    self.botbb_tries = self.botbb_tries + 1;
    if (!self function_41d9b8754a37a071(self.botbb_skin))
    {
        level.botbb_refused = level.botbb_refused + 1;
        bot_bundles_log("skins", level.botbb_applied + " applied, " + level.botbb_refused + " refused by the engine");
        return;
    }
    self operator::function_8a20b5520866f917(self.botbb_op, self.botbb_skin);
    level.botbb_applied = level.botbb_applied + 1;
    if (level.botbb_applied <= 40)
    {
        bot_bundles_log("skins", level.botbb_applied + " applied, " + level.botbb_refused + " refused by the engine");
    }
}

bot_bundles_loop()
{
    level.botbb_applied = 0;
    level.botbb_refused = 0;
    level.botbb_levels_set = 0;
    for (;;)
    {
        wait 1;
        if (!bot_bundles_mapok() || !isdefined(level.players))
        {
            continue;
        }
        level.botbb_m = bot_bundles_mode();
        bot_bundles_factions();
        bot_bundles_observe();
        bot_bundles_host_log();
        foreach (p in level.players)
        {
            if (!isdefined(p) || !isbot(p))
            {
                continue;
            }
            p bot_bundles_pick(0);
            p bot_bundles_level();
            if (level.botbb_m >= 1)
            {
                p bot_bundles_skin();
            }
        }
        bot_bundles_publish();
    }
}

bot_bundles_publish()
{
    level.botbb_pv = "";
    foreach (p in level.players)
    {
        if (isdefined(p) && isbot(p) && isdefined(p.botbb_rank) && p.botbb_rank >= 0 && isdefined(p.name))
        {
            level.botbb_pv = level.botbb_pv + p.name + "|" + p.botbb_prestige + ";";
        }
    }
    if (!isdefined(level.botbb_pv_sent) || level.botbb_pv_sent != level.botbb_pv)
    {
        level.botbb_pv_sent = level.botbb_pv;
        setdvar(@"kronos_botbb_prestige", level.botbb_pv);
    }
}

bot_bundles_data()
{
    level.botbb_rankxp = [0, 4500, 9500, 15000, 20500, 26500, 33000, 40000, 47500, 55500, 64000, 73000, 82500, 92500, 103000, 114000, 125500, 137500, 150000, 163000, 176500, 191000, 206000, 221500, 237500, 254500, 272000, 290000, 309000, 328500, 348500, 369500, 391000, 413500, 437000, 461000, 486000, 512000, 538500, 566000, 594500, 624000, 654500, 686000, 718500, 752000, 786500, 822000, 858500, 896500, 935500, 976000, 1018000, 1061500, 1106500, 1153000, 1200000];
    level.botbb_ops = [
        %"sat_usa_pl_jack_base",
        %"sat_usa_pl_jill_base",
        %"sat_usa_pl_orange",
        %"sat_usa_pl_black",
        %"sat_zaf_pl_peach",
        %"sat_ind_pl_azure",
        %"sat_ger_pl_purple",
        %"sat_rus_pl_magenta",
        %"sat_usa_pl_amber",
        %"sat_jpn_pl_scarlet",
        %"sat_usa_pl_maroon",
        %"sat_usa_pl_red",
        %"sat_mex_pl_green",
        %"sat_nzl_pl_rose",
        %"sat_usa_pl_white",
        %"sat_usa_pl_gray",
        %"sat_chn_pl_gold",
        %"sat_usa_pl_silver",
        %"sat_usa_pl_cyan",
        %"sat_ger_pl_blue",
        %"sat_mex_pl_indigo",
        %"sat_ind_pl_violet",
        %"sat_usa_pl_voss",
        %"sat_usa_pl_cdl_male_away",
        %"sat_usa_pl_cdl_male_home",
        %"sat_usa_pl_cdl_female_away",
        %"sat_usa_pl_cdl_female_home",
        %"sat_phl_pl_maya",
        %"sat_rus_pl_weaver",
        %"sat_gbr_pl_grey",
        %"sat_usa_pl_carver",
        %"sat_usa_pl_tulip",
        %"sat_usa_pl_peony",
        %"sat_usa_pl_iris",
        %"sat_usa_pl_sunflower",
        %"sat_usa_pl_breaker",
        %"sat_usa_pl_director",
        %"sat_usa_pl_overlord",
        %"sat_usa_pl_freelance",
        %"sat_usa_pl_raven",
        %"sat_usa_pl_valkyrie",
        %"sat_usa_pl_mozzarella",
        %"sat_usa_pl_swiss",
        %"sat_usa_pl_brie",
        %"sat_usa_pl_anvil",
        %"sat_kor_pl_hunterkiller",
        %"sat_usa_pl_vector",
        %"sat_usa_pl_sourdough",
        %"sat_usa_pl_spectre",
        %"sat_usa_pl_cipher",
        %"sat_usa_pl_peanut",
        %"sat_usa_pl_prism",
        %"sat_sgp_pl_blackjack",
        %"sat_usa_pl_warden",
        %"ghost_western",
        %"nicki_eastern",
        %"dune_eastern",
        %"jup_mp_beta",
        %"snoop_western",
        %"homelander_eastern",
        %"jup_mp_spring",
        %"jup_mp_summer",
        %"gus_western",
        %"jup_mp_hotel",
        %"jup_mp_void",
        %"jup_mp_bravo",
        %"jup_mp_mike"
    ];
    level.botbb_skins = [
        %"sat_usa_pl_jack_base_skin",
        %"sat_usa_pl_jill_base_skin",
        %"sat_usa_pl_orange_proto_skin",
        %"sat_usa_pl_black_proto_skin",
        %"sat_zaf_pl_peach_proto_skin",
        %"sat_ind_pl_azure_proto_skin",
        %"sat_ger_pl_purple_proto_skin",
        %"sat_rus_pl_magenta_proto_skin",
        %"sat_usa_pl_amber_proto_skin",
        %"sat_jpn_pl_scarlet_proto_skin",
        %"sat_usa_pl_maroon_proto_skin",
        %"sat_usa_pl_red_proto_skin",
        %"sat_mex_pl_green_proto_skin",
        %"sat_nzl_pl_rose_proto_skin",
        %"sat_usa_pl_orange_dronecharmer_skin",
        %"sat_usa_pl_white_proto_skin",
        %"sat_usa_pl_gray_proto_skin",
        %"sat_chn_pl_gold_proto_skin",
        %"sat_usa_pl_silver_proto_skin",
        %"sat_usa_pl_cyan_proto_skin",
        %"sat_ger_pl_blue_proto_skin",
        %"sat_mex_pl_indigo_proto_skin",
        %"sat_ind_pl_violet_proto_skin",
        %"sat_rus_pl_magenta_snow_skin",
        %"sat_jpn_pl_scarlet_samurai_skin",
        %"sat_jpn_pl_scarlet_samurai_red_skin",
        %"sat_mex_pl_green_trap_skin",
        %"sat_rus_pl_magenta_space_skin",
        %"sat_ger_pl_purple_laboratory_skin",
        %"sat_chn_pl_gold_milsim_skin",
        %"sat_chn_pl_gold_tactical_skin",
        %"sat_usa_pl_orange_air_skin",
        %"sat_mex_pl_green_sweater_skin",
        %"sat_usa_pl_red_safety_skin",
        %"sat_ind_pl_azure_killer_skin",
        %"sat_nzl_pl_rose_hive_skin",
        %"sat_usa_pl_amber_chickenlover_skin",
        %"sat_chn_pl_gold_luxury_skin",
        %"sat_mex_pl_indigo_luxury_skin",
        %"sat_usa_pl_maroon_uchi_skin",
        %"sat_ind_pl_azure_fantasy_skin",
        %"sat_ger_pl_blue_invent_skin",
        %"sat_usa_pl_red_sweater_skin",
        %"sat_chn_pl_gold_agile_skin",
        %"sat_ger_pl_purple_drained_skin",
        %"sat_usa_pl_amber_drained_skin",
        %"sat_jpn_pl_scarlet_drained_skin",
        %"sat_rus_pl_magenta_drained_skin",
        %"sat_usa_pl_red_beta_skin",
        %"sat_nzl_pl_rose_code_skin",
        %"sat_mex_pl_indigo_monster_skin",
        %"sat_mex_pl_green_beta_skin",
        %"sat_zaf_pl_peach_mud_skin",
        %"sat_usa_pl_red_psyop_skin",
        %"sat_ind_pl_azure_cradle_skin",
        %"sat_chn_pl_gold_blood_skin",
        %"sat_usa_pl_amber_turned_skin",
        %"sat_usa_pl_amber_quad_skin",
        %"sat_ger_pl_blue_obsidian_skin",
        %"sat_usa_pl_cyan_combat_skin",
        %"sat_usa_pl_amber_cook_skin",
        %"sat_usa_pl_cyan_trained_skin",
        %"sat_nzl_pl_rose_covert_skin",
        %"sat_nzl_pl_rose_gym_skin",
        %"sat_usa_pl_red_halo_skin",
        %"sat_ger_pl_purple_chemicals_skin",
        %"sat_zaf_pl_peach_eagle_skin",
        %"sat_usa_pl_maroon_shadow_skin",
        %"sat_usa_pl_orange_countermeasure_skin",
        %"sat_ind_pl_violet_ski_skin",
        %"sat_ind_pl_violet_web_skin",
        %"sat_chn_pl_gold_hooded_skin",
        %"sat_ind_pl_azure_biohazard_skin",
        %"sat_usa_pl_red_collide_skin",
        %"sat_ger_pl_blue_caesars_skin",
        %"sat_zaf_pl_peach_polar_skin",
        %"sat_ger_pl_blue_active_skin",
        %"sat_usa_pl_voss_base_skin",
        %"sat_usa_pl_voss_cape_skin",
        %"sat_usa_pl_cdl_male_away_base_skin",
        %"sat_usa_pl_cdl_male_home_base_skin",
        %"sat_usa_pl_cdl_female_away_base_skin",
        %"sat_usa_pl_cdl_female_home_base_skin",
        %"sat_ind_pl_violet_techcult_skin",
        %"sat_zaf_pl_peach_stealth_skin",
        %"sat_usa_pl_cdl_female_away_optic_skin",
        %"sat_usa_pl_cdl_female_away_rokkr_skin",
        %"sat_usa_pl_cdl_male_away_surge_skin",
        %"sat_usa_pl_cdl_female_home_thieves_skin",
        %"sat_usa_pl_cdl_male_home_koi_skin",
        %"sat_usa_pl_cdl_male_away_ravens_skin",
        %"sat_usa_pl_cdl_female_away_koi_skin",
        %"sat_usa_pl_cdl_female_home_breach_skin",
        %"sat_usa_pl_cdl_male_home_falcons_skin",
        %"sat_usa_pl_cdl_male_home_faze_skin",
        %"sat_usa_pl_cdl_female_home_optic_skin",
        %"sat_usa_pl_cdl_female_home_koi_skin",
        %"sat_usa_pl_cdl_female_away_falcons_skin",
        %"sat_usa_pl_cdl_female_away_faze_skin",
        %"sat_usa_pl_cdl_male_home_ravens_skin",
        %"sat_usa_pl_cdl_female_away_m8s_skin",
        %"sat_usa_pl_cdl_male_home_m8s_skin",
        %"sat_usa_pl_cdl_female_away_breach_skin",
        %"sat_usa_pl_cdl_female_away_ravens_skin",
        %"sat_usa_pl_cdl_male_away_m8s_skin",
        %"sat_usa_pl_cdl_male_home_heretics_skin",
        %"sat_usa_pl_cdl_male_away_breach_skin",
        %"sat_usa_pl_cdl_female_home_ravens_skin",
        %"sat_usa_pl_cdl_female_home_heretics_skin",
        %"sat_usa_pl_cdl_female_away_thieves_skin",
        %"sat_usa_pl_cdl_male_home_breach_skin",
        %"sat_usa_pl_cdl_male_away_optic_skin",
        %"sat_usa_pl_cdl_female_away_heretics_skin",
        %"sat_usa_pl_cdl_male_away_falcons_skin",
        %"sat_usa_pl_cdl_female_away_cloud9_skin",
        %"sat_usa_pl_cdl_female_home_faze_skin",
        %"sat_usa_pl_cdl_male_home_thieves_skin",
        %"sat_usa_pl_cdl_male_away_cloud9_skin",
        %"sat_usa_pl_cdl_female_home_rokkr_skin",
        %"sat_usa_pl_cdl_female_home_surge_skin",
        %"sat_usa_pl_cdl_female_home_m8s_skin",
        %"sat_usa_pl_cdl_male_home_surge_skin",
        %"sat_usa_pl_cdl_male_away_rokkr_skin",
        %"sat_usa_pl_cdl_female_home_cloud9_skin",
        %"sat_usa_pl_cdl_female_away_surge_skin",
        %"sat_usa_pl_cdl_male_away_koi_skin",
        %"sat_usa_pl_cdl_female_home_falcons_skin",
        %"sat_usa_pl_cdl_male_away_heretics_skin",
        %"sat_usa_pl_cdl_male_home_rokkr_skin",
        %"sat_usa_pl_cdl_male_away_faze_skin",
        %"sat_usa_pl_cdl_male_away_thieves_skin",
        %"sat_usa_pl_cdl_male_home_cloud9_skin",
        %"sat_usa_pl_cdl_male_home_optic_skin",
        %"sat_usa_pl_orange_emea_skin",
        %"sat_usa_pl_cyan_augment_skin",
        %"sat_jpn_pl_scarlet_road_skin",
        %"sat_mex_pl_indigo_monster_alt_skin",
        %"sat_mex_pl_green_escape_skin",
        %"sat_mex_pl_indigo_digital_skin",
        %"sat_nzl_pl_rose_arctic_skin",
        %"sat_ind_pl_violet_wc_skin",
        %"sat_usa_pl_cyan_wc_skin",
        %"sat_usa_pl_red_wc_skin",
        %"sat_nzl_pl_rose_wc_skin",
        %"sat_ger_pl_blue_wc_skin",
        %"sat_ind_pl_azure_wc_skin",
        %"sat_usa_pl_maroon_wc_skin",
        %"sat_usa_pl_orange_wc_skin",
        %"sat_mex_pl_green_wc_skin",
        %"sat_mex_pl_indigo_wc_skin",
        %"sat_zaf_pl_peach_wc_skin",
        %"sat_chn_pl_gold_wc_skin",
        %"sat_usa_pl_black_sp_skin",
        %"sat_usa_pl_gray_slugger_skin",
        %"sat_mex_pl_indigo_demon_lava_skin",
        %"sat_mex_pl_green_corrupted_skin",
        %"sat_usa_pl_silver_proto_neo_skin",
        %"sat_ind_pl_violet_techcult_bc_skin",
        %"sat_ind_pl_azure_rhino_skin",
        %"sat_usa_pl_silver_acid_skin",
        %"sat_usa_pl_maroon_abstract_skin",
        %"sat_jpn_pl_scarlet_fold_skin",
        %"sat_ind_pl_violet_puzzle_skin",
        %"sat_mex_pl_indigo_swamp_skin",
        %"sat_usa_pl_red_tv_skin",
        %"sat_phl_pl_maya_drained_skin",
        %"sat_rus_pl_weaver_drained_skin",
        %"sat_mex_pl_green_phase_skin",
        %"sat_gbr_pl_grey_drained_skin",
        %"sat_usa_pl_carver_drained_skin",
        %"sat_chn_pl_gold_force_skin",
        %"sat_phl_pl_maya_rogue_skin",
        %"sat_usa_pl_carver_infiltration_skin",
        %"sat_rus_pl_weaver_rogue_skin",
        %"sat_gbr_pl_grey_sable_skin",
        %"sat_phl_pl_maya_quest_skin",
        %"sat_usa_pl_voss_cape_bc_skin",
        %"sat_usa_pl_voss_base_bc_skin",
        %"sat_usa_pl_maroon_shadow_bc_skin",
        %"sat_usa_pl_amber_quad_bc_skin",
        %"sat_usa_pl_orange_countermeasure_bc_skin",
        %"sat_ger_pl_purple_chemicals_bc_skin",
        %"sat_usa_pl_tulip_base_skin",
        %"sat_usa_pl_peony_base_skin",
        %"sat_usa_pl_iris_base_skin",
        %"sat_mex_pl_green_lofi_skin",
        %"sat_usa_pl_iris_white_skin",
        %"sat_usa_pl_silver_factory_skin",
        %"sat_usa_pl_cdl_male_home_wz_ranked_base_skin",
        %"sat_usa_pl_cdl_female_home_wz_ranked_base_skin",
        %"sat_usa_pl_sunflower_base_skin",
        %"sat_ind_pl_azure_sneak_skin",
        %"sat_gbr_pl_grey_janus_skin",
        %"sat_usa_pl_maroon_redacted_skin",
        %"sat_phl_pl_maya_terminus_skin",
        %"sat_usa_pl_carver_mansion_skin",
        %"sat_rus_pl_weaver_bloodstone_skin",
        %"sat_ind_pl_violet_bloom_skin",
        %"sat_mex_pl_indigo_slate_skin",
        %"sat_usa_pl_breaker_base_skin",
        %"sat_usa_pl_white_space_skin",
        %"sat_usa_pl_red_damage_skin",
        %"sat_rus_pl_magenta_handler_skin",
        %"sat_mex_pl_green_club_skin",
        %"sat_usa_pl_jack_base_specialforces_skin",
        %"sat_usa_pl_cdl_female_away_mp_ranked_base_skin",
        %"sat_usa_pl_cdl_male_home_mp_ranked_base_skin",
        %"sat_usa_pl_cdl_male_away_mp_ranked_base_skin",
        %"sat_usa_pl_cdl_female_home_mp_ranked_base_skin",
        %"sat_zaf_pl_peach_stargazer_skin",
        %"sat_mex_pl_indigo_heist_skin",
        %"sat_ger_pl_purple_fancy_skin",
        %"sat_usa_pl_red_urban_skin",
        %"sat_ger_pl_purple_teleport_skin",
        %"sat_rus_pl_magenta_knight_skin",
        %"sat_usa_pl_red_bloom_skin",
        %"sat_gbr_pl_grey_quest_skin",
        %"sat_usa_pl_amber_celtic_skin",
        %"sat_mex_pl_indigo_pirate_skin",
        %"sat_ger_pl_blue_carbon_skin",
        %"sat_usa_pl_peony_variant_skin",
        %"sat_usa_pl_director_base_skin",
        %"sat_usa_pl_maroon_fbi_skin",
        %"sat_usa_pl_amber_magic_skin",
        %"sat_usa_pl_jack_base_infected_skin",
        %"sat_usa_pl_cdl_male_home_wz_ranked_1_skin",
        %"sat_usa_pl_cdl_female_home_mp_ranked_iridescent_skin",
        %"sat_usa_pl_cdl_male_away_mp_ranked_crimson_skin",
        %"sat_usa_pl_cdl_male_home_mp_ranked_1_skin",
        %"sat_usa_pl_cdl_female_home_mp_ranked_diamond_skin",
        %"sat_usa_pl_cdl_male_home_mp_ranked_crimson_skin",
        %"sat_usa_pl_cdl_male_home_mp_ranked_platinum_skin",
        %"sat_usa_pl_cdl_female_away_mp_ranked_1_skin",
        %"sat_usa_pl_cdl_male_home_mp_ranked_diamond_skin",
        %"sat_usa_pl_cdl_male_home_wz_ranked_250_skin",
        %"sat_usa_pl_cdl_female_home_wz_ranked_iridescent_skin",
        %"sat_usa_pl_cdl_male_away_mp_ranked_platinum_skin",
        %"sat_usa_pl_cdl_female_away_mp_ranked_gold_skin",
        %"sat_usa_pl_cdl_female_home_mp_ranked_platinum_skin",
        %"sat_usa_pl_cdl_female_home_wz_ranked_diamond_skin",
        %"sat_usa_pl_cdl_female_home_mp_ranked_250_skin",
        %"sat_usa_pl_cdl_male_away_mp_ranked_1_skin",
        %"sat_usa_pl_cdl_female_home_wz_ranked_1_skin",
        %"sat_usa_pl_cdl_female_home_wz_ranked_crimson_skin",
        %"sat_usa_pl_cdl_male_away_mp_ranked_gold_skin",
        %"sat_usa_pl_cdl_male_home_wz_ranked_crimson_skin",
        %"sat_usa_pl_cdl_male_home_wz_ranked_iridescent_skin",
        %"sat_usa_pl_cdl_female_home_mp_ranked_gold_skin",
        %"sat_usa_pl_cdl_male_away_mp_ranked_iridescent_skin",
        %"sat_usa_pl_cdl_male_home_wz_ranked_gold_skin",
        %"sat_usa_pl_cdl_male_home_wz_ranked_platinum_skin",
        %"sat_usa_pl_cdl_female_home_wz_ranked_platinum_skin",
        %"sat_usa_pl_cdl_male_home_mp_ranked_gold_skin",
        %"sat_usa_pl_cdl_male_away_mp_ranked_diamond_skin",
        %"sat_usa_pl_cdl_female_away_mp_ranked_iridescent_skin",
        %"sat_usa_pl_cdl_male_home_wz_ranked_diamond_skin",
        %"sat_usa_pl_cdl_female_home_wz_ranked_250_skin",
        %"sat_usa_pl_cdl_female_home_wz_ranked_gold_skin",
        %"sat_usa_pl_cdl_male_away_mp_ranked_250_skin",
        %"sat_usa_pl_cdl_female_away_mp_ranked_250_skin",
        %"sat_usa_pl_cdl_male_home_mp_ranked_iridescent_skin",
        %"sat_usa_pl_cdl_female_away_mp_ranked_platinum_skin",
        %"sat_usa_pl_cdl_female_away_mp_ranked_diamond_skin",
        %"sat_usa_pl_cdl_female_home_mp_ranked_1_skin",
        %"sat_usa_pl_cdl_male_home_mp_ranked_250_skin",
        %"sat_usa_pl_cdl_female_home_mp_ranked_crimson_skin",
        %"sat_usa_pl_cdl_female_away_mp_ranked_crimson_skin",
        %"sat_usa_pl_jack_base_infected_gardenia_skin",
        %"sat_usa_pl_overlord_base_skin",
        %"sat_usa_pl_white_cupid_skin",
        %"sat_chn_pl_gold_equus_skin",
        %"sat_mex_pl_green_cold_skin",
        %"sat_ind_pl_azure_surgeon_bp_skin",
        %"sat_jpn_pl_scarlet_breacher_skin",
        %"sat_jpn_pl_scarlet_battle_skin",
        %"sat_usa_pl_freelance_tie_skin",
        %"sat_zaf_pl_peach_xo_skin",
        %"sat_ind_pl_azure_surgeon_bc_skin",
        %"sat_ger_pl_blue_fire_skin",
        %"sat_zaf_pl_peach_xo_bc_skin",
        %"sat_chn_pl_gold_hunt_skin",
        %"sat_usa_pl_gray_robot_bc_skin",
        %"sat_usa_pl_gray_robot_bp_skin",
        %"sat_usa_pl_black_subject_bp_skin",
        %"sat_usa_pl_maroon_medic_bp_skin",
        %"sat_rus_pl_magenta_handler_bc_skin",
        %"sat_usa_pl_red_urban_bc_skin",
        %"sat_usa_pl_director_base_bc_skin",
        %"sat_usa_pl_maroon_army_skin",
        %"sat_usa_pl_director_vector_skin",
        %"sat_usa_pl_director_vector_bc_skin",
        %"sat_usa_pl_black_bot_skin",
        %"sat_mex_pl_indigo_moss_skin",
        %"sat_usa_pl_gray_rgb_skin",
        %"sat_usa_pl_orange_nm_skin",
        %"sat_zaf_pl_peach_nm_skin",
        %"sat_chn_pl_gold_nm_skin",
        %"sat_usa_pl_silver_protect_skin",
        %"sat_usa_pl_white_nm_skin",
        %"sat_ind_pl_violet_assassin_skin",
        %"sat_ind_pl_violet_soldier_skin",
        %"sat_ind_pl_azure_merc_skin",
        %"sat_usa_pl_cyan_deadeye_skin",
        %"sat_usa_pl_red_blackout_skin",
        %"sat_mex_pl_green_blackout_skin",
        %"sat_nzl_pl_rose_toa_skin",
        %"sat_usa_pl_orange_paint_skin",
        %"sat_usa_pl_black_virus_skin",
        %"sat_ger_pl_blue_vein_skin",
        %"sat_usa_pl_amber_challenge_skin",
        %"sat_chn_pl_gold_droid_skin",
        %"sat_jpn_pl_scarlet_shepard_skin",
        %"sat_zaf_pl_peach_hitman_skin",
        %"sat_usa_pl_cyan_villain_skin",
        %"sat_usa_pl_jill_base_infected_skin",
        %"sat_usa_pl_jill_base_infected_gardenia_skin",
        %"sat_mex_pl_green_spy_skin",
        %"sat_rus_pl_magenta_evil_skin",
        %"sat_usa_pl_overlord_base_alt_skin",
        %"sat_usa_pl_black_seal_skin",
        %"sat_usa_pl_red_avalon_skin",
        %"sat_usa_pl_white_chrome_skin",
        %"sat_usa_pl_amber_monkeybomb_skin",
        %"sat_usa_pl_cyan_flank_skin",
        %"sat_ind_pl_azure_mono_skin",
        %"sat_ind_pl_violet_engage_skin",
        %"sat_mex_pl_indigo_tundranaut_skin",
        %"sat_rus_pl_magenta_wasteland_skin",
        %"sat_nzl_pl_rose_mono_skin",
        %"sat_ind_pl_azure_shieldsoldier_skin",
        %"sat_usa_pl_white_karma_skin",
        %"sat_usa_pl_orange_stealth_skin",
        %"sat_usa_pl_amber_bio_skin",
        %"sat_usa_pl_maroon_sea_skin",
        %"sat_ind_pl_azure_jsoc_skin",
        %"sat_mex_pl_green_jsoc_skin",
        %"sat_nzl_pl_rose_guild_skin",
        %"sat_usa_pl_red_guild_skin",
        %"sat_chn_pl_gold_jungle_skin",
        %"sat_ger_pl_purple_cryo_skin",
        %"sat_ger_pl_purple_hundred_skin",
        %"sat_zaf_pl_peach_roman_skin",
        %"sat_usa_pl_raven_base_skin",
        %"sat_usa_pl_amber_ultimis_skin",
        %"sat_ger_pl_purple_cryo_bc_skin",
        %"sat_usa_pl_valkyrie_proto_skin",
        %"sat_usa_pl_white_legacy_bc_skin",
        %"sat_usa_pl_amber_alpine_bc_skin",
        %"sat_usa_pl_silver_harsh_bc_skin",
        %"sat_usa_pl_raven_base_bc_skin",
        %"sat_usa_pl_raven_altitude_bc_skin",
        %"sat_usa_pl_maroon_bruiser_skin",
        %"sat_usa_pl_orange_sub_skin",
        %"sat_usa_pl_amber_slacker_skin",
        %"sat_usa_pl_maroon_igl_skin",
        %"sat_usa_pl_red_mam_alt_skin",
        %"sat_usa_pl_red_mam_skin",
        %"sat_usa_pl_silver_harsh_skin",
        %"sat_chn_pl_gold_jungle_bc_skin",
        %"sat_usa_pl_valkyrie_tear_skin",
        %"sat_usa_pl_valkyrie_skull_skin",
        %"sat_usa_pl_maroon_tagger_skin",
        %"sat_zaf_pl_peach_cryo_skin",
        %"sat_usa_pl_raven_altitude_skin",
        %"sat_ger_pl_blue_flame_skin",
        %"sat_mex_pl_indigo_ninja_skin",
        %"sat_usa_pl_amber_alpine_bp_skin",
        %"sat_mex_pl_indigo_grunt_skin",
        %"sat_usa_pl_mozzarella_base_skin",
        %"sat_usa_pl_mozzarella_burrata_skin",
        %"sat_usa_pl_voss_secret_skin",
        %"sat_ger_pl_blue_techcamo_skin",
        %"sat_usa_pl_red_nm_glitch_skin",
        %"sat_usa_pl_orange_nm_glitch_skin",
        %"sat_ger_pl_blue_nm_glitch_skin",
        %"sat_rus_pl_magenta_henchman_skin",
        %"sat_chn_pl_gold_redline_skin",
        %"sat_usa_pl_gray_liquid_skin",
        %"sat_usa_pl_white_thug_skin",
        %"sat_jpn_pl_scarlet_sight_skin",
        %"sat_zaf_pl_peach_recon_skin",
        %"sat_mex_pl_green_captain_skin",
        %"sat_usa_pl_swiss_base_skin",
        %"sat_usa_pl_swiss_damaged_skin",
        %"sat_usa_pl_brie_base_skin",
        %"sat_usa_pl_swiss_iri_skin",
        %"sat_mex_pl_indigo_pyro_skin",
        %"sat_usa_pl_cyan_poseidon_skin",
        %"sat_usa_pl_anvil_base_skin",
        %"sat_rus_pl_magenta_faberge_skin",
        %"sat_ger_pl_blue_neon_skin",
        %"sat_rus_pl_weaver_quest_skin",
        %"sat_chn_pl_gold_cute_skin",
        %"sat_chn_pl_gold_west_skin",
        %"sat_kor_pl_hunterkiller_base_skin",
        %"sat_zaf_pl_peach_nm_glitch_skin",
        %"sat_usa_pl_amber_washington_skin",
        %"sat_rus_pl_magenta_raider_skin",
        %"sat_ind_pl_violet_raptor_skin",
        %"sat_usa_pl_silver_protect_clean_skin",
        %"sat_usa_pl_silver_protect_brown_clean_skin",
        %"sat_ger_pl_blue_tread_skin",
        %"sat_usa_pl_red_sixpack_skin",
        %"sat_ind_pl_azure_tattoo_skin",
        %"sat_usa_pl_red_fbi_skin",
        %"sat_ind_pl_azure_brass_skin",
        %"sat_ind_pl_azure_sand_skin",
        %"sat_mex_pl_indigo_jersey_skin",
        %"sat_usa_pl_director_slice_skin",
        %"sat_usa_pl_black_dad_skin",
        %"sat_usa_pl_white_chaos_skin",
        %"sat_rus_pl_magenta_circus_skin",
        %"sat_mex_pl_green_tarot_skin",
        %"sat_ger_pl_purple_panzer_skin",
        %"sat_ind_pl_azure_thug_skin",
        %"sat_mex_pl_indigo_nm_glitch_skin",
        %"sat_zaf_pl_peach_gamble_skin",
        %"sat_usa_pl_cyan_slash_skin",
        %"sat_usa_pl_cyan_color_skin",
        %"sat_usa_pl_brie_brioche_skin",
        %"sat_usa_pl_maroon_mask_skin",
        %"sat_rus_pl_magenta_organ_skin",
        %"sat_ind_pl_azure_tattoo_bc_skin",
        %"sat_usa_pl_cyan_slash_bc_skin",
        %"sat_ger_pl_blue_tread_bc_skin",
        %"sat_usa_pl_brie_honey_skin",
        %"sat_usa_pl_anvil_hammer_bc_skin",
        %"sat_jpn_pl_scarlet_sight_bc_skin",
        %"sat_usa_pl_anvil_hammer_skin",
        %"sat_rus_pl_magenta_henchman_bc_skin",
        %"sat_usa_pl_vector_base_skin",
        %"sat_usa_pl_vector_alpha_skin",
        %"sat_usa_pl_vector_redacted_skin",
        %"sat_usa_pl_vector_omega_skin",
        %"sat_usa_pl_orange_outlaw_skin",
        %"sat_ind_pl_violet_nm_glitch_skin",
        %"sat_usa_pl_raven_action_skin",
        %"sat_ind_pl_azure_grenadier_skin",
        %"sat_usa_pl_silver_glitch_skin",
        %"sat_usa_pl_sourdough_base_skin",
        %"sat_usa_pl_sourdough_hero_skin",
        %"sat_usa_pl_voss_bankrobber_skin",
        %"sat_ger_pl_blue_bankrobber_skin",
        %"sat_jpn_pl_scarlet_spirit_skin",
        %"sat_usa_pl_white_clean_skin",
        %"sat_mex_pl_green_sandy_skin",
        %"sat_usa_pl_cyan_lmao_skin",
        %"sat_usa_pl_silver_upgrade_skin",
        %"sat_ind_pl_azure_marrow_skin",
        %"sat_ger_pl_blue_kaiju_skin",
        %"sat_usa_pl_red_modern_skin",
        %"sat_usa_pl_maroon_wrath_skin",
        %"sat_chn_pl_gold_west_beta_skin",
        %"sat_chn_pl_gold_west_alpha_skin",
        %"sat_usa_pl_anvil_base_bc_skin",
        %"sat_nzl_pl_rose_nycto_skin",
        %"sat_usa_pl_black_support_skin",
        %"sat_usa_pl_amber_tropical_skin",
        %"sat_ind_pl_violet_breach_skin",
        %"sat_jpn_pl_scarlet_street_skin",
        %"sat_ger_pl_blue_cq_skin",
        %"sat_nzl_pl_rose_nm_glitch_skin",
        %"sat_ind_pl_azure_nm_glitch_skin",
        %"sat_chn_pl_gold_wall_skin",
        %"sat_usa_pl_cyan_nm_glitch_skin",
        %"sat_usa_pl_maroon_nm_glitch_skin",
        %"sat_chn_pl_gold_nm_glitch_skin",
        %"sat_mex_pl_green_nm_glitch_skin",
        %"sat_zaf_pl_peach_shattered_skin",
        %"sat_rus_pl_magenta_soda_skin",
        %"sat_usa_pl_director_witch_skin",
        %"sat_ger_pl_blue_ruin_skin",
        %"sat_usa_pl_maroon_rage_skin",
        %"sat_usa_pl_carver_quest_skin",
        %"sat_mex_pl_indigo_patrol_skin",
        %"sat_usa_pl_gray_tank_skin",
        %"sat_chn_pl_gold_mechanic_skin",
        %"sat_ger_pl_purple_fused_skin",
        %"sat_usa_pl_amber_metal_skin",
        %"sat_ger_pl_blue_advanced_skin",
        %"sat_usa_pl_gray_arcade_skin",
        %"sat_usa_pl_maroon_welded_skin",
        %"sat_usa_pl_orange_bubblegum_skin",
        %"sat_zaf_pl_peach_crush_skin",
        %"sat_usa_pl_silver_machine_skin",
        %"sat_usa_pl_spectre_base_skin",
        %"sat_mex_pl_indigo_jersey_alt_skin",
        %"sat_ind_pl_azure_mind_skin",
        %"sat_ind_pl_violet_ambush_skin",
        %"sat_usa_pl_cipher_gamma_skin",
        %"sat_usa_pl_cipher_beta_skin",
        %"sat_usa_pl_cipher_alpha_skin",
        %"sat_usa_pl_cipher_base_skin",
        %"sat_usa_pl_spectre_base_bc_skin",
        %"sat_usa_pl_spectre_elite_skin",
        %"sat_usa_pl_spectre_elite_bc_skin",
        %"sat_ger_pl_purple_fused_bc_skin",
        %"sat_usa_pl_silver_machine_bc_skin",
        %"sat_usa_pl_amber_metal_bc_skin",
        %"sat_usa_pl_orange_bubblegum_bc_skin",
        %"sat_usa_pl_gray_tank_bc_skin",
        %"sat_jpn_pl_scarlet_spirit_skin_human_mask",
        %"sat_jpn_pl_scarlet_spirit_skin_demon_mask",
        %"sat_jpn_pl_scarlet_horror_skin",
        %"sat_mex_pl_green_range_skin",
        %"sat_ger_pl_purple_barber_skin",
        %"sat_ind_pl_azure_secure_skin",
        %"sat_usa_pl_cyan_island_skin",
        %"sat_usa_pl_gray_pepper_skin",
        %"sat_usa_pl_amber_king_skin",
        %"sat_ger_pl_blue_widow_skin",
        %"sat_nzl_pl_rose_ground_skin",
        %"sat_usa_pl_peanut_base_skin",
        %"sat_usa_pl_anvil_horseman_skin",
        %"sat_rus_pl_magenta_wolf_skin",
        %"sat_zaf_pl_peach_wild_skin",
        %"sat_usa_pl_white_death_skin",
        %"sat_zaf_pl_peach_shattered_helmet_skin",
        %"sat_zaf_pl_peach_shattered_no_helmet_skin",
        %"sat_jpn_pl_scarlet_disciple_skin",
        %"sat_zaf_pl_peach_zm_skin",
        %"sat_ind_pl_violet_zm_skin",
        %"sat_chn_pl_gold_peanut_skin",
        %"sat_usa_pl_silver_pumpkin_skin",
        %"sat_jpn_pl_scarlet_war_skin",
        %"sat_usa_pl_cyan_puppet_skin",
        %"sat_usa_pl_red_scare_skin",
        %"sat_rus_pl_magenta_super_skin",
        %"sat_rus_pl_magenta_splice_bc_skin",
        %"sat_usa_pl_prism_alpha_skin",
        %"sat_sgp_pl_blackjack_base_skin",
        %"sat_sgp_pl_blackjack_base_bc_skin",
        %"sat_usa_pl_white_arachnid_bc_skin",
        %"sat_sgp_pl_blackjack_ultra_bc_skin",
        %"sat_usa_pl_warden_base_skin",
        %"sat_usa_pl_orange_break_skin",
        %"sat_usa_pl_gray_skin_skin",
        %"sat_jpn_pl_scarlet_butcher_bc_skin",
        %"sat_ind_pl_violet_plague_skin",
        %"sat_usa_pl_amber_jester_skin",
        %"sat_usa_pl_carver_super_skin",
        %"sat_mex_pl_green_smirk_skin",
        %"sat_usa_pl_prism_gamma_skin",
        %"sat_chn_pl_gold_halloween_skin",
        %"sat_rus_pl_magenta_splice_skin",
        %"sat_ger_pl_purple_super_skin",
        %"sat_usa_pl_cyan_puppet_bc_skin",
        %"sat_ind_pl_azure_doctor_skin",
        %"sat_usa_pl_maroon_chestnut_skin",
        %"sat_jpn_pl_scarlet_butcher_skin",
        %"sat_mex_pl_green_smirk_bc_skin",
        %"sat_phl_pl_maya_super_skin",
        %"sat_sgp_pl_blackjack_ultra_skin",
        %"sat_usa_pl_white_arachnid_skin",
        %"sat_usa_pl_prism_base_skin",
        %"sat_gbr_pl_grey_super_skin",
        %"sat_rus_pl_weaver_super_skin",
        %"sat_mex_pl_indigo_chestnut_skin",
        %"sat_usa_pl_amber_super_skin",
        %"sat_jpn_pl_scarlet_super_skin",
        %"sat_ind_pl_azure_peanut_skin",
        %"sat_usa_pl_red_glitch_skin",
        %"sat_usa_pl_peanut_shell_skin",
        %"sat_usa_pl_warden_western_skin",
        %"ghost_western_a",
        %"nicki_eastern_a",
        %"dune_eastern_a",
        %"jup_mp_beta_skin",
        %"jup_mp_beta_10_skin",
        %"snoop_western_a",
        %"snoop_western_alt",
        %"homelander_eastern_a",
        %"jup_mp_spring_skin",
        %"jup_mp_summer_skin",
        %"gus_kitty_western",
        %"gus_kitty_western_alt",
        %"jup_mp_hotel_skin",
        %"jup_mp_hotel_10_skin",
        %"jup_mp_hotel_11_skin",
        %"jup_mp_hotel_12_skin",
        %"jup_mp_hotel_13_skin",
        %"jup_mp_hotel_14_skin",
        %"jup_mp_hotel_15a_skin",
        %"jup_mp_hotel_15b_skin",
        %"jup_mp_hotel_17_skin",
        %"jup_mp_hotel_18_skin",
        %"jup_mp_hotel_19_skin",
        %"jup_mp_hotel_20_skin",
        %"jup_mp_hotel_21_skin",
        %"jup_mp_hotel_22_skin",
        %"jup_mp_hotel_23_skin",
        %"jup_mp_hotel_26_skin",
        %"jup_mp_void_skin",
        %"jup_mp_void_10_skin",
        %"jup_mp_void_11_skin",
        %"jup_mp_void_13_skin",
        %"jup_mp_void_14_skin",
        %"jup_mp_bravo_skin",
        %"jup_mp_bravo_10_skin",
        %"jup_mp_bravo_11_skin",
        %"jup_mp_bravo_12_skin",
        %"jup_mp_bravo_13_skin",
        %"jup_mp_bravo_14_skin",
        %"jup_mp_bravo_15_skin",
        %"jup_mp_bravo_17_skin",
        %"jup_mp_bravo_18_skin",
        %"jup_mp_bravo_19_skin",
        %"jup_mp_bravo_20_skin",
        %"jup_mp_bravo_21_skin",
        %"jup_mp_bravo_22_skin",
        %"jup_mp_mike_skin",
        %"jup_mp_mike_10_skin",
        %"jup_mp_mike_11_skin",
        %"jup_mp_mike_12_skin",
        %"jup_mp_mike_13_skin",
        %"jup_mp_mike_14_skin",
        %"jup_mp_mike_15_skin",
        %"jup_mp_mike_16_skin",
        %"jup_mp_mike_17_skin",
        %"jup_mp_mike_18_skin",
        %"jup_mp_mike_19_skin",
        %"jup_mp_mike_21_skin",
        %"jup_mp_mike_22_skin",
        %"jup_mp_mike_23_skin",
        %"jup_mp_mike_24_skin",
        %"jup_mp_mike_25_skin",
        %"jup_mp_mike_26_skin",
        %"jup_mp_mike_27_skin",
        %"jup_mp_mike_28_skin",
        %"jup_mp_mike_28b_skin",
        %"jup_mp_mike_29_skin",
        %"jup_mp_mike_30_skin",
        %"jup_mp_mike_31_skin"
    ];
    level.botbb_skinop = [
        0,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        2,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        7,
        9,
        9,
        12,
        7,
        6,
        16,
        16,
        2,
        12,
        11,
        5,
        13,
        8,
        16,
        20,
        10,
        5,
        19,
        11,
        16,
        6,
        8,
        9,
        7,
        11,
        13,
        20,
        12,
        4,
        11,
        5,
        16,
        8,
        8,
        19,
        18,
        8,
        18,
        13,
        13,
        11,
        6,
        4,
        10,
        2,
        21,
        21,
        16,
        5,
        11,
        19,
        4,
        19,
        22,
        22,
        23,
        24,
        25,
        26,
        21,
        4,
        25,
        25,
        23,
        26,
        24,
        23,
        25,
        26,
        24,
        24,
        26,
        26,
        25,
        25,
        24,
        25,
        24,
        25,
        25,
        23,
        24,
        23,
        26,
        26,
        25,
        24,
        23,
        25,
        23,
        25,
        26,
        24,
        23,
        26,
        26,
        26,
        24,
        23,
        26,
        25,
        23,
        26,
        23,
        24,
        23,
        23,
        24,
        24,
        2,
        18,
        9,
        20,
        12,
        20,
        13,
        21,
        18,
        11,
        13,
        19,
        5,
        10,
        2,
        12,
        20,
        4,
        16,
        3,
        15,
        20,
        12,
        17,
        21,
        5,
        17,
        10,
        9,
        21,
        20,
        11,
        27,
        28,
        12,
        29,
        30,
        16,
        27,
        30,
        28,
        29,
        27,
        22,
        22,
        10,
        8,
        2,
        6,
        31,
        32,
        33,
        12,
        33,
        17,
        24,
        26,
        34,
        5,
        29,
        10,
        27,
        30,
        28,
        21,
        20,
        35,
        14,
        11,
        7,
        12,
        0,
        25,
        24,
        23,
        26,
        4,
        20,
        6,
        11,
        6,
        7,
        11,
        29,
        8,
        20,
        19,
        32,
        36,
        10,
        8,
        0,
        24,
        26,
        23,
        24,
        26,
        24,
        24,
        25,
        24,
        24,
        26,
        23,
        25,
        26,
        26,
        26,
        23,
        26,
        26,
        23,
        24,
        24,
        26,
        23,
        24,
        24,
        26,
        24,
        23,
        25,
        24,
        26,
        26,
        23,
        25,
        24,
        25,
        25,
        26,
        24,
        26,
        25,
        0,
        37,
        14,
        16,
        12,
        5,
        9,
        9,
        38,
        4,
        5,
        19,
        4,
        16,
        15,
        15,
        3,
        10,
        7,
        11,
        36,
        10,
        36,
        36,
        3,
        20,
        15,
        2,
        4,
        16,
        17,
        14,
        21,
        21,
        5,
        18,
        11,
        12,
        13,
        2,
        3,
        19,
        8,
        16,
        9,
        4,
        18,
        1,
        1,
        12,
        7,
        37,
        3,
        11,
        14,
        8,
        18,
        5,
        21,
        20,
        7,
        13,
        5,
        14,
        2,
        8,
        10,
        5,
        12,
        13,
        11,
        16,
        6,
        6,
        4,
        39,
        8,
        6,
        40,
        14,
        8,
        17,
        39,
        39,
        10,
        2,
        8,
        10,
        11,
        11,
        17,
        16,
        40,
        40,
        10,
        4,
        39,
        19,
        20,
        8,
        20,
        41,
        41,
        22,
        19,
        11,
        2,
        19,
        7,
        16,
        15,
        14,
        9,
        4,
        12,
        42,
        42,
        43,
        42,
        20,
        18,
        44,
        7,
        19,
        28,
        16,
        16,
        45,
        4,
        8,
        7,
        21,
        17,
        17,
        19,
        11,
        5,
        11,
        5,
        5,
        20,
        36,
        3,
        14,
        7,
        12,
        6,
        5,
        20,
        4,
        18,
        18,
        43,
        10,
        7,
        5,
        18,
        19,
        43,
        44,
        9,
        44,
        7,
        46,
        46,
        46,
        46,
        2,
        21,
        39,
        5,
        17,
        47,
        47,
        22,
        19,
        9,
        14,
        12,
        18,
        17,
        5,
        19,
        11,
        10,
        16,
        16,
        44,
        13,
        3,
        8,
        21,
        9,
        19,
        13,
        5,
        16,
        18,
        10,
        16,
        12,
        4,
        7,
        36,
        19,
        10,
        30,
        20,
        15,
        16,
        6,
        8,
        19,
        15,
        10,
        2,
        4,
        17,
        48,
        20,
        5,
        21,
        49,
        49,
        49,
        49,
        48,
        48,
        48,
        6,
        17,
        8,
        2,
        15,
        9,
        9,
        9,
        12,
        6,
        5,
        18,
        15,
        8,
        19,
        13,
        50,
        44,
        7,
        4,
        14,
        4,
        4,
        9,
        4,
        21,
        16,
        17,
        9,
        18,
        11,
        7,
        7,
        51,
        52,
        52,
        14,
        52,
        53,
        2,
        15,
        9,
        21,
        8,
        30,
        12,
        51,
        16,
        7,
        6,
        18,
        5,
        10,
        9,
        12,
        27,
        52,
        14,
        51,
        29,
        28,
        20,
        8,
        9,
        5,
        11,
        50,
        53,
        54,
        55,
        56,
        57,
        57,
        58,
        58,
        59,
        60,
        61,
        62,
        62,
        63,
        63,
        63,
        63,
        63,
        63,
        63,
        63,
        63,
        63,
        63,
        63,
        63,
        63,
        63,
        63,
        64,
        64,
        64,
        64,
        64,
        65,
        65,
        65,
        65,
        65,
        65,
        65,
        65,
        65,
        65,
        65,
        65,
        65,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66,
        66
    ];
    level.botbb_skinbundle = [
        "",
        "",
        "proto",
        "proto",
        "proto",
        "proto",
        "proto",
        "proto",
        "proto",
        "proto",
        "proto",
        "proto",
        "proto",
        "rose",
        "",
        "proto",
        "proto",
        "proto",
        "proto",
        "proto",
        "proto",
        "proto",
        "proto",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "safety",
        "",
        "rose",
        "chickenlover",
        "luxury",
        "luxury",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "beta",
        "rose",
        "",
        "beta",
        "",
        "psyop",
        "cradle",
        "blood",
        "",
        "quad",
        "",
        "",
        "",
        "",
        "rose",
        "rose",
        "",
        "",
        "",
        "shadow",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "active",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "stealth",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "breach",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "breach",
        "",
        "",
        "",
        "breach",
        "",
        "",
        "",
        "breach",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "augment",
        "",
        "",
        "escape",
        "",
        "rose",
        "",
        "",
        "",
        "rose",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "slugger",
        "demon",
        "",
        "proto",
        "",
        "",
        "acid",
        "",
        "",
        "",
        "swamp",
        "",
        "",
        "",
        "phase",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "shadow",
        "quad",
        "",
        "",
        "tulip",
        "",
        "iris",
        "",
        "iris",
        "",
        "",
        "",
        "sunflower",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "teleport",
        "",
        "",
        "",
        "",
        "pirate",
        "carbon",
        "",
        "director",
        "fbi",
        "",
        "infected",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "infected",
        "",
        "cupid",
        "equus",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "fire",
        "",
        "",
        "robot",
        "robot",
        "subject",
        "medic",
        "",
        "",
        "director",
        "",
        "director",
        "director",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "merc",
        "",
        "",
        "",
        "rose",
        "",
        "",
        "",
        "",
        "",
        "",
        "hitman",
        "villain",
        "infected",
        "infected",
        "",
        "",
        "",
        "",
        "avalon",
        "chrome",
        "",
        "",
        "",
        "",
        "",
        "wasteland",
        "rose",
        "",
        "karma",
        "stealth",
        "",
        "",
        "",
        "",
        "rose",
        "guild",
        "jungle",
        "cryo",
        "",
        "",
        "raven",
        "",
        "cryo",
        "proto",
        "",
        "alpine",
        "",
        "raven",
        "raven",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "jungle",
        "",
        "",
        "tagger",
        "cryo",
        "raven",
        "",
        "",
        "alpine",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "liquid",
        "",
        "",
        "recon",
        "",
        "swiss",
        "swiss",
        "brie",
        "swiss",
        "",
        "",
        "anvil",
        "faberge",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "clean",
        "clean",
        "",
        "",
        "",
        "fbi",
        "",
        "",
        "",
        "director",
        "",
        "",
        "circus",
        "tarot",
        "panzer",
        "",
        "",
        "gamble",
        "",
        "",
        "brie",
        "",
        "organ",
        "",
        "",
        "",
        "brie",
        "anvil",
        "",
        "anvil",
        "",
        "",
        "",
        "",
        "",
        "outlaw",
        "",
        "raven",
        "",
        "",
        "sourdough",
        "sourdough",
        "",
        "",
        "spirit",
        "clean",
        "sandy",
        "",
        "",
        "",
        "",
        "",
        "",
        "beta",
        "",
        "anvil",
        "rose",
        "",
        "",
        "breach",
        "",
        "",
        "rose",
        "",
        "",
        "",
        "",
        "",
        "",
        "shattered",
        "",
        "director",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "spectre",
        "",
        "mind",
        "",
        "",
        "beta",
        "",
        "",
        "spectre",
        "spectre",
        "spectre",
        "",
        "",
        "",
        "",
        "",
        "spirit",
        "spirit",
        "",
        "range",
        "",
        "",
        "",
        "",
        "",
        "widow",
        "rose",
        "peanut",
        "anvil",
        "",
        "",
        "death",
        "shattered",
        "shattered",
        "",
        "",
        "",
        "peanut",
        "",
        "",
        "puppet",
        "scare",
        "",
        "splice",
        "",
        "",
        "",
        "",
        "",
        "warden",
        "",
        "",
        "",
        "plague",
        "",
        "",
        "",
        "",
        "",
        "splice",
        "",
        "puppet",
        "",
        "chestnut",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "chestnut",
        "",
        "",
        "peanut",
        "",
        "peanut",
        "warden",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
    ];
    level.botbb_opnames = [
        "sat_usa_pl_jack_base",
        "sat_usa_pl_jill_base",
        "sat_usa_pl_orange",
        "sat_usa_pl_black",
        "sat_zaf_pl_peach",
        "sat_ind_pl_azure",
        "sat_ger_pl_purple",
        "sat_rus_pl_magenta",
        "sat_usa_pl_amber",
        "sat_jpn_pl_scarlet",
        "sat_usa_pl_maroon",
        "sat_usa_pl_red",
        "sat_mex_pl_green",
        "sat_nzl_pl_rose",
        "sat_usa_pl_white",
        "sat_usa_pl_gray",
        "sat_chn_pl_gold",
        "sat_usa_pl_silver",
        "sat_usa_pl_cyan",
        "sat_ger_pl_blue",
        "sat_mex_pl_indigo",
        "sat_ind_pl_violet",
        "sat_usa_pl_voss",
        "sat_usa_pl_cdl_male_away",
        "sat_usa_pl_cdl_male_home",
        "sat_usa_pl_cdl_female_away",
        "sat_usa_pl_cdl_female_home",
        "sat_phl_pl_maya",
        "sat_rus_pl_weaver",
        "sat_gbr_pl_grey",
        "sat_usa_pl_carver",
        "sat_usa_pl_tulip",
        "sat_usa_pl_peony",
        "sat_usa_pl_iris",
        "sat_usa_pl_sunflower",
        "sat_usa_pl_breaker",
        "sat_usa_pl_director",
        "sat_usa_pl_overlord",
        "sat_usa_pl_freelance",
        "sat_usa_pl_raven",
        "sat_usa_pl_valkyrie",
        "sat_usa_pl_mozzarella",
        "sat_usa_pl_swiss",
        "sat_usa_pl_brie",
        "sat_usa_pl_anvil",
        "sat_kor_pl_hunterkiller",
        "sat_usa_pl_vector",
        "sat_usa_pl_sourdough",
        "sat_usa_pl_spectre",
        "sat_usa_pl_cipher",
        "sat_usa_pl_peanut",
        "sat_usa_pl_prism",
        "sat_sgp_pl_blackjack",
        "sat_usa_pl_warden",
        "ghost_western",
        "nicki_eastern",
        "dune_eastern",
        "jup_mp_beta",
        "snoop_western",
        "homelander_eastern",
        "jup_mp_spring",
        "jup_mp_summer",
        "gus_western",
        "jup_mp_hotel",
        "jup_mp_void",
        "jup_mp_bravo",
        "jup_mp_mike"
    ];
    level.botbb_skinnames = [
        "sat_usa_pl_jack_base_skin",
        "sat_usa_pl_jill_base_skin",
        "sat_usa_pl_orange_proto_skin",
        "sat_usa_pl_black_proto_skin",
        "sat_zaf_pl_peach_proto_skin",
        "sat_ind_pl_azure_proto_skin",
        "sat_ger_pl_purple_proto_skin",
        "sat_rus_pl_magenta_proto_skin",
        "sat_usa_pl_amber_proto_skin",
        "sat_jpn_pl_scarlet_proto_skin",
        "sat_usa_pl_maroon_proto_skin",
        "sat_usa_pl_red_proto_skin",
        "sat_mex_pl_green_proto_skin",
        "sat_nzl_pl_rose_proto_skin",
        "sat_usa_pl_orange_dronecharmer_skin",
        "sat_usa_pl_white_proto_skin",
        "sat_usa_pl_gray_proto_skin",
        "sat_chn_pl_gold_proto_skin",
        "sat_usa_pl_silver_proto_skin",
        "sat_usa_pl_cyan_proto_skin",
        "sat_ger_pl_blue_proto_skin",
        "sat_mex_pl_indigo_proto_skin",
        "sat_ind_pl_violet_proto_skin",
        "sat_rus_pl_magenta_snow_skin",
        "sat_jpn_pl_scarlet_samurai_skin",
        "sat_jpn_pl_scarlet_samurai_red_skin",
        "sat_mex_pl_green_trap_skin",
        "sat_rus_pl_magenta_space_skin",
        "sat_ger_pl_purple_laboratory_skin",
        "sat_chn_pl_gold_milsim_skin",
        "sat_chn_pl_gold_tactical_skin",
        "sat_usa_pl_orange_air_skin",
        "sat_mex_pl_green_sweater_skin",
        "sat_usa_pl_red_safety_skin",
        "sat_ind_pl_azure_killer_skin",
        "sat_nzl_pl_rose_hive_skin",
        "sat_usa_pl_amber_chickenlover_skin",
        "sat_chn_pl_gold_luxury_skin",
        "sat_mex_pl_indigo_luxury_skin",
        "sat_usa_pl_maroon_uchi_skin",
        "sat_ind_pl_azure_fantasy_skin",
        "sat_ger_pl_blue_invent_skin",
        "sat_usa_pl_red_sweater_skin",
        "sat_chn_pl_gold_agile_skin",
        "sat_ger_pl_purple_drained_skin",
        "sat_usa_pl_amber_drained_skin",
        "sat_jpn_pl_scarlet_drained_skin",
        "sat_rus_pl_magenta_drained_skin",
        "sat_usa_pl_red_beta_skin",
        "sat_nzl_pl_rose_code_skin",
        "sat_mex_pl_indigo_monster_skin",
        "sat_mex_pl_green_beta_skin",
        "sat_zaf_pl_peach_mud_skin",
        "sat_usa_pl_red_psyop_skin",
        "sat_ind_pl_azure_cradle_skin",
        "sat_chn_pl_gold_blood_skin",
        "sat_usa_pl_amber_turned_skin",
        "sat_usa_pl_amber_quad_skin",
        "sat_ger_pl_blue_obsidian_skin",
        "sat_usa_pl_cyan_combat_skin",
        "sat_usa_pl_amber_cook_skin",
        "sat_usa_pl_cyan_trained_skin",
        "sat_nzl_pl_rose_covert_skin",
        "sat_nzl_pl_rose_gym_skin",
        "sat_usa_pl_red_halo_skin",
        "sat_ger_pl_purple_chemicals_skin",
        "sat_zaf_pl_peach_eagle_skin",
        "sat_usa_pl_maroon_shadow_skin",
        "sat_usa_pl_orange_countermeasure_skin",
        "sat_ind_pl_violet_ski_skin",
        "sat_ind_pl_violet_web_skin",
        "sat_chn_pl_gold_hooded_skin",
        "sat_ind_pl_azure_biohazard_skin",
        "sat_usa_pl_red_collide_skin",
        "sat_ger_pl_blue_caesars_skin",
        "sat_zaf_pl_peach_polar_skin",
        "sat_ger_pl_blue_active_skin",
        "sat_usa_pl_voss_base_skin",
        "sat_usa_pl_voss_cape_skin",
        "sat_usa_pl_cdl_male_away_base_skin",
        "sat_usa_pl_cdl_male_home_base_skin",
        "sat_usa_pl_cdl_female_away_base_skin",
        "sat_usa_pl_cdl_female_home_base_skin",
        "sat_ind_pl_violet_techcult_skin",
        "sat_zaf_pl_peach_stealth_skin",
        "sat_usa_pl_cdl_female_away_optic_skin",
        "sat_usa_pl_cdl_female_away_rokkr_skin",
        "sat_usa_pl_cdl_male_away_surge_skin",
        "sat_usa_pl_cdl_female_home_thieves_skin",
        "sat_usa_pl_cdl_male_home_koi_skin",
        "sat_usa_pl_cdl_male_away_ravens_skin",
        "sat_usa_pl_cdl_female_away_koi_skin",
        "sat_usa_pl_cdl_female_home_breach_skin",
        "sat_usa_pl_cdl_male_home_falcons_skin",
        "sat_usa_pl_cdl_male_home_faze_skin",
        "sat_usa_pl_cdl_female_home_optic_skin",
        "sat_usa_pl_cdl_female_home_koi_skin",
        "sat_usa_pl_cdl_female_away_falcons_skin",
        "sat_usa_pl_cdl_female_away_faze_skin",
        "sat_usa_pl_cdl_male_home_ravens_skin",
        "sat_usa_pl_cdl_female_away_m8s_skin",
        "sat_usa_pl_cdl_male_home_m8s_skin",
        "sat_usa_pl_cdl_female_away_breach_skin",
        "sat_usa_pl_cdl_female_away_ravens_skin",
        "sat_usa_pl_cdl_male_away_m8s_skin",
        "sat_usa_pl_cdl_male_home_heretics_skin",
        "sat_usa_pl_cdl_male_away_breach_skin",
        "sat_usa_pl_cdl_female_home_ravens_skin",
        "sat_usa_pl_cdl_female_home_heretics_skin",
        "sat_usa_pl_cdl_female_away_thieves_skin",
        "sat_usa_pl_cdl_male_home_breach_skin",
        "sat_usa_pl_cdl_male_away_optic_skin",
        "sat_usa_pl_cdl_female_away_heretics_skin",
        "sat_usa_pl_cdl_male_away_falcons_skin",
        "sat_usa_pl_cdl_female_away_cloud9_skin",
        "sat_usa_pl_cdl_female_home_faze_skin",
        "sat_usa_pl_cdl_male_home_thieves_skin",
        "sat_usa_pl_cdl_male_away_cloud9_skin",
        "sat_usa_pl_cdl_female_home_rokkr_skin",
        "sat_usa_pl_cdl_female_home_surge_skin",
        "sat_usa_pl_cdl_female_home_m8s_skin",
        "sat_usa_pl_cdl_male_home_surge_skin",
        "sat_usa_pl_cdl_male_away_rokkr_skin",
        "sat_usa_pl_cdl_female_home_cloud9_skin",
        "sat_usa_pl_cdl_female_away_surge_skin",
        "sat_usa_pl_cdl_male_away_koi_skin",
        "sat_usa_pl_cdl_female_home_falcons_skin",
        "sat_usa_pl_cdl_male_away_heretics_skin",
        "sat_usa_pl_cdl_male_home_rokkr_skin",
        "sat_usa_pl_cdl_male_away_faze_skin",
        "sat_usa_pl_cdl_male_away_thieves_skin",
        "sat_usa_pl_cdl_male_home_cloud9_skin",
        "sat_usa_pl_cdl_male_home_optic_skin",
        "sat_usa_pl_orange_emea_skin",
        "sat_usa_pl_cyan_augment_skin",
        "sat_jpn_pl_scarlet_road_skin",
        "sat_mex_pl_indigo_monster_alt_skin",
        "sat_mex_pl_green_escape_skin",
        "sat_mex_pl_indigo_digital_skin",
        "sat_nzl_pl_rose_arctic_skin",
        "sat_ind_pl_violet_wc_skin",
        "sat_usa_pl_cyan_wc_skin",
        "sat_usa_pl_red_wc_skin",
        "sat_nzl_pl_rose_wc_skin",
        "sat_ger_pl_blue_wc_skin",
        "sat_ind_pl_azure_wc_skin",
        "sat_usa_pl_maroon_wc_skin",
        "sat_usa_pl_orange_wc_skin",
        "sat_mex_pl_green_wc_skin",
        "sat_mex_pl_indigo_wc_skin",
        "sat_zaf_pl_peach_wc_skin",
        "sat_chn_pl_gold_wc_skin",
        "sat_usa_pl_black_sp_skin",
        "sat_usa_pl_gray_slugger_skin",
        "sat_mex_pl_indigo_demon_lava_skin",
        "sat_mex_pl_green_corrupted_skin",
        "sat_usa_pl_silver_proto_neo_skin",
        "sat_ind_pl_violet_techcult_bc_skin",
        "sat_ind_pl_azure_rhino_skin",
        "sat_usa_pl_silver_acid_skin",
        "sat_usa_pl_maroon_abstract_skin",
        "sat_jpn_pl_scarlet_fold_skin",
        "sat_ind_pl_violet_puzzle_skin",
        "sat_mex_pl_indigo_swamp_skin",
        "sat_usa_pl_red_tv_skin",
        "sat_phl_pl_maya_drained_skin",
        "sat_rus_pl_weaver_drained_skin",
        "sat_mex_pl_green_phase_skin",
        "sat_gbr_pl_grey_drained_skin",
        "sat_usa_pl_carver_drained_skin",
        "sat_chn_pl_gold_force_skin",
        "sat_phl_pl_maya_rogue_skin",
        "sat_usa_pl_carver_infiltration_skin",
        "sat_rus_pl_weaver_rogue_skin",
        "sat_gbr_pl_grey_sable_skin",
        "sat_phl_pl_maya_quest_skin",
        "sat_usa_pl_voss_cape_bc_skin",
        "sat_usa_pl_voss_base_bc_skin",
        "sat_usa_pl_maroon_shadow_bc_skin",
        "sat_usa_pl_amber_quad_bc_skin",
        "sat_usa_pl_orange_countermeasure_bc_skin",
        "sat_ger_pl_purple_chemicals_bc_skin",
        "sat_usa_pl_tulip_base_skin",
        "sat_usa_pl_peony_base_skin",
        "sat_usa_pl_iris_base_skin",
        "sat_mex_pl_green_lofi_skin",
        "sat_usa_pl_iris_white_skin",
        "sat_usa_pl_silver_factory_skin",
        "sat_usa_pl_cdl_male_home_wz_ranked_base_skin",
        "sat_usa_pl_cdl_female_home_wz_ranked_base_skin",
        "sat_usa_pl_sunflower_base_skin",
        "sat_ind_pl_azure_sneak_skin",
        "sat_gbr_pl_grey_janus_skin",
        "sat_usa_pl_maroon_redacted_skin",
        "sat_phl_pl_maya_terminus_skin",
        "sat_usa_pl_carver_mansion_skin",
        "sat_rus_pl_weaver_bloodstone_skin",
        "sat_ind_pl_violet_bloom_skin",
        "sat_mex_pl_indigo_slate_skin",
        "sat_usa_pl_breaker_base_skin",
        "sat_usa_pl_white_space_skin",
        "sat_usa_pl_red_damage_skin",
        "sat_rus_pl_magenta_handler_skin",
        "sat_mex_pl_green_club_skin",
        "sat_usa_pl_jack_base_specialforces_skin",
        "sat_usa_pl_cdl_female_away_mp_ranked_base_skin",
        "sat_usa_pl_cdl_male_home_mp_ranked_base_skin",
        "sat_usa_pl_cdl_male_away_mp_ranked_base_skin",
        "sat_usa_pl_cdl_female_home_mp_ranked_base_skin",
        "sat_zaf_pl_peach_stargazer_skin",
        "sat_mex_pl_indigo_heist_skin",
        "sat_ger_pl_purple_fancy_skin",
        "sat_usa_pl_red_urban_skin",
        "sat_ger_pl_purple_teleport_skin",
        "sat_rus_pl_magenta_knight_skin",
        "sat_usa_pl_red_bloom_skin",
        "sat_gbr_pl_grey_quest_skin",
        "sat_usa_pl_amber_celtic_skin",
        "sat_mex_pl_indigo_pirate_skin",
        "sat_ger_pl_blue_carbon_skin",
        "sat_usa_pl_peony_variant_skin",
        "sat_usa_pl_director_base_skin",
        "sat_usa_pl_maroon_fbi_skin",
        "sat_usa_pl_amber_magic_skin",
        "sat_usa_pl_jack_base_infected_skin",
        "sat_usa_pl_cdl_male_home_wz_ranked_1_skin",
        "sat_usa_pl_cdl_female_home_mp_ranked_iridescent_skin",
        "sat_usa_pl_cdl_male_away_mp_ranked_crimson_skin",
        "sat_usa_pl_cdl_male_home_mp_ranked_1_skin",
        "sat_usa_pl_cdl_female_home_mp_ranked_diamond_skin",
        "sat_usa_pl_cdl_male_home_mp_ranked_crimson_skin",
        "sat_usa_pl_cdl_male_home_mp_ranked_platinum_skin",
        "sat_usa_pl_cdl_female_away_mp_ranked_1_skin",
        "sat_usa_pl_cdl_male_home_mp_ranked_diamond_skin",
        "sat_usa_pl_cdl_male_home_wz_ranked_250_skin",
        "sat_usa_pl_cdl_female_home_wz_ranked_iridescent_skin",
        "sat_usa_pl_cdl_male_away_mp_ranked_platinum_skin",
        "sat_usa_pl_cdl_female_away_mp_ranked_gold_skin",
        "sat_usa_pl_cdl_female_home_mp_ranked_platinum_skin",
        "sat_usa_pl_cdl_female_home_wz_ranked_diamond_skin",
        "sat_usa_pl_cdl_female_home_mp_ranked_250_skin",
        "sat_usa_pl_cdl_male_away_mp_ranked_1_skin",
        "sat_usa_pl_cdl_female_home_wz_ranked_1_skin",
        "sat_usa_pl_cdl_female_home_wz_ranked_crimson_skin",
        "sat_usa_pl_cdl_male_away_mp_ranked_gold_skin",
        "sat_usa_pl_cdl_male_home_wz_ranked_crimson_skin",
        "sat_usa_pl_cdl_male_home_wz_ranked_iridescent_skin",
        "sat_usa_pl_cdl_female_home_mp_ranked_gold_skin",
        "sat_usa_pl_cdl_male_away_mp_ranked_iridescent_skin",
        "sat_usa_pl_cdl_male_home_wz_ranked_gold_skin",
        "sat_usa_pl_cdl_male_home_wz_ranked_platinum_skin",
        "sat_usa_pl_cdl_female_home_wz_ranked_platinum_skin",
        "sat_usa_pl_cdl_male_home_mp_ranked_gold_skin",
        "sat_usa_pl_cdl_male_away_mp_ranked_diamond_skin",
        "sat_usa_pl_cdl_female_away_mp_ranked_iridescent_skin",
        "sat_usa_pl_cdl_male_home_wz_ranked_diamond_skin",
        "sat_usa_pl_cdl_female_home_wz_ranked_250_skin",
        "sat_usa_pl_cdl_female_home_wz_ranked_gold_skin",
        "sat_usa_pl_cdl_male_away_mp_ranked_250_skin",
        "sat_usa_pl_cdl_female_away_mp_ranked_250_skin",
        "sat_usa_pl_cdl_male_home_mp_ranked_iridescent_skin",
        "sat_usa_pl_cdl_female_away_mp_ranked_platinum_skin",
        "sat_usa_pl_cdl_female_away_mp_ranked_diamond_skin",
        "sat_usa_pl_cdl_female_home_mp_ranked_1_skin",
        "sat_usa_pl_cdl_male_home_mp_ranked_250_skin",
        "sat_usa_pl_cdl_female_home_mp_ranked_crimson_skin",
        "sat_usa_pl_cdl_female_away_mp_ranked_crimson_skin",
        "sat_usa_pl_jack_base_infected_gardenia_skin",
        "sat_usa_pl_overlord_base_skin",
        "sat_usa_pl_white_cupid_skin",
        "sat_chn_pl_gold_equus_skin",
        "sat_mex_pl_green_cold_skin",
        "sat_ind_pl_azure_surgeon_bp_skin",
        "sat_jpn_pl_scarlet_breacher_skin",
        "sat_jpn_pl_scarlet_battle_skin",
        "sat_usa_pl_freelance_tie_skin",
        "sat_zaf_pl_peach_xo_skin",
        "sat_ind_pl_azure_surgeon_bc_skin",
        "sat_ger_pl_blue_fire_skin",
        "sat_zaf_pl_peach_xo_bc_skin",
        "sat_chn_pl_gold_hunt_skin",
        "sat_usa_pl_gray_robot_bc_skin",
        "sat_usa_pl_gray_robot_bp_skin",
        "sat_usa_pl_black_subject_bp_skin",
        "sat_usa_pl_maroon_medic_bp_skin",
        "sat_rus_pl_magenta_handler_bc_skin",
        "sat_usa_pl_red_urban_bc_skin",
        "sat_usa_pl_director_base_bc_skin",
        "sat_usa_pl_maroon_army_skin",
        "sat_usa_pl_director_vector_skin",
        "sat_usa_pl_director_vector_bc_skin",
        "sat_usa_pl_black_bot_skin",
        "sat_mex_pl_indigo_moss_skin",
        "sat_usa_pl_gray_rgb_skin",
        "sat_usa_pl_orange_nm_skin",
        "sat_zaf_pl_peach_nm_skin",
        "sat_chn_pl_gold_nm_skin",
        "sat_usa_pl_silver_protect_skin",
        "sat_usa_pl_white_nm_skin",
        "sat_ind_pl_violet_assassin_skin",
        "sat_ind_pl_violet_soldier_skin",
        "sat_ind_pl_azure_merc_skin",
        "sat_usa_pl_cyan_deadeye_skin",
        "sat_usa_pl_red_blackout_skin",
        "sat_mex_pl_green_blackout_skin",
        "sat_nzl_pl_rose_toa_skin",
        "sat_usa_pl_orange_paint_skin",
        "sat_usa_pl_black_virus_skin",
        "sat_ger_pl_blue_vein_skin",
        "sat_usa_pl_amber_challenge_skin",
        "sat_chn_pl_gold_droid_skin",
        "sat_jpn_pl_scarlet_shepard_skin",
        "sat_zaf_pl_peach_hitman_skin",
        "sat_usa_pl_cyan_villain_skin",
        "sat_usa_pl_jill_base_infected_skin",
        "sat_usa_pl_jill_base_infected_gardenia_skin",
        "sat_mex_pl_green_spy_skin",
        "sat_rus_pl_magenta_evil_skin",
        "sat_usa_pl_overlord_base_alt_skin",
        "sat_usa_pl_black_seal_skin",
        "sat_usa_pl_red_avalon_skin",
        "sat_usa_pl_white_chrome_skin",
        "sat_usa_pl_amber_monkeybomb_skin",
        "sat_usa_pl_cyan_flank_skin",
        "sat_ind_pl_azure_mono_skin",
        "sat_ind_pl_violet_engage_skin",
        "sat_mex_pl_indigo_tundranaut_skin",
        "sat_rus_pl_magenta_wasteland_skin",
        "sat_nzl_pl_rose_mono_skin",
        "sat_ind_pl_azure_shieldsoldier_skin",
        "sat_usa_pl_white_karma_skin",
        "sat_usa_pl_orange_stealth_skin",
        "sat_usa_pl_amber_bio_skin",
        "sat_usa_pl_maroon_sea_skin",
        "sat_ind_pl_azure_jsoc_skin",
        "sat_mex_pl_green_jsoc_skin",
        "sat_nzl_pl_rose_guild_skin",
        "sat_usa_pl_red_guild_skin",
        "sat_chn_pl_gold_jungle_skin",
        "sat_ger_pl_purple_cryo_skin",
        "sat_ger_pl_purple_hundred_skin",
        "sat_zaf_pl_peach_roman_skin",
        "sat_usa_pl_raven_base_skin",
        "sat_usa_pl_amber_ultimis_skin",
        "sat_ger_pl_purple_cryo_bc_skin",
        "sat_usa_pl_valkyrie_proto_skin",
        "sat_usa_pl_white_legacy_bc_skin",
        "sat_usa_pl_amber_alpine_bc_skin",
        "sat_usa_pl_silver_harsh_bc_skin",
        "sat_usa_pl_raven_base_bc_skin",
        "sat_usa_pl_raven_altitude_bc_skin",
        "sat_usa_pl_maroon_bruiser_skin",
        "sat_usa_pl_orange_sub_skin",
        "sat_usa_pl_amber_slacker_skin",
        "sat_usa_pl_maroon_igl_skin",
        "sat_usa_pl_red_mam_alt_skin",
        "sat_usa_pl_red_mam_skin",
        "sat_usa_pl_silver_harsh_skin",
        "sat_chn_pl_gold_jungle_bc_skin",
        "sat_usa_pl_valkyrie_tear_skin",
        "sat_usa_pl_valkyrie_skull_skin",
        "sat_usa_pl_maroon_tagger_skin",
        "sat_zaf_pl_peach_cryo_skin",
        "sat_usa_pl_raven_altitude_skin",
        "sat_ger_pl_blue_flame_skin",
        "sat_mex_pl_indigo_ninja_skin",
        "sat_usa_pl_amber_alpine_bp_skin",
        "sat_mex_pl_indigo_grunt_skin",
        "sat_usa_pl_mozzarella_base_skin",
        "sat_usa_pl_mozzarella_burrata_skin",
        "sat_usa_pl_voss_secret_skin",
        "sat_ger_pl_blue_techcamo_skin",
        "sat_usa_pl_red_nm_glitch_skin",
        "sat_usa_pl_orange_nm_glitch_skin",
        "sat_ger_pl_blue_nm_glitch_skin",
        "sat_rus_pl_magenta_henchman_skin",
        "sat_chn_pl_gold_redline_skin",
        "sat_usa_pl_gray_liquid_skin",
        "sat_usa_pl_white_thug_skin",
        "sat_jpn_pl_scarlet_sight_skin",
        "sat_zaf_pl_peach_recon_skin",
        "sat_mex_pl_green_captain_skin",
        "sat_usa_pl_swiss_base_skin",
        "sat_usa_pl_swiss_damaged_skin",
        "sat_usa_pl_brie_base_skin",
        "sat_usa_pl_swiss_iri_skin",
        "sat_mex_pl_indigo_pyro_skin",
        "sat_usa_pl_cyan_poseidon_skin",
        "sat_usa_pl_anvil_base_skin",
        "sat_rus_pl_magenta_faberge_skin",
        "sat_ger_pl_blue_neon_skin",
        "sat_rus_pl_weaver_quest_skin",
        "sat_chn_pl_gold_cute_skin",
        "sat_chn_pl_gold_west_skin",
        "sat_kor_pl_hunterkiller_base_skin",
        "sat_zaf_pl_peach_nm_glitch_skin",
        "sat_usa_pl_amber_washington_skin",
        "sat_rus_pl_magenta_raider_skin",
        "sat_ind_pl_violet_raptor_skin",
        "sat_usa_pl_silver_protect_clean_skin",
        "sat_usa_pl_silver_protect_brown_clean_skin",
        "sat_ger_pl_blue_tread_skin",
        "sat_usa_pl_red_sixpack_skin",
        "sat_ind_pl_azure_tattoo_skin",
        "sat_usa_pl_red_fbi_skin",
        "sat_ind_pl_azure_brass_skin",
        "sat_ind_pl_azure_sand_skin",
        "sat_mex_pl_indigo_jersey_skin",
        "sat_usa_pl_director_slice_skin",
        "sat_usa_pl_black_dad_skin",
        "sat_usa_pl_white_chaos_skin",
        "sat_rus_pl_magenta_circus_skin",
        "sat_mex_pl_green_tarot_skin",
        "sat_ger_pl_purple_panzer_skin",
        "sat_ind_pl_azure_thug_skin",
        "sat_mex_pl_indigo_nm_glitch_skin",
        "sat_zaf_pl_peach_gamble_skin",
        "sat_usa_pl_cyan_slash_skin",
        "sat_usa_pl_cyan_color_skin",
        "sat_usa_pl_brie_brioche_skin",
        "sat_usa_pl_maroon_mask_skin",
        "sat_rus_pl_magenta_organ_skin",
        "sat_ind_pl_azure_tattoo_bc_skin",
        "sat_usa_pl_cyan_slash_bc_skin",
        "sat_ger_pl_blue_tread_bc_skin",
        "sat_usa_pl_brie_honey_skin",
        "sat_usa_pl_anvil_hammer_bc_skin",
        "sat_jpn_pl_scarlet_sight_bc_skin",
        "sat_usa_pl_anvil_hammer_skin",
        "sat_rus_pl_magenta_henchman_bc_skin",
        "sat_usa_pl_vector_base_skin",
        "sat_usa_pl_vector_alpha_skin",
        "sat_usa_pl_vector_redacted_skin",
        "sat_usa_pl_vector_omega_skin",
        "sat_usa_pl_orange_outlaw_skin",
        "sat_ind_pl_violet_nm_glitch_skin",
        "sat_usa_pl_raven_action_skin",
        "sat_ind_pl_azure_grenadier_skin",
        "sat_usa_pl_silver_glitch_skin",
        "sat_usa_pl_sourdough_base_skin",
        "sat_usa_pl_sourdough_hero_skin",
        "sat_usa_pl_voss_bankrobber_skin",
        "sat_ger_pl_blue_bankrobber_skin",
        "sat_jpn_pl_scarlet_spirit_skin",
        "sat_usa_pl_white_clean_skin",
        "sat_mex_pl_green_sandy_skin",
        "sat_usa_pl_cyan_lmao_skin",
        "sat_usa_pl_silver_upgrade_skin",
        "sat_ind_pl_azure_marrow_skin",
        "sat_ger_pl_blue_kaiju_skin",
        "sat_usa_pl_red_modern_skin",
        "sat_usa_pl_maroon_wrath_skin",
        "sat_chn_pl_gold_west_beta_skin",
        "sat_chn_pl_gold_west_alpha_skin",
        "sat_usa_pl_anvil_base_bc_skin",
        "sat_nzl_pl_rose_nycto_skin",
        "sat_usa_pl_black_support_skin",
        "sat_usa_pl_amber_tropical_skin",
        "sat_ind_pl_violet_breach_skin",
        "sat_jpn_pl_scarlet_street_skin",
        "sat_ger_pl_blue_cq_skin",
        "sat_nzl_pl_rose_nm_glitch_skin",
        "sat_ind_pl_azure_nm_glitch_skin",
        "sat_chn_pl_gold_wall_skin",
        "sat_usa_pl_cyan_nm_glitch_skin",
        "sat_usa_pl_maroon_nm_glitch_skin",
        "sat_chn_pl_gold_nm_glitch_skin",
        "sat_mex_pl_green_nm_glitch_skin",
        "sat_zaf_pl_peach_shattered_skin",
        "sat_rus_pl_magenta_soda_skin",
        "sat_usa_pl_director_witch_skin",
        "sat_ger_pl_blue_ruin_skin",
        "sat_usa_pl_maroon_rage_skin",
        "sat_usa_pl_carver_quest_skin",
        "sat_mex_pl_indigo_patrol_skin",
        "sat_usa_pl_gray_tank_skin",
        "sat_chn_pl_gold_mechanic_skin",
        "sat_ger_pl_purple_fused_skin",
        "sat_usa_pl_amber_metal_skin",
        "sat_ger_pl_blue_advanced_skin",
        "sat_usa_pl_gray_arcade_skin",
        "sat_usa_pl_maroon_welded_skin",
        "sat_usa_pl_orange_bubblegum_skin",
        "sat_zaf_pl_peach_crush_skin",
        "sat_usa_pl_silver_machine_skin",
        "sat_usa_pl_spectre_base_skin",
        "sat_mex_pl_indigo_jersey_alt_skin",
        "sat_ind_pl_azure_mind_skin",
        "sat_ind_pl_violet_ambush_skin",
        "sat_usa_pl_cipher_gamma_skin",
        "sat_usa_pl_cipher_beta_skin",
        "sat_usa_pl_cipher_alpha_skin",
        "sat_usa_pl_cipher_base_skin",
        "sat_usa_pl_spectre_base_bc_skin",
        "sat_usa_pl_spectre_elite_skin",
        "sat_usa_pl_spectre_elite_bc_skin",
        "sat_ger_pl_purple_fused_bc_skin",
        "sat_usa_pl_silver_machine_bc_skin",
        "sat_usa_pl_amber_metal_bc_skin",
        "sat_usa_pl_orange_bubblegum_bc_skin",
        "sat_usa_pl_gray_tank_bc_skin",
        "sat_jpn_pl_scarlet_spirit_skin_human_mask",
        "sat_jpn_pl_scarlet_spirit_skin_demon_mask",
        "sat_jpn_pl_scarlet_horror_skin",
        "sat_mex_pl_green_range_skin",
        "sat_ger_pl_purple_barber_skin",
        "sat_ind_pl_azure_secure_skin",
        "sat_usa_pl_cyan_island_skin",
        "sat_usa_pl_gray_pepper_skin",
        "sat_usa_pl_amber_king_skin",
        "sat_ger_pl_blue_widow_skin",
        "sat_nzl_pl_rose_ground_skin",
        "sat_usa_pl_peanut_base_skin",
        "sat_usa_pl_anvil_horseman_skin",
        "sat_rus_pl_magenta_wolf_skin",
        "sat_zaf_pl_peach_wild_skin",
        "sat_usa_pl_white_death_skin",
        "sat_zaf_pl_peach_shattered_helmet_skin",
        "sat_zaf_pl_peach_shattered_no_helmet_skin",
        "sat_jpn_pl_scarlet_disciple_skin",
        "sat_zaf_pl_peach_zm_skin",
        "sat_ind_pl_violet_zm_skin",
        "sat_chn_pl_gold_peanut_skin",
        "sat_usa_pl_silver_pumpkin_skin",
        "sat_jpn_pl_scarlet_war_skin",
        "sat_usa_pl_cyan_puppet_skin",
        "sat_usa_pl_red_scare_skin",
        "sat_rus_pl_magenta_super_skin",
        "sat_rus_pl_magenta_splice_bc_skin",
        "sat_usa_pl_prism_alpha_skin",
        "sat_sgp_pl_blackjack_base_skin",
        "sat_sgp_pl_blackjack_base_bc_skin",
        "sat_usa_pl_white_arachnid_bc_skin",
        "sat_sgp_pl_blackjack_ultra_bc_skin",
        "sat_usa_pl_warden_base_skin",
        "sat_usa_pl_orange_break_skin",
        "sat_usa_pl_gray_skin_skin",
        "sat_jpn_pl_scarlet_butcher_bc_skin",
        "sat_ind_pl_violet_plague_skin",
        "sat_usa_pl_amber_jester_skin",
        "sat_usa_pl_carver_super_skin",
        "sat_mex_pl_green_smirk_skin",
        "sat_usa_pl_prism_gamma_skin",
        "sat_chn_pl_gold_halloween_skin",
        "sat_rus_pl_magenta_splice_skin",
        "sat_ger_pl_purple_super_skin",
        "sat_usa_pl_cyan_puppet_bc_skin",
        "sat_ind_pl_azure_doctor_skin",
        "sat_usa_pl_maroon_chestnut_skin",
        "sat_jpn_pl_scarlet_butcher_skin",
        "sat_mex_pl_green_smirk_bc_skin",
        "sat_phl_pl_maya_super_skin",
        "sat_sgp_pl_blackjack_ultra_skin",
        "sat_usa_pl_white_arachnid_skin",
        "sat_usa_pl_prism_base_skin",
        "sat_gbr_pl_grey_super_skin",
        "sat_rus_pl_weaver_super_skin",
        "sat_mex_pl_indigo_chestnut_skin",
        "sat_usa_pl_amber_super_skin",
        "sat_jpn_pl_scarlet_super_skin",
        "sat_ind_pl_azure_peanut_skin",
        "sat_usa_pl_red_glitch_skin",
        "sat_usa_pl_peanut_shell_skin",
        "sat_usa_pl_warden_western_skin",
        "ghost_western_a",
        "nicki_eastern_a",
        "dune_eastern_a",
        "jup_mp_beta_skin",
        "jup_mp_beta_10_skin",
        "snoop_western_a",
        "snoop_western_alt",
        "homelander_eastern_a",
        "jup_mp_spring_skin",
        "jup_mp_summer_skin",
        "gus_kitty_western",
        "gus_kitty_western_alt",
        "jup_mp_hotel_skin",
        "jup_mp_hotel_10_skin",
        "jup_mp_hotel_11_skin",
        "jup_mp_hotel_12_skin",
        "jup_mp_hotel_13_skin",
        "jup_mp_hotel_14_skin",
        "jup_mp_hotel_15a_skin",
        "jup_mp_hotel_15b_skin",
        "jup_mp_hotel_17_skin",
        "jup_mp_hotel_18_skin",
        "jup_mp_hotel_19_skin",
        "jup_mp_hotel_20_skin",
        "jup_mp_hotel_21_skin",
        "jup_mp_hotel_22_skin",
        "jup_mp_hotel_23_skin",
        "jup_mp_hotel_26_skin",
        "jup_mp_void_skin",
        "jup_mp_void_10_skin",
        "jup_mp_void_11_skin",
        "jup_mp_void_13_skin",
        "jup_mp_void_14_skin",
        "jup_mp_bravo_skin",
        "jup_mp_bravo_10_skin",
        "jup_mp_bravo_11_skin",
        "jup_mp_bravo_12_skin",
        "jup_mp_bravo_13_skin",
        "jup_mp_bravo_14_skin",
        "jup_mp_bravo_15_skin",
        "jup_mp_bravo_17_skin",
        "jup_mp_bravo_18_skin",
        "jup_mp_bravo_19_skin",
        "jup_mp_bravo_20_skin",
        "jup_mp_bravo_21_skin",
        "jup_mp_bravo_22_skin",
        "jup_mp_mike_skin",
        "jup_mp_mike_10_skin",
        "jup_mp_mike_11_skin",
        "jup_mp_mike_12_skin",
        "jup_mp_mike_13_skin",
        "jup_mp_mike_14_skin",
        "jup_mp_mike_15_skin",
        "jup_mp_mike_16_skin",
        "jup_mp_mike_17_skin",
        "jup_mp_mike_18_skin",
        "jup_mp_mike_19_skin",
        "jup_mp_mike_21_skin",
        "jup_mp_mike_22_skin",
        "jup_mp_mike_23_skin",
        "jup_mp_mike_24_skin",
        "jup_mp_mike_25_skin",
        "jup_mp_mike_26_skin",
        "jup_mp_mike_27_skin",
        "jup_mp_mike_28_skin",
        "jup_mp_mike_28b_skin",
        "jup_mp_mike_29_skin",
        "jup_mp_mike_30_skin",
        "jup_mp_mike_31_skin"
    ];
    level.botbb_skintier = [
        0,
        0,
        3,
        3,
        3,
        3,
        3,
        3,
        3,
        3,
        3,
        3,
        3,
        3,
        2,
        3,
        3,
        3,
        3,
        3,
        3,
        3,
        3,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        3,
        2,
        3,
        3,
        3,
        3,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        0,
        3,
        2,
        0,
        2,
        3,
        3,
        3,
        2,
        3,
        2,
        2,
        2,
        2,
        3,
        3,
        2,
        2,
        2,
        3,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        3,
        0,
        2,
        0,
        0,
        0,
        0,
        2,
        3,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        3,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        3,
        1,
        1,
        1,
        3,
        1,
        1,
        1,
        3,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        2,
        3,
        2,
        2,
        3,
        2,
        3,
        2,
        2,
        2,
        3,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        3,
        3,
        2,
        3,
        2,
        2,
        3,
        2,
        2,
        2,
        3,
        2,
        2,
        2,
        3,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        3,
        3,
        2,
        2,
        0,
        0,
        0,
        2,
        3,
        2,
        0,
        0,
        0,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        0,
        2,
        2,
        2,
        2,
        2,
        0,
        0,
        0,
        0,
        2,
        2,
        2,
        2,
        3,
        2,
        2,
        2,
        2,
        3,
        3,
        2,
        0,
        3,
        2,
        3,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        3,
        0,
        3,
        3,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        3,
        2,
        2,
        3,
        3,
        3,
        3,
        2,
        2,
        3,
        2,
        3,
        3,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        3,
        2,
        2,
        2,
        3,
        2,
        2,
        2,
        2,
        2,
        2,
        3,
        3,
        3,
        3,
        2,
        2,
        2,
        2,
        3,
        3,
        2,
        2,
        2,
        2,
        2,
        3,
        3,
        2,
        3,
        3,
        2,
        2,
        2,
        2,
        3,
        3,
        3,
        3,
        2,
        2,
        0,
        2,
        3,
        3,
        2,
        3,
        2,
        3,
        3,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        3,
        2,
        2,
        3,
        3,
        3,
        2,
        2,
        3,
        2,
        0,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        3,
        2,
        2,
        3,
        2,
        0,
        3,
        0,
        3,
        2,
        2,
        0,
        3,
        2,
        2,
        2,
        2,
        0,
        2,
        2,
        2,
        2,
        3,
        3,
        2,
        2,
        2,
        3,
        2,
        2,
        2,
        3,
        2,
        2,
        3,
        3,
        3,
        2,
        2,
        3,
        2,
        2,
        3,
        2,
        3,
        2,
        2,
        2,
        3,
        3,
        2,
        3,
        2,
        0,
        0,
        2,
        2,
        3,
        2,
        3,
        2,
        2,
        0,
        3,
        2,
        2,
        3,
        3,
        3,
        2,
        2,
        2,
        2,
        2,
        2,
        0,
        0,
        3,
        3,
        2,
        2,
        3,
        2,
        2,
        3,
        2,
        2,
        2,
        2,
        2,
        2,
        3,
        2,
        3,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        0,
        2,
        3,
        2,
        2,
        0,
        0,
        0,
        3,
        3,
        3,
        2,
        2,
        2,
        2,
        2,
        3,
        3,
        2,
        3,
        2,
        2,
        2,
        2,
        2,
        3,
        3,
        0,
        3,
        2,
        2,
        3,
        3,
        3,
        2,
        2,
        2,
        3,
        2,
        2,
        3,
        3,
        2,
        3,
        0,
        0,
        2,
        2,
        2,
        0,
        2,
        0,
        2,
        3,
        2,
        2,
        2,
        2,
        2,
        3,
        2,
        3,
        2,
        3,
        2,
        2,
        2,
        2,
        2,
        0,
        2,
        2,
        3,
        2,
        2,
        3,
        2,
        3,
        3,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1
    ];
    level.botbb_opteam_default = "SPECGRU,USA,KORTAC|0,1,1,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,0,1,0,1,0,0,0,1,1,1,0,1,1,0,0,1,1,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,2,2,0,0,2,2,0,0,0,-,-,-";
    level.botbb_codeside = [];
    level.botbb_codeside["SPECGRU"] = "J";
    level.botbb_codeside["USA"] = "G";
    level.botbb_codeside["KORTAC"] = "G";
    level.botbb_prims = [
        "sat_ar_albatross;1;evilsup",
        "sat_ar_albatross;2;metalmask",
        "sat_ar_albatross;3;dshake",
        "sat_ar_albatross;4;dronelab",
        "sat_ar_albatross;5;bunny",
        "sat_ar_albatross;6;widow",
        "sat_ar_albatross;7;s6blk",
        "sat_ar_albatross;8;s6blkb",
        "sat_ar_albatross;9;peanut",
        "sat_ar_albatross;10;s6blkd",
        "sat_ar_condor;1;vault",
        "sat_ar_condor;2;hallucin",
        "sat_ar_condor;3;rwb",
        "sat_ar_condor;4;spider",
        "sat_ar_condor;5;death",
        "sat_ar_condor;6;claws",
        "sat_ar_condor;7;roadgate",
        "sat_ar_condor;8;cookie",
        "sat_ar_condor;9;major1",
        "sat_ar_condor;10;star",
        "sat_ar_condor;11;advisor",
        "sat_ar_condor;12;daisy03",
        "sat_ar_condor;13;emascot",
        "sat_ar_condor;14;villain",
        "sat_ar_condor;15;orsnake",
        "sat_ar_condor;16;onsen",
        "sat_ar_condor;17;actionh",
        "sat_ar_condor;18;theigl",
        "sat_ar_condor;19;cyunder",
        "sat_ar_condor;20;endgame",
        "sat_ar_condor;21;clean",
        "sat_ar_condor;22;sourdough",
        "sat_ar_condor;23;faith",
        "sat_ar_eagle;1;airbrush",
        "sat_ar_eagle;2;spacef",
        "sat_ar_eagle;3;command",
        "sat_ar_eagle;4;psyop",
        "sat_ar_eagle;5;mason",
        "sat_ar_eagle;6;milspace",
        "sat_ar_eagle;7;chickenlover",
        "sat_ar_eagle;8;tsoldier",
        "sat_ar_eagle;9;werewolf",
        "sat_ar_eagle;10;cybertooth",
        "sat_ar_eagle;11;s2blk",
        "sat_ar_eagle;12;s1blk",
        "sat_ar_eagle;13;sface",
        "sat_ar_eagle;14;scheme",
        "sat_ar_eagle;15;milseal",
        "sat_ar_eagle;16;rich100",
        "sat_ar_eagle;17;whunter",
        "sat_ar_eagle;18;swiss",
        "sat_ar_eagle;19;trench",
        "sat_ar_eagle;20;orvision",
        "sat_ar_egret;1;s2blk",
        "sat_ar_egret;2;swamp",
        "sat_ar_egret;3;origami",
        "sat_ar_egret;4;breach",
        "sat_ar_egret;5;stealth",
        "sat_ar_egret;6;mbomb",
        "sat_ar_egret;7;teddcor",
        "sat_ar_egret;8;slim",
        "sat_ar_egret;9;rebel",
        "sat_ar_egret;10;tactroman",
        "sat_ar_egret;11;paintb",
        "sat_ar_egret;12;weekly",
        "sat_ar_egret;13;s4blk",
        "sat_ar_egret;14;s4blkb",
        "sat_ar_egret;15;s4blkc",
        "sat_ar_egret;16;s4blkd",
        "sat_ar_egret;17;kaijuh",
        "sat_ar_egret;18;jungle",
        "sat_ar_egret;19;lava",
        "sat_ar_egret;20;mayhem",
        "sat_ar_emu;1;honesie",
        "sat_ar_emu;2;djester",
        "sat_ar_emu;3;fire",
        "sat_ar_falcon;1;kingdeath",
        "sat_ar_falcon;2;general",
        "sat_ar_falcon;3;digiskel",
        "sat_ar_falcon;4;iris",
        "sat_ar_falcon;5;augment",
        "sat_ar_falcon;6;frame",
        "sat_ar_falcon;7;tealgold",
        "sat_ar_falcon;8;slugger",
        "sat_ar_falcon;9;equus",
        "sat_ar_falcon;10;cyberjp",
        "sat_ar_falcon;11;apex",
        "sat_ar_falcon;12;pyroman",
        "sat_ar_falcon;13;tlock",
        "sat_ar_falcon;14;tagger",
        "sat_ar_falcon;15;s3blk",
        "sat_ar_falcon;16;nexus",
        "sat_ar_falcon;17;straw",
        "sat_ar_falcon;18;wilder",
        "sat_ar_finch;1;spyvil",
        "sat_ar_finch;2;guild",
        "sat_ar_finch;3;infected",
        "sat_ar_finch;4;bonsai",
        "sat_ar_finch;5;s3blk",
        "sat_ar_finch;6;tarot",
        "sat_ar_finch;7;trollface",
        "sat_ar_finch;8;kitbash",
        "sat_ar_finch;9;cosmich",
        "sat_ar_finch;10;anvil100",
        "sat_ar_finch;11;training",
        "sat_ar_finch;12;modwar",
        "sat_ar_finch;13;30year",
        "sat_ar_finch;14;s5blk",
        "sat_ar_finch;15;horseman",
        "sat_ar_finch;16;lucky",
        "sat_ar_finch;17;s6blk",
        "sat_ar_hawk;1;zsnow",
        "sat_ar_hawk;2;beta",
        "sat_ar_hawk;3;puzzlebox",
        "sat_ar_hawk;4;hazard",
        "sat_ar_hawk;5;frycook",
        "sat_ar_hawk;6;campaign",
        "sat_ar_hawk;7;cultists",
        "sat_ar_hawk;8;mpleader",
        "sat_ar_hawk;9;darkbook",
        "sat_ar_hawk;10;harper",
        "sat_ar_hawk;11;ddeath",
        "sat_ar_hawk;12;fieldmed",
        "sat_ar_hawk;13;darka",
        "sat_ar_hawk;14;highend",
        "sat_ar_hawk;15;darkevil",
        "sat_ar_hawk;16;rankeds02",
        "sat_ar_hawk;17;cdlmidsea",
        "sat_ar_hawk;18;major3",
        "sat_ar_hawk;19;wsowevent",
        "sat_ar_hawk;20;radar",
        "sat_ar_hawk;21;liquid",
        "sat_ar_hawk;22;rankeds03",
        "sat_ar_hawk;23;mozza",
        "sat_ar_hawk;24;armory",
        "sat_ar_hawk;25;endgame",
        "sat_ar_hawk;26;gamble",
        "sat_ar_hawk;27;brioche",
        "sat_ar_hawk;28;s4blk",
        "sat_ar_hawk;29;champs",
        "sat_ar_hawk;30;gnebula",
        "sat_ar_hawk;31;chestnut",
        "sat_ar_hawk;32;rankeds06",
        "sat_ar_heron;1;teddbus",
        "sat_ar_heron;2;merc",
        "sat_ar_heron;3;sentinel",
        "sat_ar_heron;4;illum",
        "sat_ar_heron;5;deathshep",
        "sat_ar_heron;6;demp",
        "sat_ar_heron;7;perkas",
        "sat_ar_heron;8;retrocab",
        "sat_ar_heron;9;milbash",
        "sat_ar_heron;10;father",
        "sat_ar_heron;11;riviera",
        "sat_ar_heron;12;exproto",
        "sat_ar_heron;13;splice",
        "sat_ar_heron;14;ghostw",
        "sat_ar_kite;1;partier",
        "sat_ar_kite;2;dronespec",
        "sat_ar_kite;3;robotk",
        "sat_ar_kite;4;soupedup",
        "sat_ar_kite;5;demon",
        "sat_ar_kite;6;rose",
        "sat_ar_kite;7;tech",
        "sat_ar_kite;8;phase",
        "sat_ar_kite;9;s2blk",
        "sat_ar_kite;10;cradle",
        "sat_ar_kite;11;silverzm",
        "sat_ar_kite;12;regalr",
        "sat_ar_kite;13;cryo",
        "sat_ar_kite;14;s2blkv2",
        "sat_ar_kite;15;raven",
        "sat_ar_kite;16;panzer",
        "sat_ar_kite;17;miljung",
        "sat_ar_kite;18;bone",
        "sat_ar_kite;19;endgame",
        "sat_ar_kiwi;1;sun",
        "sat_ar_kiwi;2;masked",
        "sat_ar_kiwi;3;sport",
        "sat_ar_kiwi;4;deserted",
        "sat_ar_kiwi;5;woodblock",
        "sat_ar_kiwi;6;armygrn",
        "sat_ar_kiwi;7;maidend",
        "sat_ar_kiwi;8;alien",
        "sat_ar_kiwi;9;s6blk",
        "sat_ar_macaw;1;mecheagle",
        "sat_ar_macaw;2;capybara",
        "sat_ar_macaw;3;apres",
        "sat_ar_macaw;4;warfare",
        "sat_ar_macaw;5;celticw",
        "sat_ar_macaw;6;sunflower",
        "sat_ar_macaw;7;s1blk",
        "sat_ar_macaw;8;wpndoa",
        "sat_ar_macaw;9;medic",
        "sat_ar_macaw;10;ibattle",
        "sat_ar_macaw;11;weeklys02",
        "sat_ar_macaw;12;chrome",
        "sat_ar_macaw;13;bongo",
        "sat_ar_macaw;14;indust",
        "sat_ar_macaw;15;chemwar",
        "sat_ar_macaw;16;rt100",
        "sat_ar_macaw;17;earth",
        "sat_ar_macaw;18;faberge",
        "sat_ar_macaw;19;shirt",
        "sat_ar_vulture;1;btrap",
        "sat_ar_vulture;2;uglysweat",
        "sat_ar_vulture;3;luxury",
        "sat_ar_vulture;4;pforce",
        "sat_ar_vulture;5;shadow",
        "sat_ar_vulture;6;forces",
        "sat_ar_vulture;7;primis",
        "sat_ar_vulture;8;pirate",
        "sat_ar_vulture;9;damaged",
        "sat_ar_vulture;10;extrater",
        "sat_ar_vulture;11;avalon",
        "sat_ar_vulture;12;wasteland",
        "sat_ar_vulture;13;shockt",
        "sat_ar_vulture;14;zmleadice",
        "sat_ar_vulture;15;pcydon",
        "sat_ar_vulture;16;brie",
        "sat_ar_vulture;17;buzzkill",
        "sat_ar_vulture;18;s4blk",
        "sat_ar_vulture;19;redcamo",
        "sat_ar_vulture;20;pinball",
        "sat_ar_wren;1;smind",
        "sat_ar_wren;2;zmbmech",
        "sat_ar_wren;3;mdsf",
        "sat_ar_wren;4;mind",
        "sat_ar_wren;5;kotz",
        "sat_ar_wren;6;s5blk",
        "sat_ar_wren;7;ppatch",
        "sat_ar_wren;8;week",
        "sat_ar_wren;9;death",
        "sat_dm_kara;1;shiny",
        "sat_dm_kara;2;alienbud",
        "sat_dm_kara;3;science",
        "sat_dm_kara;4;cookie",
        "sat_dm_kara;5;manip",
        "sat_dm_kara;6;galactic",
        "sat_dm_kara;7;highalt",
        "sat_dm_kara;8;s3blk",
        "sat_dm_kara;9;circus",
        "sat_dm_oman;1;polarb",
        "sat_dm_oman;2;hunter",
        "sat_dm_oman;3;hive",
        "sat_dm_oman;4;spacef",
        "sat_dm_oman;5;techwar",
        "sat_dm_oman;6;s2blk",
        "sat_dm_oman;7;primis",
        "sat_dm_oman;8;recharge",
        "sat_dm_oman;9;bamboo",
        "sat_dm_oman;10;tactroman",
        "sat_dm_oman;11;father",
        "sat_dm_oman;12;redteeth",
        "sat_dm_samar;1;panzer",
        "sat_dm_samar;2;maze",
        "sat_dm_samar;3;miljung",
        "sat_dm_samar;4;humanoid",
        "sat_dm_samar;5;s4blk",
        "sat_dm_samar;6;machines",
        "sat_dm_samar;7;redcamo",
        "sat_dm_samar;8;plague",
        "sat_dm_scotia;1;hazard",
        "sat_dm_scotia;2;soupedup",
        "sat_dm_scotia;3;recon",
        "sat_dm_scotia;4;diytech",
        "sat_dm_scotia;5;code",
        "sat_dm_scotia;6;star",
        "sat_dm_scotia;7;stealth",
        "sat_dm_scotia;8;iris",
        "sat_dm_scotia;9;drops02",
        "sat_dm_scotia;10;s1blk",
        "sat_dm_scotia;11;subject",
        "sat_dm_scotia;12;rich100",
        "sat_dm_scotia;13;cryo",
        "sat_dm_scotia;14;tarot",
        "sat_dm_scotia;15;squid",
        "sat_dm_scotia;16;warden",
        "sat_dm_solomon;1;fbi",
        "sat_dm_solomon;2;harper",
        "sat_dm_solomon;3;pirate",
        "sat_dm_solomon;4;contract",
        "sat_dm_solomon;5;kotz",
        "sat_dm_solomon;6;alien",
        "sat_lm_hades;1;shiny",
        "sat_lm_hades;2;cybersam",
        "sat_lm_hades;3;btrap",
        "sat_lm_hades;4;quad",
        "sat_lm_hades;5;augment",
        "sat_lm_hades;6;cshift",
        "sat_lm_hades;7;milseal",
        "sat_lm_hades;8;bamboo",
        "sat_lm_hades;9;cryostalker",
        "sat_lm_hades;10;s3blk",
        "sat_lm_hades;11;spirit",
        "sat_lm_hades;12;liquid",
        "sat_lm_hades;13;pinball",
        "sat_lm_hildr;1;dienst",
        "sat_lm_hildr;2;gwall",
        "sat_lm_hildr;3;widow",
        "sat_lm_hildr;4;spiders",
        "sat_lm_typhon;1;luxury",
        "sat_lm_typhon;2;partier",
        "sat_lm_typhon;3;darkbook",
        "sat_lm_typhon;4;advisor",
        "sat_lm_typhon;5;mumnight",
        "sat_lm_typhon;6;damaged",
        "sat_lm_typhon;7;chemwar",
        "sat_lm_typhon;8;sport",
        "sat_lm_typhon;9;range",
        "sat_lm_typhon;10;diyzm",
        "sat_lm_typhon;11;s4blk",
        "sat_lm_typhon;12;sbarber",
        "sat_lm_zeus;1;alpine",
        "sat_lm_zeus;2;airbrush",
        "sat_lm_zeus;3;testingf",
        "sat_lm_zeus;4;acid",
        "sat_lm_zeus;5;s1blk",
        "sat_lm_zeus;6;monochrome",
        "sat_lm_zeus;7;wasteland",
        "sat_lm_zeus;8;organ",
        "sat_lm_zeus;9;buzzkill",
        "sat_lm_zeus;10;brioche",
        "sat_lm_zeus;11;flames",
        "sat_lm_zeus;12;bwred",
        "sat_lm_zeus;13;pigfarm",
        "sat_sh_akita;1;uap",
        "sat_sh_akita;2;alienbud",
        "sat_sh_akita;3;testingf",
        "sat_sh_akita;4;star",
        "sat_sh_akita;5;forces",
        "sat_sh_akita;6;tnaut",
        "sat_sh_akita;7;outpost",
        "sat_sh_akita;8;enforcer",
        "sat_sh_akita;9;trollface",
        "sat_sh_akita;10;s4blk",
        "sat_sh_akita;11;bruise",
        "sat_sh_akita;12;honesie",
        "sat_sh_corso;1;edge",
        "sat_sh_corso;2;vault",
        "sat_sh_corso;3;hallucin",
        "sat_sh_corso;4;roadgate",
        "sat_sh_corso;5;butter",
        "sat_sh_corso;6;opening",
        "sat_sh_corso;7;iris",
        "sat_sh_corso;8;s2blk",
        "sat_sh_corso;9;frame",
        "sat_sh_corso;10;karma",
        "sat_sh_corso;11;earth",
        "sat_sh_corso;12;safety",
        "sat_sh_corso;13;jungle",
        "sat_sh_corso;14;bunny",
        "sat_sh_corso;15;peanut",
        "sat_sh_husky;1;zsnow",
        "sat_sh_husky;2;rwb",
        "sat_sh_husky;3;enhancem",
        "sat_sh_husky;4;eod",
        "sat_sh_husky;5;darkbook",
        "sat_sh_husky;6;official",
        "sat_sh_husky;7;s1blk",
        "sat_sh_husky;8;bloodflow",
        "sat_sh_husky;9;zmleadash",
        "sat_sh_husky;10;brie",
        "sat_sh_husky;11;cyunder",
        "sat_sh_husky;12;perkas",
        "sat_sh_husky;13;werewolf",
        "sat_sh_husky;14;techbody",
        "sat_sh_shepherd;1;arctic",
        "sat_sh_shepherd;2;fieldmed",
        "sat_sh_shepherd;3;silverzm",
        "sat_sh_shepherd;4;teddcor",
        "sat_sh_shepherd;5;buzzkill",
        "sat_sh_shepherd;6;orvision",
        "sat_sh_shepherd;7;exproto",
        "sat_sh_shepherd;8;s5blk",
        "sat_sh_shepherd;9;scare",
        "sat_sm_bear;1;s3blk",
        "sat_sm_bear;2;s3blkb",
        "sat_sm_bear;3;illum",
        "sat_sm_bear;4;monochrome",
        "sat_sm_bear;5;actionh",
        "sat_sm_bear;6;porcelain",
        "sat_sm_bear;7;fbi",
        "sat_sm_bear;8;mozza",
        "sat_sm_bear;9;anvil",
        "sat_sm_bear;10;colors",
        "sat_sm_bear;11;sandy",
        "sat_sm_bear;12;pinball",
        "sat_sm_bear;13;gwall",
        "sat_sm_bear;14;s5blk",
        "sat_sm_bear;15;rocker",
        "sat_sm_bear;16;djester",
        "sat_sm_bengal;1;digiskel",
        "sat_sm_bengal;2;milspace",
        "sat_sm_bengal;3;escape",
        "sat_sm_bengal;4;highend",
        "sat_sm_bengal;5;spyvil",
        "sat_sm_bengal;6;equus",
        "sat_sm_bengal;7;armed",
        "sat_sm_bengal;8;faberge",
        "sat_sm_bengal;9;spirit",
        "sat_sm_bengal;10;smind",
        "sat_sm_bengal;11;s5blk",
        "sat_sm_bengal;12;s5blkb",
        "sat_sm_bengal;13;s5blkc",
        "sat_sm_bengal;14;s5blkd",
        "sat_sm_bengal;15;eldritch",
        "sat_sm_civet;1;maidend",
        "sat_sm_civet;2;dental",
        "sat_sm_civet;3;horseman",
        "sat_sm_civet;4;s6blk",
        "sat_sm_cobra;1;sweatsuit",
        "sat_sm_cobra;2;alpine",
        "sat_sm_cobra;3;alienbud",
        "sat_sm_cobra;4;jtac",
        "sat_sm_cobra;5;soupedup",
        "sat_sm_cobra;6;command",
        "sat_sm_cobra;7;samoan",
        "sat_sm_cobra;8;swamp",
        "sat_sm_cobra;9;villain",
        "sat_sm_cobra;10;cshift",
        "sat_sm_cobra;11;sun",
        "sat_sm_cobra;12;apex",
        "sat_sm_cobra;13;rankeds04",
        "sat_sm_cobra;14;rankeds05",
        "sat_sm_cobra;15;cosmich",
        "sat_sm_cobra;16;blood",
        "sat_sm_cobra;17;bloodbc",
        "sat_sm_gecko;1;s2blk",
        "sat_sm_gecko;2;galactic",
        "sat_sm_gecko;3;teleport",
        "sat_sm_gecko;4;tealgold",
        "sat_sm_gecko;5;techspy",
        "sat_sm_gecko;6;aghillie",
        "sat_sm_gecko;7;subject",
        "sat_sm_gecko;8;infected",
        "sat_sm_gecko;9;tagger",
        "sat_sm_gecko;10;blind",
        "sat_sm_gecko;11;faction",
        "sat_sm_gecko;12;nuked",
        "sat_sm_gecko;13;bone",
        "sat_sm_gecko;14;proto",
        "sat_sm_hyena;1;uap",
        "sat_sm_hyena;2;active",
        "sat_sm_hyena;3;chickenlover",
        "sat_sm_hyena;4;cybertooth",
        "sat_sm_hyena;5;s1blk",
        "sat_sm_hyena;6;recharge",
        "sat_sm_hyena;7;tech",
        "sat_sm_hyena;8;carbon",
        "sat_sm_hyena;9;mars",
        "sat_sm_hyena;10;slugger",
        "sat_sm_hyena;11;mbomb",
        "sat_sm_hyena;12;hitman",
        "sat_sm_hyena;13;dormant",
        "sat_sm_hyena;14;organ",
        "sat_sm_hyena;15;freerun",
        "sat_sm_hyena;16;straw",
        "sat_sm_komodo;1;kingdeath",
        "sat_sm_komodo;2;spider",
        "sat_sm_komodo;3;manip",
        "sat_sm_komodo;4;martial",
        "sat_sm_komodo;5;operator",
        "sat_sm_komodo;6;capybara",
        "sat_sm_komodo;7;teddbus",
        "sat_sm_komodo;8;sunflower",
        "sat_sm_komodo;9;weeklys01",
        "sat_sm_komodo;10;s1blk",
        "sat_sm_komodo;11;shattered",
        "sat_sm_komodo;12;guild",
        "sat_sm_komodo;13;director",
        "sat_sm_komodo;14;cyberjp",
        "sat_sm_komodo;15;s3blk",
        "sat_sm_komodo;16;s3blkc",
        "sat_sm_komodo;17;s3blkb",
        "sat_sm_komodo;18;animeco",
        "sat_sm_komodo;19;brioche",
        "sat_sm_komodo;20;armygrn",
        "sat_sm_marmot;1;vipmerc",
        "sat_sm_marmot;2;indust",
        "sat_sm_marmot;3;circus",
        "sat_sm_marmot;4;s4blk",
        "sat_sm_marmot;5;outlaw",
        "sat_sm_marmot;6;dienst",
        "sat_sm_marmot;7;flames",
        "sat_sm_marmot;8;bwred",
        "sat_sm_marmot;9;cybercam",
        "sat_sm_marmot;10;s5blk",
        "sat_sm_marmot;11;warden",
        "sat_sm_orca;1;mecheagle",
        "sat_sm_orca;2;hunter",
        "sat_sm_orca;3;polarb",
        "sat_sm_orca;4;apres",
        "sat_sm_orca;5;campaign",
        "sat_sm_orca;6;chemical",
        "sat_sm_orca;7;mrhino",
        "sat_sm_orca;8;sentinel",
        "sat_sm_orca;9;mumnight",
        "sat_sm_orca;10;deathshep",
        "sat_sm_orca;11;nwarfare",
        "sat_sm_orca;12;s3blk",
        "sat_sm_orca;13;swiss",
        "sat_sm_orca;14;whunter",
        "sat_sm_orca;15;milbash",
        "sat_sm_orca;16;deserted",
        "sat_sm_orca;17;fire",
        "sat_sm_otter;1;hive",
        "sat_sm_otter;2;cybersam",
        "sat_sm_otter;3;btrap",
        "sat_sm_otter;4;pforce",
        "sat_sm_otter;5;extrater",
        "sat_sm_otter;6;arctic",
        "sat_sm_otter;7;origami",
        "sat_sm_otter;8;s2blk",
        "sat_sm_otter;9;evhunter",
        "sat_sm_otter;10;avalon",
        "sat_sm_otter;11;darkevil",
        "sat_sm_otter;12;chrome",
        "sat_sm_otter;13;evilsup",
        "sat_sm_otter;14;brie",
        "sat_sm_otter;15;training",
        "sat_sm_otter;16;ppatch",
        "sat_sm_puma;1;uglysweat",
        "sat_sm_puma;2;traitor",
        "sat_sm_puma;3;aerial",
        "sat_sm_puma;4;shonen",
        "sat_sm_puma;5;s1blk",
        "sat_sm_puma;6;tulip",
        "sat_sm_puma;7;firebreak",
        "sat_sm_puma;8;celticw",
        "sat_sm_puma;9;darka",
        "sat_sm_puma;10;nightmare",
        "sat_sm_puma;11;bloodflow",
        "sat_sm_puma;12;pcydon",
        "sat_sm_puma;13;kitbash",
        "sat_sm_puma;14;maze",
        "sat_sm_puma;15;mdsf",
        "sat_sm_puma;16;spectre",
        "sat_sm_serval;1;kaijuh",
        "sat_sm_serval;2;dshake",
        "sat_sm_serval;3;humanoid",
        "sat_sm_serval;4;dronelab",
        "sat_sm_serval;5;s5blk",
        "sat_sm_serval;6;shadows",
        "sat_sm_serval;7;wilder",
        "sat_sm_serval;8;ghostw",
        "sat_sm_serval;9;redteeth",
        "sat_sm_zebra;1;vault",
        "sat_sm_zebra;2;puzzlebox",
        "sat_sm_zebra;3;science",
        "sat_sm_zebra;4;robotk",
        "sat_sm_zebra;5;opening",
        "sat_sm_zebra;6;code",
        "sat_sm_zebra;7;drops01",
        "sat_sm_zebra;8;daisy",
        "sat_sm_zebra;9;acid",
        "sat_sm_zebra;10;major2",
        "sat_sm_zebra;11;cupid",
        "sat_sm_zebra;12;wzrp",
        "sat_sm_zebra;13;zmlead02",
        "sat_sm_zebra;14;nova7",
        "sat_sm_zebra;15;rankeds02",
        "sat_sm_zebra;16;defuse",
        "sat_sm_zebra;17;major4",
        "sat_sm_zebra;18;pyroman",
        "sat_sm_zebra;19;zombg",
        "sat_sm_zebra;20;claws",
        "sat_sm_zebra;21;gamble",
        "sat_sm_zebra;22;sourdough",
        "sat_sm_zebra;23;mind",
        "sat_sm_zebra;24;chestnut",
        "sat_sn_aden;1;shonen",
        "sat_sn_aden;2;mason",
        "sat_sn_aden;3;mrhino",
        "sat_sn_aden;4;deepsea",
        "sat_sn_aden;5;hitman",
        "sat_sn_aden;6;mozza",
        "sat_sn_aden;7;s3blk",
        "sat_sn_aden;8;masked",
        "sat_sn_aden;9;privsec",
        "sat_sn_aden;10;rusty",
        "sat_sn_aden;11;shirt",
        "sat_sn_aden;12;s5blk",
        "sat_sn_baltic;1;dronespec",
        "sat_sn_baltic;2;inventor",
        "sat_sn_baltic;3;samoan",
        "sat_sn_baltic;4;phase",
        "sat_sn_baltic;5;breach",
        "sat_sn_baltic;6;techspy",
        "sat_sn_baltic;7;faction",
        "sat_sn_baltic;8;modmac",
        "sat_sn_baltic;9;mayhem",
        "sat_sn_caspian;1;campaign",
        "sat_sn_caspian;2;counter",
        "sat_sn_caspian;3;tsoldier",
        "sat_sn_caspian;4;escape",
        "sat_sn_caspian;5;ddeath",
        "sat_sn_caspian;6;teleport",
        "sat_sn_caspian;7;porcelain",
        "sat_sn_caspian;8;regalr",
        "sat_sn_caspian;9;outlaw",
        "sat_sn_caspian;10;scare",
        "sat_sn_coral;1;paintb",
        "sat_sn_coral;2;aghillie",
        "sat_sn_coral;3;cyberjp",
        "sat_sn_coral;4;animeco",
        "sat_sn_coral;5;zombg",
        "sat_sn_coral;6;nexus",
        "sat_sn_coral;7;clean",
        "sat_sn_coral;8;s4blk",
        "sat_sn_coral;9;sandy",
        "sat_sn_coral;10;exproto",
        "sat_sn_coral;11;puppet",
        "sat_sn_drake;1;vault",
        "sat_sn_drake;2;warfare",
        "sat_sn_drake;3;claws",
        "sat_sn_drake;4;drops02",
        "sat_sn_drake;5;firebreak",
        "sat_sn_drake;6;arctic",
        "sat_sn_drake;7;optin",
        "sat_sn_drake;8;s2blk",
        "sat_sn_drake;9;medic",
        "sat_sn_drake;10;sface",
        "sat_sn_drake;11;apex",
        "sat_sn_drake;12;metalmask",
        "sat_sn_drake;13;retrocab",
        "sat_sn_drake;14;bmarket"
    ];
    level.botbb_secs = [
        "sat_pi_alcor;1;rebel",
        "sat_pi_alcor;2;demp",
        "sat_pi_alcor;3;range",
        "sat_pi_alcor;4;mdsf",
        "sat_pi_alcor;5;hollow",
        "sat_pi_atlas;1;traitor",
        "sat_pi_atlas;2;chemical",
        "sat_pi_atlas;3;harper",
        "sat_pi_atlas;4;sunflower",
        "sat_pi_atlas;5;bonsai",
        "sat_pi_atlas;6;tghost",
        "sat_pi_orion;1;edge",
        "sat_pi_orion;2;shadow",
        "sat_pi_orion;3;robot",
        "sat_pi_orion;4;cryo",
        "sat_pi_orion;5;nwarfare",
        "sat_pi_orion;6;swiss",
        "sat_pi_orion;7;liquid",
        "sat_pi_orion;8;smind",
        "sat_pi_timir;1;sweatsuit",
        "sat_pi_timir;2;inventor",
        "sat_pi_timir;3;scheme",
        "sat_pi_timir;4;ibattle",
        "sat_pi_timir;5;paintb",
        "sat_pi_timir;6;sourdough",
        "sat_pi_timir;7;alien"
    ];
}
