$fn=60;
difference(){
    union(){
linear_extrude(17){
       square([70,110],center=true);
}
translate([0,0,17]) linear_extrude(3,scale=0.98){
       square([70,110],center=true);
}
}
translate([0,0,10])linear_extrude(20){
        offset(-10) square([70,110],center=true);       
}

linear_extrude(20){
        circle(d=6);
        translate([0,30]) circle(d=5.5);
        translate([0,-30]) circle(d=5.5);
}

}






/////


thickness=3;
OD=65;
ID=OD-2*thickness;
of=0.2;



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