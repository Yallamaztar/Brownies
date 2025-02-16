#include maps\mp\gametypes\_hud_util;

createMapBackground() { /* Pretty much only works if player's resolution is 1920x1080 */
    self.mapBackground = createServerFontString( "bigfixed", 1 );
    self.mapBackground setText( "Brow^5nies" );
    self.mapBackground setPoint( "TOP_LEFT", "TOP_LEFT", -37, 43 );

    self.mapBackground.hidewheninmenu = 1;
    self.mapBackground.hidewheninkillcam = 1;
    self.mapBackground.hidewhendead = 1;
    self.mapBackground.hidewhenindemo = 1;
    self.mapBackground.hide_when_unavailable = 1;   
}

destroyMapBackground() {
    self.mapBackground Destroy();
}

createWaterMark() {
    self.waterMark = level createServerFontString( "bigfixed", 1 );
    self.waterMark setText( "^5Brownies ^4Nuketown ^5Sniper ^4SND\n" + " \t\t " + "^7https://dsc.gg/browner" );
    self.waterMark setPoint( "TOP_RIGHT", "TOP_RIGHT", 30, -30 );
}

destroyWaterMark() {
    self.waterMark Destroy();
}

createBlinkingText( text ) {
    self.blinkingText = self createServerFontString( "bigfixed", 3.5 );
    self.blinkingText setText( text );
    self.blinkingText setPoint( "CENTER", "CENTER" );

    self thread blinkText(); 
}

destroyBlinkingText() {
    self.blinkingText Destroy();
}

blinkText() {
    while (isDefined(self.blinkingText)) {
        self.blinkingText.alpha = 1; 
        wait .2;
        self.blinkingText.alpha = 0;
        wait .2;
    }
}