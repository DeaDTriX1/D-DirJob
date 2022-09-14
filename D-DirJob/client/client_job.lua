ESX = nil

local PlayerData = {}


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

function Menuf6dir()
    local fdirf6 = RageUI.CreateMenu("", "Interactions", X, Y, "DirJOB", "DirJOB", nil, nil, nil, nil)
    local fdirf6Facture = RageUI.CreateSubMenu(fdirf6, "", "Facturation")
    local fdirf6Tarif = RageUI.CreateSubMenu(fdirf6Facture, "", "Tarif")
    local fdirf6Sub = RageUI.CreateSubMenu(fdirf6, "", "Annonces")
    local fdirf6veh = RageUI.CreateSubMenu(fdirf6, "", "Véhicule")
    RageUI.Visible(fdirf6, not RageUI.Visible(fdirf6))
    while fdirf6 do
        Citizen.Wait(0)
            RageUI.IsVisible(fdirf6, true, true, true, function()

                RageUI.ButtonWithStyle("Gestion Facturation/Tarif", nil,  {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                end, fdirf6Facture)

                RageUI.ButtonWithStyle("Gestion Annonce", nil,  {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                end, fdirf6Sub)

                RageUI.ButtonWithStyle("Gestion Véhicule", nil,  {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                end, fdirf6veh)

                end, function()
                end)

                RageUI.IsVisible(fdirf6veh, true, true, true, function()

                RageUI.Separator("~y~↓ Entretien ↓")

                RageUI.ButtonWithStyle("~b~Réparer le véhicule", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Active then
                        GetCloseVehi()
                        if Selected then
                            local target, distance = ESX.Game.GetClosestVehicle()
                            playerheading = GetEntityHeading(PlayerPedId())
                            playerlocation = GetEntityForwardVector(PlayerPedId())
                            playerCoords = GetEntityCoords(PlayerPedId())
                            if distance <= 2.0 then 
                                TriggerServerEvent('D-dir:réparer')
                            else
                                ESX.ShowNotification('Véhicule trop loin')
                            end
                        end
                    end
                end)

                RageUI.ButtonWithStyle("~b~Nettoyer le véhicule", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Active then
                        GetCloseVehi()
                        if Selected then
                            local target, distance = ESX.Game.GetClosestVehicle()
                            playerheading = GetEntityHeading(PlayerPedId())
                            playerlocation = GetEntityForwardVector(PlayerPedId())
                            playerCoords = GetEntityCoords(PlayerPedId())
                            if distance <= 2.0 then 
                                TriggerServerEvent('D-dir:nettoyé')
                            else
                                ESX.ShowNotification('Véhicule trop loin')
                            end
                        end
                    end
                end)

                RageUI.Separator("~y~↓ Outil de dépannage ↓")

                        RageUI.ButtonWithStyle("~b~👨‍🔧 Crocheter le véhicule", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                GetCloseVehi()
                            end
                            if Selected then
                                local playerPed = PlayerPedId()
                                local vehicle = ESX.Game.GetVehicleInDirection()
                                local coords = GetEntityCoords(playerPed)
                    
                                if IsPedSittingInAnyVehicle(playerPed) then
                                    RageUI.Popup({message = "<C>Sorter du véhicule"})
                                    return
                                end
                    
                                if DoesEntityExist(vehicle) then
                                    isBusy = true
                                    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
                                    Citizen.CreateThread(function()
                                        Citizen.Wait(10000)
                    
                                        SetVehicleDoorsLocked(vehicle, 1)
                                        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                                        ClearPedTasksImmediately(playerPed)
                                        RageUI.Popup({message = "<C>Véhicule dévérouiller"})
                                        isBusy = false
                                    end)
                                else
                                    RageUI.Popup({message = "<C>Pas de véhicule proche"})
                                end
                            end
                        end)

                RageUI.Separator("~y~↓ Autre ↓")

                        RageUI.ButtonWithStyle("~b~🚚  Mettre Véhicule en Fourriere", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                GetCloseVehi()
                            end
                            if (Selected) then
                                local playerPed = PlayerPedId()
                                if IsPedSittingInAnyVehicle(playerPed) then
                                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                                    if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                                        ESX.ShowNotification('vehicule ~r~mis en fourrière')
                                        ESX.Game.DeleteVehicle(vehicle)
                                    end
                                else
                                    local vehicle = ESX.Game.GetVehicleInDirection()

                                    if DoesEntityExist(vehicle) then
                                        ESX.Game.DeleteVehicle(vehicle)
                                    else
                                        ESX.ShowNotification('vous devez être ~r~près d\'un véhicule~s~ pour le mettre en fourrière')
                                    end
                                end
                            end
                        end)

                        RageUI.ButtonWithStyle("~b~🚚  Véhicule sur plateau", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                GetCloseVehi()
                            end
                            if (Selected) then
                                local playerPed = PlayerPedId()
                                local vehicle = GetVehiclePedIsIn(playerPed, true)

                                local towmodel = GetHashKey('flatbed')
                                local isVehicleTow = IsVehicleModel(vehicle, towmodel)

                                if isVehicleTow then
                                    local targetVehicle = ESX.Game.GetVehicleInDirection()

                                    if CurrentlyTowedVehicle == nil then
                                        if targetVehicle ~= 0 then
                                            if not IsPedInAnyVehicle(playerPed, true) then
                                                if vehicle ~= targetVehicle then
                                                    AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                                                    CurrentlyTowedVehicle = targetVehicle
                                                    ESX.ShowNotification('Véhicule Attaché avec succés')
                                                else
                                                    ESX.ShowNotification('~r~Impossible~s~ d\'attacher votre propre dépanneuse')
                                                end
                                            end
                                        else
                                            ESX.ShowNotification('il n\'y a ~r~pas de véhicule~s~ à attacher')
                                        end
                                    else
                                        AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                                        DetachEntity(CurrentlyTowedVehicle, true, true)

                                        CurrentlyTowedVehicle = nil
                                        ESX.ShowNotification('vehicule ~b~détattaché~s~ avec succès!')
                                    end
                                else
                                    ESX.ShowNotification('~r~Impossible! ~s~Vous devez avoir un ~b~Flatbed ~s~pour ça')
                                end
                                end
                            end)

                end, function() 
                end)

                RageUI.IsVisible(fdirf6Sub, true, true, true, function()

                RageUI.ButtonWithStyle("~b~Annonces d'ouverture",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('fdir:Ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("~b~Annonces de fermeture",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('fdir:Fermer')
                    end
                end)
        
                RageUI.ButtonWithStyle("~b~Personnalisé", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local msg = KeyboardInput("Message", "", 100)
                        TriggerServerEvent('fdir:Perso', msg)
                    end
                end)

                end, function() 
                end)

                RageUI.IsVisible(fdirf6Facture, true, true, true, function()

                RageUI.Separator("~y~↓ Facture ↓")

                RageUI.ButtonWithStyle("~b~Facture",nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if Selected then
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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_dir', ('Benny\'s'), montant)
                                            TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                            TriggerServerEvent('D-dir:Facture', GetPlayerName(PlayerPedId()), montant)
                                        else
                                            ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)

                RageUI.Separator("~y~↓ Tarif ↓")

                RageUI.ButtonWithStyle("~b~Menu Tarif", nil,  {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                end, fdirf6Tarif)

                end, function()
                end)

                RageUI.IsVisible(fdirf6Tarif, true, true, true, function()

                    RageUI.Separator("~y~↓ Liste des different tarif ↓")

                        for _, v in pairs (dir.Tarif) do
                            RageUI.ButtonWithStyle(v.depannage, nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                                local player, distance = ESX.Game.GetClosestPlayer()
                                if Selected then
                                    local raison = KeyboardInput("Validation Facture Appuyée sur ENTRER", 0)
                                    local raison = v.depannage
                                    if player ~= -1 and distance <= 3.0 then
                                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_dir', ('DIR'), v.montant)
                                        TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..v.montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                        TriggerServerEvent('D-dir:Facture', GetPlayerName(PlayerPedId()), v.montant)
                                    else
                                        ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                    end
                                end
                            end)
                        end


                end, function()
                end)

                if not RageUI.Visible(fdirf6) and not RageUI.Visible(fdirf6Sub) and not RageUI.Visible(fdirf6veh) and not RageUI.Visible(fdirf6Facture) and not RageUI.Visible(fdirf6Tarif) then
                    fdirf6 = RMenu:DeleteType("dir", true)
        end
    end
end

Keys.Register('F6', 'dir', 'Ouvrir le menu dir', function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'dir' then
        Menuf6dir()
    end
end)