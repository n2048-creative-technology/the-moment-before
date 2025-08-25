$fn=180;

module bevelCube(size,radius=0, center=false){
    real_size = is_list(size) ? size : [size, size, size];    
    x=real_size[0];
    y=real_size[1];
    z=real_size[2];    
    if(radius>0){        
        if(center) {
            hull(){
                translate([radius-x/2,radius-y/2,radius-z/2]) sphere(r=radius);
                translate([-radius+x/2,radius-y/2,radius-z/2]) sphere(r=radius);
                translate([radius-x/2,-radius+y/2,radius-z/2]) sphere(r=radius);
                translate([-radius+x/2,-radius+y/2,radius-z/2]) sphere(r=radius);
                translate([radius-x/2,radius-y/2,-radius+z/2]) sphere(r=radius);
                translate([-radius+x/2,radius-y/2,-radius+z/2]) sphere(r=radius);
                translate([radius-x/2,-radius+y/2,-radius+z/2]) sphere(r=radius);
                translate([-radius+x/2,-radius+y/2,-radius+z/2]) sphere(r=radius);
            }
        }
        else{
            translate([x/2,y/2,z/2]) bevelCube(size,radius,true);
        }        
    }
    else{
        cube(size,center=center);
    }
}

difference(){
bevelCube([50,50,20],radius=1,center=true, $fn=60);

translate([0,0,-4]) bevelCube([40,40,10],radius=1,center=true, $fn=60);

linear_extrude(11) {
    translate([0,0]) circle(d=5.5); // screw fitting
    
    translate([0,15]) circle(d=5.5); // screw fitting
    translate([10,15]) circle(d=5.5); // screw fitting
    translate([-10,15]) circle(d=5.5); // screw fitting

    translate([0,-15]) circle(d=5.5); // screw fitting
    translate([10,-15]) circle(d=5.5); // screw fitting
    translate([-10,-15]) circle(d=5.5); // screw fitting    
}
}