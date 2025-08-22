$fn=100;

t=5;

difference(){
    union(){
linear_extrude(15) difference(){
    square(15.33+2*t,center=true);
    square(15.33,center=true);
}
translate([0,0,-5]) linear_extrude(5) difference(){
    square(15.33+2*t,center=true);
}

}

translate([0,0,-1])linear_extrude(20) 
//translate([0,3.9]) 
square([18.06,15.33/2],center=true);

linear_extrude(20,center=true) circle(2);
}
