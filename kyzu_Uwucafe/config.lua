Config = {


    MarkerType = 23, -- Pour voir les différents type de marker: https://docs.fivem.net/docs/game-references/markers/

    MarkerSizeLargeur = 0.7, -- Largeur du marker

    MarkerSizeEpaisseur = 0.7, -- Épaisseur du marker

    MarkerSizeHauteur = 0.7, -- Hauteur du marker

    MarkerDistance = 6.0, -- Distane de visibiliter du marker (1.0 = 1 mètre)

    MarkerColorR = 252, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8

    MarkerColorG = 186, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8

    MarkerColorB = 3, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8

    MarkerOpacite = 180, -- Opacité du marker (min: 0, max: 255)

    MarkerSaute = false, -- Si le marker saute (true = oui, false = non)

    MarkerTourne = true, -- Si le marker tourne (true = oui, false = non)



    TextCoffre = "Appuyez sur ~o~[E] ~s~pour accèder au ~o~coffre ~s~!", -- Text écris lors de l'approche du blip voir: https://discord.gg/dkHFBkBBPZ Channel couleur pour changer la couleur du texte 

    TextCuisine = "Appuyez sur ~o~[E] ~s~pour ~o~cuisiner ~s~!", -- Text écris lors de l'approche du blip voir: https://discord.gg/dkHFBkBBPZ Channel couleur pour changer la couleur du texte 

    TextStock = "Appuyez sur ~o~[E] ~s~pour pour accèder au ~o~stock ~s~!", -- Text écris lors de l'approche du blip voir: https://discord.gg/dkHFBkBBPZ Channel couleur pour changer la couleur du texte 

    TextBoisson = "Appuyez sur ~o~[E] ~s~pour pour accèder au ~o~boisson ~s~!", -- Text écris lors de l'approche du blip voir: https://discord.gg/dkHFBkBBPZ Channel couleur pour changer la couleur du texte 

    TextBoss = "Appuyez sur ~o~[E] ~s~pour pour accèder au ~o~action patron ~s~!", -- Text écris lors de l'approche du blip voir: https://discord.gg/dkHFBkBBPZ Channel couleur pour changer la couleur du texte 

    TextGarage = "Appuyez sur ~o~[E] ~s~pour accèder au ~o~garage ~s~!", -- Text écris lors de l'approche du blip voir: https://discord.gg/dkHFBkBBPZ Channel couleur pour changer la couleur du texte 



    Preparation = {

        {Nom = "Bubble Tea", ItemRequis = "the", ItemCuisiner = "bubbletea"},

        {Nom = "Mochi", ItemRequis = "patemochi", ItemCuisiner = "mochi"},

        {Nom = "PizzaChat", ItemRequis = "patepizza", ItemCuisiner = "pizzacat"},

        {Nom = "Latte", ItemRequis = "cafe", ItemCuisiner = "latte"},

    },



    Stock = {

        {Nom = "The", Item = "the"},

        {Nom = "Pate a mochi", Item = "patemochi"},

        {Nom = "Pate a pizza", Item = "patepizza"},

        {Nom = "Cafe", Item = "cafe"},

    },



    Boisson = {

        {Nom = "Coca-cola", Item = "coca"},

        {Nom = "Ice-Tea", Item = "icetea"},

        {Nom = "Mogu Mogu", Item = "mogu"},

    },



    Vehicule = {

        {Nom = "Deplacement", Spawn = "surge"},

        {Nom = "Camionnette", Spawn = "paradise"},

    },



    Position = {

        Coffre = {vector3(-588.56, -1068.01, 21.40)},

        Cuisine = {vector3(-590.43, -1056.63, 21.40)},

        Stock = {vector3(-590.45, -1063.16, 21.40)},

        Boisson = {vector3(-590.38, -1058.74, 21.40)},

        Boss = {vector3(-577.56, -1067.57, 25.70)},

        Garage = {vector3(-598.50, -1056.15, 21.40)},

    }



}

