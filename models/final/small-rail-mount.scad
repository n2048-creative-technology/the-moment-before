$fn=180;

    difference(){
union(){

translate([0,0,-5]) linear_extrude(10){
difference(){
    translate([5,0]) offset(2) offset(-2) square([76,66],center=true);
    offset(2) offset(-2) square(56.1,center=true);
}
}

linear_extrude(10){
difference(){
    translate([5,0]) offset(2) offset(-2) square([76,66],center=true);
    circle(d=38.2);
    }
}

translate([0,0,10]) linear_extrude(14) difference(){
    translate([5,0]) offset(2) offset(-2) square([76,66],center=true);
    translate([-5,0]) offset(2) offset(-2) square([76,66],center=true);
    circle(d=38.2);
}

}

linear_extrude(1000,center=true){
    translate([47/2,47/2]) circle(d=5);
    translate([-47/2,47/2]) circle(d=5);
    translate([47/2,-47/2]) circle(d=5);
    translate([-47/2,-47/2]) circle(d=5);
}

translate([0,0,20]) linear_extrude(30,center=true){
    translate([47/2,47/2]) circle(d=12);
    translate([-47/2,47/2]) circle(d=12);
    translate([47/2,-47/2]) circle(d=12);
    translate([-47/2,-47/2]) circle(d=12);
}


translate([18.95+7.5,0,7.6+8.57]){
cube([16,100,16],center=true);
translate([-7.5-5,0]) cube([11,100,11],center=true);
}
}
