main() {   
    level.halftimesubcaption = "^5@Brownies ^7Half Time";

    game["strings"]["sniper_only_warning"] = "This is a ^3SNIPER ^1ONLY ^7server, please use ^5DSR-50 ^7or ^5Ballista";  // custom
    game["strings"]["round_loss"]          = "shitter team";
    game["strings"]["round_win"]           = "ez win";   
    game["strings"]["change_class"]        = "^5Made ^7By: ^5Budi^7world";
    game["strings"]["score_limit_reached"] = "^5Brownies ^7Score Limit Reached GG\n\t\thttps://dsc.gg/browner";
    game["strings"]["tie"]                 = "Omg God Yall Suck";

    foreach(team in level.teams) {
        game["strings"]["objective_hint_" + team] = "^5@Brownies ^4FUCK ^7THE ^1FRENCH";
        game["strings"][team + "_win_round"]      = "^5@Brownies ^4FUCK ^7THE ^1FRENCH";
        game["strings"][team + "_win"]            = "^5@Brownies ^1^FEzPz";
        game["strings"][team + "_eliminated"]     = "yo ahh terrible";

        game["entity_headicon_" + team] = "loadscreen_mp_overflow";
    }
}