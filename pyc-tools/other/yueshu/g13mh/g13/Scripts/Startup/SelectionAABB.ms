Fn draw_selection_bounding_box =
(
	min_v = Selection.Min
	max_v = Selection.Max
	line_color = green
	
	p1 = min_v
	p2 = max_v
	
	gw.setTransform(Matrix3 1)
	gw.setColor #line line_color
	
	gw.Polyline #(min_v,[max_v.x,min_v.y,min_v.z]) false 
	gw.Polyline #(min_v,[min_v.x,max_v.y,min_v.z]) false 
	gw.Polyline #(min_v,[min_v.x,min_v.y,max_v.z]) false 
	
	gw.Polyline #(max_v,[min_v.x,max_v.y,max_v.z]) false 
	gw.Polyline #(max_v,[max_v.x,min_v.y,max_v.z]) false 
	gw.Polyline #(max_v,[max_v.x,max_v.y,min_v.z]) false 
	
	gw.Polyline #([min_v.x,min_v.y,max_v.z],[max_v.x,min_v.y,max_v.z]) false 
	gw.Polyline #([min_v.x,max_v.y,max_v.z],[min_v.x,min_v.y,max_v.z]) false 
	
	gw.Polyline #([max_v.x,max_v.y,min_v.z],[min_v.x,max_v.y,min_v.z]) false 
	gw.Polyline #([max_v.x,min_v.y,min_v.z],[max_v.x,max_v.y,min_v.z]) false 

	gw.Polyline #([max_v.x,min_v.y,max_v.z],[max_v.x,min_v.y,min_v.z]) false 
	gw.Polyline #([min_v.x,max_v.y,max_v.z],[min_v.x,max_v.y,min_v.z]) false
	
	gw.enlargeUpdateRect #whole
	gw.updateScreen()
)

/*
point name:"max" pos:selection.max
point name:"min" pos:selection.min
*/