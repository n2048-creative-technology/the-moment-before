$fn=180;

// polycarbonat cylinder
OD = 65;
th = 1.5;
ID = OD-2*th;
of = 0.2;

module polycarbonat(){
    linear_extrude(500) difference() {
        circle(d=OD+10);
        circle(d=ID-of);
    }
}

module oring(){
    rotate_extrude() translate([(ID-6)/2,0]) {
        circle(d=6);
        translate([3,0]) square(6,center=true);
    }
}


module  driver(margin=0){    
    cube([120+margin,35+margin,85+margin],center=true);
}

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
    
    union(){
        hull(){
            // main block
            translate([0,0,-5]) linear_extrude(45) offset(2) offset(-2) square(56+10,center=true);
            
            translate([-26.42,0,25]) rotate([90,0]) {
                // polycarbonat cylinder mount 
               translate([0,0,-60]) linear_extrude(30) circle(d=ID-6-of);

                       
            }
         
                 translate([-26.42,-32.5,25]) rotate([90,0]) {
                            linear_extrude(10){
                       square([110,70],center=true);
                }
        }
        
   
        }
    
        //driver
        hull(){
            translate([0,0,-5]) linear_extrude(45) offset(2) offset(-2) square(56+10,center=true);
            
            translate([-110,-2,0]) bevelCube([120+15,35+28,85+15],center=true,radius=3);
        }
        
        //electronics
         hull(){           
            translate([-130,-50,0]) bevelCube([55,70,60],center=true,radius=3);
            translate([-132,-2,0]) bevelCube([85,70,60],center=true,radius=3);
        }
        
        
    // bellow side:
        translate([-26.42,-32.5,25]) rotate([90,0]) {
                     
      translate([0,0,10])  
            difference(){
                union(){
                linear_extrude(17){
                       square([110,70],center=true);
                }
                translate([0,0,17]) linear_extrude(3,scale=0.98){
                       square([110,70],center=true);
                }
                }
                translate([0,0,10])linear_extrude(20){
                        offset(-10) square([110,70],center=true);       
                }
            }
            

        }
    }

    //electronics:0
    translate([-130,-40,-10]) cube([50,65,50],center=true);
    translate([-100,-2,-35]) rotate([0,90]) cylinder(d=12,h=30);

    // driver access:
    translate([-110,-2,+5-11]) driver(5);

    
    // shaft screw reach
    translate([20,0,10]) linear_extrude(25){
        square([30,12],center=true);
    }

    // motor fit:
    translate([0,0,-60]) linear_extrude(60) offset(2) offset(-2+.1) square(56.1,center=true);
    
    // ,main passthrough
    linear_extrude(1000, center=true) {    
        for(i=[0:90:360]) rotate(i) translate([47/2,47/2]) circle(d=5);
        circle(d=38.2);
    }

    // top screwdriver hole
    translate([0,0,25]) linear_extrude(100){
        for(i=[0:90:360]) rotate(i) translate([47/2,47/2]) circle(d=12);
    }
   
    
    translate([0,0,0]){ 
 
    // syringe side
        translate([-26.42,0,25]) rotate([90,0]) {
            
            // extrusion rail exported with 0.5 mm offset
            import("/home/mauricio/n2048/the-moment-before/models/extrusion.stl");


            //air vents:
            translate([0,17,0]) cylinder(d=3,h=1000,center=true);
            translate([0,-17,0]) cylinder(d=3,h=1000,center=true);
            translate([10,17,0]) cylinder(d=3,h=1000,center=true);
            translate([10,-17,0]) cylinder(d=3,h=1000,center=true);
            translate([-10,17,0]) cylinder(d=3,h=1000,center=true);
            translate([-10,-17,0]) cylinder(d=3,h=1000,center=true);

            translate([0,0,-60]) {
          
                translate([0,0,5]) oring();
                translate([0,0,15]) oring();
            }
                            
            translate([0,0,-535]) polycarbonat();
        }

        translate([0,0,10]) linear_extrude(10) {    
            for(i=[0:90:180]) rotate(i) translate([47/2,47/2]) circle(d=12);
            }

     
            // LIMIT SW 1:
        translate([-41,0,28]) cube([10,300,12.85],center=true);        
        translate([-41,-18,28]) cylinder(d=8,h=400,center=true);
                
    }
    

}