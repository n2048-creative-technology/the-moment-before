
d=5;

module out(){    
    linear_extrude(1)
difference(){
offset(.5)polygon([
[0,0],
[20,20],
[70,20],
[90,0],
[70,-20],
[20,-20]
]);
   offset(-.5)polygon([
[0,0],
[20,20],
[70,20],
[90,0],
[70,-20],
[20,-20]
]);
    circle(d=d);
    translate([90,0])circle(d=d);
    translate([70,20])circle(d=d);
    translate([70,-20])circle(d=d);
    translate([20,-20])circle(d=d);
    translate([20,20])circle(d=d);
}
}

module in(){
    linear_extrude(1) difference(){
    translate([0,-.5]) square([90,1]);
            circle(d=d);
    translate([90,0])circle(d=d);
    }
}


for(y=[0:10]) translate([0,y*40]) for(x=[0:2]){
translate([140*x,0]) {
color("red") out();
color("blue") in();
}
translate([70+140*x,20]) {
color("red") out();
color("blue") in();
}

}