$fn=60;
difference(){
    union(){
linear_extrude(17){
       square([70,110],center=true);
}
translate([0,0,17]) linear_extrude(3,scale=0.98){
       square([70,110],center=true);
}
}
translate([0,0,10])linear_extrude(20){
        offset(-10) square([70,110],center=true);       
}
linear_extrude(20){
        circle(d=6);
        translate([-10,-10]) {
            for(x=[0:4:20])for(y=[0:4:20]) translate([x,y])
            circle(d=1);
        }
}

}



translate([0,0,13]) linear_extrude(5){
circle(d=52.2);
}


translate([0,0,13]) linear_extrude(5){ intersection() {difference(){
offset(15) circle(d=52.2);
offset(3) circle(d=52.2);
}

     offset(-5)  square([70,110],center=true);
}
}