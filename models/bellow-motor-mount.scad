$fn=180;


difference(){translate([-40,23,17]) rotate([0,-90]) import("/home/mauricio/n2048/the-moment-before/models/bellowcaps.stl");
    translate([0,23,17]) cube([200,20,20], center=true);
}

difference(){
    hull(){
        translate([-40,23,17]) mirror([1,0,0]) scale([.5,1]) rotate([0,-90]) import("/home/mauricio/n2048/the-moment-before/models/bellowcaps.stl");

        translate([-25,2,14]) cube([30,90,38], center=true);
    }
    translate([0,23,17]) cube([200,20,20], center=true);
        
    hull() {
        import("/home/mauricio/n2048/the-moment-before/models/motormount.stl");    import("/home/mauricio/n2048/the-moment-before/models/cylinder-to-motor.stl");
    }
}
