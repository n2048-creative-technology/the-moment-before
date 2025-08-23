$fn=100;

t=5;

difference(){
    union(){
linear_extrude(15) difference(){
    translate([0,-4.5,0]) square([15.33+2*t,15.33+2*t+9],center=true);
    square(15.33,center=true);
}
translate([0,0,-5]) linear_extrude(5) difference(){
    translate([0,-4.5,0]) square([15.33+2*t,15.33+2*t+9],center=true);
}

}


translate([0,0,-1])linear_extrude(20) 
//translate([0,3.9]) 
square([18.06,9.2],center=true);

translate([0,0,-1])linear_extrude(20) 
square([22.06,8],center=true);

linear_extrude(20,center=true) circle(2);
}


