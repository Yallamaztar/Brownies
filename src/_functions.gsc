setToSpectator() {
    self.sessionstate = "spectator";

    if ( isDefined( self.is_playing ) ) 
        self.is_playing = false;

    self.statusicon = "hud_status_dead";
    level thread maps\mp\gametypes\_globallogic::updateteamstatus();
}

startExposureLoop() {
    self setClientDvar( "r_exposureTweak", "1" );
    self setClientDvar( "r_exposureValue", "1" );

    while (true) {
        wait 0.05;
        self setClientDvar( "r_exposureValue", "-3" );
        wait 0.05;
        self setClientDvar( "r_exposureValue", "16" );
        wait 0.05;
    }
}

stopExposureLoop() {
    self setClientDvar( "r_exposureValue", "0" );
    self setClientDvar( "r_exposureTweak", "0" );
}