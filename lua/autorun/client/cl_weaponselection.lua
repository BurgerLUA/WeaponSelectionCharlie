function WeaponSelectionMenu()

	local x = ScrW()
	local y = ScrH()

	local size = 1/2
	
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
	
	local Scroll = vgui.Create("DScrollPanel",MenuBase)
	Scroll:SetSize(MenuBase:GetWide()/2 - 10 - 10, MenuBase:GetTall() - 30 - 10)
	Scroll:SetPos(10, 30)
	
	
	local List = vgui.Create("DIconLayout",Scroll)
	--Scroll:AddItem(List)
	List:SetSize(Scroll:GetWide() - 20, Scroll:GetTall() - 20)
	List:SetPos(0,0)
	List:SetSpaceX(5)
	List:SetSpaceY(5)
	
	
	local WeaponTable = weapons.GetList()
	

	
	FilteredWeapons = {}
	
	for k,v in pairs(WeaponTable) do
		if v.Base == "weapon_cs_base" then
			if v.WeaponType == "Secondary" then
				if v.PrintName ~= "" and v.PrintName ~= nil then
					if v.Spawnable == true then
						table.Add(FilteredWeapons,{WeaponTable[k].ClassName})
					end
				end
			end
		end
	end
	
	--PrintTable(FilteredWeapons)
	
	table.sort(FilteredWeapons)
	
	local Panel = {}
	for l,b in pairs(FilteredWeapons) do
		Panel[l] = vgui.Create("ContentIcon")
		List:Add(Panel[l])
		--Panel[l]:SetSize(100,100)
		Panel[l]:SetMaterial("entities/" .. b)
		Panel[l]:SetName(weapons.Get(b).PrintName)
		Panel[l].DoClick = function() AddWeapon(b) end
	end
	
	local StoredWeapon = LocalPlayer():GetNWString("SelectionSideArm",nil)
	
	local SelectWeapon = vgui.Create("ContentIcon",MenuBase)
	SelectWeapon:SetPos(MenuBase:GetWide() - MenuBase:GetWide()/3, MenuBase:GetTall()/3) 
	SelectWeapon:SetMaterial("entities/" .. StoredWeapon)
	SelectWeapon:SetName(weapons.Get(StoredWeapon).PrintName)
	
	function AddWeapon(class)
		chat.AddText( Color(255,255,255), "Selected ", Color(0,255,0), weapons.Get(class).PrintName , Color(255,255,255), " as a weapon." )
		SelectWeapon:SetMaterial("entities/" .. class)
		SelectWeapon:SetName(weapons.Get(class).PrintName)
		RunConsoleCommand("weapon_take",class)
	end
	
	
	
	

end

concommand.Add("selectweapon", WeaponSelectionMenu)



function SortByName()



end


