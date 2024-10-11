var/current_server
/world
    mob = /mob/new_player
    turf = /turf/simulated/wall/r_wall/cave
    area = /area/dunwell/surface
    view = "15x15"
    cache_lifespan = 0    //stops player uploaded stuff from being kept in the rsc past the current session
    sleep_offline = FALSE

var/story_id = 0
var/server_language = "EN"  
var/april_fools = FALSE
var/currentmaprotation = "Default"
var/date_string = time2text(world.realtime, "YYYY/MM-Month/DD-Day")
var/rtlog_path


#define RECOMMENDED_VERSION 514
/world/New()
    set waitfor = FALSE

    #ifdef NEARWEB_LIVE
        server_language = "IZ"  // For live servers, set the language to "IZ"
        current_server = "S1"   // Default server identifier for live setup
    #else
        server_language = "EN"  // Set to English for non-live servers
        current_server = "DEV"  // Identifier for dev environment
    #endif

    TgsNew(minimum_required_security_level = TGS_SECURITY_TRUSTED)
    tick_lag = 0.4

    for(var/obj/effect/landmark/mapinfo/L in landmarks_list)
        if (L.name == "mapinfo" && L.mapname != "Mini War")
            currentmaprotation = L.mapname
    load_configuration()

    if(config && config.server_name != null && config.server_suffix && world.port > 0)
        // Dumb and hardcoded but I don't care~
        config.server_name += " #[(world.port % 1000) / 100]"

    world_name()
    callHook("startup")
    load_admins()
    LoadBansjob()
    load_whitelist()

    if(!fexists("data/game_version.sav")) //This should only have to be run once.
        add_story_id()
    
    get_story_id()

    #ifdef NEARWEB_LIVE
        load_db_whitelist()
        load_db_bans()
        load_comrade_list()
        load_pigplus_list()
        load_villain_list()
        build_donations_list()
        get_story_id()
    #endif

    // Logging setup
    href_logfile = file("data/logs/[server_language]-[current_server]/STORY[story_id]-[date_string] hrefs.htm")
    diary = file("data/logs/[server_language]-[current_server]/STORY[story_id]-[date_string].log")
    diaryofmeanpeople = file("data/logs/[server_language]-[current_server]/STORY[story_id]-[date_string] Attack.log")
    diary << "\n\nStarting up. [time2text(world.timeofday, "hh:mm.ss")]\n---------------------"
    rtlog_path = file("data/logs/[server_language]-[current_server]/STORY[story_id]-[date_string] Runtime.log")
    diaryofmeanpeople << "\n\nStarting up. [time2text(world.timeofday, "hh:mm.ss")]\n---------------------"
    rtlog_path << "\n\nStarting up. [time2text(world.timeofday, "hh:mm.ss")]\n---------------------"
    changelog_hash = md5('html/changelog.html')    //used for telling if the changelog has changed recently

    jobban_loadbanfile()
    jobban_updatelegacybans()
    src.update_status()

    ..() // Ensures supertype's New() gets executed

    sleep_offline = 1
    populate_seed_list()
    src.update_status()
    world.log << "--†SERVER LANGUAGE†--"
    world.log << "[server_language] ON [src.port]"

    processScheduler = new
    thanatiGlobal = new
    master_controller = new /datum/controller/game_controller()

    spawn(1)
        processScheduler.setup()
        master_controller.setup()
        thanatiGlobal.setup()

    TgsInitializationComplete()

    spawn(3000)    //so we aren't adding to the round-start lag
        if(config.ToRban)
            ToRban_autoupdate()

#undef RECOMMENDED_VERSION

    return

// Database connection setup
#define FAILED_DB_CONNECTION_CUTOFF 5
var/failed_db_connections = 0

proc/setup_database_connection()
    if(failed_db_connections > FAILED_DB_CONNECTION_CUTOFF)    // Stop trying after 5 failed attempts
        return 0

    if(!dbcon)
        dbcon = new()

    var/user = sqllogin
    var/pass = sqlpass
    var/db = sqldb
    var/address = sqladdress
    var/port = sqlport

    dbcon.Connect("dbi:mysql:[db]:[address]:[port]", "[user]", "[pass]")
    if(dbcon.IsConnected())
        failed_db_connections = 0    // Reset failed attempts counter on success
        world.log << "Database connected successfully."
    else
        failed_db_connections++
        world.log << "Database connection failed: [dbcon.ErrorMsg()]"
    return dbcon.IsConnected()

proc/establish_db_connection()
    if(failed_db_connections > FAILED_DB_CONNECTION_CUTOFF)
        return 0
    if(!dbcon || !dbcon.IsConnected())
        return setup_database_connection()
    else
        return 1

#undef FAILED_DB_CONNECTION_CUTOFF