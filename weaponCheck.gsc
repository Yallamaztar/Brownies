
init() {
    precachestring( game["strings"]["sniper_only_warning"] );

    level endon( "game_end" );
    for(;;) {
        foreach ( player in level.players ) {
            wait 0.5;
            if (player isHost()) 
                continue;
            
            if (player.sessionstate == "playing" && !hasAllowedWeapon(player))
                player IPrintLnBold(game["strings"]["sniper_only_warning"]);
                scripts\src\_utils::delayedKick( 3, player );
        }
        wait 0.5;
    }
}

hasAllowedWeapon( player ) {
    weapons = player GetWeaponsList();
    foreach ( weapon in weapons ) {
        if ( weapon == "dsr50_mp" || IsSubStr(weapon, "dsr50_mp") || weapon == "ballista_mp" || IsSubStr(weapon, "ballista_mp") )
            return true;
    }

    return false;
}     