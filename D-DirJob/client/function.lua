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
--- BLIPS ---

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(dir.pos.blips.position.x, dir.pos.blips.position.y, dir.pos.blips.position.z)

    SetBlipSprite (blip, 147) -- Model du blip
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.80) -- Taille du blip
    SetBlipColour (blip, 1) -- Couleur du blip
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('dir') -- Nom du blip
    EndTextCommandSetBlipName(blip)
end)



function GetCloseVehi()
    local player = GetPlayerPed(-1)
    local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 4.0, 0, 70)
    local vCoords = GetEntityCoords(vehicle)
    DrawMarker(2, vCoords.x, vCoords.y, vCoords.z + 1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 102, 0, 170, 0, 1, 2, 0, nil, nil, 0)
end


function Coffredir()
    local Cdir = RageUI.CreateMenu("Coffre", "D.I.R", X, Y, "DirJOB", "DirJOB", nil, nil, nil, nil)
        RageUI.Visible(Cdir, not RageUI.Visible(Cdir))
            while Cdir do
            Citizen.Wait(0)
            RageUI.IsVisible(Cdir, true, true, true, function()

                RageUI.Separator("~y~↓ Objet ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            dirRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            dirDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                end, function()
                end)
            if not RageUI.Visible(Cdir) then
            Cdir = RMenu:DeleteType("Cdir", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 1000
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'dir' then
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, dir.pos.coffre.position.x, dir.pos.coffre.position.y, dir.pos.coffre.position.z)
            if jobdist <= 4.0 and dir.jeveuxmarker then
                Timer = 0
                DrawMarker(22, dir.pos.coffre.position.x, dir.pos.coffre.position.y, dir.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 125, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 2.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffredir()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)

function VestiaireDIR()
    local VestiaireDIR = RageUI.CreateMenu("Vestiaire", "D.I.R", X, Y, "DirJOB", "DirJOB", nil, nil, nil, nil)
    VestiaireDIR:SetRectangleBanner(150, 0, 0)
        RageUI.Visible(VestiaireDIR, not RageUI.Visible(VestiaireDIR))
            while VestiaireDIR do
            Citizen.Wait(0)
            RageUI.IsVisible(VestiaireDIR, true, true, true, function()

                RageUI.Separator("~y~↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Prendre son services",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformedir()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Terminer son services",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(VestiaireDIR) then
            VestiaireDIR = RMenu:DeleteType("Cdir", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 1000
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'dir' then
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, dir.pos.Vestiaire.position.x, dir.pos.Vestiaire.position.y, dir.pos.Vestiaire.position.z)
            if jobdist <= 4.0 and dir.jeveuxmarker then
                Timer = 0
                DrawMarker(22, dir.pos.Vestiaire.position.x, dir.pos.Vestiaire.position.y, dir.pos.Vestiaire.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 125, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 2.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au Vestiaire", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        VestiaireDIR()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)


-- Garage

function Garagedir()
  local Gdir = RageUI.CreateMenu("Garage", "D.I.R", X, Y, "DirJOB", "DirJOB", nil, nil, nil, nil)
  Gdir:SetRectangleBanner(150, 0, 0)
    RageUI.Visible(Gdir, not RageUI.Visible(Gdir))
        while Gdir do
            Citizen.Wait(0)
                RageUI.IsVisible(Gdir, true, true, true, function()

                    for k,v in pairs(Gdirvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCardir(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(Gdir) then
            Gdir = RMenu:DeleteType("Garage", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 1000
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'dir' then
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, dir.pos.garage.position.x, dir.pos.garage.position.y, dir.pos.garage.position.z)
            if dist3 <= 4.0 and dir.jeveuxmarker then
                Timer = 0
                DrawMarker(20, dir.pos.garage.position.x, dir.pos.garage.position.y, dir.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 125, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 2.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        Garagedir()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function spawnuniCardir(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, dir.pos.spawnvoiture.position.x, dir.pos.spawnvoiture.position.y, dir.pos.spawnvoiture.position.z, dir.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "DIR"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
end


itemstock = {}
function dirRetirerobjet()
    local Stockdir = RageUI.CreateMenu("Coffre", "D.I.R", X, Y, "DirJOB", "DirJOB", nil, nil, nil, nil)
    ESX.TriggerServerCallback('fdir:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stockdir, not RageUI.Visible(Stockdir))
        while Stockdir do
            Citizen.Wait(0)
                RageUI.IsVisible(Stockdir, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('fdir:getStockItem', v.name, tonumber(count))
                                    dirRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockdir) then
            Stockdir = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function dirDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "D.I.R", X, Y, "DirJOB", "DirJOB", nil, nil, nil, nil)
    ESX.TriggerServerCallback('fdir:getPlayerInventory', function(inventory)
        RageUI.Visible(StockPlayer, not RageUI.Visible(StockPlayer))
    while StockPlayer do
        Citizen.Wait(0)
            RageUI.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('fdir:putStockItems', item.name, tonumber(count))
                                            dirDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

function vuniformedir()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = dir.tenue.male
        else
            uniformObject = dir.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)end

function vcivil()
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
TriggerEvent('skinchanger:loadSkin', skin)
end)
end


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end


Citizen.CreateThread(function()
        while true do
            local Timer = 1000
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'dir' then
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, dir.pos.deleteveh.position.x, dir.pos.deleteveh.position.y, dir.pos.deleteveh.position.z)
            if dist3 <= 2.0 and dir.jeveuxmarker then
                Timer = 0
                DrawMarker(20, dir.pos.deleteveh.position.x, dir.pos.deleteveh.position.y, dir.pos.deleteveh.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 147, 112, 219, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 1.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~p~[E]~s~ pour supprimée ton véhicule", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        DeleteEntity(veh)
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

RegisterNetEvent('D-dir:Réparerclient')
AddEventHandler('D-dir:Réparerclient', function()
    local playerPed = PlayerPedId()
    local vehicle   = ESX.Game.GetVehicleInDirection()
    local coords    = GetEntityCoords(playerPed)

        if IsPedSittingInAnyVehicle(playerPed) then
            ESX.ShowNotification('Veuillez descendre de la voiture.')
            return
        end

            if DoesEntityExist(vehicle) then
                isBusy = true
                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                    Citizen.CreateThread(function()
                        Citizen.Wait(20000)
                            SetVehicleFixed(vehicle)
                            SetVehicleDeformationFixed(vehicle)
                            SetVehicleUndriveable(vehicle, false)
                            SetVehicleEngineOn(vehicle, true, true)
                            ClearPedTasksImmediately(playerPed)

                            ESX.ShowNotification('Le véhicule est réparer')
                            isBusy = false
                    end)
                    Citizen.CreateThread(function()
                        while isBusy == true do
                            Citizen.Wait(1)
                            DisableAllControlActions(0)
                            EnableControlAction(0, 1, true)
                            EnableControlAction(0, 2, true)
                        end
                    end)
            else
                ESX.ShowNotification('Aucun véhicule à proximiter')
            end
        end)

RegisterNetEvent('D-dir:Nettoyerclient')
AddEventHandler('D-dir:Nettoyerclient', function()
local playerPed = PlayerPedId()
local vehicle   = ESX.Game.GetVehicleInDirection()
local coords    = GetEntityCoords(playerPed)
    if IsPedSittingInAnyVehicle(playerPed) then
        ESX.ShowNotification('Veuillez sortir de la voiture?')
        return
    end
        if DoesEntityExist(vehicle) then
            isBusy = true
            TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
            Citizen.CreateThread(function()
            Citizen.Wait(10000)
            SetVehicleDirtLevel(vehicle, 0)
            ClearPedTasksImmediately(playerPed)
            ESX.ShowNotification('Voiture néttoyé')
            isBusy = false
            end)
        else
            ESX.ShowNotification('Aucun véhicule trouvée')
        end
    end)