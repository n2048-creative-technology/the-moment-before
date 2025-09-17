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
    }
}

translate([0,0,10]) linear_extrude(23) difference(){
    offset(2) offset(-2) square(56+10,center=true);
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

thickness=1.5;
OD=65;
ID=OD-2*thickness;
of=0.2;

difference(){
translate([18.95+7.5,58,7.6+8.57])
rotate([90,0])
difference(){

 linear_extrude(30) circle(d=ID-6-of);

   
translate([0,0,5]) rotate_extrude() translate([(ID-6)/2,0]) circle(d=6);
translate([0,0,15]) rotate_extrude() translate([(ID-6)/2,0]) circle(d=6);
    
    translate([0,0,25]) for(i=[0:36:360]) rotate(i) rotate ([90,0]) linear_extrude(100,center=true) {
        circle(d=4);
        square([1,5],center=true);
    }

    // guide
cube([16,16,100],center=true);
translate([-13.5,0])cube([11,11,100],center=true);


}
translate([0,0,20]) linear_extrude(30,center=true){
    translate([47/2,47/2]) circle(d=12);
    translate([-47/2,47/2]) circle(d=12);
    translate([47/2,-47/2]) circle(d=12);
    translate([-47/2,-47/2]) circle(d=12);
}
}


translate([18.95+7.5,-33,7.6+8.57])
rotate([90,0])
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

    // guide
cube([16,16,100],center=true);
translate([-13.5,0])cube([11,11,100],center=true);

}