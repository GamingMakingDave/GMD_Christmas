Config = {}

Config.Local = "de"

Config.UseXmasWeather = true

-- CHRISTMAS MARKET OPTIONS
Config.ChristmasMarket = vector3(-1662.180, -1082.309, 12.152)
Config.ChristmasMarketRadius = 100.00
Config.ChristmasMusicLink = "https://www.youtube.com/watch?v=lw-vF-ERE0w"
Config.ChristmasMusicVolume = 0.1

-- SANTA CLAUS OPRIONS
Config.SantaClausModel = "Santaclaus"
Config.SantaClausPosition = vector3(-1620.303, -1050.869, 12.151)
Config.SantaClausHeading = 149.264
Config.SantaClausRandoms = 50 

-- DEER MISSION
Config.DeerZones = {
    {
        DeerCount = 5,
        DeerRandom = 50,
        DeerPedModel = "a_c_deer",
        DeerZonesRadius = 50.0,
        DeerFinishedItem = "christmas_stocking",

        DeerRandomTicketCount = 5,
        GoldTicker = "gold_ticket",

        DeerFinishedSugarItems = 10,
        DeerFinishedItems = {
            "sugar_cone",
            "chocolate_santa_claus",
            "peanut_butter_reindeer_cookies",
            "gingerbread",
        },

        Coords = {
        vector4(767.221, -238.421, 66.114, 100.00),
        vector4(1140.305, 107.266, 80.788, 100.00),
        vector4(414.778, 756.583, 189.903, 100.00),
        vector4(1483.610, 1836.942, 107.414, 100.00),
        vector4(546.156, 2247.881, 64.274, 100.00),
        vector4(548.076, 2919.853, 39.086, 100.00),
        vector4(1055.152, 3172.583, 39.041, 100.00),
        vector4(2392.173, 3684.345, 55.845, 100.00),
        vector4(2953.103, 2789.059, 41.513, 100.00),
        vector4(1292.175, 2848.248, 49.363, 100.00),
        vector4(780.621, 2540.892, 74.860, 100.00)
        }
    }
}

-- GIFT JOB
Config.GiftJob = {
    {
        EnableChristmasDoorAnim = true,
        GiftItemName = "christmas_giftbox",
        GiftEntryRandom = 50,
        Coords = {
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562),
            vector3(106.989, 466.760, 147.562)
        }
    }
}


-- LANGUAGES
Config.Language = {
    ['de'] = {
        ['santa_helptext'] = 'Drücke ~INPUT_PICKUP~ um mir zu helfen.',
        ['has_found_deer'] = 'Nutze nun das item was ich dir gegeben habe'
    }
}