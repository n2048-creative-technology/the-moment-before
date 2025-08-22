$fn=100;

difference(){
linear_extrude(25)
difference(){
    offset(3) offset(-3) square([80,160],center=true);
    offset(3) offset(-5) square([60,100],center=true);
    translate([0,68]) circle(d=16);
    translate([0,-68]) circle(d=16);
}

translate([0,0,5])linear_extrude(20)
offset(2) square([70,110],center=true);
}

linear_extrude(5)
difference(){
    offset(3) offset(-3) square([80,160],center=true);
    offset(3) offset(-3) square([60,100],center=true);
    translate([0,68]) circle(d=3);
    translate([0,-68]) circle(d=3);
}
