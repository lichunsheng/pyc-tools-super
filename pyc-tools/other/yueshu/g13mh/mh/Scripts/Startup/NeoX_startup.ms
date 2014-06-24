
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

function NeoXTwoSideToCullMode b = 
(
	if (b) then return "None"
	else return "CCW"
)

function NeoxLogToListener log =
(
	print log
)

global NeoXMeshOption_ResRoot
global NeoXMeshOption_TexDir
global NeoXMeshOption_EffectPath
global NeoXMeshOption_CopyTexFiles
global NeoXMeshOption_HasTexInfo


global neox_cancel_copy_tex = false

function NeoXCopyTextureFile src_path dest_path =
(
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
	)
	else
	(
		tex_path = pathConfig.convertPathToRelativeTo map_path NeoXMeshOption_ResRoot
		if (pathConfig.isAbsolutePath tex_path) then
		(
			-- 记录绝对路径
			tex_path = map_path
		)
		else
		(
			-- 记录相对路径
			if (tex_path[1] == "\\") then
			(
				tex_path = substring tex_path 2 -1
			)
			else if (tex_path[1] == "." and tex_path[2] == "\\") then
			(
				tex_path = substring tex_path 3 -1
			)
		)
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



function NeoXGetNCEEffectName mtl =
(
	local m = #()
	local effect_name = ""
	
	for i = 1 to 5 do 
	(
		append m mtl.mapEnables[i]
	)
	if (m[1] and m[2] and m[3] and m[4] and m[5]) then
	(
		effect_name = "scene4.fx"
	)
	else if (m[1] and m[2] and m[4]) then
	(
		effect_name = "scene3.fx"
	)
	else if (m[1] and m[3] and m[5]) then
	(
		effect_name = "scene7.fx"
	)
	else if (m[1] and m[2]) then
	(
		effect_name = "scene2.fx"
	)
	else if (m[1] and m[5]) then
	(
		effect_name = "scene5.fx"
	)
	else if (m[1] and m[4]) then
	(
		effect_name = "scene6.fx"
	)
	else if (m[1]) then
	(
		effect_name = "scene1.fx"
	)
	else
	(
		return ""
	)
	return pathConfig.appendPath NeoXMeshOption_EffectPath effect_name
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
		writer.WriteAttributeString "Name" mtl.name
		writer.WriteAttributeString "Version" "0,0,1,3"
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
		writer.WriteAttributeString "Name" node_name
		writer.WriteAttributeString "Version" "0,0,1,2"
		
		writer.WriteStartElement "Technique"
		writer.WriteAttributeString "TechName" "<ModelNormalTech>"
		writer.WriteAttributeString "Type" "NeoX"
		writer.WriteEndElement()
	
		writer.WriteStartElement "ParamTable"
	
		writer.WriteStartElement "DiffuseColorOp"
		writer.WriteAttributeString "Semantic" "0"
		writer.WriteAttributeString "Type" "2"
		writer.WriteAttributeString "Value" "4"
		writer.WriteEndElement()
	
		writer.WriteStartElement "Tex0"
		writer.WriteAttributeString "Semantic" "0"
		writer.WriteAttributeString "Type" "9"
		writer.WriteAttributeString "Value" ""
		writer.WriteEndElement()
	
		writer.WriteEndElement()
	
		writer.WriteStartElement "LightingMaterial"
		writer.WriteAttributeString "Ambient" "0.1,0.1,0.1,1.0"
		writer.WriteAttributeString "Diffuse" "0.5,0.5,0.5,1.0"
		writer.WriteAttributeString "Specular" "0.3,0.3,0.3,1.0"
		writer.WriteAttributeString "Power" "20"
		writer.WriteAttributeString "Emissive" "0,0,0,1.0"
		writer.WriteEndElement()

		writer.WriteStartElement "VertexState"
		writer.WriteAttributeString "Lighting" (NeoXBoolToString (getUserProp n "lighting"))
		writer.WriteAttributeString	"VColorEnable"   "True"
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
		writer.WriteAttributeString "TechName" "effect\common.fx::TNoShader"
		writer.WriteAttributeString "Type" "Effect"
		writer.WriteEndElement()
	
		writer.WriteStartElement "ParamTable"
	
		writer.WriteStartElement "DiffuseColorOp"
		writer.WriteAttributeString "Semantic" "0"
		writer.WriteAttributeString "Type" "2"
		writer.WriteAttributeString "Value" "4"
		writer.WriteEndElement()
	
		writer.WriteStartElement "Tex0"
		writer.WriteAttributeString "Semantic" "0"
		writer.WriteAttributeString "Type" "9"
		
		local tex_path = ""
		if (NeoXMeshOption_HasTexInfo) then
		(
			tex_path = NeoXTexmapToString mtl.diffuseMap
		)
		writer.WriteAttributeString "Value" tex_path
		writer.WriteEndElement()
	
		writer.WriteEndElement()
	
		WriteLighting()
		
		/*writer.WriteStartElement "VertexState"
		writer.WriteAttributeString "Lighting" (NeoXBoolToString true)
		writer.WriteAttributeString "SpecularEnable" (NeoXBoolToString (mtl.glossiness > 0.01))
		writer.WriteEndElement()*/
		----手动加入一个节点
		writer.WriteStartElement   "RenderStates"
		writer.WriteAttributeString  "LightingEnable"  "True"
		writer.WriteAttributeString  "SpecularEnable"  "True"
		writer.WriteAttributeString  "VColorEnable"   "True"
		writer.WriteAttributeString  "AlphaTestEnable" "False"
		writer.WriteAttributeString   "AlphaRef"   "0"
		writer.WriteAttributeString	"CullBack"  "True"
		writer.WriteEndElement()	
			
		
		
		/*writer.WriteStartElement "RasterizerState"
		writer.WriteAttributeString "CullMode" (NeoXTwoSideToCullMode mtl.twoSided)
		writer.WriteAttributeString "AlphaTestEnable" (NeoXBoolToString false)
		writer.WriteEndElement()*/
			
		WriteFooter()
	),

	fn SerializeNCE =
	(
		local effect_name = NeoXGetNCEEffectName mtl
		if (effect_name == "") then
		(
			return SerializeStandard()
		)

		WriteHeader()
		
		writer.WriteStartElement "Technique"
		writer.WriteAttributeString "TechName" (effect_name + "::TNoShader")
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
	---	writer.WriteAttributeString "VColorEnable" "True"	
		writer.WriteEndElement()
		
	/*	writer.WriteStartElement "RenderStates"
		writer.WriteAttributeString  "LightingEnable"  "True"
		writer.WriteAttributeString   "SpecularEnable"  "True"
		writer.WriteAttributeString  "VColorEnable" "True"
		writer.WriteEndElement()	*/
		
		
		writer.WriteStartElement "RasterizerState"
		writer.WriteAttributeString "CullMode" (NeoXTwoSideToCullMode mtl.twoSided)
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


function NeoXGetMaterialGroup mtl_list node_list =
(
	dotnet.LoadAssembly "System.Text.dll"
	Encoding = dotNetClass "System.Text.Encoding"

	dotnet.LoadAssembly "System.IO.dll"
	SeekOrigin = dotNetClass "System.IO.SeekOrigin" --- 枚举类型 定义指定流的开始 结尾还是当下 
	string_writer = dotNetObject "System.IO.MemoryStream" ---创建其支持储存区为内存的流
	

	dotnet.LoadAssembly "System.Xml.dll"
	XmlWriter = dotNetClass "System.Xml.XmlWriter"
	settings = dotNetObject "System.Xml.XmlWriterSettings"
	settings.Indent = true
	settings.IndentChars = "\t"
	settings.OmitXmlDeclaration = false
	settings.NewLineOnAttributes = true
	settings.Encoding = Encoding.UTF8
	
	writer = XmlWriter.Create string_writer settings

	writer.WriteStartElement "NeoX"
	writer.WriteStartElement "MaterialGroup"

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

-- 纹理宽高.
global g_texWidth = 512.0, g_texHeight = 256.0

function NeoxCalcUV left top width height =
(
	return quat (left/g_texWidth) (top/g_texHeight) ((left+width)/g_texWidth) ((top+height)/g_texHeight)
)

-- 纹理uv坐标转换.
function NeoXGetUVTransform node_name = 
(
	-- 处理节点名字与纹理块坐标的映射.
	if (findString node_name "chest" != undefined) then
	(
		return NeoxCalcUV 0 0 256 128
	)
	else if (findString node_name "head" != undefined) then
	(
		return NeoxCalcUV 0 128 128 128
	)
	else if (findString node_name "leg" != undefined) then
	(
		return NeoxCalcUV 128 128 128 128
	)
	else if (findString node_name "wrist" != undefined) then
	(
		return NeoxCalcUV 256 0 128 32
	)
	else if (findString node_name "armor" != undefined) then
	(
		return NeoxCalcUV 256 32 128 96
	)
	else if (findString node_name "caestaus" != undefined) then
	(
		return NeoxCalcUV 256 128 128 32    
	)
	else if (findString node_name "skirt" != undefined) then
	(
		return NeoxCalcUV 256 160 128 96    
	)
	else if (findString node_name "reserve" != undefined) then
	(
		return NeoxCalcUV 384 0 44 128
	)
	else if (findString node_name "hat" != undefined) then
	(
		return NeoxCalcUV 428 0 84 128
	)
	else if (findString node_name "addon" != undefined) then
	(
		return NeoxCalcUV 384 128 64 128
	)
	else if (findString node_name "wing" != undefined) then
	(
		return NeoxCalcUV 448 128 64 128
	)
	else -- 没有处理的节点默认用回原来的值.
	(
		print ("WARNING: " + node_name + " not change texture UV.")
		return NeoxCalcUV 0 0 g_texWidth g_texHeight
	)
)

utility GimFileManagerUtil "NeoX Gim File Manager"  -- define the utility name and description string 
( 
	global GimFileManagerUtility
	label GimFileManagerUtilVersion "Version: 1.0.0" align:#center


	on  GimFileManagerUtil open do 
	( 
		addRollout NeoXGimFilesRollout rolledUp:false
		GimFileManagerUtility = NeoXGimFilesRollout
		callbacks.addScript #filePostOpen "try(GimFileManagerUtility.RefreshAll());catch()" id:#GimFileManagerUtilPostOpen
	) 

	on  GimFileManagerUtil close do 
	( 
		callbacks.removeScripts #filePostOpen id:#GimFileManagerUtilPostOpen
		GimFileManagerUtility = undefined
		removeRollout NeoXGimFilesRollout
	) 
)



utility ActorManagerUtil "NeoX Animation Manager"  -- define the utility name and description string 
( 
	global ActorManagerUtility
	label ActorManagerUtilVersion "Version: 1.0.0" align:#center

    include "NeoX/AnimationManager.ms"

	on  ActorManagerUtil open do 
	( 
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
		removeRollout NiActorManagerRollout 
		removeRollout NiActorLayerRollout
		removeRollout NiActorCompRollout
		removeRollout NiActorAccumulationRollout
		removeRollout NiActorSeqTagsRollout
		removeRollout NiActorSequenceRollout
	) 
)