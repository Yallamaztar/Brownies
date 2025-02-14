init() {
    level thread onPlayerConnect();
}
 
onPlayerConnect() {
    for(;;) {
        level waittill( "connected", player );
        player thread onPlayerSpawned();
    }
}
 
onPlayerSpawned() {
    self endon( "disconnect" );
    level endon( "game_ended" );
    for(;;) {
        self waittill("spawned_player");
        self antiHardscope();        
    }
}

antiHardscope() {
    self endon( "disconnect" );
    self endon( "death" );

    while(true) {
        if ( self playerADS() >= .75 ) {
            wait 4;

            if ( self playerADS() >= .75 ) 
                self IPrintLnBold("fuck you");
                self allowAds(false);

                wait 1;
                self allowAds(true);
        }
        wait 0.01;
    }
}