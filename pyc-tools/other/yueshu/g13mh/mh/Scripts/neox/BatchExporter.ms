rollout NeoXGimBatchExporterRollout "模型批量导出工具" width:159 height:500
(
	local last_path = ""
	local type_name = #("静态模型 ", "动画模型 ")
	local model_type_sel = 1
	radiobuttons model_type labels:type_name pos:[3,7] width:125 height:60

	editText imp_path "" pos:[0,45] width:90 height:20 enabled:false
	button btnImpPathBrowse "导入路径..." pos:[92,45] width:63 height:20

	editText exp_path "" pos:[0,70] width:90 height:20 enabled:false
	button btnExpPathBrowse "导出路径..." pos:[92,70] width:63 height:20

	button btnConfig "配置设置" pos:[3,95] width:70 height:20
	button btnExport "批量导出" pos:[80,95] width:70 height:20

	button btnHelp "批量导出规范及使用说明" pos:[3,125] width:150 height:20
	

	on NeoXGimBatchExporterRollout open do
	(
	)

	fn clear_scene =
	(
		delete objects
	)
	
	fn check_special_object obj_name = 
	(
		if matchPattern obj_name pattern:"col_*" then
		(
			return true
		)
		if matchPattern obj_name pattern:"collision*" then
		(
			return true
		)
		
		if matchPattern obj_name pattern:"occ1_*" then
		(
			return true
		)
		if matchPattern obj_name pattern:"umbra_1*" then
		(
			return true
		)	
		
		if matchPattern obj_name pattern:"occ2_*" then
		(
			return true
		)
		if matchPattern obj_name pattern:"umbra_2*" then
		(
			return true
		)	

		if matchPattern obj_name pattern:"pick_*" then
		(
			return true
		)
		if matchPattern obj_name pattern:"picker*" then
		(
			return true
		)
		return false
	)
	
	fn exportMesh file_list =
	(
		-- 先清理一次场景再开始批量导出
		clear_scene()
		local log_str = "导出了如下gim文件：\r\n"
		for file in file_list do
		(	
			loadMaxFile(file) quiet:true
			
			local name = getFilenameFile file
			local full_path = exp_path.text + "\\" + name + ".gim"
			exportFile full_path #noPrompt using:NeoX_Mesh_Export
			log_str += full_path + "\r\n"
			clear_scene()
		)
		print log_str
	)

	fn exportSkeletalAnimation file_list =
	(
		local log_str = "导出了如下gis文件：\r\n"
		for file in file_list do
		(	
			loadMaxFile(file) quiet:true
			local name = getFilenameFile file 
			-- export gis
			local full_path = exp_path.text + "\\" + name + ".gis"
			SetAnimName(name)
			exportFile full_path #noPrompt using:NeoX_Skeletal_Animation_Export
			log_str += full_path + "\r\n"
			clear_scene()
		)
		print log_str
	)
	
	fn meshExportConfig =
	(
		local obj = box()
		obj.name = "_neox_obj"
		local full_path = exp_path.text + "\\" + obj.name + ".gim"
		select obj
		exportFile full_path using:NeoX_Mesh_Export
		local file_list = getFiles(exp_path.text + "\\" + obj.name + ".*")
		for file in file_list do
		(
			deleteFile file
		)
		clear_scene()
	)
	
	fn skeletalAnimationExportConfig =
	(
		local obj = convertToPoly(box())
		local b = BoneSys.createBone [0,0,0] [0,0,1] [0,0,1]
		selectionSets["neox_bone_set"] = #(b)	
		local m = skin()
		addModifier obj (m)
		select obj
		max modify mode
		skinOps.addBone obj.skin b 1
		obj.name = "_neox_obj"
		local full_path = exp_path.text + "\\" + obj.name + ".gis"
		exportFile full_path using:NeoX_Skeletal_Animation_Export
		local file_list = getFiles(exp_path.text + "\\" + obj.name + ".*")
		for file in file_list do
		(
			deleteFile file
		)
		delete obj
		delete b
	)
	
	on model_type changed state do
	(
		model_type_sel = model_type.state
	)

	on btnConfig pressed do
	(
		case model_type_sel of
		(
			1: meshExportConfig()
			2: skeletalAnimationExportConfig()
		)
	)
	
	on btnExport pressed do
	(
		clear_scene()
		local file_list = getFiles (imp_path.text + "\\*.max")
		case model_type_sel of
		(
			1: exportMesh(file_list)
			2: exportSkeletalAnimation(file_list)
		)
	)
	
	on btnImpPathBrowse pressed do
	(
		local path = getSavePath caption:"设置存放批量导出文件的目录" initialDir:last_path
		if path == undefined do
		(
			path = ""
		)
		last_path = path
		imp_path.text = path
	)
	
	on btnExpPathBrowse pressed do
	(
		local path = getSavePath caption:"设置存放批量导出文件的目录" initialDir:last_path
		if path == undefined do
		(
			path = ""
		)
		last_path = path
		exp_path.text = path
	)
	
	on btnHelp pressed do
	(
		local help_doc_str = "
	[+++++ max文件规范说明 +++++]：
	
		A：模型路径+文件名请使用全英文的	
		
		静态模型： 
		1：不支持group里的模型导出
		2：隐藏的模型不导出
		3：需要改变默认的导出设置时，可以使用配置设置。
		4：对静态模型，支持一个max文件里有多个模型，每个模型将导出为一个gim，命名规则为和max模型名称一致，\r\n\t\t所以要求max里的模型命名也使用英文加数字和下划线的名称。

		骨骼动画模型
		1：动作文件，骨骼集合按规范命名为'neox_bone_set'，便于自动处理。
		2：对骨骼动作模型，只支持一个max文件里一个模型。
		3：导出的gis文件命名为max文件名 + '.gis'
		
	[+++++ 使用方法 +++++]：
	
		1：选择是静态模型导出还是骨骼动画模型导出
		2：点导入路径，这里是max文件所在的文件夹，批量导出会导出这个文件夹下的所有max文件
		3：点导出路径，这是批量导出的gim/gis文件所存放的路径
		4：配置设置，这里的配置会应用于所有需要批量导出的max文件"
		messageBox help_doc_str
	)
	
)

--createdialog NeoXGimBatchExporterRollout escapeEnable:true