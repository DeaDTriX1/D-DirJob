ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.esxGet, function(obj) ESX = obj end)
        Citizen.Wait(10)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)



function ServiceDIR()
    local ServiceDIR = RageUI.CreateMenu("Accueil de la D.I.R", "Que puis-je faire pour vous ?", X, Y, "DirJOB", "DirJOB", nil, nil, nil, nil)
    RageUI.Visible(ServiceDIR, not RageUI.Visible(ServiceDIR))
    while ServiceDIR do
        Citizen.Wait(0)
            RageUI.IsVisible(ServiceDIR, true, true, true, function()

			RageUI.ButtonWithStyle("Appeler un Membre de la dir ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
				if (Selected) then  
				TriggerServerEvent("genius:sendcall") 
                RageUI.Popup({message = "<C>~b~Votre appel à bien été pris en compte"})
				end
			end)  
            
    end, function()
	end)
	
        if not RageUI.Visible(ServiceDIR) then
            ServiceDIR = RMenu:DeleteType("ServiceDIR", true)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local Timer = 1000
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, dir.pos.RDV.position.x, dir.pos.RDV.position.y, dir.pos.RDV.position.z)
		if dist3 <= 3 then 
			Timer = 0
        DrawMarker(22, dir.pos.RDV.position.x, dir.pos.RDV.position.y, dir.pos.RDV.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 125, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
		end
		if dist3 <= 2.0 then 
                Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour ouvrir →→ ~b~L'accueil de la D.I.R", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            ServiceDIR()
                    end   
                end
        Citizen.Wait(Timer)
    end
end)
