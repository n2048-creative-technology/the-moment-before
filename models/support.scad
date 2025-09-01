$fn=180;

difference(){
    linear_extrude(8) difference() {
    circle(d=160);
    translate([0,40]) offset(3) offset(-3) square(30, center=true);
}
    for(i=[0:30:360]) rotate(i) translate([68,0,18])mirror([0,0,1]) cylinder(d1=15,d2=0,h=12);
}
