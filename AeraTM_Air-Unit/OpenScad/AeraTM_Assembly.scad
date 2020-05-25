use <150mmVentilationTubeSegmentWithHoles.scad>;
use <HepaFilter_Flat.scad>;
use <OutsideTube-HoseInsert-Cover.scad>;
use <RigidizationRing.scad>;

//M3-nut Dimmensions
nhd=3; // M3-nut hole diameter (metric)
ndc=6.1; // M3-nut corner2corner distance
nw=2.5; // M3-nut width

// HEPA Filter
lat=103; // Length of one side of the square filter
rad=3; // Corner Radius of the protective frame
dpt=30; // Depth of the HepaFilter (overall)
frame=15; // Thickness of the frame covering the faces of the HEPA filter
wall=1.5; // filter THickness of frame wall
hth=2; // HEPA flat sheet thickness (to fold)
rotate([90,0,0]) translate([-lat/2,-lat/2,-dpt-217]) sqhepafilter(lat,rad,dpt,frame,wall,hth);

// TUBE with cutout holes
dia=150; // Interior Diameter of the enclosure-tube 
tth=1.5; // Tube THickness (wall/meat)
hole=50; // Hole Diameter for the Hose
holepos=142; // Distance from one End of the Tube
lgth=270; // Length of enclosure tube

wiw=nw+2;//6.5; // Cover Wings Width
wil=ndc+2;//8; // Cover Wings Length
batd=54; // Distance between cutout circles of the battery slot
color("orange",0.95) cutoutTube(tth,dia,lgth,hole,holepos,wiw,wil,batd);

// HoseInsert-OutsideTube-Cover
coned2=70; // Diameter of the flat top of the Cover
coned1=100; // Diameter of the bottom end of the shaping cone
wih=24;  // Cover Wings Height (from flat top of the cover)
ch=5; // cover-height (above the tube)
cch=30; // cover cone height (generates the nice bevel of the cover)
angl=10; // angle of the slope for better nut retention
color("blue") translate([0,holepos,dia/2+tth+3.5]) HoseInsert_OutsideTube_Cover(dia,tth,hole,coned1,coned2,cch,ch,wiw,wil,wih,nhd,ndc,nw,angl);

// Rigidization Ring
//RigidizationRing Dimmensions
rrd=dia+1; // diameter of 151 will go forcefullty into the outer tube
rrh=18.5; // height of the ring
rth=2.25; // ring thickness (meat)
rsh=65; // rigidization spline height (radius of the hole)
rrt=1.5; // rigidization spline thickness
rsq=103; // ring square hole size


translate([0,rrh+0.5,0]) rotate([90,0,0]) color("blue") rigidizationRing(rrd,rrh,rth,rsh,rrt,rsq);
translate([0,lgth-rrh-0.5,0]) rotate([90,0,180]) color("blue") rigidizationRing(rrd,rrh,rth,rsh,rrt,rsq);
