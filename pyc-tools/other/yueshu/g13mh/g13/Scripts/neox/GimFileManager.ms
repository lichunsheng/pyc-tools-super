
	global gim_names
	global gim_sets

	
	local strfpGimPath = "NeoX_AutoExport_GimPath"
	local strfpGimCount = "NeoX_AutoExport_GimCount"
	local strfpGimFile = "NeoX_AutoExport_Gim_"
	local strBlankGim = "newfile_"                                    ----引擎只能查询英文名字 不支持中文
	local ActiveGimFile = 0

	--有关场景文件的变量
	local IsExpScn = false
	local strfpScnPath = "NeoX_AutoExport_ScnPath"
	local strfpScnIsExp = "NeoX_AutoExport_IsExp"
	local stream
	local pathvector = #()          --存储路径数组
	
	function sub_string str1 str2 =                           -- return str1 - str2
	(
	   trimleft str1 
	   trimleft str2
	   trimright str1
	   trimright str2
	   i = str2.count + 1
	   s = substring str1 i str1.count
	   --messagebox(s)
	   return s
	)
	
	function get_file_prop name defvalue = 
	(
		pi = fileProperties.findProperty #custom name
		if pi == 0 then
		(
			fileProperties.addProperty #custom name defvalue
			pi = fileProperties.findProperty #custom name
		)
		v = fileProperties.getPropertyValue #custom pi
		return v
	)
	
	function set_file_prop name value = 
	(
		fileProperties.deleteProperty #custom name
		fileProperties.addProperty #custom name value
	)
	
	function get_gim_info =
	(
		gim_count = get_file_prop strfpGimCount 0
		gim_names = #()
		gim_sets = #()
		
		for i = 1 to gim_count do
		(
			strfp = strfpGimFile + (formattedPrint i format:"03d")
			pi = fileProperties.findProperty #custom strfp
			if pi != 0 then
			(
				str = fileProperties.getPropertyValue #custom pi
				p = findString str "="
				append gim_names (substring str 1 (p-1))
				append gim_sets (substring str (p+1) (str.count-p))
			)
		)
		if gim_count != gim_names.count then
		(
			set_file_prop strfpGimCount gim_names.count
		)
	)

	function set_gim_info i =
	(
		str = gim_names[i] + "=" + gim_sets[i]
		strfp = strfpGimFile + (formattedPrint i format:"03d")
		set_file_prop strfp str
	)

	function set_all_gim_info =
	(
		for i = 1 to gim_names.count do
		(
			set_gim_info i
		)
		set_file_prop strfpGimCount gim_names.count
	)

	rollout NeoXGimFilesRollout "Gim Files"  
	(
		group  "自动导出设置"
		(
			label lblGimPath "模型路径:" align:#left enabled:true
			edittext editGimPath "" text:"" align:#left width:160 enabled:true
			button btnPickPath "..." width:64 enabled:true
			dropdownlist ddlGimFiles "模型文件(0/0):" align:#left enabled:false height:10
			label lblGimFilename "当前模型文件名:" align:#left enabled:false
			edittext editGimFilename "" text:strBlankGim align:#left width:132 enabled:false
			dropdownlist ddlSelSets "对应选择集:" align:#left enabled:false height:10
			button btnCreate "新建文件" width:120 enabled:true
			button btnDestroy "删除文件" width:120 enabled:false
			button btnImportFromSS "从Max选择集导入" width:120 enabled:true
			button btnDoExport "自动导出" width:120 enabled:true
			checkbox btnSelScn "选择导出场景文件scn" widht: 150
			label lblScnPath "场景路径:" align: #left enabled:false
			edittext editScnPath "" text:"" align: #left width:160 enabled:false
			button btnPickScnPath "..." width:64 enabled:false
			button btnExE "打开场景编辑器" width:120 enabled:false
		)

		function GetSelSetIdx text =
		(
			for i = 2 to ddlSelSets.items.count do
			(
				if text == ddlSelSets.items[i] then
					return i
			)
			return 1
		)
		
		function UpdateGimFilesUI =
		(
			print "Updating GimFiles UI..."

			editGimPath.text = get_file_prop strfpGimPath ""

			if gim_names.count == 0 then
			(
				ActiveGimFile = 0
			)
			else
			(
				if ActiveGimFile < 1 or ActiveGimFile > gim_names.count do
				(
					ActiveGimFile = 1
				)
				
				print "ActiveGimFile:"
				print gim_names[ActiveGimFile]
			)
			
			list = #()
			for i = 1 to gim_names.count do
			(
				gimname = gim_names[i]
				if gimname != undefined do
				(
					append list gimname
				)
			)
			ddlGimFiles.items = list

			list = #("(无)")
			for i = 1 to selectionSets.count do
			(
				append list selectionSets[i].name
			)
			ddlSelSets.items = list

			if ActiveGimFile != 0 do
			(
				lblGimFilename.enabled = true
				editGimFilename.enabled = true
				editGimFilename.text = gim_names[ActiveGimFile]
				gimCount = gim_names.count
				gimIndex = ActiveGimFile
				strGimCount = "模型文件(" + gimIndex as string + "/" + gimCount as string + "):"
				ddlGimFiles.text = strGimCount
				btnDestroy.enabled = true 
				ddlGimFiles.enabled = true
				ddlGimFiles.selection = gimIndex
				ddlSelSets.enabled = true
				ddlSelSets.selection = (GetSelSetIdx gim_sets[gimIndex])
			)
			if ActiveGimFile == 0 do
			(
				lblGimFilename.enabled = false
				editGimFilename.enabled = false
				editGimFilename.text = ""
				gimCount = 0
				gimIndex = 0
				strGimCount = "模型文件(" + gimIndex as string + "/" + gimCount as string + "):"
				ddlGimFiles.text = strGimCount
				btnDestroy.enabled = false 
				ddlGimFiles.enabled = false
				ddlSelSets.enabled = false
			)
			
			--新添加的代码 以便把信息保存起来
			IsExpScn = get_file_prop strfpScnIsExp false
			btnSelScn.state = IsExpScn
			lblScnPath.enabled = IsExpScn
			editScnPath.enabled = IsExpScn
			btnPickScnPath.enabled = IsExpScn
			btnExE.enabled = IsExpScn

			editScnPath.text = get_file_prop strfpScnPath ""
		)
		
		on btnViewNodes pressed do
		(
			if ActiveGimFile != 0 then
			(
				clearSelection()
				for i = 1 to gim_nodes[ActiveGimFile].count do
				(
					selectMore gim_nodes[ActiveGimFile][i]
				)
			)
		)
		on btnSelScn changed theState do
		(
		    set_file_prop strfpScnIsExp btnSelScn.state
		    IsExpScn = get_file_prop strfpScnIsExp false
			lblScnPath.enabled = IsExpScn
			editScnPath.enabled = IsExpScn
			btnPickScnPath.enabled = IsExpScn
			btnExE.enabled = IsExpScn

			editScnPath.text = get_file_prop strfpScnPath ""
		)
		
		on btnImportFromSS pressed do
		(
			gim_names = #()
			gim_sets = #()
			for i = 1 to selectionSets.count do
			(
				append gim_names (selectionSets[i].name + ".gim")
				append gim_sets selectionSets[i].name
			)
			UpdateGimFilesUI()
			set_all_gim_info()
		)
		
		on NeoXGimFilesRollout open do
		(
			get_gim_info()
			UpdateGimFilesUI()
		)
		
		on ddlGimFiles selected num do
		(
			ActiveGimFile = num
			UpdateGimFilesUI()
		) 

		on ddlSelSets selected num do
		(
			if num == 1 then
				gim_sets[ActiveGimFile] = ""
			else
				gim_sets[ActiveGimFile] = ddlSelSets.selected
			set_gim_info ActiveGimFile
			UpdateGimFilesUI()
		) 
		
		function change_filename new_name =
		(
			strfp = strfpGimFile + (formattedPrint ActiveGimFile format:"03d")
			fileProperties.deleteProperty #custom strfp

			ddlGimFiles.selected = new_name
			gim_names[ActiveGimFile] = new_name
			set_gim_info ActiveGimFile
		)
		
		on btnPickPath pressed do
		(
			local f = getSavePath caption:"Select gim path:" initialDir:editGimPath.text
			
			try
			(
				filename = f + ""			
				editGimPath.text = filename
				set_file_prop strfpGimPath editGimPath.text
			)
			catch()
		)

		on editGimPath changed text do
		(
			set_file_prop strfpGimPath text
		)
		
		
		on editGimFilename changed text do
		(
			if ActiveGimFile == undefined or ActiveGimFile == 0 then return true

			gname = gim_names[ActiveGimFile]
			if gname == text then return true
			
			change_filename(text)
		)

		on btnCreate pressed do
		(
			i = 0
			do
			(
				i += 1
				str = strBlankGim + (i as string) + ".gim"
				p = findItem gim_names str
			)
			while p != 0
			append gim_names str
			append gim_sets ""
			
			ActiveGimFile = gim_names.count
			set_gim_info ActiveGimFile
			set_file_prop strfpGimCount gim_names.count

			UpdateGimFilesUI()
		)
		
		on btnDestroy pressed do
		(
			strfp = strfpGimFile + (formattedPrint ActiveGimFile format:"03d")
			fileProperties.deleteProperty #custom strfp

			deleteItem gim_names ActiveGimFile
			deleteItem gim_sets ActiveGimFile
			if ActiveGimFile > gim_names.count then
				ActiveGimFile = gim_names.count

			set_file_prop strfpGimCount gim_names.count

			UpdateGimFilesUI()
		)
		
		---场景导出相关文件
		
		function write_light bstream =
		(
			WriteLong bstream 0  #unsigned
		)
		
		function write_fog bstream = 
		(
		    --int mode; int type;neox::math3d::Color32 color;Float start;Float end;Float density;
			WriteLong bstream 0
			WriteLong bstream 0
			
			WriteByte bstream 255  #unsigned
			WriteByte bstream 255  #unsigned
			WriteByte bstream 255  #unsigned
			WriteByte bstream 255  #unsigned
			WriteFloat bstream 0
			WriteFloat bstream 0
			WriteFloat bstream 0
		)
		
		function write_model bstream =
		(
		     --下面是根据用户所设定的选择集进行导出
			 --写进文件的数量
			 WriteLong bstream pathvector.count  #unsigned
			 --取得所有资源文件名
			 for i = 1 to pathvector.count do         --遍历数组
			 (
			     num = pathvector[i].count + 1
			     WriteLong bstream num #unsigned	  --写进路径名的长度				 
				 WriteString bstream pathvector[i]
			 )
			 
			 --下面是count  npc_count fx_count
			 WriteLong bstream pathvector.count     #unsigned      --具体看c++代码
			 WriteLong bstream 0                    #unsigned
			 WriteLong bstream 0                    #unsigned
			 
			 id = 0
			 for i = 1 to pathvector.count do                 --遍历数组
			 (
			    WriteLong bstream id   #unsigned              --写进模型的id  从0开始计算

				WriteLong bstream 6146   #unsigned            --写进模型的flag   从c++程序里面得到 6146
	
				num = i - 1  
				WriteLong bstream num   #unsigned             --写进实体对应的资源文件名序号  考虑到c++的数组是从0开始
				temp = id + 100
				WriteLong bstream temp #unsigned                 
				id += 1     
				
				--实体名称 就是路径名 在这里也就是绝对路径
				num = pathvector[i].count + 1
				WriteLong bstream num  #unsigned      
				WriteString bstream pathvector[i]
				
				 --写实体的空间属性
		         --操作方法 把选择集里面的模型都弄成Group 然后得到其空间属性
				 --下列表的文件名索引 同 选择集的索引是一一对应的 
				 ---group_name = "Groupmjken"
				 --Group selectionSets[i] name: "Groupmjken"    								   
				 
                                        			   	       --空间位置
				--相对与3dsmax里面的世界坐标原点的位置
                --最为关键的一个空间属性
                --前提是模型已经设置成了顶点局部坐标导出方式 
                WriteFloat bstream  0.0
                WriteFloat bstream  0.0
                WriteFloat bstream  0.0
				
                									           --scale向量
                WriteFloat bstream 1.0
				WriteFloat bstream 1.0
				WriteFloat bstream 1.0
				                                               --旋转矩阵
				--1 0 0 0
                --0 1 0 0
                --0 0 1 0
                --0 0 0 1
                for i = 1 to 4 do
                (
                    for j = 1 to 4 do
                    (
                        if i != j  then
                        (
                            WriteFloat bstream 0
                        )
                        else
                        (
                            WriteFloat bstream 1 
                        )
                    )--for
                )--for													   						   
				--unGroup selectionSets[i]           --取消集合	

                                                     --写进billboardType类型 默认的值为0
                WriteLong bstream 0                  --表示None
                                                     --属性数量 默认为0
                WriteLong bstream 0		#unsigned									
															   
															   
			) -- for
		)
		
		
		function write_bsp bstream =
		(
		                                    --采用默认值wall_count = 0
			WriteLong bstream 0
		)
		
		on btnDoExport pressed do
		(
		    pathvector = #()
			path = get_file_prop strfpGimPath ""
		    index = 1
			for i = 1 to gim_names.count do
			(
				sets = selectionSets[gim_sets[i]]
				clearSelection()
				for j = 1 to sets.count do
				(
					selectMore sets[j]
				)
				print ("exporting... " + path + "\\" + gim_names[i])
			   
			    --这里对资源根目录进行必要的操作 
				str = path + "\\" + gim_names[i]  --ddlGimFiles.items[i] 
				str1 = GetDir #scripts   
		        str1 = str1 + "\\set.ini"
		        str1 = GetINISetting str1 "Resource Path" "Path"
				str = sub_string str str1
				
				if pathvector.count != 0 then
				(
				   flag = false
				   for i = 1 to pathvector.count do   --遍历
				   (
				      if pathvector[i] == str then    --相等的话 甚么都不做 索引向前
					  (
					    flag = true
					  )
				   ) --for
				   
				   if flag == false do
				   (
				       pathvector[index] = str
					   index += 1
				   )
				)
				else
				(
				   pathvector[index] = str
				   index += 1
				)
				
				exportFile (path + "\\" + gim_names[i]) #noPrompt using:NeoX_Mesh_Export
			) -- for
			

		    if IsExpScn do
		    (	

           	strScnPathFile = get_file_prop strfpScnPath ""
			stream = fopen strScnPathFile "wb"
		     --写进文件的版本号
			 WriteLong stream 1313035090  #unsigned
			 WriteLong stream 66541       #unsigned
			 --写进场景环境光
			 WriteByte stream 56   #unsigned
			 WriteByte stream 56   #unsigned
			 WriteByte stream 56   #unsigned
			 WriteByte stream 0    #unsigned
			 --写进场景的灯光效果
			 write_light stream 
			 --写进场景雾的效果
			 write_fog stream 
			 --写进场景模型信息
			 write_model stream 
			 -- 写进bsptree的信息
			 write_bsp stream 
			 
			 fclose stream
			   
		    ) --if
		)--导出场景模型

	    on  btnPickScnPath pressed do
	    (     
		   local f = getSaveFileName caption: "Open the SCN file" filename:"D:\mjken.scn"\
                     types: "SCN(*SCN)|*.SCN"
		   try
		   (
		    filename = f + ""
			editScnPath.text = filename
			set_file_prop strfpScnPath editScnPath.text
		   )
		   catch()
	    )
		
		on editScnPath changed text do
		(
		  set_file_prop strfpScnPath text
		)

		on btnExE pressed do
		(
		   str = GetDir #scripts   
		   str = str + "\\set.ini"
		   str = GetINISetting str "EXE Path" "Path"	
           shellLaunch str editScnPath.text		   
		)
)
	

	
