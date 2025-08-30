$fn=100;

//%top();
bottom();


module top(){

    difference(){
        union(){
            linear_extrude(16.5) square(100,center=true);
            linear_extrude(16.5+5.8) square([95,58],center=true);
        }
        linear_extrude(100,center=true){
            translate([75/2,75/2]) circle(d=5);
            translate([-75/2,75/2]) circle(d=5);
            translate([75/2,-75/2]) circle(d=5);
            translate([-75/2,-75/2]) circle(d=5);
        }        
        translate([0,0,16.5-3]) linear_extrude(10){
            translate([75/2,75/2]) circle(d=10);
            translate([-75/2,75/2]) circle(d=10);
            translate([75/2,-75/2]) circle(d=10);
            translate([-75/2,-75/2]) circle(d=10);
        }        
        linear_extrude(100,center=true){
            translate([35,0]) circle(d=5);
            translate([-35,0]) circle(d=5);
            translate([35,20]) circle(d=5);
            translate([35,-20]) circle(d=5);
            translate([-35,20]) circle(d=5);
            translate([-35,-20]) circle(d=5);
        }
        
        translate([0,0,-1])
        linear_extrude(4){
            translate([35,0]) circle(d=10);
            translate([-35,0]) circle(d=10);
            translate([35,20]) circle(d=10);
            translate([35,-20]) circle(d=10);
            translate([-35,20]) circle(d=10);
            translate([-35,-20]) circle(d=10);
        }
        linear_extrude(100,center=true) {
            square([50,40],center=true);
            translate([0,45]) square([50,20],center=true);
            translate([0,-45]) square([50,20],center=true);
        }
    }
}


module bottom(){
    difference(){
        union(){
            linear_extrude(10) offset(1) offset(-1) square([50,40],center=true);
            linear_extrude(5) offset(2) square([111,74],center=true);
        }
        linear_extrude(100,center=true){
            translate([35,0]) circle(d=5);
            translate([-35,0]) circle(d=5);
            translate([35,20]) circle(d=5);
            translate([35,-20]) circle(d=5);
            translate([-35,20]) circle(d=5);
            translate([-35,-20]) circle(d=5);
        }
        translate([0,0,-1])
        linear_extrude(4){
            translate([35,0]) circle(d=10);
            translate([-35,0]) circle(d=10);
            translate([35,20]) circle(d=10);
            translate([35,-20]) circle(d=10);
            translate([-35,20]) circle(d=10);
            translate([-35,-20]) circle(d=10);
        }
        linear_extrude(100,center=true) offset(-6) square([50,40],center=true);
    }
}