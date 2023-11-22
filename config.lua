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
        ['santa_helptext'] = 'Drücke ~INPUT_PICKUP~, um mir zu helfen.',
        ['santa_distance_massage'] = 'Mein Rentier ist in der Nähe, halte deine Augen offen!',
        ['has_found_deer'] = 'Benutze nun das Item, das ich dir gegeben habe.',
        ['santa_found_massage'] = 'Ho ho Ho HO, du hast eins meiner Rentiere gefunden. Dir fehlen noch %s meiner Rentiere!',

        -- Deer Searching
        ['DeerSearch_1'] = 'Mir sind meine Rentiere entlaufen und mit euren Geschenken abgehauen!!',
        ['DeerSearch_2'] = 'Kannst du sie suchen helfen?',
        ['DeerSearch_3'] = 'Ansonsten war es das mit dem Weihnachtsfest und ihr müsst ohne Geschenke auskommen!',
        ['DeerSearch_4'] = 'Hier hast du von mir eine Zuckerstange. Nutze dies, sobald du mein Rentier nah bist!',

        -- Scaleform
        ['scaleform_big_text'] = 'MISSION PASSED',
        ['scaleform_small_text'] = 'HO ho HO... Du hast all meine Rentiere gefunden. Hier ein Dankeschön für deine Mühe!',

        -- Giftjob
        ['npc_hello'] = 'Hi?',
        ['npc_thanks_for_gift'] = 'Ein Geschenk? Für mich? Danke dir!',

        -- Item used
        ['used_sugar_cone'] = 'Du hast eine Zuckerstange gegessen.',
        ['used_gingerbread'] = 'Du hast einen Lebkuchen gegessen.',
        ['santas_coffee'] = 'Du hast Santas Kaffee getrunken. Spürst du diese Energie?',
        ['santas_wine'] = 'Du hast Santas Wein getrunken. Mensch, ist der stark. Das erklärt seine roten Backen! Hucks',

        -- Oxlib Menu
        ['thanks_oxlib'] = 'Danke dir nochmals für deine Hilfe!',
        ['thanks_1_oxlib'] = 'Wenn du magst, könntest du mir helfen, Geschenke auszuliefern?',
        ['thanks_2_oxlib'] = 'Ich belohne dich mit goldenen Tickets.'
    },
    ['en'] = {
        ['santa_helptext'] = 'Press ~INPUT_PICKUP~ to help me.',
        ['santa_distance_massage'] = 'My reindeer is nearby, keep your eyes open!',
        ['has_found_deer'] = 'Now use the item I gave you.',
        ['santa_found_massage'] = 'Ho ho Ho HO, you found one of my reindeers. You still need %s more of my reindeers!',

        -- Deer Searching
        ['DeerSearch_1'] = 'My reindeers have escaped and run away with your gifts!!',
        ['DeerSearch_2'] = 'Can you help me find them?',
        ['DeerSearch_3'] = 'Otherwise, Christmas is over, and you\'ll have to do without gifts!',
        ['DeerSearch_4'] = 'Here\'s a candy cane from me. Use it when you\'re near my reindeer!',

        -- Scaleform
        ['scaleform_big_text'] = 'MISSION PASSED',
        ['scaleform_small_text'] = 'HO ho HO... You found all my reindeers. Here\'s a thank you for your effort!',

        -- Gift job
        ['npc_hello'] = 'Hi?',
        ['npc_thanks_for_gift'] = 'A gift? For me? Thank you!',

        -- Item used
        ['used_sugar_cone'] = 'You ate a candy cane.',
        ['used_gingerbread'] = 'You ate a gingerbread cookie.',
        ['santas_coffee'] = 'You drank Santa\'s coffee. Can you feel that energy?',
        ['santas_wine'] = 'You drank Santa\'s wine. Wow, that\'s a kick. That explains his rosy cheeks! Hucks',

        -- Oxlib Menu
        ['thanks_oxlib'] = 'Thank you again for your help!',
        ['thanks_1_oxlib'] = 'If you like, could you help me deliver gifts?',
        ['thanks_2_oxlib'] = 'I\'ll reward you with Golden Tickets.'
    },
    ['sp'] = {
        ['santa_helptext'] = 'Presiona ~INPUT_PICKUP~ para ayudarme.',
        ['santa_distance_massage'] = 'Mi reno está cerca, ¡mantén los ojos abiertos!',
        ['has_found_deer'] = 'Ahora usa el objeto que te di.',
        ['santa_found_massage'] = 'Ho ho Ho HO, encontraste uno de mis renos. ¡Todavía te faltan %s de mis renos!',
    
        -- Deer Searching
        ['DeerSearch_1'] = '¡Mis renos escaparon y huyeron con tus regalos!',
        ['DeerSearch_2'] = '¿Puedes ayudarme a encontrarlos?',
        ['DeerSearch_3'] = 'De lo contrario, la Navidad ha terminado y tendrás que prescindir de regalos.',
        ['DeerSearch_4'] = 'Aquí tienes un bastón de caramelo. ¡Úsalo cuando estés cerca de mi reno!',
    
        -- Scaleform
        ['scaleform_big_text'] = 'MISIÓN SUPERADA',
        ['scaleform_small_text'] = 'HO ho HO... Encontraste a todos mis renos. ¡Aquí tienes un agradecimiento por tu esfuerzo!',
    
        -- Gift job
        ['npc_hello'] = '¿Hola?',
        ['npc_thanks_for_gift'] = '¿Un regalo? ¿Para mí? ¡Gracias!',
    
        -- Item used
        ['used_sugar_cone'] = 'Comiste un bastón de caramelo.',
        ['used_gingerbread'] = 'Comiste una galleta de jengibre.',
        ['santas_coffee'] = 'Bebiste el café de Santa. ¿Sientes esa energía?',
        ['santas_wine'] = 'Bebiste el vino de Santa. Vaya, eso da un golpe. ¡Eso explica sus mejillas sonrosadas! Hucks',
    
        -- Oxlib Menu
        ['thanks_oxlib'] = '¡Gracias de nuevo por tu ayuda!',
        ['thanks_1_oxlib'] = 'Si quieres, ¿podrías ayudarme a entregar regalos?',
        ['thanks_2_oxlib'] = 'Te recompensaré con Golden Tickets.'
    },
    ['ru'] = {
        ['santa_helptext'] = 'Нажмите ~INPUT_PICKUP~, чтобы мне помочь.',
        ['santa_distance_massage'] = 'Мой олень рядом, держи глаза открытыми!',
        ['has_found_deer'] = 'Теперь используй предмет, который я тебе дал.',
        ['santa_found_massage'] = 'Хо-хо-хо, ты нашел одного из моих оленей. Тебе все еще нужно %s моих оленей!',
    
        -- Deer Searching
        ['DeerSearch_1'] = 'Мои олени сбежали и унесли ваши подарки!',
        ['DeerSearch_2'] = 'Можешь помочь мне их найти?',
        ['DeerSearch_3'] = 'В противном случае Рождество закончено, и вам придется обойтись без подарков!',
        ['DeerSearch_4'] = 'Вот тебе леденец от меня. Используй его, когда ты близок к моему оленю!',
    
        -- Scaleform
        ['scaleform_big_text'] = 'ЗАДАЧА ВЫПОЛНЕНА',
        ['scaleform_small_text'] = 'Хо-хо-хо... Ты нашел всех моих оленей. Вот тебе спасибо за твои усилия!',
    
        -- Gift job
        ['npc_hello'] = 'Привет?',
        ['npc_thanks_for_gift'] = 'Подарок? Для меня? Спасибо!',
    
        -- Item used
        ['used_sugar_cone'] = 'Ты поел леденец.',
        ['used_gingerbread'] = 'Ты поел пряник.',
        ['santas_coffee'] = 'Ты выпил кофе Санты. Чувствуешь эту энергию?',
        ['santas_wine'] = 'Ты выпил вино Санты. Вау, это удар, это объясняет его румяные щеки! Hucks',
    
        -- Oxlib Menu
        ['thanks_oxlib'] = 'Спасибо еще раз за твою помощь!',
        ['thanks_1_oxlib'] = 'Если хочешь, можешь помочь мне разносить подарки?',
        ['thanks_2_oxlib'] = 'Я вознагражу тебя Золотыми билетами.'
    },
    ['fr'] = {
        ['santa_helptext'] = 'Appuyez sur ~INPUT_PICKUP~ pour m\'aider.',
        ['santa_distance_massage'] = 'Mon renne est à proximité, gardez les yeux ouverts !',
        ['has_found_deer'] = 'Utilisez maintenant l\'objet que je vous ai donné.',
        ['santa_found_massage'] = 'Ho ho Ho HO, vous avez trouvé l\'un de mes rennes. Il vous manque encore %s de mes rennes !',

        -- Deer Searching
        ['DeerSearch_1'] = 'Mes rennes se sont échappés et ont fui avec vos cadeaux !',
        ['DeerSearch_2'] = 'Pouvez-vous m\'aider à les trouver ?',
        ['DeerSearch_3'] = 'Sinon, Noël est fini, et vous devrez vous passer de cadeaux !',
        ['DeerSearch_4'] = 'Voici une canne en bonbon de ma part. Utilisez-la lorsque vous êtes près de mon renne !',

        -- Scaleform
        ['scaleform_big_text'] = 'MISSION RÉUSSIE',
        ['scaleform_small_text'] = 'HO ho HO... Vous avez trouvé tous mes rennes. Voici un merci pour vos efforts !',

        -- Gift job
        ['npc_hello'] = 'Salut ?',
        ['npc_thanks_for_gift'] = 'Un cadeau ? Pour moi ? Merci !',

        -- Item used
        ['used_sugar_cone'] = 'Vous avez mangé une canne en bonbon.',
        ['used_gingerbread'] = 'Vous avez mangé un biscuit en pain d\'épice.',
        ['santas_coffee'] = 'Vous avez bu le café du Père Noël. Sentez-vous cette énergie ?',
        ['santas_wine'] = 'Vous avez bu le vin du Père Noël. Wow, c\'est un coup, cela explique ses joues roses ! Hucks',

        -- Oxlib Menu
        ['thanks_oxlib'] = 'Merci encore pour votre aide !',
        ['thanks_1_oxlib'] = 'Si vous le souhaitez, pourriez-vous m\'aider à livrer des cadeaux ?',
        ['thanks_2_oxlib'] = 'Je vous récompenserai avec des billets dorés.'
    }
}
