
	_G = getfenv(0)
	local H = {}

	H.FCF_OnUpdate = FCF_OnUpdate

	local OnUpdate = function(elapsed)
		H.FCF_OnUpdate(elapsed)
		local vg    = _G['VG_MainFrame']
		local vgs 	= _G['VG_SettingsFrame']
		if  vg and (MouseIsOver(ChatFrame1, 45, -10, -5, 5) or MouseIsOver(ChatFrame3, 45, -10, -5, 5)  or not vg.embedded) then
			if  ChatFrame3:IsShown() then
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
			vg.embedded = true
		end
	end

	local AddWindow = function(i)
		local _, _, _, _, _, _, shown = GetChatWindowInfo(i)
		if  not shown then
			SetChatWindowShown(3, true)
			SetChatWindowName(3,  'Quests')
			--[[for _, v in pairs(
				{
					ChatFrame3,
					ChatFrame3Tab,
				}
			) do
				v:Show()
			end]]
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
		AddWindow(3)
		ChatFrame_RemoveAllMessageGroups(ChatFrame3)
		ChatFrame_RemoveAllChannels(ChatFrame3)
		AddGuide(ChatFrame3)
	end

	FCF_OnUpdate = OnUpdate

	local e = CreateFrame'Frame'
	e:RegisterEvent'PLAYER_LOGIN'
	e:SetScript('OnEvent', OnEvent)

	--
