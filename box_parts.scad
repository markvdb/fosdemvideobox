//Variables
acrylic_thickness=6;
case_width=438.15;//17.25" rack unit width
case_height=88.1;//2U rack height
case_depth=304.8;//1/2 24" rack depth

//Case panels: naive approximations for now
module front_panel(){
	cube([case_width,case_height,acrylic_thickness]);
}

module top_panel(){
	cube([case_width,case_depth,acrylic_thickness]);
}

module bottom_panel(){
	cube([case_width,case_depth,acrylic_thickness]);
}

// Parts inside the case
module ssd_25_inch(){
	cube([100,69.85,9.5]);
}
