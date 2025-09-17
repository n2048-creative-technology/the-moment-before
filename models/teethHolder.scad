$fn=180;

difference(){
union(){
linear_extrude(10)
difference(){
  hull(){
    offset(2) square(15+4, center=true);
      translate([0,15/2+5]) offset(2) square(10+4, center=true);
  }
  square(15, center=true); 
  translate([0,15/2+5]) square(10, center=true);
}


translate([0,0,10]) linear_extrude(5)
difference(){
  hull(){
    offset(2) square(15+4, center=true);
      translate([0,15/2+5]) offset(2) square(10+4, center=true);
  }
  square(15, center=true); 
}
}
translate([0,0,7.5]) rotate([90,0]) cylinder(d=4,h=50);
}