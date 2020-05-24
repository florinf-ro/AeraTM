//EnclosureTube Dimmensions
dia=150; // Interior Diameter of the enclosure-tube 
tth=1.5; // Thickness of the Tube Wall (meat)
hole=50; // Hole Diameter for the Hose
//RigidizationRing Dimmensions
rrd=dia+1; // diameter of 151 will go forcefullty into the outer tube
rrh=18.5; // height of the ring
rth=2.25; // ring thickness (meat)
rsh=65; // rigidization spline height (radius of the hole)
rrt=1.5; // rigidization spline thickness
rsq=103; // ring square hole size

module rigidizationRing(rrd,rrh,rth,rsh,rrt,rsq) {
    
    module Ring(rrd,rrh,rth,rrt) {
     difference() {
      cylinder(d=rrd,h=rrh,$fn=300);
      translate([0,0,rrt]) cylinder(d=rrd-rth,h=rrh,$fn=300);
      cube([rsq,rsq,rrh*5],center=true);
      translate([0,0,-1]) cylinder(r=rsh,h=rrh,$fn=300);
      }   
     difference() {
      translate([0,0,4]) cube([rsq+2.5,rsq+2.5,5],center=true);
      cube([rsq,rsq,15],center=true);
         translate([0,0,-1]) cylinder(r=rsh,h=rrh,$fn=300);
     }
    }

Ring(rrd,rrh,rth,rrt);

    module boltsConnectingFeature(){
     difference() {  
      union() {
         difference(){
        intersection(){
         union(){
           cylinder(d=10,h=1.49,$fn=100);
           translate([0,10,0]) cylinder(d=24.5,h=1.49,$fn=100);
          }
         translate([0,-56,0]) cylinder(d=130.4,h=50,$fn=100);
         }
         translate([-16.5,-3.4,-1]) cylinder(d=24.5,h=55,$fn=100);
         translate([16.5,-3.4,-1]) cylinder(d=24.5,h=55,$fn=100);
        }
       translate([0,0,1.49]) difference() { 
        intersection(){
         union() {
          cylinder(d=6.5,h=1.49,$fn=100);
          translate([0,14,0]) cylinder(d=30,h=1.49,$fn=100);
         }
         translate([0,-56,0]) cylinder(d=rrd-rth+0.1,h=50,$fn=100); 
        }
        translate([-30,-3.4,-1]) cylinder(d=54,h=55,$fn=100);
        translate([30,-3.4,-1]) cylinder(d=54,h=55,$fn=100);
       }
      }
     translate([0,0,-1]) cylinder(d=3,h=50,$fn=100);
     } 
    }

    bcr = 51; // pattern radius
    bcn = 4; // number of features
    bcstep = 360/bcn;
    for (i=[0:bcstep:359]) {
        angle = i;
        dx = bcr*cos(angle);
        dy = bcr*sin(angle);
        translate([dx,dy,0])
            rotate([0,0,angle])
            translate([5,0,0]) rotate([0,0,-90]) boltsConnectingFeature();
        }
        
        
    module bolts2TubeFeature(){
     difference() {
      intersection() {
       union(){
        cube([7.13,3.56,10],true);
        translate([0,3.56/2,-5]) cylinder(d=7.13,h=10,$fn=100);    
       }
       cube([7.13,10,10],true);
       }
      translate([0,3.56/2,0]) cylinder(d=3,h=50,$fn=100,center=true); 
     }
    }

     
    btr = 65; // pattern radius
    btn = 8; // number of features
    btstep = 360/btn;
    for (i=[0:btstep:359]) {
        angle = i+22.5;
        dx = btr*cos(angle);
        dy = btr*sin(angle);
        translate([dx,dy,0])
            rotate([0,0,angle])
            translate([5,0,3.56/2]) rotate([90,0,-90]) bolts2TubeFeature();
        }
 
} 
 
 color("blue") rigidizationRing(rrd,rrh,rth,rsh,rrt,rsq);
 

 
 
 
 
 
 
