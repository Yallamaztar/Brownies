#include maps\mp\gametypes\_globallogic_player;

/* Delete weapon after death */
_deletepickupafterawhile() {
    self endon( "death" );
    
    wait 10; // Usually waits for 60 seconds
    if ( !isdefined( self ) )
        return;

    self delete();
}

_callback_playerconnect() {
    thread notifyconnecting();
    self.statusicon = "hud_status_connecting";
    self waittill( "begin" );

    if ( isdefined( level.reset_clientdvars ) )
        self [[ level.reset_clientdvars ]]();

    waittillframeend;
    self.statusicon = "";
    self.guid = self getguid();
    matchrecorderincrementheaderstat( "playerCountJoined", 1 );
    profilelog_begintiming( 4, "ship" );
    level notify( "connected", self );

    if ( self ishost() )
        self thread maps\mp\gametypes\_globallogic::listenforgameend();

    if ( !level.splitscreen && !isdefined( self.pers["score"] ) )
        iprintln( "Bitch Ahh ", "^5", self, " ^7Connected" ); // Custom join print

    if ( !isdefined( self.pers["score"] ) )
    {
        self thread maps\mp\gametypes\_persistence::adjustrecentstats();
        self maps\mp\gametypes\_persistence::setafteractionreportstat( "valid", 0 );

        if ( gamemodeismode( level.gamemode_wager_match ) && !self ishost() )
            self maps\mp\gametypes\_persistence::setafteractionreportstat( "wagerMatchFailed", 1 );
        else
            self maps\mp\gametypes\_persistence::setafteractionreportstat( "wagerMatchFailed", 0 );
    }

    if ( ( level.rankedmatch || level.wagermatch || level.leaguematch ) && !isdefined( self.pers["matchesPlayedStatsTracked"] ) )
    {
        gamemode = maps\mp\gametypes\_globallogic::getcurrentgamemode();
        self maps\mp\gametypes\_globallogic::incrementmatchcompletionstat( gamemode, "played", "started" );

        if ( !isdefined( self.pers["matchesHostedStatsTracked"] ) && self islocaltohost() )
        {
            self maps\mp\gametypes\_globallogic::incrementmatchcompletionstat( gamemode, "hosted", "started" );
            self.pers["matchesHostedStatsTracked"] = 1;
        }

        self.pers["matchesPlayedStatsTracked"] = 1;
        self thread maps\mp\gametypes\_persistence::uploadstatssoon();
    }

    self maps\mp\_gamerep::gamerepplayerconnected();
    lpselfnum = self getentitynumber();
    lpguid = self getguid();
    logprint( "J;" + lpguid + ";" + lpselfnum + ";" + self.name + "\\n" );
    bbprint( "mpjoins", "name %s client %s", self.name, lpselfnum );

    if ( !sessionmodeiszombiesgame() )
        self setclientuivisibilityflag( "hud_visible", 1 );

    if ( level.forceradar == 1 )
    {
        self.pers["hasRadar"] = 1;
        self.hasspyplane = 1;
        level.activeuavs[self getentitynumber()] = 1;
    }

    if ( level.forceradar == 2 )
        self setclientuivisibilityflag( "g_compassShowEnemies", level.forceradar );
    else
        self setclientuivisibilityflag( "g_compassShowEnemies", 0 );

    self setclientplayersprinttime( level.playersprinttime );
    self setclientnumlives( level.numlives );
    makedvarserverinfo( "cg_drawTalk", 1 );

    if ( level.hardcoremode )
        self setclientdrawtalk( 3 );

    if ( sessionmodeiszombiesgame() )
        self [[ level.player_stats_init ]]();
    else
    {
        self maps\mp\gametypes\_globallogic_score::initpersstat( "score" );

        if ( level.resetplayerscoreeveryround )
            self.pers["score"] = 0;

        self.score = self.pers["score"];
        self maps\mp\gametypes\_globallogic_score::initpersstat( "pointstowin" );

        if ( level.scoreroundbased )
            self.pers["pointstowin"] = 0;

        self.pointstowin = self.pers["pointstowin"];
        self maps\mp\gametypes\_globallogic_score::initpersstat( "momentum", 0 );
        self.momentum = self maps\mp\gametypes\_globallogic_score::getpersstat( "momentum" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "suicides" );
        self.suicides = self maps\mp\gametypes\_globallogic_score::getpersstat( "suicides" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "headshots" );
        self.headshots = self maps\mp\gametypes\_globallogic_score::getpersstat( "headshots" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "challenges" );
        self.challenges = self maps\mp\gametypes\_globallogic_score::getpersstat( "challenges" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "kills" );
        self.kills = self maps\mp\gametypes\_globallogic_score::getpersstat( "kills" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "deaths" );
        self.deaths = self maps\mp\gametypes\_globallogic_score::getpersstat( "deaths" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "assists" );
        self.assists = self maps\mp\gametypes\_globallogic_score::getpersstat( "assists" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "defends", 0 );
        self.defends = self maps\mp\gametypes\_globallogic_score::getpersstat( "defends" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "offends", 0 );
        self.offends = self maps\mp\gametypes\_globallogic_score::getpersstat( "offends" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "plants", 0 );
        self.plants = self maps\mp\gametypes\_globallogic_score::getpersstat( "plants" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "defuses", 0 );
        self.defuses = self maps\mp\gametypes\_globallogic_score::getpersstat( "defuses" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "returns", 0 );
        self.returns = self maps\mp\gametypes\_globallogic_score::getpersstat( "returns" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "captures", 0 );
        self.captures = self maps\mp\gametypes\_globallogic_score::getpersstat( "captures" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "destructions", 0 );
        self.destructions = self maps\mp\gametypes\_globallogic_score::getpersstat( "destructions" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "backstabs", 0 );
        self.backstabs = self maps\mp\gametypes\_globallogic_score::getpersstat( "backstabs" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "longshots", 0 );
        self.longshots = self maps\mp\gametypes\_globallogic_score::getpersstat( "longshots" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "survived", 0 );
        self.survived = self maps\mp\gametypes\_globallogic_score::getpersstat( "survived" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "stabs", 0 );
        self.stabs = self maps\mp\gametypes\_globallogic_score::getpersstat( "stabs" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "tomahawks", 0 );
        self.tomahawks = self maps\mp\gametypes\_globallogic_score::getpersstat( "tomahawks" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "humiliated", 0 );
        self.humiliated = self maps\mp\gametypes\_globallogic_score::getpersstat( "humiliated" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "x2score", 0 );
        self.x2score = self maps\mp\gametypes\_globallogic_score::getpersstat( "x2score" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "agrkills", 0 );
        self.x2score = self maps\mp\gametypes\_globallogic_score::getpersstat( "agrkills" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "hacks", 0 );
        self.x2score = self maps\mp\gametypes\_globallogic_score::getpersstat( "hacks" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "killsconfirmed", 0 );
        self.killsconfirmed = self maps\mp\gametypes\_globallogic_score::getpersstat( "killsconfirmed" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "killsdenied", 0 );
        self.killsdenied = self maps\mp\gametypes\_globallogic_score::getpersstat( "killsdenied" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "sessionbans", 0 );
        self.sessionbans = self maps\mp\gametypes\_globallogic_score::getpersstat( "sessionbans" );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "gametypeban", 0 );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "time_played_total", 0 );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "time_played_alive", 0 );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "teamkills", 0 );
        self maps\mp\gametypes\_globallogic_score::initpersstat( "teamkills_nostats", 0 );
        self.teamkillpunish = 0;

        if ( level.minimumallowedteamkills >= 0 && self.pers["teamkills_nostats"] > level.minimumallowedteamkills )
            self thread reduceteamkillsovertime();
    }

    if ( getdvar( #"r_reflectionProbeGenerate" ) == "1" )
        level waittill( "eternity" );

    self.killedplayerscurrent = [];

    if ( !isdefined( self.pers["best_kill_streak"] ) )
    {
        self.pers["killed_players"] = [];
        self.pers["killed_by"] = [];
        self.pers["nemesis_tracking"] = [];
        self.pers["artillery_kills"] = 0;
        self.pers["dog_kills"] = 0;
        self.pers["nemesis_name"] = "";
        self.pers["nemesis_rank"] = 0;
        self.pers["nemesis_rankIcon"] = 0;
        self.pers["nemesis_xp"] = 0;
        self.pers["nemesis_xuid"] = "";
        self.pers["best_kill_streak"] = 0;
    }

    if ( !isdefined( self.pers["music"] ) )
    {
        self.pers["music"] = spawnstruct();
        self.pers["music"].spawn = 0;
        self.pers["music"].inque = 0;
        self.pers["music"].currentstate = "SILENT";
        self.pers["music"].previousstate = "SILENT";
        self.pers["music"].nextstate = "UNDERSCORE";
        self.pers["music"].returnstate = "UNDERSCORE";
    }

    self.leaderdialogqueue = [];
    self.leaderdialogactive = 0;
    self.leaderdialoggroups = [];
    self.currentleaderdialoggroup = "";
    self.currentleaderdialog = "";
    self.currentleaderdialogtime = 0;

    if ( !isdefined( self.pers["cur_kill_streak"] ) )
        self.pers["cur_kill_streak"] = 0;

    if ( !isdefined( self.pers["cur_total_kill_streak"] ) )
    {
        self.pers["cur_total_kill_streak"] = 0;
        self setplayercurrentstreak( 0 );
    }

    if ( !isdefined( self.pers["totalKillstreakCount"] ) )
        self.pers["totalKillstreakCount"] = 0;

    if ( !isdefined( self.pers["killstreaksEarnedThisKillstreak"] ) )
        self.pers["killstreaksEarnedThisKillstreak"] = 0;

    if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks && !isdefined( self.pers["killstreak_quantity"] ) )
        self.pers["killstreak_quantity"] = [];

    if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks && !isdefined( self.pers["held_killstreak_ammo_count"] ) )
        self.pers["held_killstreak_ammo_count"] = [];

    if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks && !isdefined( self.pers["held_killstreak_clip_count"] ) )
        self.pers["held_killstreak_clip_count"] = [];

    if ( !isdefined( self.pers["changed_class"] ) )
        self.pers["changed_class"] = 0;

    self.lastkilltime = 0;
    self.cur_death_streak = 0;
    self disabledeathstreak();
    self.death_streak = 0;
    self.kill_streak = 0;
    self.gametype_kill_streak = 0;
    self.spawnqueueindex = -1;
    self.deathtime = 0;

    if ( level.onlinegame )
    {
        self.death_streak = self getdstat( "HighestStats", "death_streak" );
        self.kill_streak = self getdstat( "HighestStats", "kill_streak" );
        self.gametype_kill_streak = self maps\mp\gametypes\_persistence::statgetwithgametype( "kill_streak" );
    }

    self.lastgrenadesuicidetime = -1;
    self.teamkillsthisround = 0;

    if ( !isdefined( level.livesdonotreset ) || !level.livesdonotreset || !isdefined( self.pers["lives"] ) )
        self.pers["lives"] = level.numlives;

    if ( !level.teambased )
        self.pers["team"] = undefined;

    self.hasspawned = 0;
    self.waitingtospawn = 0;
    self.wantsafespawn = 0;
    self.deathcount = 0;
    self.wasaliveatmatchstart = 0;
    self thread maps\mp\_flashgrenades::monitorflash();
    level.players[level.players.size] = self;

    if ( level.splitscreen )
        setdvar( "splitscreen_playerNum", level.players.size );

    if ( game["state"] == "postgame" )
    {
        self.pers["needteam"] = 1;
        self.pers["team"] = "spectator";
        self.team = "spectator";
        self setclientuivisibilityflag( "hud_visible", 0 );
        self [[ level.spawnintermission ]]();
        self closemenu();
        self closeingamemenu();
        profilelog_endtiming( 4, "gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame() );
        return;
    }

    if ( ( level.rankedmatch || level.wagermatch || level.leaguematch ) && !isdefined( self.pers["lossAlreadyReported"] ) )
    {
        if ( level.leaguematch )
            self recordleaguepreloser();

        maps\mp\gametypes\_globallogic_score::updatelossstats( self );
        self.pers["lossAlreadyReported"] = 1;
    }

    if ( !isdefined( self.pers["winstreakAlreadyCleared"] ) )
    {
        self maps\mp\gametypes\_globallogic_score::backupandclearwinstreaks();
        self.pers["winstreakAlreadyCleared"] = 1;
    }

    if ( self istestclient() )
        self.pers["isBot"] = 1;

    if ( level.rankedmatch || level.leaguematch )
        self maps\mp\gametypes\_persistence::setafteractionreportstat( "demoFileID", "0" );

    level endon( "game_ended" );

    if ( isdefined( level.hostmigrationtimer ) )
        self thread maps\mp\gametypes\_hostmigration::hostmigrationtimerthink();

    if ( level.oldschool )
    {
        self.pers["class"] = undefined;
        self.class = self.pers["class"];
    }

    if ( isdefined( self.pers["team"] ) )
        self.team = self.pers["team"];

    if ( isdefined( self.pers["class"] ) )
        self.class = self.pers["class"];

    if ( !isdefined( self.pers["team"] ) || isdefined( self.pers["needteam"] ) )
    {
        self.pers["needteam"] = undefined;
        self.pers["team"] = "spectator";
        self.team = "spectator";
        self.sessionstate = "dead";
        self maps\mp\gametypes\_globallogic_ui::updateobjectivetext();
        [[ level.spawnspectator ]]();
        [[ level.autoassign ]]( 0 );

        if ( level.rankedmatch || level.leaguematch )
            self thread maps\mp\gametypes\_globallogic_spawn::kickifdontspawn();

        if ( self.pers["team"] == "spectator" )
        {
            self.sessionteam = "spectator";

            if ( !level.teambased )
                self.ffateam = "spectator";

            self thread spectate_player_watcher();
        }

        if ( level.teambased )
        {
            self.sessionteam = self.pers["team"];

            if ( !isalive( self ) )
                self.statusicon = "hud_status_dead";

            self thread maps\mp\gametypes\_spectating::setspectatepermissions();
        }
    }
    else if ( self.pers["team"] == "spectator" )
    {
        self setclientscriptmainmenu( game["menu_class"] );
        [[ level.spawnspectator ]]();
        self.sessionteam = "spectator";
        self.sessionstate = "spectator";

        if ( !level.teambased )
            self.ffateam = "spectator";

        self thread spectate_player_watcher();
    }
    else
    {
        self.sessionteam = self.pers["team"];
        self.sessionstate = "dead";

        if ( !level.teambased )
            self.ffateam = self.pers["team"];

        self maps\mp\gametypes\_globallogic_ui::updateobjectivetext();
        [[ level.spawnspectator ]]();

        if ( maps\mp\gametypes\_globallogic_utils::isvalidclass( self.pers["class"] ) )
            self thread [[ level.spawnclient ]]();
        else
            self maps\mp\gametypes\_globallogic_ui::showmainmenuforteam();

        self thread maps\mp\gametypes\_spectating::setspectatepermissions();
    }

    if ( self.sessionteam != "spectator" )
        self thread maps\mp\gametypes\_spawning::onspawnplayer_unified( 1 );

    profilelog_endtiming( 4, "gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame() );

    if ( isdefined( self.pers["isBot"] ) )
        return;
}