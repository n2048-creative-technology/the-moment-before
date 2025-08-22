$fn=100;

linear_extrude(20){
    difference(){
        union(){
            offset(0.2) offset(-0.2) square([2.5,5],center=true);
            translate([0,1]) offset(0.2) offset(-0.2) square([2.5,5],center=true);
            rotate(90) offset(0.2) offset(-0.2) square([2.5,5],center=true);
        }
        circle(d=1.1);
    }
    difference(){
        translate([0,3.6]) offset(0.2) offset(-0.2) square([9,2],center=true);
        translate([0,4.6]) offset(0.2) offset(-0.2) square([7,2],center=true);
    }    
}