-- EMERGENT GAME TECHNOLOGIES PROPRIETARY INFORMATION
--
-- This software is supplied under the terms of a license agreement or
-- nondisclosure agreement with Emergent Game Technologies and may not
-- be copied or disclosed except in accordance with the terms of that
-- agreement.
--
--      Copyright (c) 1996-2006 Emergent Game Technologies.
--      All Rights Reserved.
--
-- Emergent Game Technologies, Chapel Hill, North Carolina 27517
-- http://www.emergent.net
-----------------------------------------------------------------------------

	local strNone = "无"
	local strBlankSeq = "animation"
	local AllActorRoots = #()
	local ActorRoot = undefined
	local AccumRoot = undefined
	local LayerRoot = undefined
	local AllLayerRoots = #()
	local lastTime = 0.0
	local strActorRoot = "KFActorRoot"
	local strAccumRoot = "KFAccumRoot"
	local ActiveSequence = undefined
	local ActiveSequenceEnd = undefined
	local ActiveNoteTrack = undefined
	local ActiveMorphKeyTime = undefined
	local ActiveMorphKeyText = undefined
	local ActiveInfoKeyTime = undefined
	local ActiveInfoKeyText = undefined
	
	local enableSelectionAABB = false

	include "NeoX\AnimationHelpers.ms"
	include "Startup\SelectionAABB.ms"

	rollout NiActorSeqTagsRollout "帧事件"  
	(
		group "一般事件"
		(
			dropdownlist ddlInfoTags "" align:#left enabled:false
			edittext editInfoText "名称:" text:"" enabled:false
			spinner spnInfoTagFrame "帧号: "  range:[0,99999,0] type:#integer align:#left width:132 enabled:false 
			button btnAddInfoTag "添加事件" across:2 enabled:false width:72
			button btnRemInfoTag "删除事件" across:2 enabled:false width:72
		)
		
		group "同步点(morph)"
		(
			dropdownlist ddlMorphTags "" enabled:false
			edittext editMorphText "名称:" text:"" enabled:false
			spinner spnMorphTagFrame "帧号: "  range:[0,99999,0] type:#integer align:#left width:132 enabled:false 
			button btnAddMorphTag "添加同步点" across:2 enabled:false width:72
			button btnRemMorphTag "删除同步点" across:2 enabled:false width:72
		)

		function GetActiveInfoKey =
		(
				for trackTime = ActiveSequence.time to ActiveSequenceEnd.time do 
				(
					TempInfoKey = undefined 
					TempInfoKeys = GetInfoKey ActiveNoteTrack trackTime 
					
					if TempInfoKeys != undefined and TempInfoKeys.count > 0 do
					(
						for i = 1 to TempInfoKeys.count do
						(
							TempInfoKey = TempInfoKeys[i]
							if ActiveInfoKeyTime == TempInfoKey.time and ActiveInfoKeyText == TempInfoKey.value then return TempInfoKey
						)
					)
					
				)
				
				return undefined
		)
		
		function GetActiveMorphKey =
		(
				for trackTime = ActiveSequence.time to ActiveSequenceEnd.time do 
				(
					TempMorphKey = undefined 
					TempMorphKeys = GetMorphKey ActiveNoteTrack trackTime 
					
					if TempMorphKeys != undefined and TempMorphKeys.count > 0 do
					(
						for i = 1 to TempMorphKeys.count do
						(
							TempMorphKey = TempMorphKeys[i]
							if ActiveMorphKeyTime == TempMorphKey.time and ActiveMorphKeyText == TempMorphKey.value then return TempMorphKey
						)
					)
					
				)
				
				return undefined
		)
				
		function UpdateSequenceTagsUI =
		(
			bAdded = false
			if LayerRoot != undefined and ActiveNoteTrack != undefined do
			(
				btnAddInfoTag.enabled = true
				btnAddMorphTag.enabled = true
			
				ddlInfoTags.enabled = false
				ddlMorphTags.enabled = false

				AllSequenceMorphTags = #()
				AllSequenceInfoTags = #()
				MorphTagSelectedIndex = 1
				InfoTagSelectedIndex = 1
				
				for trackTime = ActiveSequence.time to ActiveSequenceEnd.time do 
				(
					TempMorphKey = undefined 
					TempMorphKeys = GetMorphKey ActiveNoteTrack trackTime 
					
					if TempMorphKeys != undefined and TempMorphKeys.count > 0 do
					(
						for i = 1 to TempMorphKeys.count do
						(
							TempMorphKey = TempMorphKeys[i]
							append AllSequenceMorphTags (TempMorphKey.value as string)
							if ActiveMorphKeyTime == undefined do
							( 
								ActiveMorphKeyTime = TempMorphKey.time
								ActiveMorphKeyText = TempMorphKey.value
							)
							
							if ActiveMorphKeyTime == TempMorphKey.time and ActiveMorphKeyText == TempMorphKey.value do
							(
								MorphTagSelectedIndex = AllSequenceMorphTags.count
								print "MorphTagSelectedIndex = "
								print MorphTagSelectedIndex
								print "\n"
							)
						)
					)
					
					TempInfoKey = undefined 
					TempInfoKeys = GetInfoKey ActiveNoteTrack trackTime 
					
					if TempInfoKeys != undefined and TempInfoKeys.count > 0 do
					(
						for i = 1 to TempInfoKeys.count do
						(
							TempInfoKey = TempInfoKeys[i]
							append AllSequenceInfoTags (TempInfoKey.value as string)
							if ActiveInfoKeyTime == undefined do 
							(
								ActiveInfoKeyTime = TempInfoKey.time
								ActiveInfoKeyText = TempInfoKey.value
							)
							
							if ActiveInfoKeyText == TempInfoKey.value and ActiveInfoKeyTime == TempInfoKey.time do
							( 
								InfoTagSelectedIndex = AllSequenceInfoTags.count 
								print "InfoTagSelectedIndex = "
								print InfoTagSelectedIndex
								print "\n"
							)
						)
					)
				)
				
				if AllSequenceMorphTags.count > 0 do 
				(
					ddlMorphTags.items = AllSequenceMorphTags
					ddlMorphTags.enabled = true
					ddlMorphTags.selection = MorphTagSelectedIndex
				)
				if AllSequenceInfoTags.count > 0 do 
				(
					ddlInfoTags.items = AllSequenceInfoTags
					ddlInfoTags.enabled = true
					ddlInfoTags.selection = InfoTagSelectedIndex
				)
				
				if ActiveMorphKeyTime != undefined do
				(
					editMorphText.enabled = true
					value = ""
					if ActiveMorphKeyText.count > 7 then
						value = substring ActiveMorphKeyText 8 -1
					
					editMorphText.text = value
					spnMorphTagFrame.enabled = true
					spnMorphTagFrame.value = ActiveMorphKeyTime
					btnRemMorphTag.enabled = true
				)
				if ActiveMorphKeyTime == undefined do
				(
					editMorphText.enabled = false
					editMorphText.text = ""
					spnMorphTagFrame.enabled = false
					spnMorphTagFrame.value = slidertime
					btnRemMorphTag.enabled = false
				)
				
				if ActiveInfoKeyTime != undefined do
				(
					editInfoText.enabled = true
					value = ActiveInfoKeyText								
					editInfoText.text = value
					spnInfoTagFrame.enabled = true
					spnInfoTagFrame.value = ActiveInfoKeyTime
					btnRemInfoTag.enabled = true
				)
				if ActiveInfoKeyTime == undefined do
				(
					editInfoText.enabled = false
					editInfoText.text = ""
					spnInfoTagFrame.enabled = false
					spnInfoTagFrame.value = slidertime
					btnRemInfoTag.enabled = false
				)

				bAdded = true
			)
			if bAdded == false do
			(
				editMorphText.enabled = false
				editMorphText.text = ""
				editInfoText.enabled = false
				editInfoText.text = ""
				btnAddMorphTag.enabled = false
				btnAddInfoTag.enabled = false
				btnRemMorphTag.enabled = false
				btnRemInfoTag.enabled = false
				spnMorphTagFrame.enabled = false
				spnMorphTagFrame.value = slidertime
				spnInfoTagFrame.enabled = false
				spnInfoTagFrame.value = slidertime
			)
		)
		
		on ddlInfoTags selected index do 
		(
			iCount = 0
			for trackTime = ActiveSequence.time to ActiveSequenceEnd.time do 
			(
				TempInfoKeys = GetInfoKey ActiveNoteTrack trackTime 
				if TempInfoKeys != undefined and TempInfoKeys.count > 0 do
				(
					for i = 1 to TempInfoKeys.count do
					(
						iCount = iCount + 1
						if iCount == index do
						(
							ActiveInfoKeyTime = TempInfoKeys[i].time
							ActiveInfoKeyText = TempInfoKeys[i].value
							UpdateSequenceTagsUI()
							return ok
						)
					)
				)				
			)
		) 

		on ddlMorphTags selected index do 
		(
			iCount = 0
			for trackTime = ActiveSequence.time to ActiveSequenceEnd.time do 
			(
				TempMorphKeys = GetMorphKey ActiveNoteTrack trackTime 
				if TempMorphKeys != undefined and TempMorphKeys.count > 0 do
				(
					for i = 1 to TempMorphKeys.count do
					(
						iCount = iCount + 1
						if iCount == index do 
						(
							ActiveMorphKeyTime = TempMorphKeys[i].time
							ActiveMorphKeyText = TempMorphKeys[i].value
							UpdateSequenceTagsUI()
							return ok
						)
					)
				)				
			)
		) 
		
		on editMorphText changed text do
		(
			if text == "" or text == undefined do
			(
				text = "_"
			)
			if ActiveMorphKeyText != undefined do
			(
				value = "morph: " + text
				TempMorphKeys = GetMorphKey ActiveNoteTrack value 
				if TempMorphKeys != undefined and TempMorphKeys.count > 0 do
				(	
					for key in TempMorphKeys do
					(
						if key.value == value do
						(
							messageBox "不能在这一帧上设置该同步点名称！\n已存在同名的同步点！"
							return ok
						)
					)
				)
				
				ActiveMorphKey = GetActiveMorphKey()
				ActiveMorphKeyText = value
				ActiveMorphKey.value = value
				UpdateSequenceTagsUI()
			)
		)
		
		on spnMorphTagFrame changed value do
		(
			bPassed = false
			if value >= ActiveSequence.time and value <= ActiveSequenceEnd.time do
			(
				if ActiveMorphKeyText != undefined do
				(
					TempMorphKeys = GetMorphKey ActiveNoteTrack value 
					if TempMorphKeys != undefined and TempMorphKeys.count > 0 do
					(	
						for key in TempMorphKeys do
						(
							if key.value == ActiveMorphKeyText do
							(
								messageBox "不能将同步点移到这一帧上！\n已存在同名的同步点！"
								return ok
							)
						)
					)
					
					bPassed = true
					seqIndex = GetStartKeyIndex ActiveNoteTrack ActiveSequence
					ActiveMorphKey = GetActiveMorphKey()
					ActiveMorphKey.time = value
					ActiveMorphKeyTime = value
				    ActiveSequence = GetStartKey ActiveNoteTrack seqIndex
				    ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
					UpdateSequenceTagsUI()
				)
			)
			
			if not bPassed do
			(
				messageBox "同步点不能设置在此帧！\n帧号必须在已有的时间轴范围内！" 
			)
			
		)
		
		on btnAddMorphTag pressed do
		(
			bPassed = false
			if sliderTime >= ActiveSequence.time and sliderTime <= ActiveSequenceEnd.time do
			(
				value = "unknown"
				TempMorphKeys = GetMorphKey ActiveNoteTrack sliderTime 
				if TempMorphKeys != undefined and TempMorphKeys.count > 0 do
				(	
					unknownCount = 0
					for key in TempMorphKeys do
					(
						foundUnknown = findstring key.value "unknown"
						if foundUnknown != undefined do
						(		
							unknownCount = unknownCount + 1					
						)
						value = value + (unknownCount as string)
					)
				)
				
				bPassed = true
				
				seqIndex = GetStartKeyIndex ActiveNoteTrack ActiveSequence
				ActiveMorphKey = CreateNoteKey ActiveNoteTrack slidertime
				ActiveSequence = GetStartKey ActiveNoteTrack seqIndex
				ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
				ActiveMorphKey.value = "morph: " + value
				ActiveMorphKeyTime = sliderTime
				ActiveMorphKeyText = ActiveMorphKey.value
				UpdateSequenceTagsUI()
			)

			if not bPassed do
			(
				messageBox "不能在此帧上添加同步点！\n帧号必须在已有的时间轴范围内！" 
			)
		)
		
		on btnRemMorphTag pressed do
		(
			nt = ActiveNoteTrack
			index = 0
			iCount = NiGetNoteKeyCount nt
			print iCount
			for i = 1 to iCount do
			(
				key = nt.keys[i]
				if key.time == ActiveMorphKeyTime and key.value == ActiveMorphKeyText do
				(
					foundMorph = findstring key.value "morph: "
					if foundMorph != undefined and foundMorph == 1 do
					(
						index = i
						exit
					)
				)
			)
			if index != 0 do
			(
    			seqIndex = GetStartKeyIndex ActiveNoteTrack ActiveSequence
				deletenotekey ActiveNoteTrack.keys index
				ActiveMorphKeyTime = undefined
				ActiveMorphKeyText = undefined
				ActiveSequence = GetStartKey ActiveNoteTrack seqIndex
				ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
				UpdateSequenceTagsUI()
			)
		)
		
		on editInfoText changed text do
		(
			if text == "" or text == undefined do
			(
				text = "_"
			)

			foundStart = findString text "start"
			if foundStart == 1 then
			(
				text = replace text 1 5 "begin"
			)
			
			foundMorph = findString text "morph: "
			if foundMorph == 1 then
			(
				text = replace text 1 7 "morph"
			)
			
			foundEnd = findString text "end"
			if foundEnd == 1 then
			(
				text = replace text 1 3 "finish"
			)
			
			if ActiveInfoKeyTime != undefined do
			(
				value = text
				TempInfoKeys = GetInfoKey ActiveNoteTrack value 
				if TempInfoKeys != undefined and TempInfoKeys.count > 0 do
				(	
					for key in TempInfoKeys do
					(
						if key.value == value do
						(
							messageBox "不能在这一帧上设置该事件名称！\n已存在同名的事件！"
							UpdateSequenceTagsUI()
							return ok
						)
					)
				)
				ActiveInfoKey = GetActiveInfoKey()
				ActiveInfoKey.value = value
				ActiveInfoKeyText = value
				
				UpdateSequenceTagsUI()
			)
		)
		
		on spnInfoTagFrame changed value do
		(
			bPassed = false
			if value >= ActiveSequence.time and value <= ActiveSequenceEnd.time do
			(
				if ActiveInfoKeyTime != undefined do
				(
					TempInfoKeys = GetInfoKey ActiveNoteTrack value 
					if TempInfoKeys != undefined and TempInfoKeys.count > 0 do
					(	
						for key in TempInfoKeys do
						(
							if key.time == value do
							(
								messageBox "不能将事件移动到这一帧！\n此帧已存在事件！"
								UpdateSequenceTagsUI()
								return ok
							)
						)
					)
					bPassed = true
					seqIndex = GetStartKeyIndex ActiveNoteTrack ActiveSequence
				    ActiveInfoKey = GetActiveInfoKey()
					ActiveInfoKey.time = value
					ActiveInfoKeyTime = value
					ActiveSequence = GetStartKey ActiveNoteTrack seqIndex
				    ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
					UpdateSequenceTagsUI()
				)
			)
			
			if not bPassed do
			(
				messageBox "不能将事件移动到这一帧！\n必须在已有的时间轴范围内！" 
				UpdateSequenceTagsUI()
			)
			
		)
		
		on btnAddInfoTag pressed do
		(
			bPassed = false
			if sliderTime >= ActiveSequence.time and sliderTime <= ActiveSequenceEnd.time do
			(
				keyvalue = "unknown"
				TempInfoKeys = GetInfoKey ActiveNoteTrack sliderTime 
				if TempInfoKeys != undefined and TempInfoKeys.count > 0 do
				(	
					unknownCount = 0
					for key in TempInfoKeys do
					(
						foundUnknown = findstring key.value "unknown"
						if foundUnknown != undefined do
						(		
							unknownCount = unknownCount + 1					
						)
					)
					keyvalue = keyvalue + (unknownCount as string)
				)
				
				bPassed = true
				seqIndex = GetStartKeyIndex ActiveNoteTrack ActiveSequence
				ActiveInfoKey = CreateNoteKey ActiveNoteTrack slidertime
				ActiveSequence = GetStartKey ActiveNoteTrack seqIndex
				ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
			    ActiveInfoKey.value = keyvalue
				ActiveInfoKeyTime = sliderTime
				ActiveInfoKeyText = ActiveInfoKey.value
				UpdateSequenceTagsUI()
			)
			
			if not bPassed do
			(
				messageBox "不能在这一帧上添加事件！\n必须在已有的时间轴范围内！" 
			)
		)
		
		on btnRemInfoTag pressed do
		(
			nt = ActiveNoteTrack
			index = 0
			iCount = nt.keys.count
			print iCount
			for i = 1 to iCount do
			(
				key = nt.keys[i]
				if key.time == ActiveInfoKeyTime and key.value == ActiveInfoKeyText do
				(
					index = i
					exit
				)
			)
			if index != 0 do
			(
			    seqIndex = GetStartKeyIndex ActiveNoteTrack ActiveSequence
				deletenotekey ActiveNoteTrack.keys index
				ActiveSequence = GetStartKey ActiveNoteTrack seqIndex
				ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
				ActiveInfoKeyTime = undefined
				ActiveInfoKeyText = undefined
				UpdateSequenceTagsUI()
			)
		)

		on NiActorSeqTagsRollout open do
		(
			UpdateSequenceTagsUI()
		)
	)

	function IsTopLevelSequence =
	(
		if AccumRoot != undefined and LayerRoot == ActorRoot and ActorRoot != undefined do
		(
			return true
		)
			
		return false
	)

	rollout NiActorAccumulationRollout "过渡累积"
	(
		group "累积"
		(
			checkbox cbAccumTrans "平移累积" offset:[0, 6] align:#left enabled:false
			checkbox cbAccumXTrans "X 轴" offset:[15, 0] across:3 align:#left enabled:false
			checkbox cbAccumYTrans "Y 轴" offset:[15, 0] across:3 enabled:false
			checkbox cbAccumZTrans "Z 轴" offset:[15, 0] across:3 enabled:false
			checkbox cbAccumRots "旋转累积" offset:[0, 0] align:#left enabled:false
			dropdownlist ddAccumRots "" items:#("X 轴", "Y 轴", "Z 轴", "所有轴") offset:[15, 0] selection:4 enabled:false align:#left width:80
			--dropdownlist ddFront "Actor Faces:" items:#("X Axis", "Negative X Axis", "Y Axis", "Negative Y Axis") selection:1 offset:[15,0] width:120 enabled:false
		)
		
		function UpdateAccumulationGroupUI =
		(
			bFixed = false
			if IsTopLevelSequence() and ActiveSequence != undefined do
			(
				bFixed = true
	 			local strTrans = GetSequenceAccumTrans ActiveSequence 
				strTrans = uppercase strTrans
				local strRots = GetSequenceAccumRot ActiveSequence
				strRots = uppercase strRots
				local strFront = GetSequenceFront ActiveSequence
				strFront = uppercase strFront
				
				
				cbAccumRots.enabled = true
				if strRots == "NONE" then 
					cbAccumRots.checked = false 
				else 
					cbAccumRots.checked = true
				
				ddAccumRots.enabled = cbAccumRots.checked
				
				if strRots == "X" then ddAccumRots.selection = 1 
				if strRots == "Y" then ddAccumRots.selection = 2
				if strRots == "Z" then ddAccumRots.selection = 3
				if strRots == "ALL" then ddAccumRots.selection = 4
 
				cbAccumTrans.enabled = true
				if strTrans == "NONE" then 
					cbAccumTrans.checked = false 
				else 
					cbAccumTrans.checked = true
				
				foundX = findstring strTrans "X"
				foundY = findstring strTrans "Y"
				foundZ = findstring strTrans "Z"

				if foundX != undefined then 
					cbAccumXTrans.checked = true 
				else 
					cbAccumXTrans.checked = false
				if foundY != undefined then 
					cbAccumYTrans.checked = true 
				else 
					cbAccumYTrans.checked = false
				if foundZ != undefined then 
					cbAccumZTrans.checked = true 
				else 
					cbAccumZTrans.checked = false
				
				if strTrans == "ALL" do 
				(
					cbAccumXTrans.checked = true
					cbAccumYTrans.checked = true
					cbAccumZTrans.checked = true
				)
				
				if cbAccumTrans.checked do
				(
					cbAccumXTrans.enabled = true
					cbAccumYTrans.enabled = true
					cbAccumZTrans.enabled = true
				)
				if not cbAccumTrans.checked do
				(
					cbAccumXTrans.enabled = false
					cbAccumYTrans.enabled = false
					cbAccumZTrans.enabled = false
				)
/*
				if strRots == "NONE" then ddFront.enabled = false
				if strRots == "X" then ddFront.enabled = false 
				if strRots == "Y" then ddFront.enabled = false
				if strRots == "Z" then ddFront.enabled = true 
				if strRots == "ALL" then ddFront.enabled = true
					
				if ddFront.enabled == true do
				(
					if strFront == "X" then ddFront.selection = 1
					if strFront == "NEGX" then ddFront.selection = 2
					if strFront == "Y" then ddFront.selection = 3
					if strFront == "NEGY" then ddFront.selection = 4				
				)
*/
			)	
			if bFixed == false do
			(
				cbAccumRots.enabled = false
				cbAccumRots.checked = false
				cbAccumTrans.enabled = false
				cbAccumTrans.checked = false
				cbAccumXTrans.enabled = false
				cbAccumXTrans.checked = false
				cbAccumYTrans.enabled = false
				cbAccumYTrans.checked = false
				cbAccumZTrans.enabled = false
				cbAccumZTrans.checked = false
				ddAccumRots.enabled = false
				--ddFront.enabled = false	
			)
			
			
			NiActorSeqTagsRollout.UpdateSequenceTagsUI()
		)
					
		on cbAccumRots changed state do
		(
			print "cbAccumRots changed state..."
			items = filterstring ActiveSequence.value " "

			value = ""
			strRots = "none"
			if cbAccumRots.checked == true do
			(
				strRots = "all"
			)
			print strRots
			
			bAdded = false
			ignoreindex = 0
			for i = 1 to items.count do
			(
				item = items[i]
				bAppend = true
				if (EqualsNoCase item "-ar") do
				(
					bAppend = false 
					value = value + "-ar " + strRots + " "
					bAdded = true 
					ignoreindex = i + 1
					
					if items.count == ignoreindex  do
					(
						if strRots == "all" or strRots == "x" do
						(
							value = value + "-front x "
						)
					)
						
				)
				if i == ignoreindex then continue
				
				if bAppend == true then value = value + item + " "
			)
			
			if bAdded == false and cbAccumRots.checked == false then 
				value = value + "-ar none " 
			if bAdded == false and cbAccumRots.checked == true then
				value = value + "-ar " + strRots
			
			print value	
			ActiveSequence.value = value	
			UpdateAccumulationGroupUI()	
		)
		
		on ddAccumRots selected item do
		(
			items = filterstring ActiveSequence.value " "
			strRots = "none"
			
			if item == 1 then strRots = "x"
			if item == 2 then strRots = "y"
			if item == 3 then strRots = "z"			
			if item == 4 then strRots = "all"
			
			ignoreindex = 0
			value = ""
			for i = 1 to items.count do
			(
				item = items[i]
				bAppend = true
				if (EqualsNoCase item "-ar") do
				(
					bAppend = false 
					value = value + "-ar " + strRots + " "
					bAdded = true 
					ignoreindex = i + 1
				)
				if i == ignoreindex then continue
				if bAppend == true then value = value + item + " "
			)
			
			ActiveSequence.value = value
			UpdateAccumulationGroupUI()
		)
		
		on cbAccumTrans changed state do
		(
			print "cbAccumTrans changed state..."
			items = filterstring ActiveSequence.value " "

			value = ""
			strTrans = "none"
			if cbAccumTrans.checked == true do
			(
				strTrans = "xy"
			)
			print strTrans
			
			bAdded = false
			ignoreindex = 0
			for i = 1 to items.count do
			(
				item = items[i]
				bAppend = true
				if (EqualsNoCase item "-at") do
				(
					bAppend = false 
					value = value + "-at " + strTrans + " "
					bAdded = true 
					ignoreindex = i + 1
				)
				if i == ignoreindex then continue
				
				if bAppend == true then value = value + item + " "
			)
			
			if bAdded == false and cbAccumTrans.checked == false then 
				value = value + "-at none " 
			if bAdded == false and cbAccumTrans.checked == true then
				value = value + "-at " + strTrans + " "
			
			print value	
			ActiveSequence.value = value	
			UpdateAccumulationGroupUI()		
		)

		function UpdateTransAccumFlags =
		(
			items = filterstring ActiveSequence.value " "
			strTrans = ""
			
			if cbAccumXTrans.checked then strTrans = strTrans + "x"
			if cbAccumYTrans.checked then strTrans = strTrans + "y"
			if cbAccumZTrans.checked then strTrans = strTrans + "z"
			
			if strTrans == "" then strTrans = "none"
			
			ignoreindex = 0
			value = ""
			for i = 1 to items.count do
			(
				item = items[i]
				bAppend = true
				if (EqualsNoCase item "-at") do
				(
					bAppend = false 
					value = value + "-at " + strTrans + " "
					bAdded = true 
					ignoreindex = i + 1
				)
				if i == ignoreindex then continue
				if bAppend == true then value = value + item + " "
			)
			
			ActiveSequence.value = value
			UpdateAccumulationGroupUI()
		)
		
		on cbAccumXTrans changed state do
		(
			UpdateTransAccumFlags()
		)
		
		on cbAccumYTrans changed state do
		(
			UpdateTransAccumFlags()
		)
		
		on cbAccumZTrans changed state do
		(
			UpdateTransAccumFlags()
		)
/*
		on ddFront selected item do
		(
			items = filterstring ActiveSequence.value " "
			strFront = ""
			
			if item == 1 then strFront = "x"
			if item == 2 then strFront = "negx"
			if item == 3 then strFront = "y"
			if item == 4 then strFront = "negy"
			
			ignoreindex = 0
			value = ""
			bAdded = false
			for i = 1 to items.count do
			(
				myitem = items[i]
				bAppend = true
				if (EqualsNoCase myitem "-front") do
				(
					bAppend = false 
					value = value + "-front " + strFront + " "
					bAdded = true 
					ignoreindex = i + 1
				)
				if i == ignoreindex then continue
				if bAppend == true then value = value + myitem + " "
			)


			if bAdded == false then value = value + "-front " + strFront + " "		
			ActiveSequence.value = value
		)
*/
		on NiActorAccumulationRollout open do
		(
			UpdateAccumulationGroupUI()
		)
	)

	rollout NiActorCompRollout "变换成分"
	(
		group "仅保留"
		(
			checkbox cbPosition "位置" offset:[0, 0] across:3 align:#left enabled:false
			checkbox cbRotation "方向" offset:[0, 0] across:3 enabled:false
			checkbox cbScale "比例" offset:[0, 0] across:3 enabled:false
		)

		function UpdateCompositionUI =
		(
			bFixed = false
			if ActiveSequence != undefined do
			(
				bFixed = true

				local strComp = GetSequenceComp ActiveSequence
				strComp = uppercase strComp

				foundPos = findstring strComp "P"
				foundRot = findstring strComp "R"
				foundScale = findstring strComp "S"

				if foundPos != undefined then 
					cbPosition.checked = true 
				else 
					cbPosition.checked = false
				if foundRot != undefined then 
					cbRotation.checked = true 
				else 
					cbRotation.checked = false
				if foundScale != undefined then 
					cbScale.checked = true 
				else 
					cbScale.checked = false
				
				if strComp == "ALL" do 
				(
					cbPosition.checked = true
					cbRotation.checked = true
					cbScale.checked = true
				)
				
				cbPosition.enabled = true
				cbRotation.enabled = true
				cbScale.enabled = true
			)

			if bFixed == false do
			(
				cbPosition.enabled = false
				cbPosition.checked = true
				cbRotation.enabled = false
				cbRotation.checked = true
				cbScale.enabled = false
				cbScale.checked = true
			)
		)

		function UpdateCompFlags =
		(
			strComp = ""
			
			if cbPosition.checked then strComp = strComp + "p"
			if cbRotation.checked then strComp = strComp + "r"
			if cbScale.checked then strComp = strComp + "s"
			
			if strComp == "" do
			(
				message = "至少须保留一种成分！"
				messagebox message title:"不能空选"
				
				UpdateCompositionUI()
				return ok
			)

			if strComp == "prs" then strComp = "all"

			items = filterstring ActiveSequence.value " "

			bAdded = false
			ignoreindex = 0
			value = ""
			for i = 1 to items.count do
			(
				item = items[i]
				bAppend = true
				if (EqualsNoCase item "-comp") do
				(
					bAppend = false 
					value = value + "-comp " + strComp + " "
					bAdded = true 
					ignoreindex = i + 1
				)
				if i == ignoreindex then continue
				if bAppend == true then value = value + item + " "
			)
			
			if not bAdded then value = value + "-comp " + strComp + " "
			
			ActiveSequence.value = value

			UpdateCompositionUI()
		)

		on cbPosition changed state do
		(
			UpdateCompFlags()
		)

		on cbRotation changed state do
		(
			UpdateCompFlags()
		)

		on cbScale changed state do
		(
			UpdateCompFlags()
		)

		on NiActorCompRollout open do
		(
			UpdateCompositionUI()
		)
	)

	rollout NiActorSequenceRollout "时间切分"  
	(
		group  "切分成多动画"
		(
			dropdownlist  ddlSequences "" align:#left enabled:false width:132 height:10
			--label lblSeqName "Active Sequence Name:" align:#left enabled:false
			label lblSeqCount "当前动画: 0/0" enabled:false align:#left			
			edittext editSeqName "名称" text:"animation_01" enabled:false
			checkbox cbLooping "循环播放" enabled:false
			spinner spnStartFrame "起始帧: " offset:[0,6] range:[-99999,99999,0] type:#integer align:#left enabled:false
			spinner spnEndFrame "结束帧: " range:[-99999,99999,0] type:#integer align:#left enabled:false
			
			button btnRecordStartFrame "当前帧起始" across:2 enabled:false width:72
			button btnRecordEndFrame "当前帧结束" across:2 enabled:false width:72

			button btnPrev "前一个动画" across:2 width:72 enabled:false
			button btnNext "后一个动画" across:2 width:72 enabled:false
			
			button btnMakeSpanFit "按当前动画调整时间轴" width:162 enabled:false
			button btnCreate "当前动画之后加新动画" width:162 enabled:false
			button btnPrepend "当前动画之前加新动画" width:162 enabled:false
			button btnDestroy "删除当前动画" width:162 enabled:false
		)
		
		function UpdateSequenceUI =
		(
			print "Updating sequence UI..."
			print LayerRoot

			if LayerRoot != undefined do
			(
				if ActiveNoteTrack == undefined do
				(
					print "Active Note Track is undefined.. getting from layer root"
					ActiveNoteTrack = GetActorNoteTrack LayerRoot
				)
				print ActiveNoteTrack
				if ActiveSequence == undefined do
				(
					print "ActiveSequence == undefined"
					ActiveSequence = GetStartKey ActiveNotetrack 1
					ActiveInfoKeyTime = undefined
					ActiveInfoKeyText = undefined
					ActiveMorphKeyTime = undefined
					ActiveMorphKeyText= undefined
				)
				
				if ActiveSequenceEnd == undefined do
				(
					print "ActiveSequenceEnd == undefined"
					ActiveSequenceEnd = GetEndKey ActiveNotetrack ActiveSequence
					print "Active Sequence End:"
					print ActiveSequenceEnd
				)
				
				print "Active Sequence:"
				print ActiveSequence
				print "Active Sequence End:"
				print ActiveSequenceEnd

				list = #()
				listsize = GetSequenceCount ActiveNoteTrack
				if listsize != undefined do
				(
					for i = 1 to listsize do
					(
						startKey = GetStartKey ActiveNoteTrack i
						seqname = GetSequenceName startKey
						if seqname != undefined do
						(
							append list seqname
						)
					)
				)

				if listsize > 0 do
				(
					ddlSequences.items = list
				)
				if listsize == 0 do
				(
					ddlSequences.items = #()
				)
			)

			if ActiveSequence != undefined do
			(
				--lblSeqName.enabled = true
				lblSeqCount.enabled = true
				editSeqName.enabled = true
				editSeqName.text = GetSequenceName ActiveSequence
				lblSeqCount.enabled = true
				seqCount = GetSequenceCount ActiveNoteTrack
				seqIndex = GetStartKeyIndex ActiveNoteTrack ActiveSequence
				strSeqCount = "当前动画: " + seqIndex as string + "/" + seqCount as string
				lblSeqCount.caption = strSeqCount
				cbLooping.enabled = true
				cbLooping.checked = GetSequenceLoop ActiveSequence
				spnStartFrame.enabled = true
				spnEndFrame.enabled = true
				spnStartFrame.value = ActiveSequence.time
				spnEndFrame.value = ActiveSequenceEnd.time
				btnRecordStartFrame.enabled=true
				btnRecordEndFrame.enabled = true
				btnCreate.enabled = true
				btnPrepend.enabled = true
				btnMakeSpanFit.enabled = true
				
				if seqCount > 1 then 
					btnDestroy.enabled = true 
				else 
					btnDestroy.enabled = false
				
				if seqIndex == 1 then 
					btnPrev.enabled = false 
				else 
					btnPrev.enabled = true
					
				if seqIndex == seqCount then 
					btnNext.enabled = false 
				else 
					btnNext.enabled = true

				ddlSequences.enabled = true
				ddlSequences.selection = seqIndex
			)
			if ActiveSequence == undefined do
			(
				--lblSeqName.enabled = false
				lblSeqCount.enabled = false
				editSeqName.enabled = false
				editSeqName.text = ""
				lblSeqCount.enabled = false
				seqCount = 0
				seqIndex = 0
				strSeqCount = "当前动画: " + seqIndex as string + "/" + seqCount as string
				lblSeqCount.caption = strSeqCount
				cbLooping.enabled = false
				cbLooping.checked = false
				spnStartFrame.enabled = false
				spnEndFrame.enabled = false
				spnStartFrame.value = 0
				spnEndFrame.value = 0
				btnRecordStartFrame.enabled=false
				btnRecordEndFrame.enabled = false
				btnCreate.enabled = false	
				btnPrepend.enabled = false
				btnDestroy.enabled = false 
				btnPrev.enabled = false 
				btnNext.enabled = false 
				btnMakeSpanFit.enabled = false
				ddlSequences.items = #()
				ddlSequences.enabled = false
			)
			NiActorAccumulationRollout.UpdateAccumulationGroupUI()
			NiActorCompRollout.UpdateCompositionUI()
		)
		
		on btnMakeSpanFit pressed do
		(
			print "Anim Range:"
			print animationRange
			animationRange = (interval ActiveSequence.time ActiveSequenceEnd.time)
		)
		
		function AddSequence nt name start end bLooping = 
		(
			if nt == undefined then return undefined
			NewSequence = SetSimpleStartKey nt name start bLooping
			NewSequenceEnd = SetSimpleEndKey nt end
			return NewSequence
		)
		
		function RemoveSequence nt StartKey EndKey=
		(
			if nt == undefined then return undefined
			
			keyArray = #()
			for key in nt.keys do
			(
				if key.time < startKey.time or key.time > endkey.time do
				(
					append keyArray key
				)
			)
			
			ntnew = notetrack "ActorManager2"
			addNoteTrack LayerRoot ntnew
			for key in keyArray do
			(
				newKey = CreateNoteKey ntnew key.time
				newKey.value = key.value
			)

			deleteNoteTrack LayerRoot nt
			ActiveNoteTrack = ntnew
			ntnew.name = "ActorManager"
		)
		
		on NiActorSequenceRollout open do
		(
			UpdateSequenceUI()
		)
		
		on ddlSequences selected seqnum do
		(
			index = seqnum
			ActiveSequence = GetStartKey ActiveNoteTrack index
			ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
			ActiveInfoKeyTime = undefined
			ActiveInfoKeyText = undefined
			ActiveMorphKeyTime = undefined
			ActiveMorphKeyText = undefined
			UpdateSequenceUI()
		) 


		on btnPrepend pressed do
		(
			if ActiveSequence.time <= 0 do
			(
				message = "当前动画已经起始于时间轴零点，不能添加更早的动画！"
				messagebox message title:"添加失败"
				return ok
			)
			
			index = GetStartKeyIndex ActiveNoteTrack ActiveSequence
			index = index - 1
			bLooping = cbLooping.enabled
			start = 0
			end = 0
			
			if index == 0 do
			(
				start = 0
				end = ActiveSequence.time - 1
			)
			if index > 0 do
			(
				nextSeq = GetStartKey ActiveNoteTrack index
				if nextSeq == undefined do
				(
					start = ActiveSequence.time - 1
					end = ActiveSequence.time - 10
				)
				if nextSeq != undefined do
				(
					prevEnd = GetEndKey ActiveNoteTrack nextSeq
					start = prevEnd.time + 1
					end = ActiveSequence.time - 1
					if (prevEnd.time == (ActiveSequence.time - 1)) or (start == end) do
					(
						message = "当前动画之前的时间已有动画！"
						messagebox message title:"添加失败"
						return ok
					)
				)
			)
			
			strNewSeqName = strBlankSeq + "_at_" + (start as string) 
			NewSequence = AddSequence ActiveNoteTrack strNewSeqName start end bLooping
			if NewSequence != undefined do
			(
				print "btnPrepend pressed..."
				ActiveSequence = NewSequence
				print ActiveSequence
				ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
				ActiveInfoKeyTime = undefined
				ActiveInfoKeyText = undefined
				ActiveMorphKeyTime = undefined
				ActiveMorphKeyText = undefined
				UpdateSequenceUI()
			)
		)
		
		on btnCreate pressed do
		(
			index = GetStartKeyIndex ActiveNoteTrack ActiveSequence
			index = index + 1
			bLooping = cbLooping.enabled
			start = 0
			end = 0
			
			nextSeq = GetStartKey ActiveNoteTrack index
			if nextSeq == undefined do
			(
				start = ActiveSequenceEnd.time+1
				end = ActiveSequenceEnd.time + 10
			)
			if nextSeq != undefined do
			(
				start = ActiveSequenceEnd.time + 1
				end = nextSeq.time - 1
				if nextSeq.time == (ActiveSequenceEnd.time+1) or (start == end) do
				(
					message = "当前动画之后的时间已有动画！"
					messagebox message title:"添加失败！"
					return ok
				)
			)
			
			strNewSeqName = strBlankSeq + "_at_" + (start as string) 
			NewSequence = AddSequence ActiveNoteTrack strNewSeqName start end bLooping
			if NewSequence != undefined do
			(
				print "btnCreate pressed..."
				ActiveSequence = NewSequence
				print ActiveSequence
				ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
				ActiveInfoKeyTime = undefined
				ActiveInfoKeyText = undefined
				ActiveMorphKeyTime = undefined
				ActiveMorphKeyText = undefined
				UpdateSequenceUI()
			)
		)
		
		on btnDestroy pressed do
		(
			RemoveSequence ActiveNoteTrack ActiveSequence ActiveSequenceEnd
			ActiveSequence = undefined 
			ActiveSequenceEnd = undefined
			ActiveInfoKeyTime = undefined
			ActiveInfoKeyText = undefined
			ActiveMorphKeyTime = undefined
			ActiveMorphKeyText = undefined
			UpdateSequenceUI()
		)
		
		on btnPrev pressed do
		(
			index = GetStartKeyIndex ActiveNoteTrack ActiveSequence
			if index > 1 do
			(
				index = index - 1
				ActiveSequence = GetStartKey ActiveNoteTrack index
				ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
				ActiveInfoKeyTime = undefined
				ActiveInfoKeyText = undefined
				ActiveMorphKeyTime = undefined
				ActiveMorphKeyText = undefined
				UpdateSequenceUI()
			)
		)
		
		on btnNext pressed do
		(
			index = GetStartKeyIndex ActiveNoteTrack ActiveSequence
			count = GetSequenceCount ActiveNoteTrack
			if index< count do
			(
				index = index + 1
				ActiveSequence = GetStartKey ActiveNoteTrack index
				ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
				ActiveInfoKeyTime = undefined
				ActiveInfoKeyText = undefined
				ActiveMorphKeyTime = undefined
				ActiveMorphKeyText = undefined
				UpdateSequenceUI()
			)
		)
		
		
		function CanSetActiveSequenceTime start end =
		(
			if start > end then return false
			if start >= ActiveSequenceEnd.time then return false
			if end <= ActiveSequence.time then return false
			
			index = GetStartKeyIndex ActiveNoteTrack ActiveSequence
			if index > 1 do
			(
				PrevSequence = GetStartKey ActiveNoteTrack (index-1)
				PrevSequenceEnd = GetEndKey ActiveNoteTrack PrevSequence
				if PrevSequenceEnd.time >= start then return false
			)
			if index < GetSequenceCount ActiveNoteTrack do
			(
				NextSequence = GetStartKey ActiveNoteTrack (index+1)
				if NextSequence.time <= end then return false
			)
			return true
		)
		
		on btnRecordStartFrame pressed do
		(
			frame = slidertime 			
			bAdd = false
			if CanSetActiveSequenceTime frame ActiveSequenceEnd.time do
			(
			    seqIndex = GetStartKeyIndex ActiveNoteTrack ActiveSequence
				ActiveSequence.time = frame
				ActiveSequence = GetStartKey ActiveNoteTrack seqIndex
				ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
				setsliderTime ActiveSequence.time
				spnStartFrame.value = frame
				ActiveMorphKeyTime = undefined
                ActiveMorphKeyText = undefined
                ActiveInfoKeyTime = undefined
                ActiveInfoKeyText = undefined
				UpdateSequenceUI()
				NiActorSeqTagsRollout.UpdateSequenceTagsUI()
				bAdd = true
			)
			
			if bAdd == false do
			(
				message = "Cannot move the Start frame to the specified time.\nThe time either conflicts with a subsequent key or is later than the end key"
				messagebox message title:"Start Frame failure"
				spnStartFrame.value = ActiveSequence.time
				return true
			)		
		)
		
		on btnRecordEndFrame pressed do
		(
			frame = sliderTime
			if frame == ActiveSequenceEnd.time then return true
			bAdd = false
			if CanSetActiveSequenceTime ActiveSequence.time frame do
			(
				seqIndex = GetStartKeyIndex ActiveNoteTrack ActiveSequence
				ActiveSequenceEnd.time = frame
				ActiveSequence = GetStartKey ActiveNoteTrack seqIndex
				ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
				setsliderTime ActiveSequence.time
				spnEndFrame.value = frame
				bAdd = true
				ActiveMorphKeyTime = undefined
                ActiveMorphKeyText = undefined
                ActiveInfoKeyTime = undefined
                ActiveInfoKeyText = undefined
				UpdateSequenceUI()
				NiActorSeqTagsRollout.UpdateSequenceTagsUI()
			)
			
			if bAdd == false do
			(
				message = "Cannot move the End frame to the specified time.\nThe time either conflicts with a subsequent key or is earlier than the start key"
				messagebox message title:"Set End Frame failure"
				spnEndFrame.value = ActiveSequenceEnd.time
				return true
			)
		)
		
		on editSeqName changed text do
		(
			if ActiveSequence == undefined then return true
			name = GetSequenceName ActiveSequence
			if name == text then return true
			
			local finaltext = ""
			textwords = filterstring text " \t\n#@!%^&*()+=[]{}\|:;\"'<>,.?/~`"
			print textwords
			bHadToReviseText = false
			if textwords.count == 1 then finaltext = textwords[1]
			if textwords.count > 1 do
			(			
				finaltext = ""
				for i = 1 to textwords.count do
				(
					if i == textwords.count then 
						finaltext = finaltext + textwords[i] 
					else
						finaltext = finaltext + textwords[i] + "_" 
				)
				print "Had to revise text: "
				print finaltext
				bHadToReviseText = true
			)
			if text[text.count-1] == ' ' then finaltext = finaltext + "_"

			ddlSequences.selected = finaltext
			print finaltext
			items = filterstring ActiveSequence.value " "

			value = ""
			ignoreindex = 0
			for i = 1 to items.count do
			(
				item = items[i]
				bAppend = true
				if (EqualsNoCase item "-name") then bAppend = false
				if i == ignoreindex then continue 
				item = item + " "
				if bAppend == true then value = value + item
				if bAppend == false do
				(
					value = value + "-name " + finaltext + " "
					ignoreindex = i + 1
				)
			)
			print value
			ActiveSequence.value = value
			
			-- now find sequence tags in object's notetracks and rename
			ChildArray = #()
			GetAllChildren ActorRoot ChildArray
			-- replace name with finaltext
			for Child in ChildArray do
			(
				if hasNoteTracks Child then
				(
					for i = 1 to numNoteTracks Child do
					(
						Notes = getNoteTrack Child i
						if Notes != undefined then
						(
							for Key in Notes.keys do
							(
								searchString = "-" + name + "Ratio"
								oldLength = searchString.count
								-- find out if the old sequence name is in the key
								-- if it has a dash, it is a compression override
								index = findString Key.value searchString
								if index != undefined then
								(
									-- replace the sequence name
									value = replace Key.value index oldLength ("-" + finaltext + "Ratio")
									Key.value = value
								)
								searchString = "-" + name + "DontCompress"
								oldLength = searchString.count
								index = findString Key.value searchString
								if index != undefined then
									Key.value = replace Key.value index oldLength ("-" + finaltext + "DontCompress")
								searchString = "-" + name + "CompressFloats"
								oldLength = searchString.count
								index = findString Key.value searchString
								if index != undefined then
									Key.value = replace Key.value index oldLength ("-" + finaltext + "CompressFloats")
							)
						)
					)
				)
			)

			if bHadToReviseText then UpdateSequenceUI()
		)

		on cbLooping changed state do
		(
			name = GetSequenceName ActiveSequence		
			items = filterstring ActiveSequence.value " "

			value = ""
			bLoopAdded
			for i = 1 to items.count do
			(
				item = items[i]
				bAppend = true
				if (EqualsNoCase item "-loop") then bAppend = false 
			    item = item + " "

				if bAppend == true then value = value + item
			)
			
			if cbLooping.checked == true then 
				value = value + "-loop"
			ActiveSequence.value = value
		)
		
		on spnStartFrame changed frame do
		(
			bAdd = false
			if CanSetActiveSequenceTime frame ActiveSequenceEnd.time do
			(
				seqIndex = GetStartKeyIndex ActiveNoteTrack ActiveSequence
				ActiveSequence.time = frame
				ActiveSequence = GetStartKey ActiveNoteTrack seqIndex
				ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
				setsliderTime ActiveSequence.time
				ActiveMorphKeyTime = undefined
                ActiveMorphKeyText = undefined
                ActiveInfoKeyTime = undefined
                ActiveInfoKeyText = undefined
				UpdateSequenceUI()
				NiActorSeqTagsRollout.UpdateSequenceTagsUI()
				bAdd = true
			)
			
			if bAdd == false do
			(
				message = "Cannot move the Start frame to the specified time.\nThe time either conflicts with a subsequent key or is later than the end key"
				messagebox message title:"Start Frame failure"
				spnStartFrame.value = ActiveSequence.time
				return true
			)
		)
		
		on spnEndFrame changed frame do
		(
			bAdd = false
			if CanSetActiveSequenceTime ActiveSequence.time frame do
			(
			    seqIndex = GetStartKeyIndex ActiveNoteTrack ActiveSequence
				ActiveSequenceEnd.time = frame
				ActiveSequence = GetStartKey ActiveNoteTrack seqIndex
				ActiveSequenceEnd = GetEndKey ActiveNoteTrack ActiveSequence
				setsliderTime ActiveSequence.time
				bAdd = true
				ActiveMorphKeyTime = undefined
                ActiveMorphKeyText = undefined
                ActiveInfoKeyTime = undefined
                ActiveInfoKeyText = undefined
				UpdateSequenceUI()
				NiActorSeqTagsRollout.UpdateSequenceTagsUI()
			)
			
			if bAdd == false do
			(
				message = "Cannot move the End frame to the specified time.\nThe time either conflicts with a subsequent key or is earlier than the start key"
				messagebox message title:"Set End Frame failure"
				spnEndFrame.value = ActiveSequenceEnd.time
				return true
			)
		)
		
	)
	
	rollout NiActorLayerRollout "局部动画"  
	(
		group "活动骨骼分支"
		(
			dropdownlist ddLayerRoot "根骨骼节点:" items:#("无") selection:1 width:162 align:#center  enabled:false
			pickbutton btnAddLayerRoot "添加" align:#center across:2 width:72 enabled:false
			button btnRemLayerRoot "删除" align:#center across:2 width:72 enabled:false
		)
		
		function RefreshLayerRoots obj=
		(
			nt = GetActorNoteTrack obj
			if nt != undefined do
			(
				append AllLayerRoots obj
			)
			
			for child in obj.children do
			(
				RefreshLayerRoots child
			)
		)
		
		function UpdateLayerGroupUI =
		(
			if LayerRoot == undefined and ActorRoot != undefined then
				LayerRoot = ActorRoot
		
			if LayerRoot != undefined do
			(
				AllLayerRoots = #()
				RefreshLayerRoots ActorRoot
				print AllLayerRoots
				ddLayerRoot.items = GetNameArrayFromObjArray AllLayerRoots
				
				index = 1
				for layer in AllLayerRoots do
				(
					if layer == LayerRoot then ddLayerRoot.selection = index
					index = index + 1
				)
				
				print "Updating layer UI..."
				ddLayerRoot.enabled = true
				btnAddLayerRoot.enabled = true
				btnRemLayerRoot.enabled = true
				select LayerRoot
				NiActorSequenceRollout.UpdateSequenceUI()
				
			)	
			
			if LayerRoot == undefined do
			(
				AllLayerRoots = #()
				ddLayerRoot.items = #("None")
				ddLayerRoot.enabled = false
				btnAddLayerRoot.enabled = false
				btnRemLayerRoot.enabled = false
				ActiveSequence = undefined
				ActiveSequenceEnd = undefined
				ActiveInfoKeyTime = undefined
				ActiveInfoKeyText = undefined
				ActiveMorphKeyTime = undefined
				ActiveMorphKeyText = undefined
				ActiveNoteTrack = undefined
				NiActorSequenceRollout.UpdateSequenceUI()					
			)
		)
		
		
		on btnAddLayerRoot picked obj do
		(
			bCanDo = ParentIsActor ActorRoot obj
			if bCanDo == true do
			(
				nt = MakeActorNoteTrack obj
				LayerRoot = obj
				ActiveSequence = undefined
				ActiveSequenceEnd = undefined
				ActiveInfoKeyTime = undefined
				ActiveInfoKeyText = undefined
				ActiveMorphKeyTime = undefined
				ActiveMorphKeyText = undefined
				ActiveNoteTrack = undefined
				UpdateLayerGroupUI()
				select LayerRoot
			)
			if bCanDo == false do
			(
				message = "节点 \"" + obj.name + "\" 不是 \"" + ActorRoot.name + "\" 的子节点！"
				messagebox message title:"添加分支根节点错误"
			)
		)
		
		on btnRemLayerRoot pressed do
		(
			if LayerRoot == ActorRoot do
			(
				message = "不能从分支中删除顶层根节点！\n"
				messagebox message title:"删除分支根节点错误!"
				return true
			)
			
			RemoveActorNoteTrack LayerRoot
			LayerRoot = ActorRoot
			ActiveSequence = undefined
			ActiveSequenceEnd = undefined
			ActiveNoteTrack = undefined
			UpdateLayerGroupUI()
		)
		
		on ddLayerRoot selected item do
		(
			name = ddLayerRoot.items[item]
			for obj in AllLayerRoots do
			(
				if obj.name == name do
				(
					LayerRoot = obj
					str = "layer root: " + obj.name
					print str
					ActiveSequence = undefined
					ActiveSequenceEnd = undefined
					ActiveNoteTrack = undefined
					ActiveInfoKeyTime = undefined
					ActiveInfoKeyText = undefined
					ActiveMorphKeyTime = undefined
					ActiveMorphKeyText = undefined
					
					NiActorSequenceRollout.UpdateSequenceUI()
					select LayerRoot
					return true
				)
			)
		)
		
		on NiActorLayerRollout open do
		(
			UpdateLayerGroupUI()
		)
	)		
	
	rollout NiActorManagerRollout "骨骼对象"  
	(
		button btnRefreshAll "刷新全部" width:162
			
		group "骨骼树"
		(
			dropdownlist ddActorRoot "顶层根节点:" items:#("无") selection:1 width:162 align:#center 
			pickbutton btnAddActorRoot "添加" align:#center width:72 across:2 
			button btnRemActorRoot "删除" align:#center width:72 across:2 
			
			label lblAccumRoot "累积根节点:" width:120 align:#left enabled:false
			label lblAccumRootName "无" offset:[15,0] align:#left  enabled:false
			pickbutton btnSetAccumRoot "选取" align:#center width:72 across:2 enabled:false
			button btnResetAccumRoot "默认" align:#center width:72 enabled:false
		)
			
		function MakeAccumRoot obj =
		(
			setUserProp obj strAccumRoot ""
			AccumRoot = obj
			lblAccumRootName.caption = obj.name
		)
		
		function IsAccumRoot obj =
		(
			str = GetUserProp obj strAccumRoot
			if str != undefined do
			(
				message =  "Is Accum Root :" + obj.name + " str: \"" + str + "\""
				print message
			)
			if str == undefined then return false else return true
		)
		
		function FindAccumRoot obj =
		(
			bIsAccum = IsAccumRoot obj
			if bIsAccum == true do return obj
			
			for child in obj.children do
			(
				result = FindAccumRoot child
				if result != undefined do return result
			)
			return undefined
		)

		function RemoveAccumRoot obj =
		(
			str = getUserPropBuffer obj
			
			foundstring = undefined
			if str != undefined do
			(
				foundstring = findstring str strAccumRoot
				if foundstring != undefined do
				(
					str = replace str foundstring (strAccumRoot.count+4) ""
					setUserPropBuffer obj str
				)
			)
		)
		
		function RemoveAllAccumRoots root =
		(
			RemoveAccumRoot root
			for child in root.children do
			(
				RemoveAllAccumRoots child
			)
		)

		function UpdateActorGroupUI =
		(
			if ActorRoot != undefined do
			(
				ddActorRoot.items = GetNameArrayFromObjArray AllActorRoots
				index = 1;
				for actor in AllActorRoots do
				(
					if actor == ActorRoot do
					(
						ddActorRoot.selection = index
					)
					index = index + 1
				)
				
				AccumRoot = FindAccumRoot ActorRoot
				if AccumRoot == undefined then MakeAccumRoot ActorRoot
				lblAccumRootName.caption = AccumRoot.name
				lblAccumRootName.enabled = true
				lblAccumRoot.enabled = true
				btnSetAccumRoot.enabled = true
				btnResetAccumRoot.enabled = true
				
				NiActorLayerRollout.UpdateLayerGroupUI()
			)
			if ActorRoot == undefined do
			(
				ddActorRoot.items = #("无")
				AccumRoot = undefined
				lblAccumRootName.caption = "无"
				lblAccumRootName.enabled = false
				lblAccumRoot.enabled = false
				btnSetAccumRoot.enabled = false
				btnResetAccumRoot.enabled = false
				
				NiActorLayerRollout.UpdateLayerGroupUI()
			)
		)

		function ActivateActorRoot root =
		(
			ActorRoot = root
			setUserProp root strActorRoot ""
		)

		function DeactivateActorRoot root =
		(
			print "DeactivateActorRoot"
			str = getUserPropBuffer root
			foundstring = findstring str strActorRoot
			
			if foundstring == undefined then return
			print foundstring
			print str.count
			str = replace str foundstring (strActorRoot.count+4) ""
			print str
			setUserPropBuffer root str
		)

		function RefreshAll =
		(
			AllActorRoots = #()
			GetActorRoots rootNode AllActorRoots
			for root in AllActorRoots do
			(
				DeactivateActorRoot root
			)
			if AllActorRoots.count == 0 then 
				ActorRoot = undefined
			else
				ActivateActorRoot AllActorRoots[1]
			LayerRoot = undefined
			AllLayerRoots = #()
			ActiveSequence = undefined
			ActiveSequenceEnd = undefined
			ActiveNoteTrack = undefined
			ActiveInfoKeyTime = undefined
			ActiveInfoKeyText = undefined
			ActiveMorphKeyTime = undefined
			ActiveMorphKeyText = undefined
			UpdateActorGroupUI()
		)

		on btnRefreshAll pressed do
		(
			RefreshAll()
		)

		function CanCreateActorRoot obj =
		(
			bCanAdd = true
			for actor in AllActorRoots do
			(
				if actor == obj then bCanAdd = false
			)
			parent = obj.parent
			while parent != undefined do
			(
				nt = GetActorNoteTrack parent
				if nt != undefined then bCanAdd = false	
				parent = parent.parent
			)
			
			return bCanAdd
		) 
		
		function MakeActorRoot obj = 
		(
			MakeActorNoteTrack obj
			
			select obj
			append AllActorRoots obj
			MakeAccumRoot obj
			b = IsAccumRoot obj
			ActivateActorRoot obj
			LayerRoot = obj
			ActiveSequence = undefined
			ActiveSequenceEnd = undefined
			ActiveNoteTrack = undefined
			ActiveInfoKeyTime = undefined
			ActiveInfoKeyText = undefined
			ActiveMorphKeyTime = undefined
			ActiveMorphKeyText = undefined
			if b == false then print "Error in MakeActorRoot: Object is not an AccumRoot."
			-- set a key at time zero with the global compression values stored
			nt = GetActorNoteTrack obj
			if nt != undefined then
			(
				index = getNoteKeyIndex nt 0
				if index == undefined then
				(
					Key = addNewNoteKey nt.keys 0
				)
				else
				(
					Key = nt.keys[Index]
				)
			)
		)

		on ddActorRoot selected itemnumber do
		(
			name = ddActorRoot.items[itemnumber]
			for root in AllActorRoots do
			(
				if root.name == name then
				(
					ActivateActorRoot root
					str =  "Actor Root: " + ActorRoot.name
					print str
					AccumRoot = FindAccumRoot ActorRoot
					if AccumRoot == undefined then MakeAccumRoot ActorRoot
					str = "Accum Root: "+ AccumRoot.name
					print str
					LayerRoot = ActorRoot
					ActiveSequence = undefined
					ActiveSequenceEnd = undefined
					ActiveNoteTrack = undefined
					ActiveInfoKeyTime = undefined
					ActiveInfoKeyText = undefined
					ActiveMorphKeyTime = undefined
					ActiveMorphKeyText = undefined
					UpdateActorGroupUI()
					select ActorRoot
				)
				else
				(
					DeactivateActorRoot root
				)
			)
		)
		
		on btnAddActorRoot picked obj do
		(
			bResult = CanCreateActorRoot obj
			if bResult == true do
			(
				print "Creating actor root!"
				print obj.name

				if ActorRoot != undefined do DeactivateActorRoot ActorRoot
				MakeActorRoot obj
				UpdateActorGroupUI()
				select ActorRoot
			)
			if bResult == false do
			(
				str = "不能添加 \"" + obj.name + "\" 做顶层根节点！\n它的父级节点或它本身已经是顶层根节点。\n"
				messagebox str title:"添加顶层根节点错误"
			)
		)
		
		on btnRemActorRoot pressed do
		(
			if ActorRoot != undefined do
			(
				RemoveAllAccumRoots ActorRoot
				DeactivateActorRoot ActorRoot	
						
				nt = GetActorNoteTrack ActorRoot
				if nt != undefined do
				(
					print "Deleting note track"
					deletenotetrack ActorRoot nt
				)
				RefreshAll()
			)
		)
		
		on btnSetAccumRoot picked obj do
		(
			parent = obj
			
			bFoundCurrentActorRoot = false		
			while parent != undefined do
			(
				if parent == ActorRoot then bFoundCurrentActorRoot = true		
				parent = parent.parent
			)

			if bFoundCurrentActorRoot == true do
			(
				RemoveAllAccumRoots ActorRoot
				MakeAccumRoot obj
			)
			
			if bFoundCurrentActorRoot == false do
			(
				str = "不能选取 \"" + obj.name + "\" 做累积根节点！\n请选择顶层根节点 \"" + ActorRoot.name + "\" 或它的子节点。\n"
				messagebox str title:"选择累积根节点错误"
			)
		)
		
		on btnResetAccumRoot pressed do
		(
			RemoveAllAccumRoots ActorRoot
			MakeAccumRoot ActorRoot
		)

		on NiActorManagerRollout open do
		(
			RefreshAll()
		)

        on NiActorManagerRollout close do
        (
            try(callbacks.removeScripts #filePreOpen id:#ActorManagerUtilPreOpen);catch()
	        try(callbacks.removeScripts #filePostOpen id:#ActorManagerUtilPostOpen);catch()	
            try(callbacks.removeScripts #systemPreReset id:#ActorManagerUtilPreReset);catch()
	            
        )
		
	)
	
	rollout ExportFilesRollout "导出"
	(
		button btnExportGim "导出gim" width:120
		button btnExportGis "导出gis" width:120
		button btnExportTrk "导出trk" width:120
		
		on btnExportGim pressed do
		(
			file = getSaveFileName caption:"导出gim" types:"NeoX Mesh(*.gim)|*.gim|All|*.*|"
			if file != undefined do
			(
				exportFile (file) using:NeoX_Mesh_Export
			)
		)
		
		on btnExportGis pressed do
		(
			file = getSaveFileName caption:"导出gis" types:"NeoX Skeletal Animation(*.gis)|*.gis|All|*.*|"
			if file != undefined do
			(
				exportFile (file) using:NeoX_Skeletal_Animation_Export
			)
		)
		
		on btnExportTrk pressed do
		(
			file = getSaveFileName caption:"导出trk" types:"NeoX Track(*.trk)|*.trk|All|*.*|"
			if file != undefined do
			(
				exportFile (file) using:NeoX_Track_Export
			)
		)
	)
		
	rollout SelectionAABBRollout "AABB包围盒"
	(
		button btnSelectionAABB "开启AABB包围盒" width:120
		on btnSelectionAABB pressed do
		(
			if enableSelectionAABB == true then
			(
				unRegisterRedrawViewsCallback draw_selection_bounding_box
			)
			else
			(
				RegisterRedrawViewsCallback draw_selection_bounding_box
			)
			enableSelectionAABB = not enableSelectionAABB
			print "enableSelectionAABB = "
			print enableSelectionAABB
		)
	)
	
	rollout NeoxBoneRollout "自动生成骨骼"
	(
		button btnSelectionAABB "自动生成骨骼" width:120
		on btnSelectionAABB pressed do
		(
			rootBone = BoneSys.CreateBone [0,0,0] [0,0,0] [0,0,1]
			rootBone.boxMode = true
			rootBone.name = "root_bone"
			rootBone.isHidden = true
			bones_set = #()
			append bones_set rootBone
			for tempObj in Selection as Array do
			(
				max modify mode
				select tempObj 
				theBone = BoneSys.CreateBone [0,0,0] [0,0,0] [0,0,1]
				theBone.Controller = Copy tempObj.Controller
				theBone.boxMode = true	
				theBone.isHidden = true
				theBone.parent = rootBone 
				theSkin = Skin()
				addModifier tempObj theSkin
				skinOps.addbone theSkin theBone 1
				append bones_set theBone
			)
			selectionSets["NeoXBones"] = bones_set
		)
	)