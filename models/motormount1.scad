$fn=180;


difference(){
linear_extrude(32) difference(){
    offset(2) offset(-2) square(56,center=true);
    circle(d=38.2);
    translate([47/2,47/2]) circle(d=5);
    translate([-47/2,47/2]) circle(d=5);
    translate([47/2,-47/2]) circle(d=5);
    translate([-47/2,-47/2]) circle(d=5);
}

translate([0,20-5,8+10]) difference(){
    cube([100,15.25+1,15.25+1],center=true);
    difference() {
        cube([100,20,3],center=true);
        cube([100,9,5],center=true);
    }
    difference() {
        cube([100,3,20],center=true);
        cube([100,5,9],center=true);
    }
}

#translate([0,20-12,8+10-3]) difference(){
    cube([100,8,12],center=true);
}

translate([0,0,6]) linear_extrude(50) {
    
    translate([47/2,47/2]) circle(d=8);
    translate([-47/2,47/2]) circle(d=8);
    translate([47/2,-47/2]) circle(d=8);
    translate([-47/2,-47/2]) circle(d=8);
}
}