local folder = "weaponselection2"

function FirstWeaponSpawn( ply )

	local storename = string.gsub(ply:SteamID(), ":", "_")

	if not file.Exists( folder, "DATA") then
		file.CreateDir( folder ) 
		--print(folder .. " doesn't exist, creating a new one.")
	else
		--print(folder .. " exists.")
	end
	
	--print("Folder:" .. folder)
	
	if not file.Exists( folder.."/"..storename .. ".txt", "DATA" ) then 
		file.Write( folder.."/"..storename..".txt", "weapon_cs_usp" )
		--print(folder.."/"..storename .. ".txt doesn't exist, creating a new one.")
	else	
		--print(folder.."/"..storename .. ".txt exists.")
	end
	
	local weapon = file.Read(folder.."/"..storename ..".txt")
	
	ply:SetNWString("SelectionSideArm",weapon)
	
end

hook.Add( "PlayerInitialSpawn", "Load Previous Loadout", FirstWeaponSpawn )


function GivePlayerAWeapon( ply, cmd, args )

	local storename = string.gsub(ply:SteamID(), ":", "_")

	if type(args[1]) ~= "string" then 
		print("Can someone tell " .. ply:Nick() .. " to stop being a faggot?")
	return end
	
	local weapon = weapons.GetStored(args[1])
	
	if weapon.Base ~= "weapon_cs_base" then
		print("Can someone tell " .. ply:Nick() .. " to seriously stop being a faggot?")
	return end
	
	if weapon.WeaponType ~= "Secondary" then
		print("I'm really going to have to tell " .. ply:Nick() .. " to seriously stop being a faggot myself.")
	return end
	

	--print("Player " .. ply:Nick() .. " wrote " .. args[1] .. " to the file " .. folder.."/"..storename .. ".txt" )
	
	file.Write( folder.."/"..storename..".txt", args[1]  )
	
	ply:SetNWString("SelectionSideArm",args[1])

	
	--ply:ChatPrint("Your loadout will change next spawn")

end
 
concommand.Add("weapon_take", GivePlayerAWeapon)


function PlayerSpawn(ply)

	ply:StripAmmo()
	ply:StripWeapons()
	
	if ply:IsBot() == false then
	
		ply:Give("gmod_tool")
		ply:Give("weapon_physgun")
		
		local weapon = ply:GetNWString("SelectionSideArm",nil)
		
		if weapon ~= nil then
			ply:ConCommand("gm_giveswep " .. weapon)
			
			--[[timer.Simple(1, function()
				for k,v in pairs( ply:GetWeapons() ) do
					if v:GetClass() == weapon then
						ply:SetActiveWeapon(v)
					end
				end
			end)--]]
			
			
		end
		
	end
	
end

hook.Add("PlayerSpawn", "Player Spawn", PlayerSpawn)




