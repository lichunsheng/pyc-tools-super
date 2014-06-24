macroScript gt_orient_yue_shu
	category:"gt_big_parent_par " 
	(
--路径约束
fn gt_orient_yue_shu =
(
oop_k= selection as array 
   if oop_k.count <1 then 
   (
	      
   )else 
   (  
	   /*if  superclassof  oop_k[oop_k.count]!=shape then 
	   (  
		   clearListener()

		  jk="你选择的最后一个不是shape的类，这样导致不能进行路劲约束，\n请选择的最后一个物体时shape类。" 
		   
		   format "问题:\t%\n" jk
 
	   )else*/
	   (
			 for i = 1 to (oop_k.count)-1  do 
			 (
				 
				  try (
					   oop_k[i].rotation.controller = Euler_XYZ ()
					   oop_k[i].rotation.controller = rotation_list ()
					   oop_k[i]. rotation.controller.Available.controller = Orientation_Constraint ()
					    
					   oop_set_count =oop_k[i]. rotation.controller
					   oop_set_count .setActive 2
					  
					   oop_set_count_1 =oop_k[i]. rotation.controller[2]
					  
					   oop_set_count_1.appendTarget oop_k[oop_k.count] 50.
					  
					  --oop_set_count_1. lookat_vector_length =0
					  --macros.run "Animation Tools" "DeleteSelectedAnimation"
					  )catch   
					 (
					  --oop_k[oop_k.count] .parent =  undefined
					 
					 --oop_k[i].parent = oop_k[oop_k.count]
					 
					 )
				 
			 )  
		 )
   )
)
gt_orient_yue_shu()
)


