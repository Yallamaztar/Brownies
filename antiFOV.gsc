init() {
  level.maxFov = 100; // Max FOV to allow (int)
  level.maxFovScale = 1.50; // Max FOV scale to allow (float)
  level thread onPlayerConnect();
}

onPlayerConnect() {
  level endon( "game_ended" );
  self endon( "disconnect" );
  for(;;) {
    self waittill( "connected", player );
    player monitorPlayerFOV();
  }
}

monitorPlayerFOV() {
  for(;;) {
    fov = GetDvarInt( "cg_fov" );
    fovScale = GetDvarFloat( "cg_fovScale" );
    
    if ( fov >= level.maxFov && fovScale >= level.maxFovScale ) {
      self IPrintLnBold("Your ^3FOV ^7Is ^1Too High");
      wait 2.5;
      self Suicide();
    }

    wait .5;
  }
}