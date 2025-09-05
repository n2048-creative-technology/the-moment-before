
//import("/home/mauricio/n2048/the-moment-before/models/bellowcaps.stl");
//import("/home/mauricio/n2048/the-moment-before/models/base.stl");
//import("/home/mauricio/n2048/the-moment-before/models/bellowjoin.stl");



import("/home/mauricio/n2048/the-moment-before/models/motormount.stl");

import("/home/mauricio/n2048/the-moment-before/models/cylinder-to-motor.stl");

//import("/home/mauricio/n2048/the-moment-before/models/guide.stl");
//import("/home/mauricio/n2048/the-moment-before/models/cap.stl");

//import("/home/mauricio/n2048/the-moment-before/models/mic-holder.stl");
//import("/home/mauricio/n2048/the-moment-before/models/support.stl");
//import("/home/mauricio/n2048/the-moment-before/models/stopper.stl");


import("/home/mauricio/n2048/the-moment-before/models/bellow-motor-mount.stl");

translate([-100,23,17]) rotate([0,90]) {
import("/home/mauricio/n2048/the-moment-before/models/plunge-bellow.stl");
}

translate([100,23,17]) rotate([0,-90]) {
import("/home/mauricio/n2048/the-moment-before/models/plunge.stl");



translate([0,0,-50]) import("/home/mauricio/n2048/the-moment-before/models/serynge-top.stl");
}


import("/home/mauricio/n2048/the-moment-before/models/stopper.stl");
