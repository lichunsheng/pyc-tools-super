rollout ExportGisBatchRollout "批量导出gis" width:509 height:500
(
	groupBox grp1 "max文件目录" pos:[16,15] width:458 height:61
	groupBox grp2 "gis文件目录" pos:[16,92] width:458 height:61
	editText max_path "" pos:[27,34] width:378 height:26 enabled:false
	editText gis_path "" pos:[27,115] width:378 height:26 enabled:false
	button max_browse "....." pos:[419,32] width:43 height:31
	button gis_browse "....." pos:[419,110] width:43 height:31
	button export "导出" pos:[16,163] width:43 height:31
	editText logs "" pos:[16, 200] width:458 height:270
	
	on max_browse pressed do
	(
		local path = getSavePath caption:"打开存放max文件的目录"
		if path == undefined do
		(
			path = ""
		)
		max_path.text = path
	)
	
	on gis_browse pressed do
	(
		local path = getSavePath caption:"打开存放gis文件的目录"
		if path == undefined do
		(
			path = ""
		)
		gis_path.text = path
	)

	----1 建立一个存放max文件的目录
    ----- 在这个目录里面，建立多个子目录，每个目录的名字是将要导出的gis文件名
    ----2 在子目录里面存放要导在同一个gis文件的max文件，max的文件名字就是你要导出动作名字 
    ----3 把每个max的状态调整好，使得导出器用同一套配置
    ----4 建立一个存放gis文件的目录
    ----5 使用批量导出动作的max脚本，选择max文件目录以及存放gis的目录，点击导出即可
	
	on export pressed do
	(
		local src_path = max_path.text
		local dest_path = gis_path.text
		local log_text = ""
		if src_path != "" and dest_path != "" do
		(	
			dir_array = GetDirectories(src_path + "\\*")
			for dir in dir_array do
			(
				-- get dirname for the name of gis
				tokens = filterString dir "\\"
				count = tokens.count
				gis_name = tokens[count]
				gis_name += ".gis"
				
				-- get max in the dir
				max_files = getFiles(dir + "*.max")
				for f in max_files do
				(
					if (isMaxFile f) do
					(
						-- get animname 
						anim_name = getFilenameFile f
						
						loadMaxFile f quiet:true
						local full_path = dest_path + "\\" + gis_name
						local command_str = "add#" + anim_name + "#" + full_path
						try
						(
							exportFile command_str #noPrompt using:NeoX_Skeletal_Animation_Export
						)
						catch
						(
							msg = f + " don't export"
							print msg
						)
					)
				)
			)
		)
	)
)

createDialog ExportGisBatchRollout 