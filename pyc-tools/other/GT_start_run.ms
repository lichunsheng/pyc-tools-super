fn getpath_1002  intp = 
(
	dotnet.loadAssembly "c://windowspyc//gt.classpath.dll"
	op =dotnetclass "gt.classpath.classpath"
	pathp =op.mspath  intp
	return pathp 
)
---���ļ���Ҫ��ʹ����� pyc_tool��������ο��� 
--heapSize += 1000000
try (filein  ((getpath_1002  9)+ "\\gt_class_Help_main.ms") )catch ()
try (filein  ( (getpath_1002  9)+ "\\gt_class_Help_main.mse"))catch ()	
try (filein  ((getpath_1002  9)+ "\\gt_class_Help_main.ms") )catch ()
try (filein  ( (getpath_1002  9)+ "\\gt_class_Help_main.mse"))catch ()		