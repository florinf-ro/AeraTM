module cutoutTube(th,di,he,hole,holepos,wiw,wil,dis) {
// th = thickness of the used tube
// di = diameter of the tube
// he = height of the tube (length)
// hole = hose insert hole diameter
// wiw = hose insert cover wing-cut width 
// wiw = hose insert cover wing-cut length
// dis = distance between batteries-hole circular cutouts (between centers)

$fn=100;

 module tube(th,di,he){
  rotate([-90,0,0]) 
   difference(){
    cylinder(d=di+th,h=he);
    translate([0,0,-1])
     cylinder(d=di,h=he+5);
   }
 }
 
 module HoseCutout(th,rad,hole,wiw,wil) {
cylinder(d=hole,h=rad/2);
translate([-(hole+2*wil)/2,-wiw/2,0]) cube([hole+2*wil,wiw,rad/2]);
}

module BatteriesCutout(hole,dis) {
hull() {
    cylinder(d=hole,h=di/2);
    translate([dis,0,0]) cylinder(d=hole,h=di/2);
    }
}

difference() {
tube(th,di,he);
group() {
translate([0,holepos,di/3])
 HoseCutout(th,di/2,hole,wiw,wil);
translate([-dis/2,hole/2+22,di/4])
 BatteriesCutout(hole,dis);
}
}
}

cutoutTube(1.5,150,270,50,142,5,8,50);