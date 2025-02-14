init() {
    for( i = 0; i < level.bombzones.size; i++ ) {
        level.bombzones[i] maps\mp\gametypes\_gameobjects::setvisibleteam( "none" );
    }
    level.sdbomb maps\mp\gametypes\_gameobjects::setvisibleteam( "none" );
    level.sdbomb maps\mp\gametypes\_gameobjects::allowcarry( "none" );
}