surface.CreateFont( "WeaponSelectionFont", {
	font = "Arial", 
	size = 64, 
	weight = 500, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = false, 
} )



function WeaponSelectionMenu()

	local x = ScrW()
	local y = ScrH()

	local size = 1/16
	
	local MenuBase = vgui.Create("DFrame")
	MenuBase:SetPos(x*size*0.5,x*size*0.5)
	MenuBase:SetSize(x - x*size, y - y*size)
	MenuBase:SetTitle("Weapon Selection")
	MenuBase:Center(true)
	MenuBase:SetDeleteOnClose(false)
	MenuBase:SetDraggable( true )
	MenuBase:SetBackgroundBlur(false)
	MenuBase:SetVisible( true )
	MenuBase.Paint = function()
		draw.RoundedBox( 8, 0, 0, MenuBase:GetWide(), MenuBase:GetTall(), Color( 0, 0, 0, 150 ) )
	end
	MenuBase:MakePopup()
	
	local PrimaryScroll = vgui.Create("DScrollPanel",MenuBase)
	PrimaryScroll:SetSize(MenuBase:GetWide()/4 - 10 - 10, MenuBase:GetTall() - 30 - 10)
	PrimaryScroll:SetPos(10, 30)
	
	local SecondaryScroll = vgui.Create("DScrollPanel",MenuBase)
	SecondaryScroll:SetSize(MenuBase:GetWide()/4 - 10 - 10, MenuBase:GetTall() - 30 - 10)
	SecondaryScroll:SetPos(10 + PrimaryScroll:GetWide(), 30)
	
	local PrimaryList = vgui.Create("DIconLayout",PrimaryScroll)
	PrimaryList:SetSize(PrimaryScroll:GetWide() - 20, PrimaryScroll:GetTall() - 20)
	PrimaryList:SetPos(0,0)
	PrimaryList:SetSpaceX(5)
	PrimaryList:SetSpaceY(5)
	
	local SecondaryList = vgui.Create("DIconLayout",SecondaryScroll)
	SecondaryList:SetSize(SecondaryScroll:GetWide() - 20, SecondaryScroll:GetTall() - 20)
	SecondaryList:SetPos(0,0)
	SecondaryList:SetSpaceX(5)
	SecondaryList:SetSpaceY(5)
	
	
	
	local WeaponTable = weapons.GetList()
	
	local PrimaryWeapons = {}
	local SecondaryWeapons = {}
	
	for i,SWEP in pairs(WeaponTable) do
		if SWEP.Base == "weapon_cs_base" then
			if SWEP.PrintName ~= "" and SWEP.PrintName ~= nil then
				if SWEP.Spawnable == true then
					if SWEP.WeaponType	== "Primary" then
						table.Add(PrimaryWeapons,{WeaponTable[i].ClassName})
					elseif SWEP.WeaponType	== "Secondary" then
						table.Add(SecondaryWeapons,{WeaponTable[i].ClassName})
					end
				end
			end
		end
	end
	
	

	


	table.sort(PrimaryWeapons)
	table.sort(SecondaryWeapons)
	
	local PrimaryPanel = {}
	local SecondaryPanel = {}
	
	
	for i,SWEP in pairs(PrimaryWeapons) do
		PrimaryPanel[i] = vgui.Create("ContentIcon")
		PrimaryList:Add(PrimaryPanel[i])
		PrimaryPanel[i]:SetMaterial("entities/" .. SWEP)
		PrimaryPanel[i]:SetName(weapons.Get(SWEP).PrintName)
		PrimaryPanel[i].DoClick = function() AddWeapon(SWEP) end
	end
	
	for i,SWEP in pairs(SecondaryWeapons) do
		SecondaryPanel[i] = vgui.Create("ContentIcon")
		SecondaryList:Add(SecondaryPanel[i])
		SecondaryPanel[i]:SetMaterial("entities/" .. SWEP)
		SecondaryPanel[i]:SetName(weapons.Get(SWEP).PrintName)
		SecondaryPanel[i].DoClick = function() AddWeapon(SWEP) end
	end
	
	
	
	local StoredPrimary = LocalPlayer():GetNWString("SelectionPrimary",nil)
	local StoredSecondary = LocalPlayer():GetNWString("SelectionSecondary",nil)
	
	local PrimarySelection = StoredPrimary
	local SecondarySelection = StoredSecondary
	
	--[[
	local SelectionText = vgui.Create("DLabel",MenuBase)
	SelectionText:SetPos(MenuBase:GetWide() - MenuBase:GetWide()/3, MenuBase:GetTall()/3 - 100  ) 
	SelectionText:SetFont("WeaponSelectionFont")
	SelectionText:SetText("Weapons")
	SelectionText:SizeToContents()
	--]]
	
	local PrimarySelectWeapon = vgui.Create("ContentIcon",MenuBase)
	PrimarySelectWeapon:SetPos(MenuBase:GetWide() - MenuBase:GetWide()/3, MenuBase:GetTall()/3) 
	PrimarySelectWeapon:SetMaterial("entities/" .. StoredPrimary)
	PrimarySelectWeapon:SetName(weapons.Get(StoredPrimary).PrintName)
	
	local SecondarySelectWeapon = vgui.Create("ContentIcon",MenuBase)
	SecondarySelectWeapon:SetPos(MenuBase:GetWide() - MenuBase:GetWide()/3 + PrimarySelectWeapon:GetWide(), MenuBase:GetTall()/3) 
	SecondarySelectWeapon:SetMaterial("entities/" .. StoredSecondary)
	SecondarySelectWeapon:SetName(weapons.Get(StoredSecondary).PrintName)
	
	local HECheckbox = vgui.Create( "DCheckBoxLabel", MenuBase )// Create the checkbox
	HECheckbox:SetPos(MenuBase:GetWide() - MenuBase:GetWide()/3, MenuBase:GetTall()/3 + 100 + 30) 
	HECheckbox:SetText("HE Grenade")
	HECheckbox:SetValue( 0 )
	HECheckbox:SizeToContents()
	HECheckbox.OnChange = function()
		HECheckbox.Bool = HECheckbox:GetChecked()
	end
	
	local FlashCheckbox = vgui.Create( "DCheckBoxLabel", MenuBase )// Create the checkbox
	FlashCheckbox:SetPos(MenuBase:GetWide() - MenuBase:GetWide()/3, MenuBase:GetTall()/3 + 100 + 30 + 20) 
	FlashCheckbox:SetText("Flash Grenade")
	FlashCheckbox:SetValue( 0 )
	FlashCheckbox:SizeToContents()
	FlashCheckbox.OnChange = function()
		FlashCheckbox.Bool = FlashCheckbox:GetChecked()
	end
	
	local SmokeCheckbox = vgui.Create( "DCheckBoxLabel", MenuBase )// Create the checkbox
	SmokeCheckbox:SetPos(MenuBase:GetWide() - MenuBase:GetWide()/3, MenuBase:GetTall()/3 + 100 + 30 + 20 + 20) 
	SmokeCheckbox:SetText("Smoke Grenade")
	SmokeCheckbox:SetValue( 0 )
	SmokeCheckbox:SizeToContents()
	SmokeCheckbox.OnChange = function()
		SmokeCheckbox.Bool = SmokeCheckbox:GetChecked()
	end	
	
	local KnifeCheckbox = vgui.Create( "DCheckBoxLabel", MenuBase )// Create the checkbox
	KnifeCheckbox:SetPos(MenuBase:GetWide() - MenuBase:GetWide()/3, MenuBase:GetTall()/3 + 100 + 30 + 20 + 20 + 20) 
	KnifeCheckbox:SetText("Combat Knife")
	KnifeCheckbox:SetValue( 0 )
	KnifeCheckbox:SizeToContents()
	KnifeCheckbox.OnChange = function()
		KnifeCheckbox.Bool = KnifeCheckbox:GetChecked()
	end
	
	local ArmorCheckbox = vgui.Create( "DCheckBoxLabel", MenuBase )// Create the checkbox
	ArmorCheckbox:SetPos(MenuBase:GetWide() - MenuBase:GetWide()/3, MenuBase:GetTall()/3 + 100 + 30 + 20 + 20 + 20 + 20) 
	ArmorCheckbox:SetText("100 Armor")
	ArmorCheckbox:SetValue( 0 )
	ArmorCheckbox:SizeToContents()
	ArmorCheckbox.OnChange = function()
		ArmorCheckbox.Bool = ArmorCheckbox:GetChecked()
	end
	
	if LocalPlayer():GetNWString("SelectionHE","false") == "true" then
		HECheckbox:SetChecked(true)
		HECheckbox.Bool = true
	end
	
	if LocalPlayer():GetNWString("SelectionFlash","false") == "true" then
		FlashCheckbox:SetChecked(true)
		FlashCheckbox.Bool = true
	end
	
	if LocalPlayer():GetNWString("SelectionSmoke","false") == "true" then
		SmokeCheckbox:SetChecked(true)
		SmokeCheckbox.Bool = true
	end
	
	if LocalPlayer():GetNWString("SelectionKnife","false") == "true" then
		KnifeCheckbox:SetChecked(true)
		KnifeCheckbox.Bool = true
	end
	
	if LocalPlayer():GetNWString("SelectionArmor","false") == "true" then
		ArmorCheckbox:SetChecked(true)
		ArmorCheckbox.Bool = true
	end

	function AddWeapon(class)
	
		local SWEP = weapons.Get(class)
	
		if SWEP.WeaponType == "Primary" then
			PrimarySelectWeapon:SetMaterial("entities/" .. class)
			PrimarySelectWeapon:SetName(SWEP.PrintName)
			
			PrimarySelection = class
			
			
		elseif SWEP.WeaponType == "Secondary" then
			SecondarySelectWeapon:SetMaterial("entities/" .. class)
			SecondarySelectWeapon:SetName(SWEP.PrintName)
			
			SecondarySelection = class
			
		end
		
		
		--chat.AddText( Color(255,255,255), "Selected ", Color(0,255,0), SWEP.PrintName , Color(255,255,255), " as a weapon." )
		--RunConsoleCommand("weapon_take",SWEP)
	end
	
	local ApplyButton = vgui.Create( "DButton",MenuBase )
	ApplyButton:SetPos(MenuBase:GetWide() - MenuBase:GetWide()/3, MenuBase:GetTall()/3 + 100 + 30 + 20 + 20 + 20 + 20 + 50) 
	ApplyButton:SetText( "Apply This Loadout" )
	ApplyButton:SetSize( 255, 60 )
	ApplyButton.DoClick = function()

		local text = PrimarySelection .. " " .. SecondarySelection
	

	
		if HECheckbox.Bool == true then
			text = text .. " " .. "true"
		else
			text = text .. " " .. "false"
		end
		

		if FlashCheckbox.Bool == true then
			text = text .. " " .. "true"
		else
			text = text .. " " .. "false"
		end
		
		if SmokeCheckbox.Bool == true then
			text = text .. " " .. "true"
		else
			text = text .. " " .. "false"
		end
		
		if KnifeCheckbox.Bool == true then
			text = text .. " " .. "true"
		else
			text = text .. " " .. "false"
		end
		
		if ArmorCheckbox.Bool == true then
			text = text .. " " .. "true"
		else
			text = text .. " " .. "false"
		end

		print(text)
		
		RunConsoleCommand("weapon_take",text)

	end
	
	
	
	
	

end

concommand.Add("selectweapon", WeaponSelectionMenu)

