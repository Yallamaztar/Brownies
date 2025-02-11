main() {   
    game["strings"]["sniper_only_warning"] = "This is a ^3SNIPER ^1ONLY ^7server, please use ^5DSR-50 ^7or ^5Ballista"; 
    game["strings"]["change_class"]        = "^5Made ^7By: ^5Budi^7world";

    foreach(team in level.teams) {
        game["strings"]["objective_hint_" + team] = "^5@Brownies ^4FUCK ^7THE ^1FRENCH";
        game["strings"][team + "_win_round"]      = "^5@Brownies ^4FUCK ^7THE ^1FRENCH";
        game["strings"][team + "_eliminated"]     = "yo ahh terrible";
    }
}