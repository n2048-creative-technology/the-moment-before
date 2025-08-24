$fn=180;

o=0.2;

module keyhole(){
difference(){
    translate([0,1]) linear_extrude(38) square([9+4,15], center=true);
    translate([0,10,-1]) linear_extrude(34) square([6,15], center=true);
    translate([0,0,-1]) cylinder(d=10,h=34);
    cylinder(d=6+o,h=100,center=true);
}
}

module key(){
 translate([0,3]) linear_extrude(15) square([5,10], center=true);
 translate([0,0]) cylinder(d=9,h=15);
}

key();
keyhole();