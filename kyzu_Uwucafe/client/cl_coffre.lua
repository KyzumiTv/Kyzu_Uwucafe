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

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

-- Menu --
local open = false
local MenuCoffreuwucafe = RageUI.CreateMenu("Coffre", "INTERACTION")
MenuCoffreuwucafe.Display.Header = true
MenuCoffreuwucafe.Closed = function()
    open = false
end

function OpenMenuCoffreuwucafe() 
    if open then 
        open = false
        RageUI.Visible(MenuCoffreuwucafe, false)
        return
    else
        open = true
        RageUI.Visible(MenuCoffreuwucafe, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(MenuCoffreuwucafe, function()
                    RageUI.Separator("↓     ~o~Coffre     ~s~↓")
                    RageUI.Button("Prendre", nil, {RightLabel = "~y~→→→"}, true, {
                        onSelected = function() 
                            OpenPrendreuwucafeMenu()
                            RageUI.CloseAll()
                        end
                    })

                    RageUI.Button("Déposer", nil, {RightLabel = "~y~→→→"}, true, {
                        onSelected = function() 
                            OpenDeposeruwucafeMenu()
                            RageUI.CloseAll()
                        end
                    })

                    RageUI.Separator("↓     ~r~Fermeture     ~s~↓")
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

Citizen.CreateThread(function()
    while true do
		local wait = 750
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'uwucafe' then
				for k in pairs(Config.Position.Coffre) do
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local pos = Config.Position.Coffre
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

				if dist <= Config.MarkerDistance then
					wait = 0
					DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
				end

				if dist <= 2.0 then
					wait = 0
					Visual.Subtitle(Config.TextCoffre, 1)
					if IsControlJustPressed(1,51) then
						OpenMenuCoffreuwucafe()
					end
				end
			end
		end
    Citizen.Wait(wait)
    end
end)

-- fonction --
function OpenPrendreuwucafeMenu()
	ESX.TriggerServerCallback('uwucafeJob:prendreitem', function(items)
		local elements = {}

		for i=1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'uwucafe',
			title    = 'Uwucafe stockage',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                css      = 'uwucafe',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('uwucafeJob:prendreitems', itemName, count)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenDeposeruwucafeMenu()
	ESX.TriggerServerCallback('uwucafeJob:inventairejoueur', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'police',
			title    = 'inventaire',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                css      = 'police',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('uwucafeJob:stockitem', itemName, count)

					Citizen.Wait(300)
					OpenDeposeruwucafeMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end
