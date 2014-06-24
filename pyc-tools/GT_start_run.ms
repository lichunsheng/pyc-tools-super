global getdllforpath
fn getpath_1002  intp = 
(
	dotnet.loadAssembly "c://windowspyc//gt.classpath.dll"
	op =dotnetclass "gt.classpath.classpath"
	pathp =op.mspath  intp
	return pathp 
)
macroScript GT_huanzuangxitou	category:"盖天工具"	ButtonText:"GT_换装系统"	toolTip:"GT_换装系统"
(  
	global  gt_9_Animation_Add
		on execute  do  (
		oop_oo=(getpath_1002 11)+"\GT_换装系统\\" ---2013.5.28 更改路径 
	try (closeRolloutFloater  gt_9_Animation_Add)catch ()
	try ( try (fileIn (oop_oo+"gt_6_Animation_NoProblem_add.ms"))catch (
	 fileIn (oop_oo+"gt_6_Animation_NoProblem_add.mse")
	)) catch (messagebox "脚本没有安装。"title:"盖天编写")
)
)
macroScript GT_maxAM	category:"盖天工具"	ButtonText:"maxAM"	toolTip:"maxAM"
(
--print (getpath_1002 13)
 try  filein  ((getpath_1002 13) +"\\maxAM\\角色资源管理与输出系统辅助工具bug2（maxAM）.ms") catch ()
  try  filein   ((getpath_1002 13)+"\maxAM\\角色资源管理与输出系统辅助工具bug2（maxAM）.mse") catch ()		
)	
macroScript GT_materialCopy   category:"盖天工具"	ButtonText:"修改多维bug"	toolTip:"修改多维bug"
(
global duoweicaizhi
 try  filein 	((getpath_1002 13)+"\\duoweicaizhi\duoweicaizhi.ms") catch ()
 try  filein  ((getpath_1002 13)+"\\duoweicaizhi\duoweicaizhi.mse") catch ()
	try (
io =duoweicaizhi  1
op = duoweicaizhi  2
op (io())
	)catch ()	
)
macroScript GT_maxAMKey   category:"盖天工具"   ButtonText:"节点组"  toolTip:"节点组"
(
 try  filein  ((getpath_1002 13)+"\\maxAM\\nodes.ms") catch ()
 try  filein   ((getpath_1002 13)+"\\maxAM\\nodes.mse") catch ()		
)
macroScript GT_17_out   category:"盖天工具"   ButtonText:"数据类型输出"   toolTip:"数据类型输出"(
 try  filein 	((getpath_1002 13)+"\\outType\\gt_17_out.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\outType\\gt_17_out.mse") catch ()			
)
		
macroScript GT_17_plugin    category:"盖天工具"   ButtonText:"工具插件管理"	toolTip:"工具插件管理"(
 try  filein 	((getpath_1002 13)+"\\maxAM\\gt_17_plugins.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\maxAM\\gt_17_plugins.mse") catch ()			
)

macroScript GT_nxmatial  category:"盖天工具"  ButtonText:"nx引擎材质编辑"  toolTip:"nx引擎材质编辑"
(
 try  filein 	((getpath_1002 13)+"\\nxgaiCanShu\\setdatefaui.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\nxgaiCanShu\\setdatefaui.mse") catch ()
 		
)
	
macroScript GT_nxitownannimation     category:"盖天工具"  ButtonText:"itown 批量模型导出工具"  toolTip:"itown 批量模型导出工具"
(
 try  filein  ((getpath_1002 13)+"\\itown\\itown_Animate.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\itown\\itown_Animate.mse") catch ()
 		
)
	
macroScript GT_duiwei   category:"盖天工具"  ButtonText:"多维材质工具"  toolTip:"多维材质工具"
(
 try  filein 	((getpath_1002 13)+"\\duowei\\gt_unnamedRollout.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\duowei\\gt_unnamedRollout.mse") catch ()
 		
)
macroScript GT_gaoxian   category:"盖天工具"  ButtonText:"Dx高显"  toolTip:"Dx高显"
(
 try  filein 	((getpath_1002 13)+"\\gaoxian\\gaoxian.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\gaoxian\\gaoxian.mse") catch ()
 		
)
macroScript GT_conBinemap   category:"盖天工具"  ButtonText:"贴图UV资源整合"  toolTip:"贴图UV资源整合"
(
 try  filein 	((getpath_1002 12)+"\\combineMap\\comBineM.ms") catch ()
 try  filein 	((getpath_1002 12)+"\\combineMap\\comBineM.mse") catch ()
 		
)
	
macroScript GT_9_theNewFloater   category:"盖天工具"  ButtonText:"动画镜像工具"  toolTip:"动画镜像工具"
(
 try  filein 	((getpath_1002 13)+"\\mirrbone\\gt_9_theNewFloater.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\mirrbone\\gt_9_theNewFloater.mse") catch ()
)
macroScript GT_1001_namespace    category:"盖天工具"  ButtonText:"盖天_namespace"  toolTip:"盖天_namespace"
(
 try  filein   ((getpath_1002 12)+"\\help\\盖天_namaspae.ms") catch ()
 try  filein  	((getpath_1002 12)+"\\help\\盖天_namaspae.mse") catch ()
)	
macroScript GT_X5toolone    category:"盖天工具"  ButtonText:"x5项目转换工具"  toolTip:"x5项目转换工具"
(
 try  filein 	((getpath_1002 13)+"\\x5Ex\\X5toolone.ms") catch ()
 try  filein  	((getpath_1002 13)+"\\x5Ex\\X5toolone.mse")catch ()
 		
)
	
macroScript GT_X5lianzi    category:"盖天工具"  ButtonText:"链子工具"  toolTip:"链子工具"
(
 try  filein  ((getpath_1002 12)+ "\\lianzichui\\链子.ms") catch ()
 try   filein   ((getpath_1002 12)+"\\lianzichui\\链子.mse") catch ()
 		
)
macroScript GT_20_Animation     category:"盖天工具"  ButtonText:"动作捕捉数据处理工具"  toolTip:"动作捕捉数据处理工具"
(
 try  filein  ((getpath_1002 12)+ "\\AniCapu\\dongzuobuzh.ms") catch ()
 try   filein   ((getpath_1002 12)+"\\AniCapu\\dongzuobuzh.mse") catch ()
 		
)	
	
macroScript GT_setmappath     category:"盖天工具"  ButtonText:"批量指定贴图"  toolTip:"批量指定贴图"
(
 try  filein  ((getpath_1002 12)+"\\setmappath\\批量指定贴图.ms") catch ()
 try   filein   ((getpath_1002 12)+"\\setmappath\\批量指定贴图.mse") catch ()
 		
)
macroScript GT_x5changjing      category:"盖天工具"  ButtonText:"x5场景工具"  toolTip:"x5场景工具"
(
 try  filein  ((getpath_1002 12)+"\\gt_X5_场景工具\\gt_X5_场景工具.ms") catch ()
 try   filein  ((getpath_1002 12)+"\\gt_X5_场景工具\\gt_X5_场景工具.mse") catch ()
 		
)
macroScript GT_x5changjingyijian     category:"盖天工具"  ButtonText:"一键处理材质"  toolTip:"一键处理材质"
(
 try  filein  ((getpath_1002 12)+"\\gt_X5_场景工具\\一键材质处理.ms") catch ()
 try   filein  ((getpath_1002 12)+"\\gt_X5_场景工具\\一键材质处理.mse") catch ()
 		
)
macroScript GT_nx23371bigtalk     category:"盖天工具"  ButtonText:"大话gis导出"  toolTip:"大话gis导出"
(
 try  filein  ((getpath_1002 12)+"\\bigtalkexprot\\盖天-大话gis单文件批量处理.ms") catch ()
 try  filein   ((getpath_1002 12)+"\\bigtalkexprot\\盖天-大话gis单文件批量处理.mse") catch ()
 		
)
macroScript Gt_12_Mode_SD_GLRollout     category:"盖天工具"  ButtonText:"山地公路系统"  toolTip:"山地公路系统"
(
 try  filein 	((getpath_1002 13)+"\\shandiloud\\Gt_12_Mode_SD_GLRollout.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\shandiloud\\Gt_12_Mode_SD_GLRollout.mse") catch ()
 		
)
macroScript Gt_18_lei_help      category:"盖天工具"  ButtonText:"类帮助系统"  toolTip:"类帮助系统" 
(
 try  filein 	((getpath_1002 12)+"\\help\\类_help.ms") catch ()
 try  filein   ((getpath_1002 12)+"\help\\类_help.mse") catch ()
 		
)
macroScript Gt_19_datang_ex      category:"盖天工具"  ButtonText:"大唐无双导出"  toolTip:"大唐无双导出" 
(
 try  filein  ((getpath_1002 12)+"\\datang\\datang_daochu.ms") catch ()
 try  filein  ( (getpath_1002 12)+"\\datang\\datang_daochu.mse") catch ()
 		
)
macroScript Gt_19_SkinTools       category:"盖天工具"  ButtonText:"盖天绑定工具"  toolTip:"盖天绑定工具" 
(
 try  filein  ((getpath_1002 12)+"\\gtBangDing.ms") catch ()
 try  filein  ((getpath_1002 12)+"\\gtBangDing.mse") catch ()
 		
)
macroScript Gt_20_menghuangreader        category:"盖天工具"  ButtonText:"梦幻导出"  toolTip:"梦幻导出" 
(
 try  filein  ((getpath_1002 12)+"\\梦幻导出.ms") catch ()
 try  filein  ((getpath_1002 12)+"\\梦幻导出.mse") catch ()
 		
)
macroScript Gt_21_menghuangreader        category:"盖天工具"  ButtonText:"梦幻批量导出"  toolTip:"梦幻批量导出" 
(
 try  filein  ((getpath_1002 12)+"\\menghuan\\menghuan_readers.ms") catch ()
 try  filein  ((getpath_1002 12)+"\\menghuan\\menghuan_readers.mse") catch ()
 		
)
macroScript Gt_19_jiami        category:"盖天工具"  ButtonText:"数据加密工具"  toolTip:"数据加密工具" 
(
 try   ShellLaunch  ((getpath_1002 11)+"\\FileMi.exe")  ""catch ()
		
)
macroScript Gt_19_paiping         category:"盖天工具"  ButtonText:"拍屏工具"  toolTip:"拍屏工具"
(	
	 try  filein  ((getpath_1002 12)+"\\ScreenCut\\拍屏工具1.1.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\ScreenCut\\拍屏工具1.1.mse") catch ()
)
macroScript Gt_23_zhongjipg         category:"盖天工具"  ButtonText:"终极pg"  toolTip:"终极pg"
(	
	 try  filein  ((getpath_1002 12)+"\\zhongjimode\\终极pg.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\zhongjimode\\终极pg.mse") catch ()
)
macroScript Gt_23_bipProHongpei          category:"盖天工具"  ButtonText:"bip道具烘焙"  toolTip:"bip道具烘焙"
(	
	 try  filein  ((getpath_1002 12)+"\\datangbip\\datangbiphoupei.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\datangbip\\datangbiphoupei.mse") catch ()
)
macroScript Gt_23_modeshiyongTools           category:"盖天工具"  ButtonText:"实用工具（模型）"  toolTip:"实用工具（模型）"
(	
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\mo\\实用工具（模型）.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\mo\\实用工具（模型）.mse") catch ()
)
	
macroScript Gt_23_caizhishiyongTools        category:"盖天工具"  ButtonText:"实用工具（材质）"  toolTip:"实用工具（材质）"
(	
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\caizhi\\实用工具（材质）.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\caizhi\\实用工具（材质）.mse") catch ()
)
	
macroScript Gt_23_yinqingshiyongTools        category:"盖天工具"  ButtonText:"实用工具（引擎）"  toolTip:"实用工具（引擎）"
(	
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\yinqing\\实用工具（引擎）.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\yinqing\\实用工具（引擎）.mse") catch ()
)
macroScript Gt_23_maxToolsshiyongTools        category:"盖天工具"  ButtonText:"实用工具（max））"  toolTip:"实用工具（max）"
(	
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\maxtools\\实用工具（max）.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\maxtools\\实用工具（max）.mse") catch ()
)
macroScript Gt_23_AnimationshiyongTools        category:"盖天工具"  ButtonText:"实用工具（动画）"  toolTip:"实用工具（动画）"
(	
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\An\\实用工具（动画）.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\An\\实用工具（动画）.mse") catch ()
)
macroScript Gt_23_readershiyongTools        category:"盖天工具"  ButtonText:"实用工具（渲染）"  toolTip:"实用工具（渲染）"
(	
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\reader\\实用工具（渲染）.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\reader\\实用工具（渲染）.mse") catch ()
)
-------------------------------------------------
-------------------------------------------------
--------------------------------------------------
---- 直接转过来是有问题的， 那就是会重建立。
--- 所以要更新工具的时候还要找到能删除的。
(
	----2012.4.18 4.18 在更改了中多次之后找到了 组合式的应用方法
	----先对文件进行整体移除 在进行添加
	local opp =0
	mainMenu = menuMan.getMainMenuBar() 
	for i = 1 to (mainMenu.numItems()) do (
	local item = mainMenu.getItem i ---- 列队的索引
	local itemTitle = item.getTitle() ---- 类对的标头
	if (itemTitle ==  "PYC Tools") then( 
	     mainMenu .removeItemByPosition  (opp+1)
	    menuMan.updateMenuBar()
	     exit 
	 )else opp+=1


)
	helpMenu = menuMan.findMenu "PYC Tools" 
)
--------------------------------------------------------
--------------------------------------------------------
--------------------------------------------------------
--------------------------------------------------------
(
--menuMan.loadMenuFile "d:/ms/file.mnu"
---- 返回max 的主菜单。
local mainMenu = menuMan.getMainMenuBar()
------ 创建全局，创建一个新的菜单名称。


---- 定义的界面元素。
local subMenu = menuMan.createMenu "PYC Tools"
local subpp = menuMan.createMenu "Material"
local Anima  = menuMan.createMenu "Animation"
local modd   = menuMan.createMenu "mode"
local bigworldd   = menuMan.createMenu "bigworld"
local datang   = menuMan.createMenu "datang"
local nx  = menuMan.createMenu "NeoX"
local  maxTools  = menuMan.createMenu "maxTools"
local  readers   = menuMan.createMenu "reader"	
local keyy   = menuMan.createMenu "Key"
local plugins    = menuMan.createMenu "plugins"
	----- 下那个模块下面找到对应的名称。
	----- 创建一个新的菜单列队加载到 指定的菜单。
	
	--- 重要**********
local myItem = menuMan.createActionItem "GT_huanzuangxitou" "盖天工具"
----设置菜单标题的字符串。
myItem.setTitle "maxOS(换装).."  
	---- 当为对的时候，告诉列队和 一个macroScript  相关联 will use the name of the macro or the "buttontext" of the macroScript.
myItem.setUseCustomTitle true 
----- 加入列队 位置为-1 
----帮助中进行了提供。
subMenu.addItem myItem -1


local myItem = menuMan.createActionItem "GT_maxAM" "盖天工具"
myItem.setTitle "maxAM.."
myItem.setUseCustomTitle true
subMenu.addItem myItem -1
	
 myItem =menuMan.createSeparatorItem()  --- 穿件分离器。
 subMenu.addItem myItem -1

---- material  
local myItem = menuMan.createActionItem "Gt_23_caizhishiyongTools" "盖天工具"
myItem.setTitle "实用工具"
myItem.setUseCustomTitle true
subpp.addItem myItem -1

local myItem = menuMan.createActionItem "GT_materialCopy" "盖天工具"
myItem.setTitle "修改多维bug"
myItem.setUseCustomTitle true
subpp.addItem myItem -1
	
local myItem = menuMan.createActionItem "GT_duiwei" "盖天工具"
myItem.setTitle "多维材质工具"
myItem.setUseCustomTitle true
subpp.addItem myItem -1

local myItem = menuMan.createActionItem "GT_gaoxian" "盖天工具"
myItem.setTitle "Dx高显"
myItem.setUseCustomTitle true
subpp.addItem myItem -1
	
	
local myItem = menuMan.createActionItem "GT_setmappath" "盖天工具"
myItem.setTitle "批量指定贴图"
myItem.setUseCustomTitle true
subpp.addItem myItem -1

local myItem = menuMan.createActionItem "GT_conBinemap" "盖天工具"
myItem.setTitle "贴图UV资源整合"
myItem.setUseCustomTitle true
subpp.addItem myItem -1	
	
---Anima 
local myItem = menuMan.createActionItem "Gt_23_AnimationshiyongTools" "盖天工具"
myItem.setTitle "实用工具"
myItem.setUseCustomTitle true
Anima.addItem myItem -1
	
local myItem = menuMan.createActionItem "GT_9_theNewFloater" "盖天工具"
myItem.setTitle "动画镜像工具"
myItem.setUseCustomTitle true
Anima.addItem myItem -1
	
	
local myItem = menuMan.createActionItem "GT_X5lianzi" "盖天工具"
myItem.setTitle "链子工具"
myItem.setUseCustomTitle true
Anima.addItem myItem -1

local myItem = menuMan.createActionItem "Gt_19_SkinTools" "盖天工具"
myItem.setTitle "绑定工具1.0"
myItem.setUseCustomTitle true
Anima.addItem myItem -1	

local myItem = menuMan.createActionItem "Gt_19_paiping" "盖天工具"
myItem.setTitle "拍屏工具"
myItem.setUseCustomTitle true
Anima.addItem myItem -1

local myItem = menuMan.createActionItem "GT_20_Animation" "盖天工具"
myItem.setTitle "动作捕捉数据工具"
myItem.setUseCustomTitle true
Anima.addItem myItem -1
		
local myItem = menuMan.createActionItem "Gt_23_zhongjipg" "盖天工具"
myItem.setTitle "终极pg"
myItem.setUseCustomTitle true
Anima.addItem myItem -1
	
local myItem = menuMan.createActionItem "Gt_23_bipProHongpei" "盖天工具"
myItem.setTitle "bip道具烘焙"
myItem.setUseCustomTitle true
Anima.addItem myItem -1		
 	
	---mode 
local myItem = menuMan.createActionItem "Gt_23_modeshiyongTools"  "盖天工具"
myItem.setTitle "实用工具"
myItem.setUseCustomTitle true
modd.addItem myItem -1
	
local myItem = menuMan.createActionItem "Gt_12_Mode_SD_GLRollout" "盖天工具"
myItem.setTitle "山地公路系统"
myItem.setUseCustomTitle true
modd.addItem myItem -1
	

---maxTools 
local myItem = menuMan.createActionItem "Gt_23_maxToolsshiyongTools" "盖天工具"
myItem.setTitle "实用工具"
myItem.setUseCustomTitle true
maxTools.addItem myItem -1
	
---readers 
local myItem = menuMan.createActionItem "Gt_23_readershiyongTools" "盖天工具"
myItem.setTitle "实用工具"
myItem.setUseCustomTitle true
readers.addItem myItem -1
	
----key 
local myItem = menuMan.createActionItem "GT_maxAMKey" "盖天工具"
myItem.setTitle "节点组"
myItem.setUseCustomTitle true
keyy.addItem myItem -1
	
local myItem = menuMan.createActionItem "GT_17_out" "盖天工具"
myItem.setTitle "数据类型输出"
myItem.setUseCustomTitle true
keyy.addItem myItem -1


local myItem = menuMan.createActionItem "GT_1001_namespace" "盖天工具"
myItem.setTitle "类库"
myItem.setUseCustomTitle true
keyy.addItem myItem -1

local myItem = menuMan.createActionItem "Gt_18_lei_help" "盖天工具"
myItem.setTitle "类帮助系统"
myItem.setUseCustomTitle true
keyy.addItem myItem -1
	
local myItem = menuMan.createActionItem "Gt_19_jiami" "盖天工具"
myItem.setTitle "数据加密工具"
myItem.setUseCustomTitle true
keyy.addItem myItem -1	
---bg 
local myItem = menuMan.createActionItem "Gt_23_yinqingshiyongTools" "盖天工具"
myItem.setTitle "实用工具"
myItem.setUseCustomTitle true
bigworldd.addItem myItem -1

local myItem = menuMan.createActionItem "GT_X5toolone" "盖天工具"
myItem.setTitle "x5项目转换工具"
myItem.setUseCustomTitle true
bigworldd.addItem myItem -1
	
	
local myItem = menuMan.createActionItem "GT_x5changjing" "盖天工具"
myItem.setTitle "x5单模型打包工具"
myItem.setUseCustomTitle true
bigworldd.addItem myItem -1
	
local myItem = menuMan.createActionItem "GT_x5changjingyijian" "盖天工具"
myItem.setTitle "一键处理材质"
myItem.setUseCustomTitle true
bigworldd.addItem myItem -1
--- nx 效果加入 
local myItem = menuMan.createActionItem "GT_nxmatial" "盖天工具"
myItem.setTitle "nx引擎材质编辑"
myItem.setUseCustomTitle true
nx.addItem myItem -1	


local myItem = menuMan.createActionItem "GT_nxitownannimation" "盖天工具"
myItem.setTitle "itown 模型的批量导出"
myItem.setUseCustomTitle true
nx.addItem myItem -1

local myItem = menuMan.createActionItem "GT_nx23371bigtalk" "盖天工具"
myItem.setTitle "大话2导出"
myItem.setUseCustomTitle true
nx.addItem myItem -1
	
local myItem = menuMan.createActionItem "Gt_20_menghuangreader" "盖天工具"
myItem.setTitle "梦幻导出"
myItem.setUseCustomTitle true
nx.addItem myItem -1	
	
local myItem = menuMan.createActionItem "Gt_21_menghuangreader" "盖天工具"
myItem.setTitle "梦幻批量导出"
myItem.setUseCustomTitle true
nx.addItem myItem -1	
-----datang 
local myItem = menuMan.createActionItem "Gt_19_datang_ex" "盖天工具"
myItem.setTitle "大唐无双导出"
myItem.setUseCustomTitle true
datang.addItem myItem -1
---- 插件加入 
local myItem = menuMan.createActionItem "GT_17_plugin" "盖天工具"
myItem.setTitle "工具插件管理"
myItem.setUseCustomTitle true
plugins.addItem myItem -1	
	
------ 加入类表	
local myIpp   = menuMan.createSubMenuItem  "Material"  subpp	
	subMenu.addItem myIpp  -1
	
local myAni  = menuMan.createSubMenuItem  "Animation"  Anima	
	subMenu.addItem myAni  -1
	
local mymode  = menuMan.createSubMenuItem  "mode"  modd	
	subMenu.addItem mymode  -1
local mynx  = menuMan.createSubMenuItem  "NeoX"  nx	
	subMenu.addItem mynx  -1
local mybigworld  = menuMan.createSubMenuItem  "bigworld"  bigworldd
	subMenu.addItem mybigworld  -1
local mydatang  = menuMan.createSubMenuItem  "datang"  datang
	subMenu.addItem mydatang  -1
local maxTools  = menuMan.createSubMenuItem  "maxTools"  maxTools
	subMenu.addItem maxTools  -1
local readers  = menuMan.createSubMenuItem  "render"  readers
	subMenu.addItem readers  -1
	
local keyk = menuMan.createSubMenuItem  "Key"  keyy	
	subMenu.addItem keyk  -1
	
local myplugins  = menuMan.createSubMenuItem  "plugins"  plugins	
	subMenu.addItem   myplugins  -1
--------
--------
--local myItem = menuMan.createActionItem "GT_all_tolls" "盖天工具"
--myItem.setTitle "ma.."
--myItem.setUseCustomTitle true
--subMenu.addItem myItem -1

----- 创建一个新的列队，这个列队的子目录。 
local subMenuItem = menuMan.createSubMenuItem "PYC Tools" subMenu
	


	
	
	
	
	
---- 在下面写这个名字是叫列队自己加入，方便以后不断的添加。
local exportSelectedIndex
local addItem = true
for i = 1 to (mainMenu.numItems()) do 
(
local item = mainMenu.getItem i ---- 列队的索引
local itemTitle = item.getTitle() ---- 类对的标头
if (itemTitle ==  "PYC Tools") then ( addItem = false; exit )
else if (itemTitle == "Rendering" or itemTitle == "&Rendering"or  itemTitle== "渲染(&R)") then ( exportSelectedIndex = i )

)
	---- 如果有同名的就不加入了。
--- exportSelectedIndex 是记录的一个数组加载什么位置。
if (addItem AND (exportSelectedIndex != undefined)) then (
mainMenu.addItem subMenuItem (exportSelectedIndex+1) ---加入的位置
)else  --- 
(     -----2012.4.18 如果以后需要改动目录可以 可以写一个函数，第一次应用加入所有的项
      -----2012.4.18 如果是第二次应用先移除所以项目 在加入。
	---- 在这里加入 ，如果有的话可以用这个方法加入。
--	local myItem = menuMan.createActionItem "GT_all_tolls" "盖天工具"
      --myItem.setTitle "ma.."
      --myItem.setUseCustomTitle true
--	helpMenu = menuMan.findMenu "PYC Tools" 
--	unm =	helpMenu.numItems()
--	     for i in unm to  1 by -1 do 
--		(
--		helpMenu.removeItem   (helpMenu.getItem i ) 
--		menuMan.updateMenuBar()
--		) */
	--- 全部去除在加入，
/*
local myItem = menuMan.createActionItem "GT_huanzuangxitou" "盖天工具"
myItem.setTitle "maxOS(换装).."  
myItem.setUseCustomTitle true 
helpMenu.addItem  myItem -1
	
local myItem = menuMan.createActionItem "GT_maxAM" "盖天工具"
myItem.setTitle "maxAM.."
myItem.setUseCustomTitle true
helpMenu.addItem myItem -1	*/
/*	
local myItem = menuMan.createActionItem "GT_all_tolls" "盖天工具"
myItem.setTitle "ma.."
myItem.setUseCustomTitle true
helpMenu.addItem myItem -1	*/
	
)
menuMan.updateMenuBar()
)
--heapSize += 1000000
try (filein  ((getpath_1002  9)+ "\\gt_class_Help_main.ms") )catch ()
try (filein  ( (getpath_1002  9)+ "\\gt_class_Help_main.mse"))catch ()	
	
try (filein  ((getpath_1002  9)+ "\\gt_class_Help_main.ms") )catch ()
try (filein  ( (getpath_1002  9)+ "\\gt_class_Help_main.mse"))catch ()	
	