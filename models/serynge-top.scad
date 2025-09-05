$fn=360;

thickness=1.5;
OD=65;
ID=OD-2*thickness;
of=0.2;

difference(){
linear_extrude(30) circle(d=ID-6-of);
translate([0,0,+5] )linear_extrude(30) circle(d=ID-25);
    
translate([0,0,5]) rotate_extrude() translate([(ID-6)/2,0]) circle(d=6);
translate([0,0,15]) rotate_extrude() translate([(ID-6)/2,0]) circle(d=6);
translate([0,0,25]) rotate_extrude() translate([(ID-6)/2,0]) circle(d=6);
    
linear_extrude(100,center=true) for(i=[0:120:360]) rotate(i) translate([10,0]) circle(d=5.5);
}

