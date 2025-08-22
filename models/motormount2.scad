$fn=180;

difference(){
union(){

translate([0,0,-5]) linear_extrude(10){
difference(){
    offset(2) offset(-2) square(56+10,center=true);
    offset(2) offset(-2) square(56.1,center=true);
}
}

linear_extrude(10){
difference(){
    offset(2) offset(-2) square(56+10,center=true);
    circle(d=38.2);
    translate([19.5,0]) circle(d=5);
    translate([-19.5,0]) circle(d=5);
    }
}

translate([0,0,10]) linear_extrude(13) difference(){
    offset(2) offset(-2) square(56+10,center=true);
    circle(d=38.2);
    translate([19.5,0]) circle(d=26);
    translate([-19.5,0]) circle(d=29);
}


translate([0,0,23]) linear_extrude(10) difference(){
    offset(2) offset(-2) square(56+10,center=true);
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
    translate([47/2,47/2]) circle(d=12);
    translate([-47/2,47/2]) circle(d=12);
}
translate([0,0,30]) linear_extrude(30,center=true){
    translate([47/2,-47/2]) circle(d=12);
    translate([-47/2,-47/2]) circle(d=12);
}

difference(){
    translate([0,21,17]) cube([100,25,16],center=true);
    difference(){
        translate([0,21,17]) cube([100,2.5,32],center=true);
    }
}

translate([0,21,17]) cube([100,6,10],center=true);
translate([-33,3,28]) cube([16.08,12.85,10]);

translate([-33,6,30]) cube([20,5,10]);
translate([-15.5,-39,30]) cube([5,50,10]);

}