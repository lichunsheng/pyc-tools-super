macroScript NeoXExport_GisBatch category:"NeoX" 
	buttonText:"NeoX Export GisBatch" toolTip:"NeoX Export GisBatch" Icon:#("NeoX", 2)
(
	include "NeoX/export_gis_batch.ms"
	DestroyDialog ExportGisBatchRollout
	CreateDialog ExportGisBatchRollout
)
