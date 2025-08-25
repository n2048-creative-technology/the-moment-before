$fn=180;

extended_spring_height = 34;
contracted_spring_height = 8.3;
mid_lenth = (extended_spring_height+contracted_spring_height)*2/3;

module pin(){
    linear_extrude(5) difference() {
        offset(5) offset(-5) square(45, center=true);
        for(i=[0:90:360]) rotate(i) translate([15,15]) circle(d=5);
            circle(d=5.5);
    }
    linear_extrude(mid_lenth) {
        difference() {
            union(){
                circle(d=9);
                square([16,4], center=true);
            }
            circle(d=5.5);
        }
    }
}

module base() {
    difference(){
        linear_extrude(5) difference() {
            offset(5) offset(-5) square(45, center=true);
            for(i=[0:90:360]) rotate(i) translate([15,15]) circle(d=5);
        }
        translate([0,0,2]) cylinder(d2=15,d1=0,h=12);
    }
}

module conepin() {
    linear_extrude(mid_lenth) difference(){
        circle(d=15);
        circle(d=10);
        square([16,5],center=true);
    }

    //cone
    difference() {
        mirror([0,0,1]) cylinder(d1=15,d2=0,h=12);
        translate([0,0,6])mirror([0,0,1]) cylinder(d1=15,d2=0,h=12);
    }
    
}

!translate([0,0,extended_spring_height*2]) mirror([0,0,1]) conepin();
pin();
base();