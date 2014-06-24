include "StartUp/NeoX_startup.ms"

-- 资源根目录
global g_user_config = false
global g_res_root_path = ""
global g_scene_file_path = ""
global g_test_dir = "/maxpreviewtest/"
global g_rel_configure_path = "maxpreview/client/configure.ini"
global g_gim_file_name = "/maxpreviewtest/test.gim"
global g_gis_file_name = "/maxpreviewtest/test.gis"
global g_add_gim_file_name = "/maxpreviewtest/test1.gim"
global g_add_gis_file_name = "/maxpreviewtest/test1.gis"
global g_maxpreview_file_path = "/maxpreview/client/client.exe"
global g_configure_path = ""
global g_texture_dir = "/maxpreviewtest/textures/"
global g_bg_shallow_img = "/maxpreview/client/white_bg.bmp"
global g_bg_deep_img = "/maxpreview/client/dark_bg.bmp"
global g_bg_img = ""
global g_bg_type = "shallow"
global g_add_model = false
--global g_user_gis = false
global g_user_gis_path = ""

function auto_read_max_configure_path empty = 
(
	local environment,specialFolder
	environment = DotNetClass "System.Environment"
	specialFolder = DotNetClass "System.Environment+SpecialFolder"
	local path = environment.GetFolderPath specialFolder.LocalApplicationData
	g_configure_path = path + "\\MaxExporter\\main_configure.ini"
)

-- is_static_model is 字符串
function auto_write_max_configure is_static_model = 
(
	setINISetting g_configure_path "IsStaticModel" "Value" is_static_model
	setINISetting g_configure_path "res_root" "Value" g_res_root_path
	setINISetting g_configure_path "TextureDir" "Value" g_texture_dir
	setINISetting g_configure_path "CopyTexture" "Value" "true"	
	setINISetting g_configure_path "IsPreview" "Value" "true"
)
-- 从max目录里面读取相应的配置文件
function auto_read_configure empty = 
(	
	max_path = PathConfig.GetDir(#maxroot)
	configure_path = max_path + g_rel_configure_path
	g_res_root_path = getINISetting configure_path "res_root" "value"
	g_scene_file_path = getINISetting configure_path "scene_file" "value"

	return true
)

function auto_write_configure empty = 
(
	max_path = PathConfig.GetDir(#maxroot)	
	configure_path = max_path + g_rel_configure_path
	
	setINISetting configure_path "res_root" "value" g_res_root_path
	setINISetting configure_path "scene_file" "value" g_scene_file_path
	setINISetting configure_path "bg_img" "value" g_bg_img
	setINISetting configure_path "bg_type" "value" g_bg_type
	setINISetting configure_path "user_gis_path" "value" g_user_gis_path
	if (g_add_model == true) then
	(
		setINISetting configure_path "add_model" "value" "true"
	)
	else
	(
		setINISetting configure_path "add_model" "value" "false"
	)
)

function HasBoneAnimation inputObject =  
(
	 local skinModifier,resultState
	 resultState = false
	 
	 for tempModifier in inputObject.Modifiers  where
	 (
		Physique  == ClassOf tempModifier or Skin == ClassOf tempModifier
	 )
	 do skinModifier = tempModifier
	 if skinModifier != undefined do
	 (
		 boneList = refs.dependsOn skinModifier
		 for tempBone in boneList where tempBone.transform.isAnimated == true do  resultState = true
	 )
	 return resultState
)
-- 暂时不删除目录，只删除文件
function clear_preview_dir empty =
(
	local test_full_path = g_res_root_path + g_test_dir	
	for f in getFiles (test_full_path + "*.*") do
	(
		deleteFile f
	)
)

function create_preview_dir empty = 
(
	local test_full_path = g_res_root_path + g_test_dir
	makeDir test_full_path all:true
)

function test_gim_exist empty = 
(
	local test_full_path = ""
	if (not g_add_model) then 
	(
		test_full_path = g_res_root_path + g_test_dir + "\\test.gim"
	)
	else
	(
		test_full_path = g_res_root_path + g_test_dir + "\\test1.gim"
	)
	return (getfiles test_full_path).count != 0
)	

function get_shallow_img empty = 
(
	local path = PathConfig.GetDir(#maxroot)
	g_bg_type = "shallow"
	return path + g_bg_shallow_img
)

function get_deep_img empty = 
(
	local path = PathConfig.GetDir(#maxroot)
	g_bg_type = "deep"
	return path + g_bg_deep_img
)

rollout maxpreview_test "NeoxMaxPreview" width:411 height:250
(
	label lbl2 "资源根目录：" pos:[4,10] width:93 height:24 
	editText res_root_edit "" pos:[113,5] width:192 height:24 readOnly:true
	button res_root_browse "浏览" pos:[316,6] width:71 height:23
	label lbl3 "场景文件：" pos:[4,55] width:93 height:24
	editText scene_edit "" pos:[113,48] width:192 height:24 readOnly:true
	button scene_browse "浏览" pos:[318,49] width:71 height:23
	checkbox user_config "用户配置" pos:[4, 118] width:83 height:22 checked:false
	label lbl4 "            ----------------------------------------------------------------------------------" pos:[45,84] width:341 height:33
	Radiobuttons bg_config "背景图片" pos:[208, 118] labels:#("浅色", "深色") default:1
	checkbox add_model "叠加模型" pos:[208, 190] width:83 height:22 checked:false
	button theStaticButton "静态模型预览" pos:[4,155] width:187 height:23
	button theSkeletalButton "骨骼动画模型预览" pos:[4,190] width:187 height:23
	
	checkbox user_gis "gis设置" pos:[4, 222] width:83 height:22 checked:false
	editText gis_edit "" pos:[76, 220] width:192 height:24 readOnly:true
	button gis_browse "浏览" pos:[270, 220] width:71 height:23 enabled:false

	on bg_config changed theState do
	(
		state = case bg_config.state of
		(
			1: g_bg_img = get_shallow_img ""
			2: g_bg_img = get_deep_img ""
		)
	)
	
	on user_config changed theState do
	(
		g_user_config = user_config.state
	)
	
	on user_gis changed theState do
	(
		local state = user_gis.state
		gis_browse.enabled = state
		
		if (state == false) then
		(
			g_user_gis_path = ""
		)
		else
		(
			g_user_gis_path = gis_edit.text
		)
		
		auto_write_configure ""
	)
	
	on add_model changed theState do
	(
		g_add_model = add_model.state
	)
	
	on res_root_browse pressed do
	(
		local old_res_root_path = g_res_root_path
		g_res_root_path = getSavePath caption: "资源根目录" initialDir:""
		if (g_res_root_path == undefined) then
		(
			g_res_root_path = old_res_root_path
		)
		res_root_edit.text = g_res_root_path
		auto_write_configure ""
		create_preview_dir ""
	)
	
	on gis_browse pressed do
	(
		local gis_path = getOpenFileName caption: "动画文件" filename: ""
		if (gis_path == undefined) then
		(
			gis_path = ""
		)
		gis_edit.text = gis_path
		g_user_gis_path = gis_path
		
		auto_write_configure ""
	)
	
	on scene_browse pressed do
	(
		local old_scene_path = g_scene_file_path
		g_scene_file_path = getOpenFileName caption: "场景文件" filename: old_scene_path
		if (g_scene_file_path == undefined) then
		(
			g_scene_file_path = old_scene_path
		)
		scene_edit.text = g_scene_file_path
		auto_write_configure ""
	)
	
	
	on theStaticButton pressed do
	(
		--首先读取配置文件，取得全局信息
		suc = auto_read_configure ""
		if (not suc) then
		(
			messagebox "请设置资源根目录!"
			return false
		)
		
		local gim_full_path = ""
		if (not g_add_model) then
		(
			clear_preview_dir ""
			gim_full_path = g_res_root_path + g_gim_file_name
		)
		else
		(
			gim_full_path = g_res_root_path + g_add_gim_file_name
		)
		
		auto_read_max_configure_path ""
		
		auto_write_max_configure "true"
		
		try
		(
			if (not g_user_config) then
			(	
				exportFile gim_full_path  #noPrompt using:NeoX_Mesh_Export
			)
			else
			(
				exportFile gim_full_path using:NeoX_Mesh_Export
			)
		)
		catch
		(
			messageBox "don't preview the model"
			return false
		)

		--最后启动预览窗口
		max_path = PathConfig.GetDir(#maxroot)
		preview_exe = max_path + g_maxpreview_file_path
		auto_write_configure ""
		
		exist = test_gim_exist ""
		
		if (exist == true) then
		(
			max_path = PathConfig.GetDir(#maxroot)
			configure_path = max_path + g_rel_configure_path
			ShellLaunch preview_exe configure_path
		)
		
		return true
	)
	
	on theSkeletalButton pressed do
	(
		--首先读取配置文件，取得全局信息
		suc = auto_read_configure ""
		if (not suc) then
		(
			messagebox "请设置资源根目录!"
			return false
		)
		
		local gis_full_path = ""
		local gim_full_path = ""
		if (not g_add_model) then
		(
			clear_preview_dir ""
			--操作是进行gim和gis的导出
			gis_full_path = g_res_root_path + g_gis_file_name
			gim_full_path = g_res_root_path + g_gim_file_name
		)
		else
		(
			gis_full_path = g_res_root_path + g_add_gis_file_name
			gim_full_path = g_res_root_path + g_add_gim_file_name
		)
		
		auto_read_max_configure_path ""
		
		auto_write_max_configure "false"
		
		try
		(
			if (g_user_gis_path == "") then
			(
				if (not g_user_config) then
				(
					exportFile gis_full_path #noPrompt using:NeoX_Skeletal_Animation_Export
				)
				else
				(
					exportFile gis_full_path using:NeoX_Skeletal_Animation_Export
				)
			)
			
			if (not g_user_config) then
			(
				exportFile gim_full_path  #noPrompt using:NeoX_Mesh_Export
			)
			else
			(
				exportFile gim_full_path using NeoX_Mesh_Export
			)
		)
		catch
		(
			messageBox "don't preview the model"
			return false
		)
	
		--最后启动预览窗口
		max_path = PathConfig.GetDir(#maxroot)
		preview_exe = max_path + g_maxpreview_file_path
		auto_write_configure ""
		
		exist = test_gim_exist ""
		
		if (exist == true) then
		(
			max_path = PathConfig.GetDir(#maxroot)
			configure_path = max_path + g_rel_configure_path
			ShellLaunch preview_exe configure_path
		)

		return true 
	)
)

createDialog maxpreview_test style: #(#style_titlebar, #style_border, #style_sysmenu, #style_minimizebox, #style_maximizebox) placement:#minimized
auto_read_configure ""
maxpreview_test.res_root_edit.Text = g_res_root_path
maxpreview_test.scene_edit.Text = g_scene_file_path
create_preview_dir ""
g_bg_img = PathConfig.GetDir(#maxroot) + g_bg_shallow_img
