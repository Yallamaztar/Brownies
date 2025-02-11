init() {
    level thread onPlayerConnect();
}

onPlayerConnect() {
    for(;;) {
        level waittill( "connected", player );
        player thread onPlayerPressed();
    }
}

onPlayerPressed() {
    level endon( "disconnect" );
    self endon( "game_ended" );

    for(;;) {
        if ( self useButtonPressed() ) {
            self camoSwap();

            while ( self useButtonPressed() )
                wait 2;
        }
        wait 0.05;
    }
}

camoSwap() {
    weap = self getCurrentWeapon();
    self takeWeapon( weap );
    self giveWeapon( weap, 0, randomIntRange(1, 45) );
    self switchToWeapon( weap );
}