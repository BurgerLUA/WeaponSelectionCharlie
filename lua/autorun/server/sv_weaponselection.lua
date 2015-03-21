local folder = "weaponselection2"

function FirstWeaponSpawn( ply )

	local storename = string.gsub(ply:SteamID(), ":", "_")

	if not file.Exists( folder, "DATA") then
		file.CreateDir( folder ) 
	end
	
	if not file.Exists( folder.."/"..storename .. ".txt", "DATA" ) then 
		file.Write( folder.."/"..storename..".txt", "weapon_cs_m4 weapon_cs_usp false false false false false" )
	end
	
	local weapon = file.Read(folder.."/"..storename ..".txt")
	
	local args = string.Explode( " " , weapon )
	
	
	ply:SetNWString("SelectionPrimary",args[1])
	ply:SetNWString("SelectionSecondary",args[2])
	
	ply:SetNWString("SelectionHE",args[3])
	ply:SetNWString("SelectionFlash",args[4])
	ply:SetNWString("SelectionSmoke",args[5])
	ply:SetNWString("SelectionKnife",args[6])
	ply:SetNWString("SelectionArmor",args[7])
	
end

hook.Add( "PlayerInitialSpawn", "Load Previous Loadout", FirstWeaponSpawn )


function GivePlayerAWeapon( ply, cmd, arg )

	local storename = string.gsub(ply:SteamID(), ":", "_")

	local weapon1
	local weapon2
	
	
	
	local args = string.Explode(" ", arg[1])
	
	
	--PrintTable(args)
	
	--if IsValid(args[1]) then
	
		if type(args[1]) ~= "string" then 
			print("Can someone tell " .. ply:Nick() .. " to stop being a faggot?")
		return end
	
		weapon1 = weapons.GetStored(args[1])

		if weapon1.Base ~= "weapon_cs_base" then
			print("Can someone tell " .. ply:Nick() .. " to seriously stop being a faggot?")
		return end

		if weapon1.WeaponType ~= "Primary" then
			print("I'm really going to have to tell " .. ply:Nick() .. " to seriously stop being a faggot myself.")
		return end
		
	--end
	
	--if IsValid(args[2]) then
	
		if type(args[2]) ~= "string" then 
			print("Can someone tell " .. ply:Nick() .. " to stop being a faggot?")
		return end
	
		weapon2 = weapons.GetStored(args[2])
		
		if weapon2.Base ~= "weapon_cs_base" then
			print("Can someone tell " .. ply:Nick() .. " to seriously stop being a faggot?")
		return end

		if weapon2.WeaponType ~= "Secondary" then
			print("I'm really going to have to tell " .. ply:Nick() .. " to seriously stop being a faggot myself.")
		return end
		
	--end
	
	--[[
	if IsValid(args[3]) then
		if args[3] == true then
			
		end
	end
	
	if IsValid(args[4]) then
		if args[3] == true then
		
		end
	end
	
	if IsValid(args[5]) then
		if args[3] == true then
		
		end
	end
	--]]
	

	--print("Player " .. ply:Nick() .. " wrote " .. arg[1] .. " to the file " .. folder.."/"..storename .. ".txt" )
	
	ply:SetNWString("SelectionPrimary",args[1])
	ply:SetNWString("SelectionSecondary",args[2])
	
	ply:SetNWString("SelectionHE",args[3])
	ply:SetNWString("SelectionFlash",args[4])
	ply:SetNWString("SelectionSmoke",args[5])
	ply:SetNWString("SelectionKnife",args[6])
	ply:SetNWString("SelectionArmor",args[7])
	
	local why = args[1] .. " " .. args[2] .. " " .. args[3] .. " " .. args[4] .. " " .. args[5] .. " " .. args[6] .. " " .. args[7]
	
	file.Write( folder.."/"..storename..".txt", why  )

end

concommand.Add("weapon_take", GivePlayerAWeapon)


function PlayerSpawn(ply)

	ply:StripAmmo()
	ply:StripWeapons()
	
	if ply:IsBot() == false then
	
		ply:Give("gmod_tool")
		ply:Give("weapon_physgun")

		local Secondary = ply:GetNWString("SelectionSecondary",nil)
		if Secondary ~= nil then
			ply:ConCommand("gm_giveswep " .. Secondary)
			--ply:Give(Secondary)
		end	
		
		local Primary = ply:GetNWString("SelectionPrimary",nil)
		if Primary ~= nil then
			ply:ConCommand("gm_giveswep " .. Primary)
			--ply:Give(Primary)
		end
		

		
		if ply:GetNWString("SelectionHE","false") == "true" then
			ply:Give("weapon_cs_he")
		end
		
		if ply:GetNWString("SelectionFlash","false") == "true" then
			ply:Give("weapon_cs_flash")
		end
		
		if ply:GetNWString("SelectionSmoke","false") == "true" then
			ply:Give("weapon_cs_smoke")
		end
		
		if ply:GetNWString("SelectionKnife","false") == "true" then
			ply:Give("weapon_cs_knife")
		end
		
		--[[
		if ply:GetNWString("SelectionArmor","false") == "true" then
			timer.Simple(0,function()
				ply:SetArmor(100)
			end)
		end
		--]]
		
		

	end
	
end

hook.Add("PlayerSpawn", "Player Spawn", PlayerSpawn)




