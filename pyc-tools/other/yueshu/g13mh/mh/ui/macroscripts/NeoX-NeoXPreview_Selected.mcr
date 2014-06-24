macroScript NeoXPreview_Selected category:"NeoX" 
	buttonText:"NeoX Preview Selected" toolTip:"NeoX Preview Selected" Icon:#("NeoX", 12)
(
	exportFile "preview.gim" #noPrompt selectedOnly:true using:NeoX_Mesh_Export
)
