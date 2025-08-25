$fn=100;

r=1;

difference(){
    hull(){    
        translate([25.33/2-r,28/2-r-4.5,r]) sphere(r);
        translate([-25.33/2+r,28/2-r-4.5,r]) sphere(r);
        translate([25.33/2-r,-28/2+r-4.5,r]) sphere(r);
        translate([-25.33/2+r,-28/2+r-4.5,r]) sphere(r);
        translate([25.33/2-r,28/2-r-4.5,20-r]) sphere(r);
        translate([-25.33/2+r,28/2-r-4.5,20-r]) sphere(r);
        translate([25.33/2-r,-28/2+r-4.5,20-r]) sphere(r);
        translate([-25.33/2+r,-28/2+r-4.5,20-r]) sphere(r);
    }

    linear_extrude(100,center=true) 
        square(15.33,center=true);
    linear_extrude(100,center=true) 
      translate([1.8,0])  square([19,9.2],center=true);
    
 translate([0,0,10]) rotate([90,0])   {
    cylinder(h=100,d=4, center=true);
     cube([1,6,100],center=true);
 }
 translate([0,-28,10]) rotate([90,0])    {
     cylinder(h=25,d=10, center=true);
     cube([1,12,25],center=true);
 }
}


