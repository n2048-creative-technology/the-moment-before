$fn=180;
linear_extrude(500) difference() {
    circle(d=65);
    offset(-1.5) circle(d=65);
}