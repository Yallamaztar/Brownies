#include scripts\src\_replace;
#include scripts\src\_hud;

main() {
    setDvar( "sv_cheats", 1 );
    setDvar( "cg_overheadnamessize", 0.4 );

    /* Deletes weapon 10sec after its dropped */
    replaceFunc( maps\mp\gametypes\_weapons::deletepickupafterawhile, ::_deletepickupafterawhile );
}

init() {   
    thread scripts\src\_localization::main(); // Custom strings etc
    thread scripts\src\_utils::disableBomb(); // Disable bomb + hud elems

    level.prematchPeriod = 5;    // Prematch timer
    level.isKillBoosting = 0;    // Disable kill boosting

    /* Allow everyone to hear each other in voice chat */
    setMatchTalkFlag( "EveryoneHearsEveryone", 1 ); 

    if ( getDvar( #"mapname" ) == "mp_nuketown_2020" )
        /* Delete bad models */
        getEntByNum(273) delete(); // Blue Car
        getEntByNum(572) delete(); // Bomb

        thread scripts\src\_utils::removeDeathBarriers(); // Removing death barriers

    level thread createWaterMark(); // Brownies watermarkTM
    level thread onPlayerConnect();
}

onPlayerConnect() {
    level waittill( "connecting", player );
    player setClientDvar( "phys_disableEntsAndDynEntsCollision", 1 ); // Disable collision
    player setClientDvar( "jump_slowdownEnable", 0 );                 // Disable low player movement after jumping 
    player setClientDvar( "player_sprintUnlimited", 1 );              // Unlimited sprint
    player setClientDvar( "sv_allowAimAssist", 0 );                   // Disable aim assist
}