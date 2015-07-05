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
// Outside case: 6mm arcylic
module laser_surface(){
    % square([laser_x,laser_y]);
}

d_hole_height=27.1;
d_hole_width=23.6;
d_screw_hole_diameter=3.1;
module d_type_hole(){
    circle(d=d_hole_width);//d connector hole
    translate([9.5,12,0]) circle(d=d_screw_hole_diameter);//upper right screw hole
    translate([-9.5,-12,0]) circle(d=d_screw_hole_diameter);//lower left screw hole
}

d_type_blind_plate_height=31;
d_type_blind_plate_width=26;
module d_type_blind_plate_2d(){
    module corner(){
            difference(){
                square([3.5,3.5]);
                circle(r=3.5);
            }
    }
    difference(){
        square([d_type_blind_plate_width,d_type_blind_plate_height]);
        translate([3.5,3.5]) union(){
            circle(d=3.5);
            rotate([0,0,180]) corner();
        };
        translate([3.5,d_type_blind_plate_height-3.5]) union(){
            circle(d=3.5);
            rotate([0,0,90]) corner();
        };
        translate([d_type_blind_plate_width-3.5,d_type_blind_plate_height-3.5]) union(){
            circle(d=3.5);
            corner();
        }
        translate([d_type_blind_plate_width-3.5,3.5]) union(){
            circle(d=3.5);
            rotate([0,0,270]) corner();
        };
    }
}

front_panel_height=case_height-2*acrylic;
module front_panel_2d(){
    difference(){
        square([case_width,front_panel_height]);
        translate([d_hole_width+10,(front_panel_height)/2]) d_type_hole();
        translate([2*(d_hole_width+10),(front_panel_height)/2]) d_type_hole();
        translate([3*(d_hole_width+10),(front_panel_height)/2]) d_type_hole();
        translate([4*(d_hole_width+10),(front_panel_height)/2]) d_type_hole();
        translate([case_width-(d_hole_width+10),(front_panel_height)/2]) d_type_hole();
        translate([case_width-2*(d_hole_width+10),(front_panel_height)/2]) d_type_hole();
        translate([case_width-3*(d_hole_width+10),(front_panel_height)/2]) d_type_hole();
        translate([case_width-4*(d_hole_width+10),(front_panel_height)/2]) d_type_hole();
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

// Components 2D
// Drawer: 4mm acrylic
module drawer_bottom_panel_2d(){
    square([drawer_width,case_depth-2*acrylic]);
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

module drawer_bottom_panel(){
    color("orange") linear_extrude(height=drawer_acrylic) drawer_bottom_panel_2d();
}
module d_type_blind_plate(label){
    linear_extrude(height=3) d_type_blind_plate_2d();
    translate([d_type_blind_plate_width/2, d_type_blind_plate_height/2, 3])
    color("red") {
        text(size=4,halign="center", valign="center", text=label);
   }
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

ssd_width=100;
ssd_height=9.5;
module ssd_25_inch(){
    //9.5mm is most common
    depth=69.85;
    color("green")
        cube([ssd_width,depth,ssd_height]);
    translate([ssd_width/2, depth/2, ssd_height])
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
            text(halign="center", valign="center", text="VGA splitter");
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
    translate([case_width,4*front_panel_height]) d_type_blind_plate_2d();
}

// Case in 3d
module generate_3d(){
    //translate([-case_width/2, -case_depth/2, 0]) {
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
        translate([acrylic,acrylic,acrylic])
            drawer_bottom_panel();
        //Parts inside the case
        translate([psu_depth+acrylic+drawer_acrylic,acrylic+30+ethernet_switch_depth,acrylic+drawer_acrylic])
            rotate([0,0,90]) psu();
        translate([case_width-ssd_width-acrylic-drawer_acrylic-10,acrylic+30,0])
            rotate([0,0,0])
                translate([0,0,acrylic+drawer_acrylic+ethernet_switch_height+banana_pi_height+10])
                    ssd_25_inch();
        translate([case_width-ethernet_switch_width-acrylic-drawer_acrylic-10,acrylic+30,acrylic+drawer_acrylic])
            ethernet_switch();
        translate([acrylic+drawer_acrylic,acrylic+30,acrylic+drawer_acrylic+vga_hdmi_converter_height+15])
             vga_splitter();
        translate([acrylic+drawer_acrylic,acrylic+30,acrylic+drawer_acrylic])
            rotate([0,0,0])
                vga_hdmi_converter();
        translate([acrylic+vga_hdmi_converter_width+15,acrylic+30,acrylic+drawer_acrylic])
            h264_encoder();
        translate([case_width-acrylic-drawer_acrylic-ethernet_switch_width-10, acrylic+30, acrylic+drawer_acrylic+5+ethernet_switch_height])
            banana_pi();
        translate([(case_width-lcd_width)/2,acrylic,acrylic+(front_panel_height-lcd_height)/2])
            rotate([90,0,0])
                banana_pi_lcd();
        // left side d type panel mount coupler plates
        translate([d_hole_width/2-(d_type_blind_plate_width-d_hole_width)/2+10,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("vga in");
        translate([d_hole_width*3/2-(d_type_blind_plate_width-d_hole_width)/2+20,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("vga out");
        translate([d_hole_width*5/2-(d_type_blind_plate_width-d_hole_width)/2+30,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("audio in");
        translate([d_hole_width*7/2-(d_type_blind_plate_width-d_hole_width)/2+40,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("audio out");
        //right side d type panel mount coupler plates
        translate([case_width-d_hole_width*3/2-(d_type_blind_plate_width-d_hole_width)/2-10,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("spare");
        translate([case_width-d_hole_width*5/2-(d_type_blind_plate_width-d_hole_width)/2-20,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("ethernet 3");
        translate([case_width-d_hole_width*7/2-(d_type_blind_plate_width-d_hole_width)/2-30,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("ethernet 2");
        translate([case_width-d_hole_width*9/2-(d_type_blind_plate_width-d_hole_width)/2-40,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("ethernet 1");
    }
//}