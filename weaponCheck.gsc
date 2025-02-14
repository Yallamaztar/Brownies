init() {
    precachestring( game["strings"]["sniper_only_warning"] );
    level thread onPlayerConnect();
}
 
onPlayerConnect() {
    for(;;) {
        level waittill( "connected", player );
        player thread onPlayerSpawned();
    }
}
 
onPlayerSpawned() {
    level endon( "game_ended" );
    self endon( "disconnect" );

    for(;;) {
        self waittill( "spawned_player" );
        self monitorPlayer();
    }
}

monitorPlayer() {
    level endon( "game_end" );
    wait 10; // give player time to choose a class 
    
    for(;;) { 
        if ( self isHost() )
            return;

        if ( self.sessionstate == "playing" && !self hasAllowedWeapon() ) {
            self IPrintLnBold( game["strings"]["sniper_only_warning"] );
            wait 10;

            // self thread scripts\src\_functions::startExposureLoop(); // Epilepsy warning gg
            self thread scripts\src\_hud::createBlinkingText( "^1WTF FUCK TONEH TAKE A SNIPAH" );
            self scripts\src\_utils::delayedKick( 5, self );
            self thread scripts\src\_hud::destroyBlinkingText();
        }
        wait .1;
    }
}

hasAllowedWeapon() {
    weapons = self GetWeaponsList();
    foreach ( weapon in weapons ) {
        if ( weapon == "dsr50_mp" || IsSubStr(weapon, "dsr50_mp") || weapon == "ballista_mp" || IsSubStr(weapon, "ballista_mp") )
            return true; 
    }

    return false;
}     