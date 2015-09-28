//smooth holes in rendering
$fn = 50;

/* Variables
------------------------------------------*/
// Laser surface
laser_x=1220;
laser_y=610;

// Nuts and bolts
case_bolt_d=3;
case_bolt_length=12;
case_nut_d=3;
case_nut_max_width=case_nut_d*2;
case_nut_min_width=case_nut_d*1.8;
case_nut_height=case_nut_d*0.9;

// Case size 
acrylic=6;
case_width=438.15;//17.25" rack unit width
case_height=88.1;//2U rack height
case_depth=304.8;//1/2 24" rack depth
bottom_panel_width=case_width;
side_panel_width=case_depth-2*acrylic;
side_panel_height=case_height-2*acrylic;
side_panel_teeth=5;
case_teeth_height=acrylic;
case_teeth_width=side_panel_width/(side_panel_teeth*2-1);


// Panels

d_hole_height=27.1;
d_hole_width=23.6;
d_screw_hole_diameter=3.1;
front_panel_height=case_height-2*acrylic;
spacer_hole_diameter=3;

// Parts 
d_type_blind_plate_height=31;
d_type_blind_plate_width=26;
h264_encoder_depth=123.19;
h264_encoder_inner_depth=97.5;
h264_encoder_height=23.114;
h264_encoder_width=107.70;
lcd_width=80;
lcd_height=67;
lcd_depth=6;
lcd_mounting_panel_width=93;
lcd_mounting_panel_height=70;
psu_width=125;
psu_height=63;
psu_depth=145;
psu_cutout_width=71;
psu_cutout_depth=84;
ssd_depth=69.85;
ssd_height=9.5;
ssd_width=100;


/* Components 2D
------------------------------------------*/
// Case
module laser_surface(){
    % square([laser_x,laser_y]);
}

module d_type_hole(){
    circle(d=d_hole_width);//d connector hole
    translate([9.5,12,0]) circle(d=d_screw_hole_diameter);//upper right screw hole
    translate([-9.5,-12,0]) circle(d=d_screw_hole_diameter);//lower left screw hole
}

module case_bolt_hole_2d(){
    union(){
        translate([(case_nut_max_width-case_bolt_d)/2,0])
            square([case_bolt_d,case_bolt_length-acrylic]);
        square([case_nut_max_width,case_nut_height*1.1]);
    }
}

module case_bolt_hole_centered(){
    //center through bolt
    translate([-case_nut_max_width/2,0]) case_bolt_hole_2d();
}

module lcd_hole(){
    square([lcd_width,lcd_height]);
    translate([lcd_width+3.5, lcd_height-4.9]) circle(d=3);//upper right lcd backing panel hole
    translate([lcd_width+3.5, 15]) circle(d=3);//lower right lcd backing panel hole
    translate([-3.5, lcd_height-4.9]) circle(d=3);//upper left lcd backing panel hole
    translate([-3.5, 7.3]) circle(d=3);//lower left lcd backing panel hole
}

module spacer_holes_vga_hdmi_2d(){
    circle(d=spacer_hole_diameter);
    translate([169,0]) circle(d=spacer_hole_diameter);
    translate([0,49]) circle(d=spacer_hole_diameter);
    translate([169,49]) circle(d=spacer_hole_diameter);
}

module spacer_holes_vga_splitter_2d(){
    circle(d=spacer_hole_diameter);
    translate([44,0]) circle(d=spacer_hole_diameter);
    translate([44,44]) circle(d=spacer_hole_diameter);
    translate([0,44]) circle(d=spacer_hole_diameter);
}

module spacer_holes_bpi_2d(){
    circle(d=spacer_hole_diameter);
    translate([85.4,0]) circle(d=spacer_hole_diameter);
    translate([0,54]) circle(d=spacer_hole_diameter);
    translate([85.4,49]) circle(d=spacer_hole_diameter);
}
module spacer_holes_switch_2d(){
    circle(d=spacer_hole_diameter);
    translate([70,0]) circle(d=spacer_hole_diameter);
}
module spacer_holes_ssd_2d(){
    circle(d=spacer_hole_diameter);
    translate([76,0]) circle(d=spacer_hole_diameter);
    translate([0,62]) circle(d=spacer_hole_diameter);
    translate([76,62]) circle(d=spacer_hole_diameter);
}    

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

module h264_holder_holes_2d(){
    //top spacer holes
    translate([-(h264_encoder_width+8)/2,(h264_encoder_inner_depth-8)/2]) circle(d=spacer_hole_diameter);
    translate([(h264_encoder_width+8)/2,(h264_encoder_inner_depth-8)/2]) circle(d=spacer_hole_diameter);
    translate([(h264_encoder_width+8)/2,-(h264_encoder_inner_depth-8)/2]) circle(d=spacer_hole_diameter);
    translate([-(h264_encoder_width+8)/2,-(h264_encoder_inner_depth-8)/2]) circle(d=spacer_hole_diameter);
}    
module h264_holder_bottom_2d(){
    difference(){
        square([h264_encoder_width+16,h264_encoder_inner_depth+16], center=true);
        square([h264_encoder_width,h264_encoder_inner_depth], center=true);
        h264_holder_holes_2d();
    }
}
module h264_holder_top_2d(){
    difference(){
        square([h264_encoder_width+16,h264_encoder_inner_depth], center=true);
        square([h264_encoder_width,h264_encoder_inner_depth-16], center=true);
        h264_holder_holes_2d();
    }    
}
module psu_back_holes_2d(){
    //attachment holes for back plate+ venting grille cutouts
    translate([psu_width-6.3,6.3]) circle(d=3);
    translate([psu_width-6.3,psu_height-6.3]) circle(d=3);
    translate([6.3,psu_height/2]) circle(d=3);
    //power button and 220v in square
    button_hole_width=48;
    button_hole_height=24;
    translate([psu_width-58-button_hole_width,28]) square([button_hole_width,button_hole_height]);
    vent_square_width=44;
    vent_square_height=52;
    translate([psu_width-12-vent_square_width,7]) square([vent_square_width,vent_square_height]);
}

module frack_panel_2d(){
    //// silly name for parent of front and back panel
    difference(){
        square([case_width,front_panel_height]);
        translate([acrylic/2,front_panel_height/8]) circle(d=3);
        translate([acrylic/2,front_panel_height*7/8]) circle(d=3);
        translate([case_width-acrylic/2,front_panel_height/8]) circle(d=3);
        translate([case_width-acrylic/2,front_panel_height*7/8]) circle(d=3);
    }
}

module front_panel_2d(){
    difference(){
        frack_panel_2d();
        translate([d_hole_width+10,(front_panel_height)/2]) d_type_hole();
        translate([2*(d_hole_width+10),(front_panel_height)/2]) d_type_hole();
        translate([3*(d_hole_width+10),(front_panel_height)/2]) d_type_hole();
        translate([4*(d_hole_width+10),(front_panel_height)/2]) d_type_hole();
        translate([case_width-(d_hole_width+10),(front_panel_height)/2]) d_type_hole();
        translate([case_width-2*(d_hole_width+10),(front_panel_height)/2]) d_type_hole();
        translate([case_width-3*(d_hole_width+10),(front_panel_height)/2]) d_type_hole();
        translate([case_width-4*(d_hole_width+10),(front_panel_height)/2]) d_type_hole();
        translate([(case_width-lcd_width)/2,(front_panel_height-lcd_height)/2]) lcd_hole();
    }
}

module front_panel_backing_2d(){
    front_panel_backing_hole_height=32;
    front_panel_backing_hole_width=135;
    difference(){
        frack_panel_2d();
        translate([acrylic+10,(front_panel_height-front_panel_backing_hole_height)/2]) square([front_panel_backing_hole_width,front_panel_backing_hole_height]);
        translate([case_width-acrylic-10-front_panel_backing_hole_width,(front_panel_height-front_panel_backing_hole_height)/2]) square([front_panel_backing_hole_width,front_panel_backing_hole_height]);
        translate([(case_width-lcd_width)/2,(front_panel_height-lcd_height)/2]) lcd_hole();
    }
}

module back_panel_2d(){
    difference(){
        frack_panel_2d();
        translate([case_width-acrylic-psu_width,0]) psu_back_holes_2d();
    }
}

module toptom_panel_2d(){
    //top and bottom panel inherit from this
    difference(){
        square([case_width, case_depth]);
        translate([0,acrylic]) for( i=[0:side_panel_teeth-1]){
            rotate([0,0,90]) translate([i*2*case_teeth_width,-case_teeth_height]) square([case_teeth_width,case_teeth_height]);
            rotate([0,0,90]) translate([(i*2+3/2)*case_teeth_width,-case_teeth_height/2])  circle(d=3);
        }
    translate([bottom_panel_width-acrylic,acrylic]) for( i=[0:side_panel_teeth-1]){
            rotate([0,0,90]) translate([i*2*case_teeth_width,-case_teeth_height]) square([case_teeth_width,case_teeth_height]);
            rotate([0,0,90]) translate([(i*2+3/2)*case_teeth_width,-case_teeth_height/2])  circle(d=3);
        }
    }
}
module bottom_panel_2d(){
    difference(){
        toptom_panel_2d();
        translate([acrylic+8,30]) spacer_holes_vga_hdmi_2d();
        translate([acrylic+90,140]) spacer_holes_vga_splitter_2d();
        translate([acrylic+217,acrylic+20]) spacer_holes_bpi_2d();
        translate([acrylic+340,acrylic+35]) spacer_holes_switch_2d();
        translate([acrylic+330,acrylic+79]) spacer_holes_ssd_2d();
        translate([acrylic+235,acrylic+170]) h264_holder_holes_2d();
    }
}

module top_panel_2d(){
    honeycomb_rows=20;
    honeycomb_columns=41;
    honeycomb_psu_rows=10;
    honeycomb_psu_columns=10;
    honeycomb_cell_interior=8;
    honeycomb_walls=2;

    difference(){
        toptom_panel_2d();
        //translate([case_width-2*acrylic-psu_width/2+5,case_depth-acrylic-psu_depth/2]) circle(d=psu_cutout_width);
        translate([case_width-2*acrylic-psu_width+psu_cutout_width/2-8, case_depth-acrylic-psu_depth+psu_cutout_depth/2-7]) honeycomb(honeycomb_psu_rows, honeycomb_psu_columns, honeycomb_cell_interior, honeycomb_walls);
        translate([acrylic+13,acrylic+10]) honeycomb(honeycomb_rows, honeycomb_columns, honeycomb_cell_interior, honeycomb_walls);
        import(file="/home/lusis/fosdembox/fosdem_logo_and_gear.dxf");
    }
}

module side_panel_2d(){
    union(){
        difference(){
            square([side_panel_width,side_panel_height]);
            for( i=[0:side_panel_teeth-1]){
                translate([case_teeth_width*(2*i+3/2)+case_bolt_d,case_bolt_length-acrylic]) rotate(180,0) case_bolt_hole_2d();
                translate([case_teeth_width*(2*i+3/2)-case_bolt_d,side_panel_height-acrylic]) case_bolt_hole_2d();
            }
            //t slots for front panel
            //highest bolt
            translate([case_bolt_length-acrylic,front_panel_height/8]) rotate(90,0) case_bolt_hole_centered();
            //lowest bolt
            translate([case_bolt_length-acrylic,front_panel_height*7/8]) rotate(90,0) case_bolt_hole_centered();
            //t slots for back panel
            translate([case_depth-case_bolt_length-acrylic,front_panel_height*7/8]) rotate(-90,0) case_bolt_hole_centered();
            translate([case_depth-case_bolt_length-acrylic,front_panel_height/8]) rotate(-90,0) case_bolt_hole_centered();
        }
        //teeth
        for( i=[0:side_panel_teeth-1]){
            translate([i*2*case_teeth_width,-case_teeth_height]) square([case_teeth_width,case_teeth_height]);
            translate([i*2*case_teeth_width,side_panel_height]) square([case_teeth_width,case_teeth_height]);
        }
    }
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
    % linear_extrude(height=acrylic) bottom_panel_2d();
}

module side_panel(){
    linear_extrude(height=acrylic) side_panel_2d(); 
}

module d_type_blind_plate(label){
    linear_extrude(height=3) d_type_blind_plate_2d();
    translate([d_type_blind_plate_width/2, d_type_blind_plate_height/2, 3])
    color("red") {
        text(size=4,halign="center", valign="center", text=label);
   }
}

module honeycomb(rows, columns, cell_interior, walls) {
    for (i = [0 : rows - 1]) {
            for (j = [0 : (columns - 1 - i%2)]) {
                translate([(j + (i % 2) /2) * (cell_interior + walls),
                           (cell_interior + walls) * i * sqrt(3) / 2])
                rotate([0,0,30])
                difference() {
                  //circle(r=(cell_interior + 2 * walls)/sqrt(3),$fn=6); //comment out to get inverse
                  circle(r=cell_interior/sqrt(3),$fn=6);
                }
            }
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
        % bottom_panel();
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

        // left side d type panel mount coupler plates
        translate([d_hole_width/2-(d_type_blind_plate_width-d_hole_width)/2+10,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("spare");
        translate([d_hole_width*3/2-(d_type_blind_plate_width-d_hole_width)/2+20,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("spare");
        translate([d_hole_width*5/2-(d_type_blind_plate_width-d_hole_width)/2+30,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("spare");
        translate([d_hole_width*7/2-(d_type_blind_plate_width-d_hole_width)/2+40,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("spare");
        //right side d type panel mount coupler plates
        translate([case_width-d_hole_width*3/2-(d_type_blind_plate_width-d_hole_width)/2-10,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("ethernet 3");
        translate([case_width-d_hole_width*5/2-(d_type_blind_plate_width-d_hole_width)/2-20,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("ethernet 2");
        translate([case_width-d_hole_width*7/2-(d_type_blind_plate_width-d_hole_width)/2-30,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("ethernet 1");
        translate([case_width-d_hole_width*9/2-(d_type_blind_plate_width-d_hole_width)/2-40,0,acrylic+(front_panel_height-d_type_blind_plate_height)/2])
            rotate([90,0,0])
                d_type_blind_plate("camera in");
    }
//}