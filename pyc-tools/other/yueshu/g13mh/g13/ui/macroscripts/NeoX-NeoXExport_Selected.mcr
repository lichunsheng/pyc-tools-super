macroScript NeoXExport_Selected category:"NeoX" 
	buttonText:"NeoX Export Selected" toolTip:"NeoX Export Selected" Icon:#("NeoX", 11)
(
    include "NeoX/GimFileManager.ms"

	local node_set = selection as array
	build_gim_map(node_set)
	for i=1 to gim_names.count do
	(
		clearSelection()
		for j=1 to gim_nodes[i].count do
		(
			selectMore gim_nodes[i][j]
		)
		exportFile gim_names[i] using:NeoX_Mesh_Export
	)
)
