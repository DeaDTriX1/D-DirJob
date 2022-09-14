ESX = nil
local Jobs = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'dir', 'Alerte dir', true, true)

TriggerEvent('esx_society:registerSociety', 'dir', 'dir', 'society_dir', 'society_dir', 'society_dir', {type = 'public'})

ESX.RegisterServerCallback('fdir:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_dir', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('fdir:getStockItem')
AddEventHandler('fdir:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_dir', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showAdvancedNotification', _source, 'Coffre', '~o~Informations~s~', 'Vous avez retiré ~r~'..inventoryItem.label.." x"..count, 'CHAR_MP_FM_CONTACT', 8)
		else
			TriggerClientEvent('esx:showAdvancedNotification', _source, 'Coffre', '~o~Informations~s~', "Quantité ~r~invalide", 'CHAR_MP_FM_CONTACT', 9)
		end
	end)
end)

ESX.RegisterServerCallback('fdir:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('fdir:putStockItems')
AddEventHandler('fdir:putStockItems', function(itemName, count)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_dir', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showAdvancedNotification', _src, 'Coffre', '~o~Informations~s~', 'Vous avez déposé ~g~'..inventoryItem.label.." x"..count, 'CHAR_MP_FM_CONTACT', 8)
		else
			TriggerClientEvent('esx:showAdvancedNotification', _src, 'Coffre', '~o~Informations~s~', "Quantité ~r~invalide", 'CHAR_MP_FM_CONTACT', 9)
		end
	end)
end)

RegisterServerEvent('fdir:Ouvert')
AddEventHandler('fdir:Ouvert', function()
	local name = GetPlayerName(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'D.I.R', '~y~Informations', 'La D.I.R est désormais Disponible!', 'CHAR_DIR', 2)
	end
	sendToDiscordWithSpecialURL("D.I.R", "Annonce de  "..name, 'La D.I.R est désormais Disponible !', 1942002, Config2.webhookDiscordfermer)
end)

RegisterServerEvent('fdir:Fermer')
AddEventHandler('fdir:Fermer', function()
	local name = GetPlayerName(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'D.I.R', '~y~Informations', 'La D.I.R est fermé!', 'CHAR_DIR', 2)
	end
	sendToDiscordWithSpecialURL("D.I.R", "Annonce de  "..name, 'La D.I.R est actuellement FERMER !', 1942002, Config2.webhookDiscordfermer)
end)

RegisterServerEvent('fdir:Perso')
AddEventHandler('fdir:Perso', function(msg)
	local name = GetPlayerName(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'D.I.R', '~y~Annonce', msg, 'CHAR_DIR', 8)
    end
    sendToDiscordWithSpecialURL("D.I.R", "Annonce de  "..name,  msg, 1942002, Config2.webhookDiscordperso)
end)


RegisterServerEvent("D-dir:Facture")
AddEventHandler("D-dir:Facture", function(name,montant)
	local name = GetPlayerName(source)
	sendToDiscordWithSpecialURL("D.I.R", "Facture de " ..name, montant, 1942002, Config2.webhookDiscordfacture)
end)

-- ADD Item

RegisterNetEvent('D-dir:réparation')
AddEventHandler('D-dir:réparation', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem('kitrepa', 1)
    TriggerClientEvent('esx:showNotification', source, "~g~Vous avez ~w~ Fabriquée ~b~1x Kit de réparation ! ")

end)

RegisterNetEvent('D-dir:néttoyage')
AddEventHandler('D-dir:néttoyage', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem('kitnettoyage', 1)
    TriggerClientEvent('esx:showNotification', source, "~g~Vous avez ~w~ Fabriquée ~b~1x Kit de Néttoyage ! ")
    
end)

-- Remove Item + Action coté client

RegisterNetEvent('D-dir:réparer')
AddEventHandler('D-dir:réparer', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem('kitrepa').count

    if xItem > 0  then

	    xPlayer.removeInventoryItem('kitrepa', 1)
	    TriggerClientEvent('D-dir:Réparerclient', source)
	    TriggerClientEvent('esx:showNotification', source, "~g~Vous avez ~w~ Utilisée ~b~1x Kit de réparation ! ")
	else
		TriggerClientEvent('esx:showNotification', source, "~g~Il vous ~w~ Manque ~b~1x Kit de réparation ! ")
    end    
end)

RegisterNetEvent('D-dir:nettoyé')
AddEventHandler('D-dir:nettoyé', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem('kitnettoyage').count

    if xItem > 0  then

	    xPlayer.removeInventoryItem('kitnettoyage', 1)
	    TriggerClientEvent('D-dir:Nettoyerclient', source)
	    TriggerClientEvent('esx:showNotification', source, "~g~Vous avez ~w~ Utilisée ~b~1x Kit de Néttoyage ! ")
	else
		TriggerClientEvent('esx:showNotification', source, "~g~Il vous ~w~ Manque ~b~1x Kit de Néttoyage ! ")
    end    
end)

-- Acueille

RegisterServerEvent('genius:sendcall')
AddEventHandler('genius:sendcall', function()
    
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'dir' then
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'D.I.R', '~r~Accueil', 'Un membre de la D.I.R est demandé à l\'accueil !', 'CHAR_DIR', 8)
        end
    end
end)


function sendToDiscordWithSpecialURL(name,message,des,color,url)
    local DiscordWebHook = url
	local embeds = {
		{
			["title"]=message,
			['description']=des,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
			["text"]= "",
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = name, avatar_url = "https://help.twitter.com/content/dam/help-twitter/brand/logo.png", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end