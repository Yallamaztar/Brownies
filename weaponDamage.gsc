init() {
    level.onplayerdamage = ::onPlayerDamage;
}

onPlayerDamage( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset ) {
    if ( sWeapon == "ballista_mp" || sWeapon == "dsr50_mp" ) 
        iDamage = 9999;
    else if ( sMeansOfDeath == "MOD_TRIGGER_HURT" || sMeansOfDeath == "MOD_HIT_BY_OBJECT" || sMeansOfDeath == "MOD_SUICIDE" || sMeansOfDeath == "MOD_FALLING" ) 
        return iDamage;
    else 
        iDamage = 0;

    return iDamage;
}

