global getdllforpath
fn getpath_1002  intp = 
(
	dotnet.loadAssembly "c://windowspyc//gt.classpath.dll"
	op =dotnetclass "gt.classpath.classpath"
	pathp =op.mspath  intp
	return pathp 
)
macroScript GT_huanzuangxitou	category:"���칤��"	ButtonText:"GT_��װϵͳ"	toolTip:"GT_��װϵͳ"
(  
	global  gt_9_Animation_Add
		on execute  do  (
		oop_oo=(getpath_1002 11)+"\GT_��װϵͳ\\" ---2013.5.28 ����·�� 
	try (closeRolloutFloater  gt_9_Animation_Add)catch ()
	try ( try (fileIn (oop_oo+"gt_6_Animation_NoProblem_add.ms"))catch (
	 fileIn (oop_oo+"gt_6_Animation_NoProblem_add.mse")
	)) catch (messagebox "�ű�û�а�װ��"title:"�����д")
)
)
macroScript GT_maxAM	category:"���칤��"	ButtonText:"maxAM"	toolTip:"maxAM"
(
--print (getpath_1002 13)
 try  filein  ((getpath_1002 13) +"\\maxAM\\��ɫ��Դ���������ϵͳ��������bug2��maxAM��.ms") catch ()
  try  filein   ((getpath_1002 13)+"\maxAM\\��ɫ��Դ���������ϵͳ��������bug2��maxAM��.mse") catch ()		
)	
macroScript GT_materialCopy   category:"���칤��"	ButtonText:"�޸Ķ�άbug"	toolTip:"�޸Ķ�άbug"
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
macroScript GT_maxAMKey   category:"���칤��"   ButtonText:"�ڵ���"  toolTip:"�ڵ���"
(
 try  filein  ((getpath_1002 13)+"\\maxAM\\nodes.ms") catch ()
 try  filein   ((getpath_1002 13)+"\\maxAM\\nodes.mse") catch ()		
)
macroScript GT_17_out   category:"���칤��"   ButtonText:"�����������"   toolTip:"�����������"(
 try  filein 	((getpath_1002 13)+"\\outType\\gt_17_out.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\outType\\gt_17_out.mse") catch ()			
)
		
macroScript GT_17_plugin    category:"���칤��"   ButtonText:"���߲������"	toolTip:"���߲������"(
 try  filein 	((getpath_1002 13)+"\\maxAM\\gt_17_plugins.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\maxAM\\gt_17_plugins.mse") catch ()			
)

macroScript GT_nxmatial  category:"���칤��"  ButtonText:"nx������ʱ༭"  toolTip:"nx������ʱ༭"
(
 try  filein 	((getpath_1002 13)+"\\nxgaiCanShu\\setdatefaui.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\nxgaiCanShu\\setdatefaui.mse") catch ()
 		
)
	
macroScript GT_nxitownannimation     category:"���칤��"  ButtonText:"itown ����ģ�͵�������"  toolTip:"itown ����ģ�͵�������"
(
 try  filein  ((getpath_1002 13)+"\\itown\\itown_Animate.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\itown\\itown_Animate.mse") catch ()
 		
)
	
macroScript GT_duiwei   category:"���칤��"  ButtonText:"��ά���ʹ���"  toolTip:"��ά���ʹ���"
(
 try  filein 	((getpath_1002 13)+"\\duowei\\gt_unnamedRollout.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\duowei\\gt_unnamedRollout.mse") catch ()
 		
)
macroScript GT_gaoxian   category:"���칤��"  ButtonText:"Dx����"  toolTip:"Dx����"
(
 try  filein 	((getpath_1002 13)+"\\gaoxian\\gaoxian.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\gaoxian\\gaoxian.mse") catch ()
 		
)
macroScript GT_conBinemap   category:"���칤��"  ButtonText:"��ͼUV��Դ����"  toolTip:"��ͼUV��Դ����"
(
 try  filein 	((getpath_1002 12)+"\\combineMap\\comBineM.ms") catch ()
 try  filein 	((getpath_1002 12)+"\\combineMap\\comBineM.mse") catch ()
 		
)
	
macroScript GT_9_theNewFloater   category:"���칤��"  ButtonText:"�������񹤾�"  toolTip:"�������񹤾�"
(
 try  filein 	((getpath_1002 13)+"\\mirrbone\\gt_9_theNewFloater.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\mirrbone\\gt_9_theNewFloater.mse") catch ()
)
macroScript GT_1001_namespace    category:"���칤��"  ButtonText:"����_namespace"  toolTip:"����_namespace"
(
 try  filein   ((getpath_1002 12)+"\\help\\����_namaspae.ms") catch ()
 try  filein  	((getpath_1002 12)+"\\help\\����_namaspae.mse") catch ()
)	
macroScript GT_X5toolone    category:"���칤��"  ButtonText:"x5��Ŀת������"  toolTip:"x5��Ŀת������"
(
 try  filein 	((getpath_1002 13)+"\\x5Ex\\X5toolone.ms") catch ()
 try  filein  	((getpath_1002 13)+"\\x5Ex\\X5toolone.mse")catch ()
 		
)
	
macroScript GT_X5lianzi    category:"���칤��"  ButtonText:"���ӹ���"  toolTip:"���ӹ���"
(
 try  filein  ((getpath_1002 12)+ "\\lianzichui\\����.ms") catch ()
 try   filein   ((getpath_1002 12)+"\\lianzichui\\����.mse") catch ()
 		
)
macroScript GT_20_Animation     category:"���칤��"  ButtonText:"������׽���ݴ�������"  toolTip:"������׽���ݴ�������"
(
 try  filein  ((getpath_1002 12)+ "\\AniCapu\\dongzuobuzh.ms") catch ()
 try   filein   ((getpath_1002 12)+"\\AniCapu\\dongzuobuzh.mse") catch ()
 		
)	
	
macroScript GT_setmappath     category:"���칤��"  ButtonText:"����ָ����ͼ"  toolTip:"����ָ����ͼ"
(
 try  filein  ((getpath_1002 12)+"\\setmappath\\����ָ����ͼ.ms") catch ()
 try   filein   ((getpath_1002 12)+"\\setmappath\\����ָ����ͼ.mse") catch ()
 		
)
macroScript GT_x5changjing      category:"���칤��"  ButtonText:"x5��������"  toolTip:"x5��������"
(
 try  filein  ((getpath_1002 12)+"\\gt_X5_��������\\gt_X5_��������.ms") catch ()
 try   filein  ((getpath_1002 12)+"\\gt_X5_��������\\gt_X5_��������.mse") catch ()
 		
)
macroScript GT_x5changjingyijian     category:"���칤��"  ButtonText:"һ����������"  toolTip:"һ����������"
(
 try  filein  ((getpath_1002 12)+"\\gt_X5_��������\\һ�����ʴ���.ms") catch ()
 try   filein  ((getpath_1002 12)+"\\gt_X5_��������\\һ�����ʴ���.mse") catch ()
 		
)
macroScript GT_nx23371bigtalk     category:"���칤��"  ButtonText:"��gis����"  toolTip:"��gis����"
(
 try  filein  ((getpath_1002 12)+"\\bigtalkexprot\\����-��gis���ļ���������.ms") catch ()
 try  filein   ((getpath_1002 12)+"\\bigtalkexprot\\����-��gis���ļ���������.mse") catch ()
 		
)
macroScript Gt_12_Mode_SD_GLRollout     category:"���칤��"  ButtonText:"ɽ�ع�·ϵͳ"  toolTip:"ɽ�ع�·ϵͳ"
(
 try  filein 	((getpath_1002 13)+"\\shandiloud\\Gt_12_Mode_SD_GLRollout.ms") catch ()
 try  filein 	((getpath_1002 13)+"\\shandiloud\\Gt_12_Mode_SD_GLRollout.mse") catch ()
 		
)
macroScript Gt_18_lei_help      category:"���칤��"  ButtonText:"�����ϵͳ"  toolTip:"�����ϵͳ" 
(
 try  filein 	((getpath_1002 12)+"\\help\\��_help.ms") catch ()
 try  filein   ((getpath_1002 12)+"\help\\��_help.mse") catch ()
 		
)
macroScript Gt_19_datang_ex      category:"���칤��"  ButtonText:"������˫����"  toolTip:"������˫����" 
(
 try  filein  ((getpath_1002 12)+"\\datang\\datang_daochu.ms") catch ()
 try  filein  ( (getpath_1002 12)+"\\datang\\datang_daochu.mse") catch ()
 		
)
macroScript Gt_19_SkinTools       category:"���칤��"  ButtonText:"����󶨹���"  toolTip:"����󶨹���" 
(
 try  filein  ((getpath_1002 12)+"\\gtBangDing.ms") catch ()
 try  filein  ((getpath_1002 12)+"\\gtBangDing.mse") catch ()
 		
)
macroScript Gt_20_menghuangreader        category:"���칤��"  ButtonText:"�λõ���"  toolTip:"�λõ���" 
(
 try  filein  ((getpath_1002 12)+"\\�λõ���.ms") catch ()
 try  filein  ((getpath_1002 12)+"\\�λõ���.mse") catch ()
 		
)
macroScript Gt_21_menghuangreader        category:"���칤��"  ButtonText:"�λ���������"  toolTip:"�λ���������" 
(
 try  filein  ((getpath_1002 12)+"\\menghuan\\menghuan_readers.ms") catch ()
 try  filein  ((getpath_1002 12)+"\\menghuan\\menghuan_readers.mse") catch ()
 		
)
macroScript Gt_19_jiami        category:"���칤��"  ButtonText:"���ݼ��ܹ���"  toolTip:"���ݼ��ܹ���" 
(
 try   ShellLaunch  ((getpath_1002 11)+"\\FileMi.exe")  ""catch ()
		
)
macroScript Gt_19_paiping         category:"���칤��"  ButtonText:"��������"  toolTip:"��������"
(	
	 try  filein  ((getpath_1002 12)+"\\ScreenCut\\��������1.1.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\ScreenCut\\��������1.1.mse") catch ()
)
macroScript Gt_23_zhongjipg         category:"���칤��"  ButtonText:"�ռ�pg"  toolTip:"�ռ�pg"
(	
	 try  filein  ((getpath_1002 12)+"\\zhongjimode\\�ռ�pg.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\zhongjimode\\�ռ�pg.mse") catch ()
)
macroScript Gt_23_bipProHongpei          category:"���칤��"  ButtonText:"bip���ߺ決"  toolTip:"bip���ߺ決"
(	
	 try  filein  ((getpath_1002 12)+"\\datangbip\\datangbiphoupei.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\datangbip\\datangbiphoupei.mse") catch ()
)
macroScript Gt_23_modeshiyongTools           category:"���칤��"  ButtonText:"ʵ�ù��ߣ�ģ�ͣ�"  toolTip:"ʵ�ù��ߣ�ģ�ͣ�"
(	
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\mo\\ʵ�ù��ߣ�ģ�ͣ�.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\mo\\ʵ�ù��ߣ�ģ�ͣ�.mse") catch ()
)
	
macroScript Gt_23_caizhishiyongTools        category:"���칤��"  ButtonText:"ʵ�ù��ߣ����ʣ�"  toolTip:"ʵ�ù��ߣ����ʣ�"
(	
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\caizhi\\ʵ�ù��ߣ����ʣ�.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\caizhi\\ʵ�ù��ߣ����ʣ�.mse") catch ()
)
	
macroScript Gt_23_yinqingshiyongTools        category:"���칤��"  ButtonText:"ʵ�ù��ߣ����棩"  toolTip:"ʵ�ù��ߣ����棩"
(	
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\yinqing\\ʵ�ù��ߣ����棩.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\yinqing\\ʵ�ù��ߣ����棩.mse") catch ()
)
macroScript Gt_23_maxToolsshiyongTools        category:"���칤��"  ButtonText:"ʵ�ù��ߣ�max����"  toolTip:"ʵ�ù��ߣ�max��"
(	
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\maxtools\\ʵ�ù��ߣ�max��.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\maxtools\\ʵ�ù��ߣ�max��.mse") catch ()
)
macroScript Gt_23_AnimationshiyongTools        category:"���칤��"  ButtonText:"ʵ�ù��ߣ�������"  toolTip:"ʵ�ù��ߣ�������"
(	
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\An\\ʵ�ù��ߣ�������.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\An\\ʵ�ù��ߣ�������.mse") catch ()
)
macroScript Gt_23_readershiyongTools        category:"���칤��"  ButtonText:"ʵ�ù��ߣ���Ⱦ��"  toolTip:"ʵ�ù��ߣ���Ⱦ��"
(	
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\reader\\ʵ�ù��ߣ���Ⱦ��.ms") catch ()
	 try  filein  ((getpath_1002 12)+"\\gt_tool\\reader\\ʵ�ù��ߣ���Ⱦ��.mse") catch ()
)
-------------------------------------------------
-------------------------------------------------
--------------------------------------------------
---- ֱ��ת������������ģ� �Ǿ��ǻ��ؽ�����
--- ����Ҫ���¹��ߵ�ʱ��Ҫ�ҵ���ɾ���ġ�
(
	----2012.4.18 4.18 �ڸ������ж��֮���ҵ��� ���ʽ��Ӧ�÷���
	----�ȶ��ļ����������Ƴ� �ڽ�������
	local opp =0
	mainMenu = menuMan.getMainMenuBar() 
	for i = 1 to (mainMenu.numItems()) do (
	local item = mainMenu.getItem i ---- �жӵ�����
	local itemTitle = item.getTitle() ---- ��Եı�ͷ
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
---- ����max �����˵���
local mainMenu = menuMan.getMainMenuBar()
------ ����ȫ�֣�����һ���µĲ˵����ơ�


---- ����Ľ���Ԫ�ء�
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
	----- ���Ǹ�ģ�������ҵ���Ӧ�����ơ�
	----- ����һ���µĲ˵��жӼ��ص� ָ���Ĳ˵���
	
	--- ��Ҫ**********
local myItem = menuMan.createActionItem "GT_huanzuangxitou" "���칤��"
----���ò˵�������ַ�����
myItem.setTitle "maxOS(��װ).."  
	---- ��Ϊ�Ե�ʱ�򣬸����жӺ� һ��macroScript  ����� will use the name of the macro or the "buttontext" of the macroScript.
myItem.setUseCustomTitle true 
----- �����ж� λ��Ϊ-1 
----�����н������ṩ��
subMenu.addItem myItem -1


local myItem = menuMan.createActionItem "GT_maxAM" "���칤��"
myItem.setTitle "maxAM.."
myItem.setUseCustomTitle true
subMenu.addItem myItem -1
	
 myItem =menuMan.createSeparatorItem()  --- ������������
 subMenu.addItem myItem -1

---- material  
local myItem = menuMan.createActionItem "Gt_23_caizhishiyongTools" "���칤��"
myItem.setTitle "ʵ�ù���"
myItem.setUseCustomTitle true
subpp.addItem myItem -1

local myItem = menuMan.createActionItem "GT_materialCopy" "���칤��"
myItem.setTitle "�޸Ķ�άbug"
myItem.setUseCustomTitle true
subpp.addItem myItem -1
	
local myItem = menuMan.createActionItem "GT_duiwei" "���칤��"
myItem.setTitle "��ά���ʹ���"
myItem.setUseCustomTitle true
subpp.addItem myItem -1

local myItem = menuMan.createActionItem "GT_gaoxian" "���칤��"
myItem.setTitle "Dx����"
myItem.setUseCustomTitle true
subpp.addItem myItem -1
	
	
local myItem = menuMan.createActionItem "GT_setmappath" "���칤��"
myItem.setTitle "����ָ����ͼ"
myItem.setUseCustomTitle true
subpp.addItem myItem -1

local myItem = menuMan.createActionItem "GT_conBinemap" "���칤��"
myItem.setTitle "��ͼUV��Դ����"
myItem.setUseCustomTitle true
subpp.addItem myItem -1	
	
---Anima 
local myItem = menuMan.createActionItem "Gt_23_AnimationshiyongTools" "���칤��"
myItem.setTitle "ʵ�ù���"
myItem.setUseCustomTitle true
Anima.addItem myItem -1
	
local myItem = menuMan.createActionItem "GT_9_theNewFloater" "���칤��"
myItem.setTitle "�������񹤾�"
myItem.setUseCustomTitle true
Anima.addItem myItem -1
	
	
local myItem = menuMan.createActionItem "GT_X5lianzi" "���칤��"
myItem.setTitle "���ӹ���"
myItem.setUseCustomTitle true
Anima.addItem myItem -1

local myItem = menuMan.createActionItem "Gt_19_SkinTools" "���칤��"
myItem.setTitle "�󶨹���1.0"
myItem.setUseCustomTitle true
Anima.addItem myItem -1	

local myItem = menuMan.createActionItem "Gt_19_paiping" "���칤��"
myItem.setTitle "��������"
myItem.setUseCustomTitle true
Anima.addItem myItem -1

local myItem = menuMan.createActionItem "GT_20_Animation" "���칤��"
myItem.setTitle "������׽���ݹ���"
myItem.setUseCustomTitle true
Anima.addItem myItem -1
		
local myItem = menuMan.createActionItem "Gt_23_zhongjipg" "���칤��"
myItem.setTitle "�ռ�pg"
myItem.setUseCustomTitle true
Anima.addItem myItem -1
	
local myItem = menuMan.createActionItem "Gt_23_bipProHongpei" "���칤��"
myItem.setTitle "bip���ߺ決"
myItem.setUseCustomTitle true
Anima.addItem myItem -1		
 	
	---mode 
local myItem = menuMan.createActionItem "Gt_23_modeshiyongTools"  "���칤��"
myItem.setTitle "ʵ�ù���"
myItem.setUseCustomTitle true
modd.addItem myItem -1
	
local myItem = menuMan.createActionItem "Gt_12_Mode_SD_GLRollout" "���칤��"
myItem.setTitle "ɽ�ع�·ϵͳ"
myItem.setUseCustomTitle true
modd.addItem myItem -1
	

---maxTools 
local myItem = menuMan.createActionItem "Gt_23_maxToolsshiyongTools" "���칤��"
myItem.setTitle "ʵ�ù���"
myItem.setUseCustomTitle true
maxTools.addItem myItem -1
	
---readers 
local myItem = menuMan.createActionItem "Gt_23_readershiyongTools" "���칤��"
myItem.setTitle "ʵ�ù���"
myItem.setUseCustomTitle true
readers.addItem myItem -1
	
----key 
local myItem = menuMan.createActionItem "GT_maxAMKey" "���칤��"
myItem.setTitle "�ڵ���"
myItem.setUseCustomTitle true
keyy.addItem myItem -1
	
local myItem = menuMan.createActionItem "GT_17_out" "���칤��"
myItem.setTitle "�����������"
myItem.setUseCustomTitle true
keyy.addItem myItem -1


local myItem = menuMan.createActionItem "GT_1001_namespace" "���칤��"
myItem.setTitle "���"
myItem.setUseCustomTitle true
keyy.addItem myItem -1

local myItem = menuMan.createActionItem "Gt_18_lei_help" "���칤��"
myItem.setTitle "�����ϵͳ"
myItem.setUseCustomTitle true
keyy.addItem myItem -1
	
local myItem = menuMan.createActionItem "Gt_19_jiami" "���칤��"
myItem.setTitle "���ݼ��ܹ���"
myItem.setUseCustomTitle true
keyy.addItem myItem -1	
---bg 
local myItem = menuMan.createActionItem "Gt_23_yinqingshiyongTools" "���칤��"
myItem.setTitle "ʵ�ù���"
myItem.setUseCustomTitle true
bigworldd.addItem myItem -1

local myItem = menuMan.createActionItem "GT_X5toolone" "���칤��"
myItem.setTitle "x5��Ŀת������"
myItem.setUseCustomTitle true
bigworldd.addItem myItem -1
	
	
local myItem = menuMan.createActionItem "GT_x5changjing" "���칤��"
myItem.setTitle "x5��ģ�ʹ������"
myItem.setUseCustomTitle true
bigworldd.addItem myItem -1
	
local myItem = menuMan.createActionItem "GT_x5changjingyijian" "���칤��"
myItem.setTitle "һ����������"
myItem.setUseCustomTitle true
bigworldd.addItem myItem -1
--- nx Ч������ 
local myItem = menuMan.createActionItem "GT_nxmatial" "���칤��"
myItem.setTitle "nx������ʱ༭"
myItem.setUseCustomTitle true
nx.addItem myItem -1	


local myItem = menuMan.createActionItem "GT_nxitownannimation" "���칤��"
myItem.setTitle "itown ģ�͵���������"
myItem.setUseCustomTitle true
nx.addItem myItem -1

local myItem = menuMan.createActionItem "GT_nx23371bigtalk" "���칤��"
myItem.setTitle "��2����"
myItem.setUseCustomTitle true
nx.addItem myItem -1
	
local myItem = menuMan.createActionItem "Gt_20_menghuangreader" "���칤��"
myItem.setTitle "�λõ���"
myItem.setUseCustomTitle true
nx.addItem myItem -1	
	
local myItem = menuMan.createActionItem "Gt_21_menghuangreader" "���칤��"
myItem.setTitle "�λ���������"
myItem.setUseCustomTitle true
nx.addItem myItem -1	
-----datang 
local myItem = menuMan.createActionItem "Gt_19_datang_ex" "���칤��"
myItem.setTitle "������˫����"
myItem.setUseCustomTitle true
datang.addItem myItem -1
---- ������� 
local myItem = menuMan.createActionItem "GT_17_plugin" "���칤��"
myItem.setTitle "���߲������"
myItem.setUseCustomTitle true
plugins.addItem myItem -1	
	
------ �������	
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
--local myItem = menuMan.createActionItem "GT_all_tolls" "���칤��"
--myItem.setTitle "ma.."
--myItem.setUseCustomTitle true
--subMenu.addItem myItem -1

----- ����һ���µ��жӣ�����жӵ���Ŀ¼�� 
local subMenuItem = menuMan.createSubMenuItem "PYC Tools" subMenu
	


	
	
	
	
	
---- ������д��������ǽ��ж��Լ����룬�����Ժ󲻶ϵ����ӡ�
local exportSelectedIndex
local addItem = true
for i = 1 to (mainMenu.numItems()) do 
(
local item = mainMenu.getItem i ---- �жӵ�����
local itemTitle = item.getTitle() ---- ��Եı�ͷ
if (itemTitle ==  "PYC Tools") then ( addItem = false; exit )
else if (itemTitle == "Rendering" or itemTitle == "&Rendering"or  itemTitle== "��Ⱦ(&R)") then ( exportSelectedIndex = i )

)
	---- �����ͬ���ľͲ������ˡ�
--- exportSelectedIndex �Ǽ�¼��һ���������ʲôλ�á�
if (addItem AND (exportSelectedIndex != undefined)) then (
mainMenu.addItem subMenuItem (exportSelectedIndex+1) ---�����λ��
)else  --- 
(     -----2012.4.18 ����Ժ���Ҫ�Ķ�Ŀ¼���� ����дһ����������һ��Ӧ�ü������е���
      -----2012.4.18 ����ǵڶ���Ӧ�����Ƴ�������Ŀ �ڼ��롣
	---- ��������� ������еĻ�����������������롣
--	local myItem = menuMan.createActionItem "GT_all_tolls" "���칤��"
      --myItem.setTitle "ma.."
      --myItem.setUseCustomTitle true
--	helpMenu = menuMan.findMenu "PYC Tools" 
--	unm =	helpMenu.numItems()
--	     for i in unm to  1 by -1 do 
--		(
--		helpMenu.removeItem   (helpMenu.getItem i ) 
--		menuMan.updateMenuBar()
--		) */
	--- ȫ��ȥ���ڼ��룬
/*
local myItem = menuMan.createActionItem "GT_huanzuangxitou" "���칤��"
myItem.setTitle "maxOS(��װ).."  
myItem.setUseCustomTitle true 
helpMenu.addItem  myItem -1
	
local myItem = menuMan.createActionItem "GT_maxAM" "���칤��"
myItem.setTitle "maxAM.."
myItem.setUseCustomTitle true
helpMenu.addItem myItem -1	*/
/*	
local myItem = menuMan.createActionItem "GT_all_tolls" "���칤��"
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
	