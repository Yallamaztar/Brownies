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