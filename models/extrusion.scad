

module extrusion(off = 0, $fn=100){
linear_extrude(750, center=true)    offset(0.2) offset(-0.2)  difference() { 
    offset(off) {
    square(15,center=true);
    }    
    for(i=[0:90:360]) rotate(i) translate([11,0]) square([10,2],center=true);
}
linear_extrude(500,center=true)    offset(0.2) offset(-0.2)  difference(){ offset(off) {
        square(15,center=true);
        translate([(15+10)/2,0]) square(10, center=true);        

    }
        for(i=[0:90:180]) rotate(i+90) translate([10,0]) square([10,2],center=true);
        }    
}

extrusion(0.5);