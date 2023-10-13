local weaponPrices = {
	[GetHashKey("WEAPON_PISTOL")] = 35000,
	[GetHashKey("WEAPON_BAT")] = 5000,
	[GetHashKey("WEAPON_SWITCHBLADE")] = 8000,
}

RegisterNetEvent('buyWeapon')
AddEventHandler('buyWeapon', function(weaponHash)
	local source = source
	local player = PlayerId()
	local playerPed = GetPlayerPed(player)
	local playerMoney = GetPlayMoney(player)

	for _, weapon in pairs(Config.Weapons) do
		if weapon.hash == weaponHash then
			if playerMoney >= weapon.price then
				GiveWeaponToPed(playerPed, weaponHash, 100, false, true)
				RemoveMoneyFromPlayer(player, weapon.price)
			else

		TriggerClientEvent('notEnoughMoney', source)
			end
			break
		end
	end
end)