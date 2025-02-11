init() {
    level.onplayerdamage = ::onPlayerDamage;
}

onPlayerDamage( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset ) {
    if ( sWeapon == "ballista_mp" || sWeapon == "dsr50_mp" )  
        iDamage = 9999;
    else 
        iDamage = 0;

    return iDamage;
}

