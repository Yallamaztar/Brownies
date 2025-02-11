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

            PrintLn(getTime() - player.afkTime);

            if ( (getTime() - player.afkTime) >= timeToKick ) {
                Kick(player GetEntNum());
            }
        }
        wait 0.05;
    }
}