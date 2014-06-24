macroScript NeoXGimFileManager category:"NeoX" 
	buttonText:"NeoX GimFiles Manager" toolTip:"NeoX GimFiles Manager" Icon:#("NeoX", 6)
( 
	global GimFileManagerUtility
    local r_dialogue = undefined

    include "NeoX/GimFileManager.ms"

    function CleanUp =
    (
	    try(callbacks.removeScripts #filePostOpen id:#GimFileManagerUtilPostOpen);catch()
        try(callbacks.removeScripts #systemPreReset id:#GimFileManagerUtilPreReset);catch()
	    try(GimFileManagerUtility = undefined);catch()
	    try(closerolloutfloater r_dialogue);catch()
    )

	on execute do
    (
        CleanUp()
        
        r_dialogue = newrolloutfloater "NeoX GimFiles Manager Utility" 220 400 10 200
		addRollout NeoXGimFilesRollout r_dialogue rolledUp:false
		GimFileManagerUtility = NeoXGimFilesRollout
		callbacks.addScript #filePostOpen "try(GimFileManagerUtility.RefreshAll());catch()" id:#GimFileManagerUtilPostOpen
		callbacks.addScript #systemPreReset "CleanUp()" id:#GimFileManagerUtilPreReset
    )
)
