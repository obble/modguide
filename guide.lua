
	_G 			= getfenv(0)
	local H 	= {}

	H.FCF_SelectDockFrame = FCF_SelectDockFrame

	local SelectDockFrame = function(f)
		H.FCF_SelectDockFrame(f)
		local vg    = _G['VG_MainFrame']
		local vgs 	= _G['VG_SettingsFrame']
        if  vg then
        	if  f == ChatFrame3 then
        		vg:Show()
	        	if  vgs.showthis then
	        		vgs:Show()
	        	end
	        else
	        	vg:Hide()
	        	if  vgs:IsVisible() then
	        		vgs.showthis = true
	        		vgs:Hide()
	        	end
	        end
	    end
	end

	local AddGuide = function(parent)
		local vg = _G['VG_MainFrame']
		vg:Hide()
		vg:RegisterForDrag(nil)
		vg:SetPoint('TOPLEFT', 		parent)
		vg:SetPoint('BOTTOMRIGHT',	parent, 0, -6)
		vg:SetBackdrop(nil)
		vg:SetScript('OnMouseDown', nil)
		for _,  v in pairs({vg:GetChildren()}) do
			if  v:GetBackdrop() then
				v:SetBackdrop(nil)
			end
		end
	end

	local OnEvent = function(n)
		SetChatWindowShown(3, true)
		SetChatWindowName(3,  'Quests')
		ChatFrame_RemoveAllMessageGroups(ChatFrame3)
		ChatFrame_RemoveAllChannels(ChatFrame3)
		AddGuide(ChatFrame3)
	end

	FCF_SelectDockFrame = SelectDockFrame

	local e = CreateFrame'Frame'
	e:RegisterEvent'PLAYER_LOGIN'
	e:SetScript('OnEvent', OnEvent)

	--
