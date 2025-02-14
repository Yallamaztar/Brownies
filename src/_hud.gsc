#include maps\mp\gametypes\_hud_util;

createWaterMark() {
    self.waterMark = level createServerFontString( "bigfixed", 1 );
    self.waterMark setText( "^5Brownies ^4Nuketown ^5Sniper ^4SND\n" + " \t\t " + "^7https://dsc.gg/browner" );
    self.waterMark setPoint( "TOP_RIGHT", "TOP_RIGHT", 30, -30 );
}

destroyWaterMark() {
    for ( x = 30; x <= 600; x += 0.1 ) 
        self.waterMark setPoint( "TOP_RIGHT", "TOP_RIGHT", x, -30 );
    
    wait 1;
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