// Cheapskate Mount and Boom Jig
// by ScribbleJ - Originally by xnaron

// Overall dimensions of Cheapskate Mount
mount_length       = 76; // 
mount_height       = 10; // 
mount_width        = 6;  // Length of 'extra' behind the angle - total width is mount_width + mount_height.
ball_sep           = 48; // Separation distance of ball assemblies.
mount_bolt_sep     = 66; // Separation distance of Cheapskate mounting bolt holes.

// Dimensions of ball assembly parts
// TODO: Move this to separate file.
ball_dia          = 9.525;  // Diameter of ball bearing
ball_bolthead_dia = 5.4;    // Diameter of bolt head
ball_bolthead_l   = 3;      // Height of bolt head
ball_bolt_dia     = 3.2;    // Diameter of bolt shaft
ball_bolt_l       = 6;      // Length of bolt shaft
washer_dia        = 7;      // Diameter of washer
washer_h          = 0.6;    // Thickness of washer

// Dimensions of mounting bolts to attach to cheapskate
mount_bolthead_dia = 7;     // Diameter of bolt head
mount_bolt_dia     = 4;     // Diameter of bolt shaft

// Position and dimensions of long bolt for hitting endstops
endstop_bolt_dia   = 3.8;                      // Diameter of bolt shaft
endstop_bolt_x_off = -12 - endstop_bolt_dia/2; // X offset (from center)
endstop_bolt_y_off = 1 + mount_width + endstop_bolt_dia/2; // Y offset 

// Dimensions of Jig
jig_length       = 30; // 
jig_height       = 10; // 
jig_width        = 6;  // Length of 'extra' behind the angle - total width is mount_width + mount_height.
jig_nail_sep     = 20; // Separation distance of Cheapskate mounting bolt holes.
nail_dia         = 4;  // Diameter of nails for arm Jig

// Garbage Variables
huge = 200;


// The mount for the cheapskate carriages
cheapskate_mount();

// The parts for the arm-making Jig
// See the following URLs for use:
// http://www.flickr.com/photos/13723140@N04/8771948345/
// http://www.flickr.com/photos/13723140@N04/8771958335/
//
//jig_end();
//translate([0,0,mount_height+5]) rotate([180,0,0]) jig_stop();





module cheapskate_mount()
{
  difference()
  {
    translate([-mount_length/2,-mount_width,0]) cube([mount_length,mount_height+mount_width,mount_height]);

    // Angle cut
    translate([-huge/2,0,mount_height]) rotate([-45,0,0]) cube([huge,huge,huge]);

    // Ball Assembly
    #for(x=[ball_sep/2,-ball_sep/2])
      translate([x,0,0]) rotate([-45,0,0]) translate([0,0,(mount_height / sqrt(2))]) ball_assembly();

    // Mounting Bolts
    for(x=[mount_bolt_sep/2,-mount_bolt_sep/2])
      //translate([x,(mount_height - mount_bolthead_dia)/2,mount_height/2]) rotate([-90,90/4,0]) // Align with slope so bolthead has no overhang.
      translate([x,0,mount_height/2]) rotate([-90,90/4,0]) // Align with 'extra' portion
      {
        translate([0,0,-huge+1]) cylinder(r=mount_bolt_dia/2, h=huge, $fn=8);
        cylinder(r=mount_bolthead_dia/2, h=huge, $fn=8);
      }

    // Endstop bolt
    translate([endstop_bolt_x_off, endstop_bolt_y_off - mount_width, -1]) cylinder(r=endstop_bolt_dia/2, h=huge);
  }
}


module jig_end()
{
  difference()
  {
    translate([-jig_length/2,-jig_width,0]) cube([jig_length,jig_height+jig_width,jig_height]);

    // Angle cut
    translate([-huge/2,0,jig_height]) rotate([-45,0,0]) cube([huge,huge,huge]);

    // Ball Assembly
    #rotate([-45,0,0]) translate([0,0,(jig_height / sqrt(2))]) ball_assembly();

    // Mounting Nails
    for(x=[jig_nail_sep/2,-jig_nail_sep/2])
      translate([x,0,-1]) rotate([0,0,0])
      {
        cylinder(r=nail_dia/2, h=huge, $fn=8);
      }
  }
}

module jig_stop()
{
  difference()
  {

    translate([-5,-jig_width-5,0]) cube([jig_length, jig_height+jig_width+10, jig_height+5]);

    #translate([jig_length/2 + 5,-jig_width,-1]) cylinder(r=nail_dia/2,h=huge,$fn=8);
    #translate([jig_length/2 + 5,jig_width,-1]) cylinder(r=nail_dia/2,h=huge,$fn=8);

    translate([0,0,-0.05]) difference()
    {
      translate([-jig_length/2,-jig_width,0]) cube([jig_length,jig_height+jig_width,jig_height]);
      translate([-huge/2,0,jig_height]) rotate([-45,0,0]) cube([huge,huge,huge]);
    }
  }
}


// TODO: Adjust for depth of ball in hex on top of bolt.
//ball_assembly();
module ball_assembly()
{
  translate([0,0,ball_dia/2 + ball_bolthead_l + washer_h]) sphere(r=ball_dia/2);
  translate([0,0,washer_h]) cylinder(r=ball_bolthead_dia/2, h=ball_bolthead_l);
  cylinder(r=washer_dia/2,h=washer_h);
  translate([0,0,-ball_bolt_l+washer_h]) cylinder(r=ball_bolt_dia/2, h=ball_bolt_l+0.05);
}
