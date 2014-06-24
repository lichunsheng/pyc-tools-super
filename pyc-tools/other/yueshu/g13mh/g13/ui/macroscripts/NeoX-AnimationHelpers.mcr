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

-----------------------------------------------------------------------------
-- This utility was designed to assist with Bone Level-of-detail setup.
-----------------------------------------------------------------------------
macroscript ActorManagerUtil category:"NeoX" 
	buttonText:"NeoX Animation Manager" toolTip:"NeoX Animation Manager" Icon:#("NeoX", 4)
( 
	global ActorManagerUtility
    local r_dialogue = undefined
    include "NeoX/AnimationManager.ms"

    function clean_up =
    (
        -- close the oldrollout floater if it exists
	    try(callbacks.removeScripts #filePostOpen id:#ActorManagerUtilPostOpen);catch()
        try(callbacks.removeScripts #systemPreReset id:#ActorManagerUtilPreReset);catch()
	    try(ActorManagerUtility = undefined);catch()
	    try(closerolloutfloater r_dialogue);catch()
    )

	on execute do
    (
        clean_up()
        
        -- put up new rollout floater and add rollout to it
        r_dialogue = newrolloutfloater "NeoX¹Ç÷À¶¯»­" 220 708 10 150
		addRollout NiActorManagerRollout r_dialogue rolledUp:false
		addRollout NiActorLayerRollout r_dialogue rolledUp:true
		addRollout NiActorSequenceRollout r_dialogue rolledUp:false
		addRollout NiActorCompRollout r_dialogue rolledUp:false
		addRollout NiActorAccumulationRollout r_dialogue rolledUp:true
		addRollout NiActorSeqTagsRollout r_dialogue rolledUp:true
		ActorManagerUtility = NiActorManagerRollout
		callbacks.addScript #filePostOpen "try(ActorManagerUtility.RefreshAll());catch()" id:#ActorManagerUtilPostOpen
		callbacks.addScript #systemPreReset "clean_up()" id:#ActorManagerUtilPreReset
		-- end of Macro Script; rollout takes over
    )
)
