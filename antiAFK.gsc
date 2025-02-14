#include scripts\src\_utils;

init() {
    level thread onPlayerConnect();
}
 
onPlayerConnect() {
    for(;;) {
        level waittill("connected", player);
        level thread afkMonitorThing();
    }
}

afkMonitorThing() {
    level endon( "end_game" );
    timeToKick = 600000; // 5 Minutes

    while(true) {
        if ( level.players.size < 2) 
            wait .05;
            continue;

        foreach ( player in level.players ) {
            if ( player anyButtonPressed() ) {
                player.afkTime = undefined;
                continue;
            }
                
            if ( player.sessionstate == "spectator" && isDefined(player.afkTime) ) {
                player.afkTime += 50;
				continue;
            }
            if ( !isDefined(player.afkTime) )
                player.afkTime = getTime();
                
            if ( (getTime() - player.afkTime) >= timeToKick )
                Kick(player GetEntNum());

        }
        wait .05;
    }
}