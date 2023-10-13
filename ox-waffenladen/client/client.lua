local weaponShopMenu = nil
local ePressed = false
local playerPed = nil
-- -- -- -- -- -- -- -- --

function CreateWeaponShopMenu()
	weaponShopMenu = NativeUI.CreateMenu("Waffenladen", "Wähle deine Waffe aus:")
	local banner = "stream/banner.png"
	local waffenladenBanner = NativeUI.CreateBanner(banner)
	weaponShopMenu:SetBannerType(waffenladenBanner)

for _, weapon in pairs(Config.Weapons) do
	local weaponItem = NativeUI.CreateItem(weapon.name, "$" .. weapon.price)
	weaponShopMenu:AddItem(weaponItem)
	print "OX-Waffenladen by xNiefo"
	weaponItem.Activated = function(ParentMenu, SelectedItem)
		TriggerServerEvent('buyWeapon', weapon.hash)
			ShowNotification("~g~Du hast ~r~" .. weapon.name .. "~g~gekauft!")
		end
	end
end

-- Gibt Spieler die gekaufte Waffe!
function GivePlayerWeapon(weaponHash)
	local playerPed = GetPlayerPed(-1)
	GiveWeaponToPed(playerPed, weaponHash, 100, false, true)
end

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function CheckForInteraction()
	while true do
		Citizen.Wait(0)
		if ePressed and DoesEntityExist(playerPed) then
			local playerCoords = GetEntityCoords(playerPed)
			local shopCoords = vector3(xxx, yyy, zzz)
			local distance = Vdist(playerCoords, shopCoords)

			if distance < 2.0 then
				if not weaponShopMenu:IsVisible() then
					weaponShopMenu:Visible(false)
				end
			end
		end
	end
end

Citizen.CreateThread(function()
	CreateWeaponShopMenu()

	while true do
		Citizen.Wait(0)
		ePressed = IsControlJustReleased(0, 51) -- Auf der Tastatur "E"

		if not DoesEntityExist(playerPed) then
			playerPed = GetPlayerPed(-1)
		end
	end
end)