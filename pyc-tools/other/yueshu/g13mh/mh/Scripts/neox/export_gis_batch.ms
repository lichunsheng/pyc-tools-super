rollout ExportGisBatchRollout "��������gis" width:509 height:500
(
	groupBox grp1 "max�ļ�Ŀ¼" pos:[16,15] width:458 height:61
	groupBox grp2 "gis�ļ�Ŀ¼" pos:[16,92] width:458 height:61
	editText max_path "" pos:[27,34] width:378 height:26 enabled:false
	editText gis_path "" pos:[27,115] width:378 height:26 enabled:false
	button max_browse "....." pos:[419,32] width:43 height:31
	button gis_browse "....." pos:[419,110] width:43 height:31
	button export "����" pos:[16,163] width:43 height:31
	editText logs "" pos:[16, 200] width:458 height:270
	
	on max_browse pressed do
	(
		local path = getSavePath caption:"�򿪴��max�ļ���Ŀ¼"
		if path == undefined do
		(
			path = ""
		)
		max_path.text = path
	)
	
	on gis_browse pressed do
	(
		local path = getSavePath caption:"�򿪴��gis�ļ���Ŀ¼"
		if path == undefined do
		(
			path = ""
		)
		gis_path.text = path
	)

	----1 ����һ�����max�ļ���Ŀ¼
    ----- �����Ŀ¼���棬���������Ŀ¼��ÿ��Ŀ¼�������ǽ�Ҫ������gis�ļ���
    ----2 ����Ŀ¼������Ҫ����ͬһ��gis�ļ���max�ļ���max���ļ����־�����Ҫ������������ 
    ----3 ��ÿ��max��״̬�����ã�ʹ�õ�������ͬһ������
    ----4 ����һ�����gis�ļ���Ŀ¼
    ----5 ʹ����������������max�ű���ѡ��max�ļ�Ŀ¼�Լ����gis��Ŀ¼�������������
	
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