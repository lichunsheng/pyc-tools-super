NeoXExporterVersion = "1.0"

function GetNeoXExporterVersion = 
(
	return NeoXExporterVersion;
)

function NeoXGetSelectionBoxMax = 
(
	return Selection.Max
)

function NeoXGetSelectionBoxMin = 
(
	return Selection.Min
)

function NeoXColorToString color = 
(
	local str = stringStream ""
	format "%,%,%,1.0" (color.r/255.0) (color.g/255.0) (color.b/255.0) to: str
	return str as string
)

function NeoXBoolToString b = 
(
	if (b != undefined and b) then return "True"
	else return "False"
)

function NeoxLogToListener log =
(
	print log
)

function NeoxVertexColor node color = 
(
	convertToMesh node
	defaultVCFaces node
	
	count = GetNumVerts node
	for i = 1 to count do
	(
		SetVertColor node.mesh i color
	)
	
	update node
)

global Unwrella2_found = true

function NeoxUvwnie node = 
(
	if (not Unwrella2_found) then
	(
		return false
	)
	local u = Unwrella2()
	if (u == undefined) then
	(
		Unwrella2_found = false
		messageBox "找不到Unwrella2插件，无法自动展开第二层UV" title:"警告"
		return false
	)
	u.map_channel = 2
	u.mode = 1
	u.preview = off
	addModifier node u
	u.unwrap()	
)

function NeoxUvwnieOnEnd node = 
(
	deleteModifier node 1
)

function NeoxAutoRunX2Need node = 
(
	NeoxVertexColor node white
	NeoxUnwrella2 node
)

function ExistFile fname = (getfiles fname).count != 0

global NeoXMeshOption_ResRoot
global NeoXMeshOption_GimPath
global NeoXMeshOption_TexDir
global NeoXMeshOption_EffectPath
global NeoXMeshOption_CopyTexFiles
global NeoXMeshOption_CompressTex
global NeoXMeshOption_HasTexInfo

struct PathMap (dest, src)

global neox_cancel_copy_tex = false
global neox_compress_array = #()
global dds_quality = #("-quality_normal", "-quick", "-quality_production", "-quality_highest")

function NeoXCopyTextureFile src_path dest_path =
(
	if (not ExistFile src_path) then
	(
		local msg = "贴图文件: " + src_path + " 不存在"
		print "[ERROR]" + msg
		--messageBox msg title:"警告"
		return false
	)
	local suc = false
	local dest_dir = pathConfig.removePathLeaf dest_path
	if (dest_dir != "") then
	(
		local dirs = getDirectories dest_dir 
		if (dirs.count > 0) then
		(
			suc = copyFile src_path dest_path
		)
		else
		(
			local str = "正在复制贴图文件到 " + dest_dir +  "，此文件夹不存在，是否创建？"
			if (queryBox str title:"创建文件夹") and (makeDir dest_dir all:true) then
			(
				suc = copyFile src_path dest_path
			)
			else
			(
				neox_cancel_copy_tex = true
				messageBox "复制贴图文件失败，请在模型编辑器中编辑贴图文件路径！" title:"温馨提示"
			)
		)
	)
		
	if (not suc) then
	(
		print "[ERROR] Failed to copy texture file " + src_path + " to " + dest_path
	)
)

function NeoXProcessTexture map_path = 
(
	local tex_path = ""

	if (NeoXMeshOption_CopyTexFiles) then
	(
		local tex_file = pathConfig.stripPathToLeaf map_path
		tex_path = pathConfig.appendPath NeoXMeshOption_TexDir tex_file
		local full_path = ""
		if (pathConfig.isAbsolutePath tex_path) then
		(
			full_path = tex_path
		)
		else
		(
			full_path = pathConfig.appendPath NeoXMeshOption_ResRoot tex_path
		)
		if (not neox_cancel_copy_tex) then
		(
			NeoXCopyTextureFile map_path full_path
		)
		
		if (NeoXMeshOption_CompressTex) then
		(
			path_node = PathMap dest:full_path src:map_path
			append neox_compress_array path_node
		)
	)
	else
	(
		-- 采用同gim相同目录
		--tex_path = pathConfig.convertPathToRelativeTo NeoXMeshOption_GimPath NeoXMeshOption_ResRoot
		--tex_file_name = pathConfig.stripPathToLeaf map_path
		--tex_path = pathConfig.appendPath tex_path tex_file_name
		--if (NeoXMeshOption_CompressTex) then
		--(
			--dest_path = NeoXMeshOption_ResRoot + "\\" + tex_file_name
			--path_node = PathMap dest:dest_path src:map_path
			--append neox_compress_array path_node
		--)
		
		tex_path = pathConfig.convertPathToRelativeTo map_path NeoXMeshOption_ResRoot
		--tex_file_name = pathConfig.stripPathToLeaf map_path
		--tex_path = pathConfig.appendPath tex_path tex_file_name
	)
	tex_path = pathConfig.convertPathToLowerCase tex_path
	
	return tex_path
)

function NeoXTexmapToString texmap = 
(
	if (texmap == undefined) then
	(
		return ""
	)
	else
	(
		return NeoXProcessTexture texmap.filename
	)
)

struct MatieralWriter
(
	writer, mtl,
	
	fn Init _writer _mtl =
	(
		writer = _writer
		mtl = _mtl
	),

	fn WriteHeader =
	(
		writer.WriteStartElement "Material"
		writer.WriteAttributeString "Version" "0,0,1,3"
		writer.WriteAttributeString "Name" mtl.name
	),

	fn WriteFooter =
	(
		writer.WriteEndElement()
	),
	
	fn WriteLighting =
	(
		if (mtl.useSelfIllumColor) then
		(
			si_color = mtl.selfIllumColor
		)
		else
		(
			si_color = mtl.diffuse * (mtl.selfIllumAmount / 100.0)
		)
		sp_color = mtl.specular * (mtl.specularLevel / 100.0)
		writer.WriteStartElement "LightingMaterial"
		writer.WriteAttributeString "Ambient" (NeoXColorToString mtl.ambient)
		writer.WriteAttributeString "Diffuse" (NeoXColorToString mtl.diffuse)
		writer.WriteAttributeString "Specular" (NeoXColorToString sp_color)
		writer.WriteAttributeString "Power" (formattedPrint mtl.glossiness format:"0.0f")
		writer.WriteAttributeString "Emissive" (NeoXColorToString si_color)
		writer.WriteEndElement()
	),

	fn SerializeUserDefined node_name =
	(
		local n = getnodebyname node_name exact:true

		writer.WriteStartElement "Material"
		writer.WriteAttributeString "Version" "0,0,1,3"
		writer.WriteAttributeString "Name" node_name		
		
		writer.WriteStartElement "Technique"
		writer.WriteAttributeString "Type" "Effect"
		writer.WriteAttributeString "TechName" (NeoXMeshOption_EffectPath)
		writer.WriteEndElement()
	
		writer.WriteStartElement "ParamTable"
		writer.WriteStartElement "Tex0"
		writer.WriteAttributeString "Value" ""
		writer.WriteEndElement()
		writer.WriteEndElement()
	
		writer.WriteStartElement "LightingMaterial"
		writer.WriteAttributeString "Ambient" "0.0,0.0,0.0,0.0"
		writer.WriteAttributeString "Diffuse" "0.0,0.0,0.0,0.0"
		writer.WriteAttributeString "Specular" "0.0,0.0,0.0,0.0"
		writer.WriteAttributeString "Emissive" "0,0,0,0.0"
		writer.WriteAttributeString "Power" "0"
		writer.WriteEndElement()

		writer.WriteStartElement "RenderStates"
		writer.WriteAttributeString "LightingEnable" (NeoXBoolToString false)	
		writer.WriteAttributeString "SpecularEnable" (NeoXBoolToString false)
		writer.WriteAttributeString "VColorEnable" (NeoXBoolToString false)
		writer.WriteAttributeString "CullBack" (NeoXBoolToString true)
		writer.WriteAttributeString "AlphaTestEnable" (NeoXBoolToString false)
		writer.WriteEndElement()
		
		if ((getUserProp n "alpha_ref") != undefined) then
		(
			writer.WriteStartElement "RasterizerState"
			writer.WriteAttributeString "AlphaTestEnable" (NeoXBoolToString ((getUserProp n "alpha_ref") > 0))
			writer.WriteAttributeString "AlphaRef" (formattedPrint (getUserProp n "alpha_ref") format:"d")
			writer.WriteEndElement()
		)
		
		WriteFooter()
	),

	fn SerializeStandard =
	(
		WriteHeader()
		
		writer.WriteStartElement "Technique"
		writer.WriteAttributeString "Type" "Effect"
		writer.WriteAttributeString "TechName" (NeoXMeshOption_EffectPath)	
		writer.WriteEndElement()
	
		writer.WriteStartElement "ParamTable"
	
		writer.WriteStartElement "Tex0"
	
		local tex_path = ""
		if (NeoXMeshOption_HasTexInfo) then
		(
			tex_path = NeoXTexmapToString mtl.diffuseMap
		)
		writer.WriteAttributeString "Value" tex_path
		writer.WriteEndElement()
	
		writer.WriteEndElement()
	
		WriteLighting()

		writer.WriteStartElement "RenderStates"
		writer.WriteAttributeString "LightingEnable" (NeoXBoolToString false)	
		writer.WriteAttributeString "SpecularEnable" (NeoXBoolToString false)
		writer.WriteAttributeString "VColorEnable" (NeoXBoolToString false)
		writer.WriteAttributeString "CullBack" (NeoXBoolToString true)
		writer.WriteAttributeString "AlphaTestEnable" (NeoXBoolToString false)
		writer.WriteEndElement()
		WriteFooter()
	),

	fn SerializeNCE =
	(
		WriteHeader()
		
		writer.WriteStartElement "Technique"
		writer.WriteAttributeString "TechName" (NeoXMeshOption_EffectPath)
		writer.WriteAttributeString "Type" "Effect"
		writer.WriteEndElement()
	
		writer.WriteStartElement "ParamTable"
	
		writer.WriteStartElement "DiffuseColorOp"
		writer.WriteAttributeString "Semantic" "0"
		writer.WriteAttributeString "Type" "2"
		writer.WriteAttributeString "Value" (formattedPrint (mtl.ColorMode+1) format:"d") 
		writer.WriteEndElement()
	
		writer.WriteStartElement "BlendEnable"
		writer.WriteAttributeString "Semantic" "0"
		writer.WriteAttributeString "Type" "1"
		writer.WriteAttributeString "Value" "False"
		writer.WriteEndElement()
	
		writer.WriteStartElement "SrcBlendMode"
		writer.WriteAttributeString "Semantic" "0"
		writer.WriteAttributeString "Type" "2"
		writer.WriteAttributeString "Value" (formattedPrint (mtl.AlphaOPSrc+1) format:"d") 
		writer.WriteEndElement()
	
		writer.WriteStartElement "DestBlendMode"
		writer.WriteAttributeString "Semantic" "0"
		writer.WriteAttributeString "Type" "2"
		writer.WriteAttributeString "Value" (formattedPrint (mtl.AlphaOPDest+1) format:"d") 
		writer.WriteEndElement()
	
		for i = 1 to 5 do
		(
			if (mtl.mapEnables[i]) then
			(
				writer.WriteStartElement ("Tex" + (formattedPrint (i-1) format:"d"))
				writer.WriteAttributeString "Semantic" "0"
				writer.WriteAttributeString "Type" "9"
				local tex_path = ""
				if (NeoXMeshOption_HasTexInfo) then
				(
					tex_path = NeoXTexmapToString (getSubTexmap mtl i)
				)
				writer.WriteAttributeString "Value" tex_path
				writer.WriteEndElement()
			)
		)
		writer.WriteEndElement()

		WriteLighting()
		
		writer.WriteStartElement "VertexState"
		writer.WriteAttributeString "Lighting" (NeoXBoolToString (mtl.LightMode == 0))
		writer.WriteAttributeString "SpecularEnable" (NeoXBoolToString (mtl.glossiness > 0.01))
		writer.WriteAttributeString "CullBack" (NeoXBoolToString true)
		writer.WriteAttributeString "AlphaTestEnable" (NeoXBoolToString mtl.AlphaTest)
		if (mtl.AlphaTest) then
		(
			writer.WriteAttributeString "AlphaRef" (formattedPrint mtl.AlphaTestValue format:"d")
		)
		writer.WriteEndElement()

		WriteFooter()
	)
)


include "NeoX/MaterialPlugin.ms"


function IsSameClass c1 c2 = 
(
	return c1.classID[1] == c2.classID[1] and c1.classID[2] == c2.classID[2]
)

function NeoxClearCompressPaths = 
(
	neox_compress_array = #()
)

function NeoXRunCompressProgress quality = 
(
	if (NeoXMeshOption_CompressTex) then 
	(
		-- 对文件进行分析
		--   BMP ---》DXT1 +1bit alpha
		--   TGA ---> DXT5
		-- 生成批处理文件bat
		max_path = PathConfig.GetDir(#maxroot)
		bat_path = max_path + "neoxcompress.bat"
		
		bat_stream = openFile bat_path mode:"w"
		if (bat_stream != undefined) then
		(	
			format "@echo 准备压缩图片，请耐心等待。。\n" to:bat_stream
			count = neox_compress_array.count
			for i = 1 to count do
			(
				path_node = neox_compress_array[i]
				dest = path_node.dest	
				is = false
				find_id = findString dest ".bmp"
				option = "-dxt5" + " " + dds_quality[quality + 1]
				if (find_id != undefined) then
				(
					is = true
					option = "-dxt1a" + " " + dds_quality[quality + 1]
				)
				else
				(
					find_id = findString dest ".tga"
					if (find_id != undefined) then
					(
						is = true
					)
				)
				if (is) then
				(
					length = dest.count - find_id + 1
					new_dest = replace dest find_id length ".dds"			
					command = "nvdxt.exe" + " " + "-file " + "\"" + path_node.src + "\"" + " -output " + "\"" + new_dest + "\"" + " " + option + "\n"
					format command to:bat_stream
				)
			)
			format "@echo 压缩完成\n" to:bat_stream
			format "pause" to:bat_stream
			flush bat_stream
			close bat_stream
			
			--执行bat
			ShellLaunch bat_path ""
		)
	)
)

function NeoXGetMaterialGroup mtl_list node_list neox_mtl_unique_id_list =
(
	dotnet.LoadAssembly "System.Text.dll"
	Encoding = dotNetClass "System.Text.Encoding"

	dotnet.LoadAssembly "System.IO.dll"
	SeekOrigin = dotNetClass "System.IO.SeekOrigin"
	string_writer = dotNetObject "System.IO.MemoryStream"

	dotnet.LoadAssembly "System.Xml.dll"
	XmlWriter = dotNetClass "System.Xml.XmlWriter"
	settings = dotNetObject "System.Xml.XmlWriterSettings"
	settings.Indent = true
	settings.IndentChars = "\t"
	settings.OmitXmlDeclaration = false
	settings.NewLineOnAttributes = true
	settings.Encoding = Encoding.UTF8
	
	writer = XmlWriter.Create string_writer settings

	local mtls_count = mtl_list.count
	local mtls_count_str = (formattedPrint (mtls_count) format:"d")
	
	writer.WriteStartElement "NeoX"
	writer.WriteStartElement "MaterialGroup"
	writer.WriteAttributeString "Version" "0,0,1,4"
	writer.WriteAttributeString "Name" ""
	writer.WriteAttributeString "MaterialCount" mtls_count_str
	
	mtl_writer = MatieralWriter()
	
	for i = 1 to mtl_list.count do
	(
		writer.WriteStartElement ("Material_" + (formattedPrint (i-1) format:"d"))
		writer.WriteAttributeString "Type" "0"

		local mtl = undefined
		if (mtl_list[i].count == 1) then
		(
			mtl = sceneMaterials[mtl_list[i][1]]
		)
		else
		(
			mtl = sceneMaterials[mtl_list[i][1]][mtl_list[i][2]]
		)
		
		if (mtl != undefined) then
		(
			mtl_writer.Init writer mtl
			writer.WriteAttributeString "Id" neox_mtl_unique_id_list[i]
			if (IsSameClass mtl NeoXMaterial) then
			(
				mtl.Serialize mtl_writer
			)
			else if (IsSameClass mtl StandardMaterial) then
			(
				if (mtl.shaderByName == "NCE Default Material") then
				(
					mtl_writer.SerializeNce()
				)
				else if (mtl.shaderByName == "Anisotropic" or mtl.shaderByName == "Blinn" or mtl.shaderByName == "Phong") then
				(
					mtl_writer.SerializeStandard()
				)
				else if (mtl.shaderByName == "(A)各项异性" or mtl.shaderByName == "(B)Blinn" or mtl.shaderByName == "(P)Phong") then
				(
					mtl_writer.SerializeStandard()
				)
				else
				(
					mtl_writer.SerializeUserDefined node_list[i]
				)
			)
			else
			(
				mtl_writer.SerializeUserDefined node_list[i]
			)
		)
		else
		(
			mtl_writer.Init writer undefined
			mtl_writer.SerializeUserDefined node_list[i]
		)
		writer.WriteEndElement()
	)
	
	writer.WriteEndElement()
	writer.WriteEndElement()
	writer.Flush()
	writer.Close()
	
	local ret_str = ""
	local ret_buffer = string_writer.GetBuffer()
	for i = 1 to string_writer.Length do
	(
		ret_str += bit.intAsChar ret_buffer[i]
	)
	return ret_str
)

utility ActorManagerUtil "NeoX Animation Manager"  -- define the utility name and description string 
( 
	global ActorManagerUtility
	label ActorManagerUtilVersion "Version: 1.0.0" align:#center

    include "NeoX/AnimationManager.ms"

	on  ActorManagerUtil open do 
	( 
		addRollout NeoxBoneRollout rolledUp:true
		addRollout SelectionAABBRollout rolledUp:true
		addRollout ExportFilesRollout rolledUp:true
		addRollout NiActorManagerRollout rolledUp:false
		addRollout NiActorLayerRollout rolledUp:true
		addRollout NiActorSequenceRollout rolledUp:false
		addRollout NiActorCompRollout rolledUp:false
		addRollout NiActorAccumulationRollout rolledUp:true
		addRollout NiActorSeqTagsRollout rolledUp:true
		ActorManagerUtility = NiActorManagerRollout
		callbacks.addScript #filePostOpen "try(ActorManagerUtility.RefreshAll());catch()" id:#ActorManagerUtilPostOpen
	) 

	on  ActorManagerUtil close do 
	( 
		callbacks.removeScripts #filePostOpen id:#ActorManagerUtilPostOpen
		ActorManagerUtility = undefined
		removeRollout NeoxBoneRollout
		removeRollout SelectionAABBRollout
		removeRollout ExportFilesRollout
		removeRollout NiActorManagerRollout 
		removeRollout NiActorLayerRollout
		removeRollout NiActorCompRollout
		removeRollout NiActorAccumulationRollout
		removeRollout NiActorSeqTagsRollout
		removeRollout NiActorSequenceRollout
	) 
)

utility BatchExporterUtil "NeoX Batch Exporter"  -- define the utility name and description string
(
	global BatchExporterUtility
	HyperLink help_link "NeoX引擎批量导出工具说明" pos:[5,7]
		color:(color 255 0 0) 
		hovercolor:(color 255 255 0)
		visitedcolor:(color 0 0 255)
		address:"http://bbs.neox.netease.com/viewthread.php?tid=127&extra=page%3D1&frombbs=1"
	label BatchExporterUtilityVersion "Version: 1.0.0" align:#center

	include "NeoX/BatchExporter.ms"
	
	on  BatchExporterUtil open do 
	( 
		addRollout NeoXGimBatchExporterRollout rolledUp:false
		BatchExporterUtility = NeoXGimBatchExporterRollout
		callbacks.addScript #filePostOpen "try(BatchExporterUtility.RefreshAll());catch()" id:#BatchExporterUtilPostOpen
	) 

	on  BatchExporterUtil close do 
	( 
		callbacks.removeScripts #filePostOpen id:#BatchExporterUtilPostOpen
		BatchExporterUtility = undefined
		removeRollout NeoXGimBatchExporterRollout
	) 
)
