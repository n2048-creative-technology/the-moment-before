
$fn=180;

difference(){
    union(){
linear_extrude(15) square([70,110],center=true);
translate([0,0,15]) linear_extrude(5,scale=0.99) square([70,110],center=true);
translate([0,0,-5])linear_extrude(5) square([70,110],center=true);       
translate([0,0,-5]) mirror([0,0,1]){
linear_extrude(15) square([70,110],center=true);
translate([0,0,15]) linear_extrude(5,scale=0.99) square([70,110],center=true);
}
}

linear_extrude(50,center=true) 
        difference() {
        offset(-5) 
            square([70,110],center=true);
            square([70,5],center=true);
    }    
}


translate([0,0,-2.5]) linear_extrude(35,center=true)
difference(){
    translate([0,68])offset(5) circle(d=16);
    translate([0,68]) circle(d=17);
    offset(3) square([70,110],center=true);
}


translate([0,0,-2.5]) linear_extrude(5,center=true)
difference(){
    translate([0,68])offset(8) circle(d=16);
    translate([0,68]) circle(d=17);
}


translate([0,0,-2.5]) linear_extrude(35,center=true)
difference(){
    translate([0,-68])offset(5) circle(d=16);
    translate([0,-68]) circle(d=17);
    offset(3) square([70,110],center=true);
}


translate([0,0,-2.5]) linear_extrude(5,center=true)
difference(){
    translate([0,-68])offset(8) circle(d=16);
    translate([0,-68]) circle(d=17);
}
