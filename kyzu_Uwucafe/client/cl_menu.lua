ESX = nil



local PlayerData = {}



RegisterNetEvent('esx:playerLoaded')

AddEventHandler('esx:playerLoaded', function(xPlayer)

    PlayerData = xPlayer

end)



RegisterNetEvent('esx:setJob')

AddEventHandler('esx:setJob', function(job)  

	PlayerData.job = job  

	Citizen.Wait(5000) 

end)



Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(10)

    end

    while ESX.GetPlayerData().job == nil do

		Citizen.Wait(10)

    end

    if ESX.IsPlayerLoaded() then



		ESX.PlayerData = ESX.GetPlayerData()



    end

end)



RegisterNetEvent('esx:playerLoaded')

AddEventHandler('esx:playerLoaded', function(xPlayer)

	ESX.PlayerData = xPlayer

end)



RegisterNetEvent('esx:setJob')

AddEventHandler('esx:setJob', function(job)

	ESX.PlayerData.job = job

end)




-- Menu --

local open = false

local MenuF6uwucafe = RageUI.CreateMenu("McDonal's", "INTERACTION")

local MenuAnnonceuwucafe = RageUI.CreateSubMenu(MenuF6uwucafe, "Annonce McDonal's", "INTERACTION")

MenuF6uwucafe.Display.Header = true

MenuF6uwucafe.Closed = function()

    open = false

end



function OpenMenuF6Uwucafe()

    if open then

        open = false

        RageUI.Visible(MenuF6uwucafe, false)

        return

    else

        open = true

        RageUI.Visible(MenuF6uwucafe, true)

        CreateThread(function()

            while open do 

                RageUI.IsVisible(MenuF6uwucafe, function()

                    RageUI.Separator("↓    ~o~Annonce    ~s~↓")

                    RageUI.Button("Annonce", nil, {RightLabel = "~y~→→→"}, true, {}, MenuAnnonceuwucafe)



                    RageUI.Separator("↓    ~o~Facture    ~s~↓")

                    RageUI.Button("Facture", nil, {RightLabel = "~y~→→"}, true, {
                        onSelected = function() 

                            local player, distance = ESX.Game.GetClosestPlayer()

                            local raison = ""

                            local montant = 0

                            AddTextEntry("FMMC_MPM_NA", "Objet de la facture")

                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)

                            while (UpdateOnscreenKeyboard() == 0) do

                                DisableAllControlActions(0)

                                Wait(0)

                            end

                            if (GetOnscreenKeyboardResult()) then

                                local result = GetOnscreenKeyboardResult()

                                if result then

                                    raison = result

                                    result = nil

                                    AddTextEntry("FMMC_MPM_NA", "Montant de la facture")

                                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)

                                    while (UpdateOnscreenKeyboard() == 0) do

                                        DisableAllControlActions(0)

                                        Wait(0)

                                    end

                                    if (GetOnscreenKeyboardResult()) then

                                        result = GetOnscreenKeyboardResult()

                                        if result then

                                            montant = result

                                            result = nil

                                            if player ~= -1 and distance <= 3.0 then

                                                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_uwucafe', ('uwucafe'), montant)

                                                TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)

                                            else

                                                ESX.ShowNotification("~r~Aucuns joueurs à proximité !")

                                            end

                                        end

                                    end

                                end

                            end

                        end

                    })



                    RageUI.Separator("↓    ~r~Fermeture    ~s~↓")

                    RageUI.Button("~r~Fermer", nil, {RightLabel = "~y~→→"}, true, {

                        onSelected = function()

                            RageUI.CloseAll()

                        end

                    })

                end)



                -- Menu Annonce

                RageUI.IsVisible(MenuAnnonceuwucafe, function()

                    RageUI.Separator("↓    ~y~Annonce    ~s~↓")

                    RageUI.Button("Annonce Ouverture", nil, {RightLabel = "~y~→"}, true, {

                        onSelected = function()

                            TriggerServerEvent('UwucafeJob:AnnonceOuverture')

                        end

                    })

                    RageUI.Button("Annonce Fermeture", nil, {RightLabel = "~y~→"}, true, {

                        onSelected = function()

                            TriggerServerEvent('UwucafeJob:AnnonceFermeture')

                        end

                    })

                    RageUI.Button("Annonce Recrutement", nil, {RightLabel = "~y~→"}, true, {

                        onSelected = function()

                            TriggerServerEvent('UwucafeJob:AnnonceRecrutement')

                        end

                    })



                    RageUI.Separator("↓    ~y~Personalisé    ~s~↓")

                    RageUI.Button("Annonce Personalisé", nil, {RightLabel = "~y~→→"}, true, {

                        onSelected = function()

                            local te = KeyboardInput("Message", "", 100)

                            ExecuteCommand("uwucafe " ..te)

                        end

                    })



                    RageUI.Button("Message Employer", nil, {RightLabel = "~y~→→"}, true, {

                        onSelected = function()

                            local info = 'employer'

                            local message = KeyboardInput('Message Employer', '', 40)

                            TriggerServerEvent('UwucafeJob:MessageEmployer', info, message)

                        end

                    })



                    RageUI.Separator("↓    ~r~Fermeture    ~s~↓")

                    RageUI.Button("~r~Fermer", nil, {RightLabel = "~y~→→"}, true, {

                        onSelected = function()

                            RageUI.CloseAll()

                        end

                    })

                end)

            Wait(0)

            end

        end)

    end

end



Keys.Register('F6', 'uwucafe', 'Ouvrir le menu F6 uwucafe', function()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'uwucafe' then

    	OpenMenuF6Uwucafe()

	end

end)



-- Function --

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 

    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)

    blockinput = true



    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 

        Citizen.Wait(0)

    end

        

    if UpdateOnscreenKeyboard() ~= 2 then

        local result = GetOnscreenKeyboardResult() 

        Citizen.Wait(500) 

        blockinput = false

        return result 

    else

        Citizen.Wait(500) 

        blockinput = false 

        return nil 

    end

end



RegisterNetEvent('UwucafeJob:MessageEmployer')

AddEventHandler('UwucafeJob:MessageEmployer', function(service, nom, message)

	if service == 'employer' then

		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)

		ESX.ShowAdvancedNotification('Message Uwucafe', '~y~Message:', 'Employer: ~g~'..nom..'\n~w~Message: ~g~'..message..'', 'CHAR_ESTATE_AGENT', 1)

		Wait(14000)

		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)	

	end

end)