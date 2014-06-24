
plugin material NeoXMaterial 
name:"NeoX 材质" 
classID:#(0x184f6286, 0x544e3b1e) 
extends:Standard replaceUI:true version:1 
( 
	local commonRollout, paramsRollout
	local paramTable = #()
	
	struct TechParam
	(
		name, type
	)

	parameters common rollout:commonRollout 
	(
		techFile type:#filename default:"" ui:editTechFile
		
		ambient type:#color default:gray ui:cpAmbient
		diffuse type:#color default:gray ui:cpDiffuse
		specular type:#color default:black ui:cpSpecular
		glossiness type:#float default:10 ui:spinGlossiness
		specularLevel type:#float default:100
		useSelfIllumColor type:#boolean default:true
		selfIllumColor type:#color default:black ui:cpEmissive
		selfIllumAmount type:#float default:100
		
		on ambient set val do delegate.ambient = val 
		on diffuse set val do delegate.diffuse = val
		on specular set val do delegate.specular = val
		on specularLevel set val do delegate.specularLevel = val
		on glossiness set val do delegate.glossiness = val
		on useSelfIllumColor set val do delegate.useSelfIllumColor = val
		on selfIllumColor set val do delegate.selfIllumColor = val
		on selfIllumAmount set val do delegate.selfIllumAmount = val
	)

	parameters params rollout:paramsRollout 
	( 
	    texMaps type:#texturemapTab tabSize:8 tabSizeVariable:true ui:
	    	(btnTexMap1, btnTexMap2, btnTexMap3, btnTexMap4, 
	    	btnTexMap5, btnTexMap6, btnTexMap7, btnTexMap8)

	    texNames type:#stringTab tabSize:8 tabSizeVariable:true
		
		on texMaps set val index do 
		(
			if index == 1 then
			(
				delegate.diffuseMap = val
			)
		)
	) 

	function Serialize mtl_writer =
	(
		writer = mtl_writer.writer
		
		mtl_writer.WriteHeader()
		
		writer.WriteStartElement "Technique"
		writer.WriteAttributeString "TechName" techFile
		writer.WriteAttributeString "Type" "NeoX"
		writer.WriteEndElement()

		writer.WriteStartElement "ParamTable"
		for i = 1 to 8 do
		(
			if texNames[i] != "" then
			(
				writer.WriteStartElement texNames[i]
				writer.WriteAttributeString "Semantic" "0"
				writer.WriteAttributeString "Type" "9"
				writer.WriteAttributeString "Value" (NeoXTexmapToString texMaps[i])
				writer.WriteEndElement()
			)
		)
		writer.WriteStartElement "DiffuseColorOp"
		writer.WriteAttributeString "Semantic" "0"
		writer.WriteAttributeString "Type" "2"
		writer.WriteAttributeString "Value" "4"
		writer.WriteEndElement()
		writer.WriteEndElement()

		mtl_writer.WriteLighting()
		mtl_writer.WriteFooter()
	)


	rollout commonRollout "NeoX材质" 
	(
		group "渲染效果"
		(
			edittext editTechFile "渲染效果文件:" text:"" pos:[8,28] width:240 height:17
			button btnPickTechFile "..." pos:[252,28] width:29 height:18
			button btnExportMaterial "导出材质" pos:[8,50] width:100 height:20
		)
		
		group "光照材质"
		(
			colorpicker cpAmbient "环境光" pos:[8,110] width:90 height:20
			colorpicker cpDiffuse "漫反射" pos:[148,110] width:90 height:20
			colorpicker cpSpecular "高光　" pos:[8,135] width:90 height:20
			colorpicker cpEmissive "自发光" pos:[148,135] width:90 height:20
			spinner spinGlossiness "高光Power" pos:[43,165] width:75 range:[0,100,0] type:#Integer
		)
		
		function ParseNeoX tech_file =
		(
			dotnet.LoadAssembly "System.Xml.dll"
			XmlReader = dotNetClass "System.Xml.XmlReader"
			settings = dotNetObject "System.Xml.XmlReaderSettings"
			settings.IgnoreComments = true
			settings.IgnoreProcessingInstructions = true
			settings.IgnoreWhitespace = true
			try
			(
				reader = XmlReader.Create tech_file settings
			)
			catch
			(
				paramTable = #()
				return undefined
			)

			reader.ReadToFollowing("Technique")
			format "tech version : %\n" (reader.GetAttribute("Version"))

			paramTable = #()
			
			reader.ReadToFollowing("ParamTable")
			if reader.IsEmptyElement == false then
			(
				reader.Read()
				while reader.IsStartElement() == true do
				(
					local pname = reader.Name
					local ptype = reader.GetAttribute("Type")
					local item = TechParam pname ptype
					append paramTable item
					format "param % type % \n" pname ptype
					reader.Read()
				)
			)
			reader.Close()
		)
		
		on commonRollout open do
		(
			ParseNeoX editTechFile.text
		)
		
		on editTechFile entered new_text do
		(
			ParseNeoX new_text
			paramsRollout.RefreshAll()
		)
		
		on btnPickTechFile pressed do
		(
			editTechFile.text = "H:\casual\PO\POClient\data\effects\new\scene6.tech"
			local tech_file = getOpenFileName caption:"选择渲染效果文件" filename:editTechFile.text types:"效果文件(*.tech)|*.tech"
			if tech_file == undefined then
			(
				return undefined
			)
			
			editTechFile.text = tech_file
			ParseNeoX editTechFile.text
			paramsRollout.RefreshAll()
		)

		on btnExportMaterial pressed do
		(
			local mat_file = getSaveFileName caption:"选择材质文件名" types:"材质文件(*.mtl)|*.mtl"
			if mat_file == undefined then
			(
				return undefined
			)

			dotnet.LoadAssembly "System.Xml.dll"
			XmlWriter = dotNetClass "System.Xml.XmlWriter"
			settings = dotNetObject "System.Xml.XmlWriterSettings"
			settings.Indent = true
			settings.IndentChars = "\t"
			settings.OmitXmlDeclaration = true
			settings.NewLineOnAttributes = true
			
			writer = XmlWriter.Create mat_file settings
			writer.WriteStartElement "NeoX"
			writer.WriteStartElement "Material"
			writer.WriteAttributeString "Version" "0,0,1,0"
			writer.WriteStartElement "ParamTable"
			for i = 1 to 8 do
			(
				if texNames[i] != "" then
				(
					writer.WriteStartElement texNames[i]
					writer.WriteAttributeString "Name" texNames[i]
					writer.WriteAttributeString "Value" texMaps[i].filename
					writer.WriteEndElement()
				)
			)
			writer.WriteEndElement()
			writer.WriteEndElement()
			writer.WriteEndElement()
			writer.Flush()
			writer.Close()
		)
	)

	rollout paramsRollout "NeoX材质参数" 
	(
		label lblTexMap1
		label lblTexMap2
		label lblTexMap3
		label lblTexMap4
		label lblTexMap5
		label lblTexMap6
		label lblTexMap7
		label lblTexMap8
		mapbutton btnTexMap1 width:200
		mapbutton btnTexMap2 width:200
		mapbutton btnTexMap3 width:200
		mapbutton btnTexMap4 width:200
		mapbutton btnTexMap5 width:200
		mapbutton btnTexMap6 width:200
		mapbutton btnTexMap7 width:200
		mapbutton btnTexMap8 width:200

		function RefreshAll =
		(
			local lblTexMapArray = #()
			append lblTexMapArray lblTexMap1
			append lblTexMapArray lblTexMap2
			append lblTexMapArray lblTexMap3
			append lblTexMapArray lblTexMap4
			append lblTexMapArray lblTexMap5
			append lblTexMapArray lblTexMap6
			append lblTexMapArray lblTexMap7
			append lblTexMapArray lblTexMap8
			local btnTexMapArray = #()
			append btnTexMapArray btnTexMap1
			append btnTexMapArray btnTexMap2
			append btnTexMapArray btnTexMap3
			append btnTexMapArray btnTexMap4
			append btnTexMapArray btnTexMap5
			append btnTexMapArray btnTexMap6
			append btnTexMapArray btnTexMap7
			append btnTexMapArray btnTexMap8

			local tex = 0
			for p in paramTable do
			(
				if p.type == "9" and tex < 8 then
				(
					tex = tex + 1
					lblTexMapArray[tex].visible = true
					lblTexMapArray[tex].caption = p.name
					lblTexMapArray[tex].pos = [12, tex*25-16]
					texNames[tex] = p.name

					btnTexMapArray[tex].visible = true
					btnTexMapArray[tex].pos = [100, tex*25-18]
				)
			)
			
			paramsRollout.height = tex * 25 + 10
			while tex < 8 do
			(
				tex = tex + 1
				lblTexMapArray[tex].visible = false
				btnTexMapArray[tex].visible = false
				texNames[tex] = ""
			)
		)

		on paramsRollout open do
		(
			RefreshAll()
		)
	)

	on create do 
	(
		-- setup initial material 
		-- delegate.opacityFalloff = 75 
		delegate.adLock = false
		delegate.useSelfIllumColor = true
		delegate.specularLevel = 100.0
		-- delegate.diffuseMapEnable = false ;
	)
) 
