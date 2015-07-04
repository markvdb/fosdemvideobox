// Global case size variables
acrylic=6;
case_width=438.15;//17.25" rack unit width
case_height=88.1;//2U rack height
case_depth=304.8;//1/2 24" rack depth
laser_x=1220;
laser_y=610;

// Electronics drawer variables
drawer_acrylic=4;//
drawer_width=case_width-2*acrylic;
drawer_height=case_height-2*acrylic;

// Case panels: naive approximations for now
// First 2D, then 3D

// Components 2D
module laser_surface(){
    % square([laser_x,laser_y]);
}

d_hole_height=27.1;
d_hole_width=23.6;
module d_type_hole(){
    circle(d=23.6);//d connector hole
    translate([9.5,12,0]) circle(d=3.1);//upper right screw hole
    translate([-9.5,-12,0]) circle(d=3.1);//lower left screw hole
}

front_panel_height=case_height-2*acrylic;
module front_panel_2d(){
    difference(){
        square([case_width,front_panel_height]);
        translate([d_hole_width/2+20,(front_panel_height)/2]) d_type_hole();
        translate([2*(d_hole_width/2+20),(front_panel_height)/2]) d_type_hole();
        translate([3*(d_hole_width/2+20),(front_panel_height)/2]) d_type_hole();
        translate([4*(d_hole_width/2+20),(front_panel_height)/2]) d_type_hole();
        translate([case_width-(d_hole_width/2+20),(front_panel_height)/2]) d_type_hole();
        translate([case_width-(2*(d_hole_width/2+20)),(front_panel_height)/2]) d_type_hole();
        translate([case_width-(3*(d_hole_width/2+20)),(front_panel_height)/2]) d_type_hole();
        translate([case_width-(4*(d_hole_width/2+20)),(front_panel_height)/2]) d_type_hole();
    }
}

module back_panel_2d(){
    back_panel_height=front_panel_height;
    square([case_width,back_panel_height]);
}

module top_panel_2d(){
    square([case_width, case_depth]);
}

module bottom_panel_2d(){
    square([case_width, case_depth]);
}

module side_panel_2d(){
    square([case_depth-2*acrylic,case_height-2*acrylic]); 
}

// Panel components 3D
module front_panel(){
    linear_extrude(height=acrylic) front_panel_2d();    
}

module back_panel(){
    linear_extrude(height=acrylic) back_panel_2d();
}

module top_panel(){
    linear_extrude(height=acrylic) top_panel_2d(); 
}

module bottom_panel(){
    color("black") linear_extrude(height=acrylic) bottom_panel_2d();
}

module side_panel(){
    linear_extrude(height=acrylic) side_panel_2d(); 
}

// Parts inside the case
// These need to stay global because they're used in the scene as well.
psu_width=125;
psu_height=63;
psu_depth=145;

module psu(){
    color("red")
        cube([psu_width,psu_depth,psu_height]);
    translate([psu_width/2, psu_depth/2, psu_height])
        color("yellow") {
            text(halign="center", valign="center", text="PSU");
       }
}

module ssd_25_inch(){
    //9.5mm is most common
    width=100;
    depth=69.85;
    height=9.5;
    color("green")
        cube([width,depth,height]);
    translate([width/2, depth/2, height])
        color("yellow") {
            text(halign="center", valign="center", text="SSD");
        }
}

ethernet_switch_width=97;
ethernet_switch_depth=79;
ethernet_switch_height=28;
module ethernet_switch(){
    color("red")
        cube([ethernet_switch_width,ethernet_switch_depth,ethernet_switch_height]);
    translate([ethernet_switch_width/2, ethernet_switch_depth/2, ethernet_switch_height])
        color("yellow") {
            text(halign="center", valign="center", text="Ethernet");
        }
}

module vga_splitter(){
    //approximation
    width=66;
    depth=61;
    height=23;
    color("red")
        cube([width,depth,height]);
    translate([width/2, depth/2, height])
        color("yellow") {
            text(halign="center", valign="center", text="VGA Split");
        }
}

vga_hdmi_converter_width=182;
vga_hdmi_converter_depth=78;
vga_hdmi_converter_height=25;
module vga_hdmi_converter(){
    color("pink")
        cube([vga_hdmi_converter_width,vga_hdmi_converter_depth,vga_hdmi_converter_height]);
    translate([vga_hdmi_converter_width/2, vga_hdmi_converter_depth/2, vga_hdmi_converter_height])
        color("black") {
            text(halign="center", valign="center", text="VGA->HDMI");
        }
}

module h264_encoder(){
    width=107.70;
    depth=123.19;
    height=23.114;
    color("purple")
        cube([width,depth,height]);
    translate([width/2, depth/2, height])
        color("yellow") {
            text(halign="center", valign="center", text="H264 Enc.");
        }
}

banana_pi_width=92;
banana_pi_depth=60;
banana_pi_height=10; //just a wild guess for now
module banana_pi(){
    color("yellow")
        cube([banana_pi_width,banana_pi_depth,banana_pi_height]);
    translate([banana_pi_width/2, banana_pi_depth/2, banana_pi_height])
        color("red") {
            text(halign="center", valign="center", text="BPI");
        }
}

lcd_width=76.9;
lcd_height_nt=63.9;
lcd_height_t=65.3;
lcd_depth=3.26;
// Setting these so we can just change it here
lcd_height = lcd_height_nt;
// lcd_height = lcd_height_t;
module banana_pi_lcd(){
    color("blue")
        cube([lcd_width,lcd_height,lcd_depth]); //non-touch
    translate([lcd_width/2, lcd_height/2, lcd_depth])
        color("yellow") {
            text(halign="center", valign="center", text="LCD");
        }

}

ethernet_coupler_width=19.1;
ethernet_coupler_height=35.6;
ethernet_coupler_depth=27.8;
module ethernet_coupler(){
    //just an example from http://www.l-com.com/multimedia/eng_drawings/ECF504-C5.pdf
    color("red")
        cube([ethernet_coupler_width,ethernet_coupler_height,ethernet_coupler_depth]);
    translate([ethernet_coupler_width/2, ethernet_coupler_height/2, ethernet_coupler_depth])
        color("yellow") {
            text(halign="center", valign="center", size=5, text="RJ45");
        }
}

vga_coupler_width=34;
vga_coupler_height=14;
vga_coupler_depth=20;
module vga_coupler(){
    //just an example for now from http://www.datapro.net/products/vga-panel-mounting-coupler.html
    color("red")
        cube([vga_coupler_width,vga_coupler_height,vga_coupler_depth]);
    translate([vga_coupler_width/2, vga_coupler_height/2, vga_coupler_depth])
        color("yellow") {
            text(halign="center", valign="center", size=5, text="VGA");
        }
}

3d=1;

if(3d){
    generate_3d();
}
else {
    generate_2d();
}

// Case parts in 2d for laser cutting
module generate_2d(){
    laser_surface();
    bottom_panel_2d();
    color("blue") translate([0,case_depth]) top_panel_2d();
    color("red") translate([case_width,0]) back_panel_2d();
    color("green") translate([case_width,front_panel_height]) front_panel_2d();
    color("orange") translate([case_width,2*front_panel_height]) side_panel_2d();
    color("purple") translate([case_width,3*front_panel_height]) side_panel_2d();
    
}

// Case in 3d
module generate_3d(){
    translate([-case_width/2, -case_depth/2, 0]) {
        //Panels
        bottom_panel();
        % translate([0,0,case_height-acrylic])
            top_panel();
        % translate([0,acrylic,acrylic])
            rotate([90,0,0])
                front_panel();
        % translate([0,case_depth,acrylic])
            rotate([90,0,0])
                back_panel();
        % translate([0,acrylic,acrylic])
            rotate([90,0,90])
                side_panel();
        % translate([case_width-acrylic,acrylic,acrylic])
            rotate([90,0,90])
                side_panel();
        
        //Parts inside the case
        translate([case_width-psu_width-acrylic,case_depth-psu_depth-acrylic,acrylic])
            psu();
        translate([325,acrylic+10,0])
            rotate([0,0,90])
                translate([0,0,acrylic])
                    ssd_25_inch();
        translate([case_width-ethernet_switch_width-acrylic,acrylic+30,acrylic])
            ethernet_switch();
        // translate([??,??,??])
        //     vga_splitter();
        translate([vga_hdmi_converter_depth+acrylic,acrylic,acrylic])
            rotate([0,0,90])
                vga_hdmi_converter();
        translate([acrylic+vga_hdmi_converter_depth+20,acrylic+110,acrylic])
            h264_encoder();
        translate([(case_width-banana_pi_width)/2-20, acrylic+30, acrylic+5])
            banana_pi();
        translate([(case_width-lcd_width)/2,acrylic,acrylic+(front_panel_height-lcd_height)/2])
            rotate([90,0,0])
                banana_pi_lcd();
        translate([case_width-acrylic -(ethernet_coupler_width+5),-4,acrylic+(front_panel_height-ethernet_coupler_height)/2])
            ethernet_coupler();
        translate([case_width- acrylic - 2*(ethernet_coupler_width+5),-4,acrylic+(front_panel_height-ethernet_coupler_height)/2])
            ethernet_coupler();
        translate([case_width- acrylic - 3*(ethernet_coupler_width+5),-4,acrylic+(front_panel_height-ethernet_coupler_height)/2])
            ethernet_coupler();
        translate([acrylic + 10,-4,acrylic+(front_panel_height-vga_coupler_height)/2])
            vga_coupler();
    }
}