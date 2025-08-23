$fn=180;

thickness=3;
OD=65;
ID=OD-2*thickness;

difference(){
hull(){
difference(){
translate([0,0,33]) linear_extrude(10){
difference(){
    offset(2) offset(-2) square(56+10,center=true);

    translate([47/2,47/2]) { circle(d=5); square([7,1],center=true);}
    translate([-47/2,47/2]) { circle(d=5); square([7,1],center=true);}
    translate([47/2,-47/2])  { circle(d=5); square([7,1],center=true);}
    translate([-47/2,-47/2])  { circle(d=5); square([7,1],center=true);}
}
}

translate([0,0,41]) linear_extrude(10){
    offset(2) offset(-2) square(56,center=true);
    }

}

//cylinder connection
difference(){
    translate([33,23,17]) rotate([0,90]) {
        linear_extrude(11) circle(d=ID);
        linear_extrude(3) circle(d=OD);
    }

    
}
}

    // guide
    translate([0,23,17]) cube([100,17,17],center=true);

    translate([33,23,17]) rotate([0,90]) 
        for(i=[0:2]) rotate(90*i-90) translate([20,0])
            linear_extrude(100,center=true) circle(d=5);

    translate([-12,23,17]) rotate([0,90]) 
        for(i=[0:2]) rotate(90*i-90) translate([20,0])
            linear_extrude(100,center=true) circle(d=12);


    translate([0,0,-17]) linear_extrude(50) difference(){
        offset(2.5) offset(-2) square(56+10,center=true);
    }

    translate([0,0,38])  linear_extrude(20){
        translate([47/2,47/2]) { circle(d=12); square([13,1],center=true);}
        translate([-47/2,47/2]) { circle(d=12); square([13,1],center=true);}
        translate([47/2,-47/2])  { circle(d=12); square([13,1],center=true);}
        translate([-47/2,-47/2])  { circle(d=12); square([13,1],center=true);}
    }
    linear_extrude(100,center=true){
      translate([47/2,47/2]) { circle(d=5); square([7,1],center=true);}
        translate([-47/2,47/2]) { circle(d=5); square([7,1],center=true);}
        translate([47/2,-47/2])  { circle(d=5); square([7,1],center=true);}
        translate([-47/2,-47/2])  { circle(d=5); square([7,1],center=true);}
    }
    
    
    translate([33+3,23,17]) rotate([0,90]) {
    linear_extrude(8) difference(){
        circle(d=OD+.5);
        circle(d=ID);
    }
    }
    
linear_extrude(100,center=true){
        //wheels screws
    translate([20,0]){ circle(d=12); square([13,1],center=true);}
    translate([-20,0]){ circle(d=12); square([13,1],center=true);}
}
}