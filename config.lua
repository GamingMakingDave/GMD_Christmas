Config = {}

Config.Local = "de"
Config.Debug = true -- set this false in Roleplay for settingup if you need true

Config.UseXmasWeather = true -- set false if you use other weather script

-- CHRISTMAS MARKET OPTIONS
Config.ChristmasMarket = vector3(-1662.180, -1082.309, 12.152) -- Christmas-market coords use middle!!
Config.ChristmasMarketRadius = 100.00 -- Play music on Christmas-market in radius!
Config.ChristmasMusicLink = "https://www.youtube.com/watch?v=lw-vF-ERE0w" -- link to you xmas music from youtube, look for Streamer Copyright Free music!!!
Config.ChristmasMusicVolume = 0.1 -- Music Volume

-- SANTA CLAUS OPRIONS
Config.SantaClausModel = "Santaclaus" -- Santa Ped Model
Config.SantaClausPosition = vector3(-1620.303, -1050.869, 12.151) -- Position from Santa
Config.SantaClausHeading = 149.264 -- Heading from Santa

-- DEER MISSION
Config.DeerZones = {
    {
        DeerCount = 5, -- Find Deer Count 
        DeerPedModel = "a_c_deer", -- Deer Ped Model
        DeerZonesRadius = 50.0, -- Deer wandering Radius

        DeerFinishedItem = "christmas_stocking", -- DO NOT CHANGE IF NO IDEA

        DeerRandomTicketCount = 5, -- Max Gold-Ticket count is all time random from 1 to DeerRandomTicketCount(5)
        GoldTicker = "gold_ticket", -- DO NOT CHANGE IF NO IDEA

        DeerFinishedSugarItems = 10, -- Max Item count is all time random from 1 to DeerFinishedSugarItems(10)
        DeerFinishedItems = {
            "sugar_cone",
            "santas_coffee",
            "santas_wine",
            "gingerbread"
            -- here can you add own items! 
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
         -- here you can add more random Coords for Deer spawn
        }
    }
}

-- GIFT JOB
Config.GiftJob = {
    {
        GiftItemName = "christmas_giftbox", -- ussage BzZzi´s gift prop
        GiftCount = 5, -- Max random Gift Count to finished Giftjob
        GiftRandomTicket = 4, -- Max random Gold-Ticket for Giftjob
        CoordsGift = {
            vector4(-935.000, -939.290, 2.145, 122.77),
            vector4(-913.426, -989.951, 2.150, 208.816),
            vector4(-908.531, -976.070, 2.150, 32.101),
            vector4(979.189, -716.249, 58.220, 128.602),
            vector4(970.915, -701.342, 58.481, 167.085),
            vector4(960.185, -669.820, 58.449, 120.918),
            vector4(965.179, -541.996, 59.725, 36.622),
            vector4(1009.657, -572.457, 60.594, 87.32),
            vector4(1090.455, -484.386, 65.660, 259.081),
            vector4(1060.473, -378.126, 68.231, 44.45),
            vector4(919.674, -569.625, 58.366, 25.274),
            vector4(976.679, -580.641, 59.850, 209.872),
            vector4(315.906, 501.964, 153.179, 15.392),
            vector4(223.949, 513.589, 140.766, 227.328),
            vector4(167.404, 473.754, 142.513, 268.082),
            vector4(119.668, 494.253, 147.342, 278.534),
            vector4(57.750, 449.765, 147.031, 142.563)
            -- here you can add more random Coords for Giftjob to earn Tickets
        }
    }
}


-- LANGUAGES
Config.Language = {
    ['de'] = {
        ['santa_helptext'] = 'Drücke ~INPUT_PICKUP~ um mir zu helfen.',
        ['santa_distance_massage'] = 'Mein Rentier ist in der nähe halte deine Augen auf!',
        ['has_found_deer'] = 'Nutze nun das item was ich dir gegeben habe',
        ['santa_found_massage'] = 'Ho ho Ho HO, du hast eins meiner Rentiere gefunden dir fehlen noch %s meiner Rentiere!',

        -- Scaleform
        ['scaleform_big_text'] = 'MISSION PASSED',
        ['scaleform_small_text'] = 'HO ho HO... Du hast all meine Rentiere gefunden, hier ein Dankeschön für deine Mühe!',

        -- Giftjob
        ['npc_hello'] = 'Hi?',
        ['npc_thanks_for_gift'] = 'Ein Geschenk? Für mich Danke dir!',

        -- Item used
        ['used_sugar_cone'] = 'Du hast eine Zuckerstange gegessen.',
        ['used_gingerbread'] = 'Du hast ein Lebkuchen gegessen.',
        ['santas_coffee'] = 'Du hast Santas Kaffee getrunken, spürst du diese Energie?',
        ['santas_wine'] = 'Du hast Santas Wein getrunken, mensch ist der Start , dass erklärt seine Rotenbacken! Hucks'
    }
}