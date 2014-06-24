rollout NeoXGimBatchExporterRollout "ģ��������������" width:159 height:500
(
	local last_path = ""
	local type_name = #("��̬ģ�� ", "����ģ�� ")
	local model_type_sel = 1
	radiobuttons model_type labels:type_name pos:[3,7] width:125 height:60

	editText imp_path "" pos:[0,45] width:90 height:20 enabled:false
	button btnImpPathBrowse "����·��..." pos:[92,45] width:63 height:20

	editText exp_path "" pos:[0,70] width:90 height:20 enabled:false
	button btnExpPathBrowse "����·��..." pos:[92,70] width:63 height:20

	button btnConfig "��������" pos:[3,95] width:70 height:20
	button btnExport "��������" pos:[80,95] width:70 height:20

	button btnHelp "���������淶��ʹ��˵��" pos:[3,125] width:150 height:20
	

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
		-- ������һ�γ����ٿ�ʼ��������
		clear_scene()
		local log_str = "����������gim�ļ���\r\n"
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
		local log_str = "����������gis�ļ���\r\n"
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
		local path = getSavePath caption:"���ô�����������ļ���Ŀ¼" initialDir:last_path
		if path == undefined do
		(
			path = ""
		)
		last_path = path
		imp_path.text = path
	)
	
	on btnExpPathBrowse pressed do
	(
		local path = getSavePath caption:"���ô�����������ļ���Ŀ¼" initialDir:last_path
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
	[+++++ max�ļ��淶˵�� +++++]��
	
		A��ģ��·��+�ļ�����ʹ��ȫӢ�ĵ�	
		
		��̬ģ�ͣ� 
		1����֧��group���ģ�͵���
		2�����ص�ģ�Ͳ�����
		3����Ҫ�ı�Ĭ�ϵĵ�������ʱ������ʹ���������á�
		4���Ծ�̬ģ�ͣ�֧��һ��max�ļ����ж��ģ�ͣ�ÿ��ģ�ͽ�����Ϊһ��gim����������Ϊ��maxģ������һ�£�\r\n\t\t����Ҫ��max���ģ������Ҳʹ��Ӣ�ļ����ֺ��»��ߵ����ơ�

		��������ģ��
		1�������ļ����������ϰ��淶����Ϊ'neox_bone_set'�������Զ�������
		2���Թ�������ģ�ͣ�ֻ֧��һ��max�ļ���һ��ģ�͡�
		3��������gis�ļ�����Ϊmax�ļ��� + '.gis'
		
	[+++++ ʹ�÷��� +++++]��
	
		1��ѡ���Ǿ�̬ģ�͵������ǹ�������ģ�͵���
		2���㵼��·����������max�ļ����ڵ��ļ��У����������ᵼ������ļ����µ�����max�ļ�
		3���㵼��·������������������gim/gis�ļ�����ŵ�·��
		4���������ã���������û�Ӧ����������Ҫ����������max�ļ�"
		messageBox help_doc_str
	)
	
)

--createdialog NeoXGimBatchExporterRollout escapeEnable:true