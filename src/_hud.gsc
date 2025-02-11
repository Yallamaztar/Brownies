#include maps\mp\gametypes\_hud_util;

createWaterMark() {
    self.waterMark = level createServerFontString("bigfixed", 1);
    self.waterMark setText("^5Brownies Nuketown ^7Sniper SND\n" + " \t\t " + "https://dsc.gg/browner");
    self.waterMark setPoint("TOP_RIGHT", "TOP_RIGHT", 30, -30);
}

destroyWaterMark() {
    self.waterMark Destroy();
}