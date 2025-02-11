disableBomb() {
    for(i = 0; i < level.bombzones.size; i++){
        level.bombzones[i] maps\mp\gametypes\_gameobjects::setvisibleteam( "none" );
    }
    level.sdbomb maps\mp\gametypes\_gameobjects::setvisibleteam( "none" );
    level.sdbomb maps\mp\gametypes\_gameobjects::allowcarry( "none" );
}

removeDeathBarriers() {
    barriers = GetEntArray("trigger_hurt", "classname");
    for ( i = 0; i < barriers.size; i++ ) {
        barriers[i].origin = (0,0,9999999);
    }
}

anyButtonPressed() {
    if ( self ActionSlotOneButtonPressed() || self actionSlotTwoButtonPressed() || self actionSlotThreeButtonPressed() || self actionSlotFourButtonPressed() || self attackButtonPressed() || self fragbuttonpressed() || self inventorybuttonpressed() || self jumpbuttonpressed() || self meleebuttonpressed() || self secondaryoffhandbuttonpressed() || self sprintbuttonpressed() || self stancebuttonpressed() || self throwbuttonpressed() || self usebuttonpressed() || self changeseatbuttonpressed() )
        return 1;

    return 0;
}

delayedKick( waittime, player ) {
    wait waittime;
    Kick(player getEntNum());
}