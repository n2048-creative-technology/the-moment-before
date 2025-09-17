$fn=180;

thickness=1.5;
OD=65;
ID=OD-2*thickness;
of=0.2;

difference(){

 linear_extrude(30) circle(d=ID-6-of);

    
#translate([0,0,5]) rotate_extrude() translate([(ID-6)/2,0]) circle(d=6);
translate([0,0,15]) rotate_extrude() translate([(ID-6)/2,0]) circle(d=6);
    
    
translate([0,0,25]) for(i=[0:36:360]) rotate(i) rotate ([90,0]) linear_extrude(100,center=true) {
        circle(d=4);
        square([1,5],center=true);
    }

    // guide
cube([17,17,100],center=true);
cube([12,22,100],center=true);

for(i=[0:2]) rotate(90*i-90) translate([20,0]){
    linear_extrude(100,center=true) circle(d=5);
    linear_extrude(10,center=true) circle(d=12);
}

}



