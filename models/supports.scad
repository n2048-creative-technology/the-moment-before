
$fn=180;

scale([1,1,.5]){
difference(){
    scale([.8,1,1])
    sphere(d=30);
    translate([0,0,20]) cube(40,center=true);
    translate([0,5]) cylinder(d=5,h=100,center=true);
    translate([0,-5]) cylinder(d=5,h=100,center=true);
    intersection(){
        rotate([0,90]) rotate_extrude() translate([15,0]) circle(d=5);
        hull(){
            translate([0,5]) cylinder(d=5,h=100,center=true);
            translate([0,-5]) cylinder(d=5,h=100,center=true);
        }        
    }
}

difference(){
    intersection(){
    scale([.8,1,1])
        sphere(d=32);
        translate([0,0,1]) cube([40,40,2],center=true);
    }
    translate([0,5]) cylinder(d=5,h=100,center=true);
    translate([0,-5]) cylinder(d=5,h=100,center=true);
}
}