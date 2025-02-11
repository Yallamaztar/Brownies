
/* Delete weapon after death */
_deletepickupafterawhile() {
    self endon( "death" );
    
    wait 10; // Usually waits for 60 seconds
    if ( !isdefined( self ) )
        return;

    self delete();
}