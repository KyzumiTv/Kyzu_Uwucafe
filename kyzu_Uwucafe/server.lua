TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'uwucafe', ('uwucafe'), true, true)
TriggerEvent('esx_society:registerSociety', 'uwucafe', 'uwucafe', 'society_uwucafe', 'society_uwucafe', 'society_uwucafe', {type = 'private'})

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

-- Gestion annonce
RegisterServerEvent('UwucafeJob:AnnonceOuverture')
AddEventHandler('UwucafeJob:AnnonceOuverture', function()
	local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Uwucafe', '~y~Annonce', 'Le cabinet uwucafe est désormais ~g~ouvert ~s~!', 'CHAR_ESTATE_AGENT', 1)
    end
end)

RegisterServerEvent('UwucafeJob:AnnonceFermeture')
AddEventHandler('UwucafeJob:AnnonceFermeture', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do 
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Uwucafe', '~y~Annonce', 'Le cabinet uwucafe est désormais ~r~fermer ~s~!', 'CHAR_ESTATE_AGENT', 1)
    end
end)

RegisterServerEvent('UwucafeJob:AnnonceRecrutement')
AddEventHandler('UwucafeJob:AnnonceRecrutement', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do 
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Uwucafe', '~y~Annonce', 'Le cabinet uwucafe ~y~recrute ~s~rendez-vous dans nos bureau ~y~pour plus d\'information ~s~!', 'CHAR_ESTATE_AGENT', 1)
    end
end)

RegisterCommand('uwucafe', function(source, args, rawCommand)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if xPlayer.job.name == "uwucafe" then
        local src = source
        local msg = rawCommand:sub(11)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'uwucafe', '~y~Annonce', ''..msg..'', 'CHAR_ESTATE_AGENT', 1)
            end
        else
            TriggerClientEvent('esx:showAdvancedNotification', _src, 'uwucafe', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_ESTATE_AGENT', 1)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _src, 'uwucafe', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_ESTATE_AGENT', 1)
    end
end)

RegisterCommand('uwucafe', function(source, args, rawCommand)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if xPlayer.job.name == "uwucafe" then
        local src = source
        local msg = rawCommand:sub(12)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'uwucafe' then
                    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'uwucafe', '~y~Annonce', ''..msg..'', 'CHAR_ESTATE_AGENT', 1)
                end
            end
        else
            TriggerClientEvent('esx:showAdvancedNotification', _src, 'uwucafe', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_ESTATE_AGENT', 1)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _src, 'uwucafe', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_ESTATE_AGENT', 1)
    end
end)

-- Coffre
RegisterServerEvent('uwucafeJob:prendreitems')
AddEventHandler('uwucafeJob:prendreitems', function(itemName, count)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_uwucafe', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then

			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _src, "quantité invalide")
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _src, 'Objet retiré', count, inventoryItem.label)
			end
		else
			TriggerClientEvent('esx:showNotification', _src, "quantité invalide")
		end
	end)
end)


RegisterNetEvent('uwucafeJob:stockitem')
AddEventHandler('uwucafeJob:stockitem', function(itemName, count)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_uwucafe', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _src, "Objet déposé "..count..""..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _src, "quantité invalide")
		end
	end)
end)


ESX.RegisterServerCallback('uwucafeJob:inventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('uwucafeJob:prendreitem', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_uwucafe', function(inventory)
		cb(inventory.items)
	end)
end)

-- Preparation
RegisterNetEvent('Uwucafe:Preparation')
AddEventHandler('Uwucafe:Preparation', function(Nom, ItemRequis, ItemCuisiner)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    local ItemBesoin = xPlayer.getInventoryItem(ItemRequis).count
    local ItemDonner = xPlayer.getInventoryItem(ItemCuisiner).count

    if ItemDonner > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Tu à ateint la limite')
    elseif ItemBesoin < 1 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il vous manques des ingredients')
    else
        xPlayer.removeInventoryItem(ItemRequis, 1)
        xPlayer.addInventoryItem(ItemCuisiner, 1)    
    end
end)

-- Stock
RegisterNetEvent('Uwucafe:GiveItem')
AddEventHandler('Uwucafe:GiveItem', function(Nom, Item)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    xPlayer.addInventoryItem(Item, 1)
end)
