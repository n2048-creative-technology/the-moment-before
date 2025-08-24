$fn=360;

thickness=3;
OD=65;
ID=OD-2*thickness;
of=0.2;

difference(){
linear_extrude(15) circle(d=ID-1-of);
linear_extrude(150,center=true) circle(d=3+of);
translate([0,0,-1] )linear_extrude(6) circle(d=10);
translate([0,0,+5] )linear_extrude(15) difference() circle(d=ID-10);
    
translate([0,0,4]) rotate_extrude() translate([(ID-1)/2,0]) circle(d=2);
translate([0,0,11]) rotate_extrude() translate([(ID-1)/2,0]) circle(d=2);
}


difference() {

union(){
translate([0,0,10]){
t=8;

difference(){
    union(){
linear_extrude(20) difference(){
    translate([0,0,0]) square([15.33+2*t,15.33+2*t],center=true);
    square(15.33,center=true);
}
translate([0,0,-5]) linear_extrude(5) difference(){
    translate([0,0,0]) square([15.33+2*t,15.33+2*t],center=true);
}

}


translate([0,0,-1])linear_extrude(25) 
//translate([0,3.9]) 
square([19,10],center=true);

translate([0,0,-1])linear_extrude(25) 
square([22.06,9],center=true);

linear_extrude(25,center=true) circle(2);
}

}
}

translate([0,0,22]) rotate([90,0]) linear_extrude(100,center=true ) {
    circle(d=4);
    square([1.5,5.5],center=true);
}

}