#include scripts\src\_replace;
#include scripts\src\_hud;

main() {
    setDvar( "sv_cheats", 1 );
    setDvar( "cg_overheadnamessize", 0.4 );
    // cg_overheadIconSize 
    /* Deletes weapon 10sec after its dropped */
    replaceFunc( maps\mp\gametypes\_globallogic_player::callback_playerconnect, ::_callback_playerconnect );
    replaceFunc( maps\mp\gametypes\_weapons::deletepickupafterawhile, ::_deletepickupafterawhile );
}

init() {   
    thread scripts\src\_localization::main(); // Custom strings etc

    level.prematchPeriod = 5;    // Prematch timer
    level.isKillBoosting = 0;    // Disable kill boosting
    level.spectatetype   = 2;    // Better spectating perms
 
    /* Allow everyone to hear each other in voice chat */
    setMatchTalkFlag( "EveryoneHearsEveryone", 1 ); 

    if ( getDvar( #"mapname" ) == "mp_nuketown_2020" )
        /* Delete bad models */
        getEntByNum(273) delete(); // Blue Car
        getEntByNum(572) delete(); // Bomb

        thread scripts\src\_utils::removeDeathBarriers(); // Removing death barriers

    level thread onPlayerConnect();
}

onPlayerConnect() {
    for(;;) {
        level waittill( "connecting", player );
        player setClientDvar( "phys_disableEntsAndDynEntsCollision", 1 ); // Disable collision
        player setClientDvar( "jump_slowdownEnable", 0 );                 // Disable low player movement after jumping 
        player setClientDvar( "player_sprintUnlimited", 1 );              // Unlimited sprint
        player setClientDvar( "sv_allowAimAssist", 0 );                   // Disable aim assist
        player setClientDvar( "bg_fallDamageMinHeight", 9999 );           // Disable falldamage 

        player thread onPlayerSpawned();
        player thread onPlayerDeath();  
    }
}

onPlayerSpawned() {
    level endon( "game_ended" );
    self endon( "disconnect" );
    for(;;) {
        self waittill( "spawned_player" );
        wait .5;
        self thread destroyWaterMark();
    }
}

onPlayerDeath() {
    level endon( "game_ended" );
    self endon( "disconnect" );
    for(;;) {
        self waittill( "death" );
        self thread createWaterMark();
    }
}