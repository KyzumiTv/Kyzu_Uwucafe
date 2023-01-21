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

local MenuGarageUwucafe = RageUI.CreateMenu("Garage", "INTERACTION")

MenuGarageUwucafe.Display.Header = true

MenuGarageUwucafe.Closed = function()

    open = false

end



function OpenMenuGarageUwucafe()

    if open then

        open = false

        RageUI.Visible(MenuGarageUwucafe, false)

        return

    else

        open = true

        RageUI.Visible(MenuGarageUwucafe, true)

        CreateThread(function()

            while open do 

                RageUI.IsVisible(MenuGarageUwucafe, function()

                    RageUI.Separator("↓    ~o~Ranger    ~s~↓")

                    RageUI.Button("Ranger le véhicule", nil, {RightLabel = "~y~→→→"}, true, {

                        onSelected = function()

                            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)

                            if dist4 < 4 then

                                DeleteEntity(veh)

                                ESX.ShowAdvancedNotification("Uwucafe", "~y~Garage", "Le véhicule à bien été ranger !", "CHAR_ESTATE_AGENT", 1)

                                RageUI.CloseAll()

                            end

                        end

                    })

                    RageUI.Separator("↓     ~o~Véhicule     ~s~↓")

                    for k,v in pairs(Config.Vehicule) do 

                        RageUI.Button(v.Nom, nil, {RightLabel = "~y~→"}, true, {

                            onSelected = function()

                                Citizen.Wait(3000) -- Temps de spawn 1000 = 1 seconde

                                local car = GetHashKey(v.Spawn)

                                local retval = PlayerPedId()



                                RequestModel(car)

                                while not HasModelLoaded(car) do

                                    RequestModel(car)

                                    Citizen.Wait(0)

                                end

                                

                                local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))

                                local vehicle = CreateVehicle(car, -596.18, -1059.24, 22.33, 82.20, true, false)

                                SetEntityAsMissionEntity(vehicle, true, true)

                                local plaque = "Uwucafe"

                                SetVehicleNumberPlateText(vehicle, plaque) 

                                TriggerServerEvent('ddx_vehiclelock:givekey', 'no', GetVehicleNumberPlateText(vehicle))

                            end

                        })

                    end

                end)

            Wait(0)

            end

        end)

    end

end



Citizen.CreateThread(function()

    while true do 

        local wait = 750

        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'uwucafe' then

            for k in pairs(Config.Position.Garage) do 

                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

                local pos = Config.Position.Garage

                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)



                if dist <= 5.0 then 

                    wait = 0

                    DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  

                end



                if dist <= 2.0 then 

                    wait = 0

                    Visual.Subtitle(Config.TextGarage, 1)

                    if IsControlJustPressed(1,51) then

                        OpenMenuGarageUwucafe()

                    end

                end

            end

        end

    Citizen.Wait(wait)

    end

end)



-- PED MCDO
local leped = {
	{hash="g_m_m_casrn_01", x = -598.50, y = -1056.15, z = 22.33, a=178.58},
}

Citizen.CreateThread(function()
	for _, item2 in pairs(leped) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		ped2 = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
        local playerPed        = GetPlayerPed(-1)
        TaskStartScenarioInPlace(ped2, 'WORLD_HUMAN_STAND_IMPATIENT', 0, true)
		SetBlockingOfNonTemporaryEvents(ped2, true)
		FreezeEntityPosition(ped2, true)
		SetEntityInvincible(ped2, true)
	end
end)


