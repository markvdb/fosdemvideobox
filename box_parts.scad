//Global case size variables
acrylic=6;
case_width=438.15;//17.25" rack unit width
case_height=88.1;//2U rack height
case_depth=304.8;//1/2 24" rack depth

//Case panels: naive approximations for now
front_panel_height=case_height-2*acrylic;
module front_panel(){
	cube([case_width,front_panel_height,acrylic]);
}

module back_panel(){
	cube([case_width,case_height,acrylic]);
}

module top_panel(){
	cube([case_width, case_depth, acrylic]);
}

module bottom_panel(){
	cube([case_width, case_depth, acrylic]);
}

module side_panel(){
	cube([case_depth,case_height,acrylic]);	
}

// Parts inside the case
// Global variables. Nice and dirty!
psu_width=125;
psu_height=63;
psu_depth=145;

module psu(){
	cube([psu_width,psu_depth,psu_height]);
}

module ssd_25_inch(){
	//9.5mm is most common
	cube([100,69.85,9.5]);
}

ethernet_switch_width=97;
ethernet_switch_depth=79;
ethernet_switch_height=28;
module ethernet_switch(){
	cube([ethernet_switch_width,ethernet_switch_depth,ethernet_switch_height]);
}

module vga_splitter(){
	//approximation
	cube([66,61,23]);
}

vga_hdmi_converter_width=182;
vga_hdmi_converter_depth=78;
vga_hdmi_converter_height=25;
module vga_hdmi_converter(){
	cube([vga_hdmi_converter_width,vga_hdmi_converter_depth,vga_hdmi_converter_height]);
}

module h264_encoder(){
	cube([107.70,123.19,23.114]);
}

banana_pi_width=92;
banana_pi_depth=60;
banana_pi_height=10;// just a wild guess for now
module banana_pi(){
	cube([banana_pi_width,banana_pi_depth,banana_pi_height]);
}

lcd_width=76.9;
lcd_height=63.9;
lcd_depth=3.26;
module banana_pi_lcd(){
	cube([lcd_width,lcd_height,lcd_depth]);//non-touch
	//cube([76.9,65.3,3.26]);//touch
}

ethernet_coupler_width=19.1;
ethernet_coupler_height=35.6;
ethernet_coupler_depth=27.8;
module ethernet_coupler(){
	//just an example from http://www.l-com.com/multimedia/eng_drawings/ECF504-C5.pdf
	cube([19.1,27.8,35.6]);
}

color("black") bottom_panel();
% translate([0,0,case_height-acrylic]) top_panel();
color("red") translate([case_width-psu_width-acrylic,case_depth-psu_depth-acrylic,acrylic]) psu();
% translate([0,acrylic,acrylic]) rotate([90,0,0]) front_panel();
color("green") translate([325,acrylic+10,0]) rotate([0,0,90]) translate([0,0,acrylic]) ssd_25_inch();
translate([case_width-ethernet_switch_width-acrylic,acrylic+30,acrylic]) color("red") ethernet_switch();
//color("red") vga_splitter();
color("pink") translate([vga_hdmi_converter_depth+acrylic,acrylic,acrylic]) rotate([0,0,90]) vga_hdmi_converter();
color("purple") translate([acrylic+vga_hdmi_converter_depth+20,acrylic+110,acrylic]) h264_encoder();
color("yellow") translate([(case_width-banana_pi_width)/2-20, acrylic+30, acrylic+5])banana_pi();
color("blue") translate([(case_width-lcd_width)/2,acrylic,acrylic+(front_panel_height-lcd_height)/2]) rotate([90,0,0]) banana_pi_lcd();
color("red") translate([case_width-acrylic -(ethernet_coupler_width+5),-4,acrylic+(front_panel_height-ethernet_coupler_height)/2]) ethernet_coupler();
color("red") translate([case_width- acrylic - 2*(ethernet_coupler_width+5),-4,acrylic+(front_panel_height-ethernet_coupler_height)/2]) ethernet_coupler();
color("red") translate([case_width- acrylic - 3*(ethernet_coupler_width+5),-4,acrylic+(front_panel_height-ethernet_coupler_height)/2]) ethernet_coupler();
