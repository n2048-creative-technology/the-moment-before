$fn=100;

linear_extrude(5) difference(){
    offset(9) offset(-9) square([79,200],center=true);
    translate([0,100-7]) circle(d=6.4);
    translate([0,-100+7]) circle(d=6.4);   
    translate([40-7,-100+49.8]) circle(d=6.4);
    translate([-40+7,-100+49.8]) circle(d=6.4);
    translate([40-7,100-49.8]) circle(d=6.4);
    translate([-40+7,100-49.8]) circle(d=6.4);

    translate([0,8]) offset(-5) circle(d=100);

    translate([0,-70]) offset(5) square(20, center=true);
    translate([0,75]) offset(5) circle(d=10);

}

translate([0,8]) linear_extrude(30) difference(){
    circle(d=100);
    offset(-5) circle(d=100);
}
