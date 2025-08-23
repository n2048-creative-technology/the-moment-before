$fn=180;


linear_extrude(3) difference(){
    circle(d=10);
    circle(d=3);
}

linear_extrude(5) difference() {
    circle(d=10);
    circle(d=8);
}