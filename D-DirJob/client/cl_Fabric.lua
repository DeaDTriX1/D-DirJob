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

function MenuFabrication()
    local Fabrication = RageUI.CreateMenu("", "Interactions", X, Y, "DirJOB", "DirJOB", nil, nil, nil, nil)
    RageUI.Visible(Fabrication, not RageUI.Visible(Fabrication))
    while Fabrication do
        Citizen.Wait(0)
            RageUI.IsVisible(Fabrication, true, true, true, function()

                RageUI.ButtonWithStyle("Fabrication d'un kit de : Réparation", nil,  {RightLabel = "→→"}, true, function(Hovered, Active, Selected, coords)
                    if Selected then
                        local playerPed = PlayerPedId()
                        isBusy = true
                        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                        Citizen.CreateThread(function()
                          Citizen.Wait(10000)
                        TriggerServerEvent('D-dir:réparation')
                        ClearPedTasks(playerPed)
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
                    end
                end)

                RageUI.ButtonWithStyle("Fabrication d'un kit de : Néttoyage", nil,  {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local playerPed = PlayerPedId()
                        isBusy = true
                        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                        Citizen.CreateThread(function()
                          Citizen.Wait(10000)
                        TriggerServerEvent('D-dir:néttoyage')
                        ClearPedTasks(playerPed)
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
                    end
                end)

                end, function()
                end)

                if not RageUI.Visible(Fabrication) then
                    Fabrication = RMenu:DeleteType("dir", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 1000
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'dir' then
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, dir.pos.Fabrication.position.x, dir.pos.Fabrication.position.y, dir.pos.garage.position.z)
            if dist3 <= 3.0 and dir.jeveuxmarker then
                Timer = 0
                DrawMarker(20, dir.pos.Fabrication.position.x, dir.pos.Fabrication.position.y, dir.pos.Fabrication.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 125, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 2.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au Fabrication", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        MenuFabrication()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)