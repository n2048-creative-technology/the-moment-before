$fn=100;

difference(){
hull(){
linear_extrude(10) difference(){
    translate([0,1,0]) offset(9) offset(-9) square([80,120],center=true);
}

translate([0,0,5]) linear_extrude(5) difference(){
    circle(d=100);
    offset(-5) circle(d=100);
}
}

linear_extrude(100,center=true) {
    translate([0,0,5])  offset(-5) circle(d=100);
    translate([40-7,-100+49.8]) circle(d=6.4);
    translate([-40+7,-100+49.8]) circle(d=6.4);
    translate([40-7,100-49.8]) circle(d=6.4);
    translate([-40+7,100-49.8]) circle(d=6.4);
    offset(-5) circle(d=100);
}
}


translate([0,0,5]) linear_extrude(30) difference(){
    circle(d=100);
    offset(-5) circle(d=100);
}


translate([0,0,5]) difference(){
linear_extrude(30) difference() {
    intersection(){
    for(i=[0:15:360]) rotate(i) square([90,2],center=true);
        circle(d=90);
    }
    circle(d=87);
}
translate([0,0,-1])cylinder(d1=90,d2=70,h=15);
}
    