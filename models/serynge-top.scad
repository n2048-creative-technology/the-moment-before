$fn=360;

thickness=3;
OD=65;
ID=OD-2*thickness;
of=0.2;

difference(){
linear_extrude(15) circle(d=ID-1-of);
translate([0,0,+5] )linear_extrude(15) difference() circle(d=ID-10);
    
translate([0,0,4]) rotate_extrude() translate([(ID-1)/2,0]) circle(d=2);
translate([0,0,11]) rotate_extrude() translate([(ID-1)/2,0]) circle(d=2);
    
linear_extrude(10,center=true) for(i=[0:120:360]) rotate(i) translate([10,0]) circle(d=5.5);
}

