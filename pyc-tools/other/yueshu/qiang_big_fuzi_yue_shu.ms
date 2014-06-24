  
macroScript gt_big_parent_par 
	category:"gt_big_parent_par " 
	(
 fn gt_parent_par =
 (
  oop_k= selection as array 
   if oop_k.count <1 then 
   (
	      
   )else 
   (
	 for i = 1 to (oop_k.count)-1  do 
	 (
		 
		  try (oop_k[i].parent = oop_k[oop_k.count])catch 
		 (
			  oop_k[oop_k.count] .parent =  undefined
			 
			 oop_k[i].parent = oop_k[oop_k.count]
			 
		 )
		 
	 )  
   )
   )
gt_parent_par()
   )