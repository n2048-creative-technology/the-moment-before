$fn=180;

difference(){
union(){

translate([0,0,-5]) linear_extrude(10){
difference(){
    offset(2) offset(-2) square(56+4,center=true);
    offset(2) offset(-2) square(56.1,center=true);
}
}

linear_extrude(10){
difference(){
    offset(2) offset(-2) square(56+4,center=true);
    circle(d=38.2);
    translate([19.5,0]) circle(d=5);
    translate([-19.5,0]) circle(d=5);
    }
}

translate([0,0,10]) linear_extrude(13) difference(){
    offset(2) offset(-2) square(56+4,center=true);
    circle(d=38.2);
    translate([19.5,0]) circle(d=26);
    translate([-19.5,0]) circle(d=29);
}


translate([0,0,23]) linear_extrude(10) difference(){
    offset(2) offset(-2) square(56+4,center=true);
    circle(d=18);
    translate([19.5,0]) circle(d=5);
    translate([-19.5,0]) circle(d=5);
}
}

linear_extrude(1000,center=true){
    translate([47/2,47/2]) circle(d=5);
    translate([-47/2,47/2]) circle(d=5);
    translate([47/2,-47/2]) circle(d=5);
    translate([-47/2,-47/2]) circle(d=5);
}

translate([0,0,20]) linear_extrude(30,center=true){
    translate([47/2,47/2]) circle(d=9);
    translate([-47/2,47/2]) circle(d=9);
    translate([47/2,-47/2]) circle(d=9);
    translate([-47/2,-47/2]) circle(d=9);
}

translate([0,19,17]) #cube([100,19,18],center=true);


}