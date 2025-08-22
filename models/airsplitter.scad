
$fn=180;


intersection(){
difference(){
    
hull(){
translate([-7.5,-22.5,2.5]) sphere(d=5);
translate([7.5,-22.5,2.5]) sphere(d=5);
translate([-7.5,22.5,2.5]) sphere(d=5);
translate([7.5,22.5,2.5]) sphere(d=5);

translate([-7.5,-22.5,47.5]) sphere(d=5);
translate([7.5,-22.5,47.5]) sphere(d=5);
translate([-7.5,22.5,47.5]) sphere(d=5);
translate([7.5,22.5,47.5]) sphere(d=5);
}

    translate([0,0,-.2]){
        cylinder(d=10, h=20);
        translate([0,0,20]) {
            cylinder(d=10, h=20);
            rotate([45,0]) cylinder(d=10, h=20);
            rotate([-45,0]) cylinder(d=10, h=20);
        }

        translate([0,0,30.5]){
            cylinder(d=10, h=20);
            translate([0,12.6]) cylinder(d=10, h=20);
            translate([0,-12.6]) cylinder(d=10, h=20);
        }
    }
    
    translate([0,0,20]) rotate([0,90])cylinder(d=6,h=10);

    translate([0,15,10]) rotate([0,90])cylinder(d=5.2,h=50,center=true);
    translate([0,-15,10]) rotate([0,90])cylinder(d=5.2,h=50,center=true);
}
}