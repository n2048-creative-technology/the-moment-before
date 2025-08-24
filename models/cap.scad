$fn=100;

r=1;

difference(){
    hull(){
        
            translate([25.33/2-r,28/2-r-4.5,-5+r]) sphere(r);
            translate([-25.33/2+r,28/2-r-4.5,-5+r]) sphere(r);
            translate([25.33/2-r,-28/2+r-4.5,-5+r]) sphere(r);
            translate([-25.33/2+r,-28/2+r-4.5,-5+r]) sphere(r);
            translate([25.33/2-r,28/2-r-4.5,20-r]) sphere(r);
            translate([-25.33/2+r,28/2-r-4.5,20-r]) sphere(r);
            translate([25.33/2-r,-28/2+r-4.5,20-r]) sphere(r);
            translate([-25.33/2+r,-28/2+r-4.5,20-r]) sphere(r);
        }

linear_extrude(25) square(15.33,center=true);
        
translate([0,0,-1])linear_extrude(25) 
//translate([0,3.9]) 
square([18.06,9.2],center=true);

translate([0,0,-1])linear_extrude(25) 
square([22.06,8],center=true);

linear_extrude(25,center=true) circle(2);
}


