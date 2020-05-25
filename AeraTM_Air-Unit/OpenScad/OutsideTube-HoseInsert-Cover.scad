//EnclosureTube Dimmensions
dia=150; // Interior Diameter of the enclosure-tube 
tth=1.5; // Thickness of the Tube Wall (meat)
hole=50; // Hole Diameter for the Hose
//M3-nut Dimmensions
nhd=3; // M3-nut hole diameter (metric)
ndc=6.1; // M3-nut corner2corner distance
nw=2.5; // M3-nut width
//OutsideTube HoseInsert-Cover Dimmensions
coned1=100; // Diameter of the bottom end of the shaping cone
coned2=70; // Diameter of the flat top of the Cover
wiw=nw+2;//6.5; // Cover Wings Width
wil=ndc+2;//8; // Cover Wings Length
wih=24;  // Cover Wings Height (from flat top of the cover)
ch=5; // cover-height (above the tube)
cch=30; // cover cone height
//slopedEntranceNutHole slope/angle
angl=10; // angle of the slope for better nut retention

module HoseInsert_OutsideTube_Cover(dia,tth,hole,coned1,coned2,cch,ch,wiw,wil,wih,nhd,ndc,nw,angl) {

module cover(dia,tth,hole,coned1,coned2,cch,ch,wiw,wil,wih){
 module above_tube(){
    difference(){
    // cone to be formed into cover
     translate([0,0,-cch]) cylinder(d1=coned1,d2=coned2,h=cch,$fn=100);
    // tube-size cylinder cutter
     translate([0,-2*hole,-dia/2-ch]) rotate([-90,0,0]) cylinder(d=dia+tth,h=4*hole,$fn=100);
    }    
 }    
 module below_tube(){
  // cut the wings at the interior surface of the cover, so that low cone upper diameter don't break the design
  intersection(){ 
  translate([0,0,-wih/2]) cube([hole+2*wil,wiw,wih], center=true);
  translate([0,-2*hole,-dia/2-ch]) rotate([-90,0,0]) cylinder(d=dia+tth+0.02,h=4*hole,$fn=200);
  }
 }    
 difference(){
   union(){ 
    above_tube();
    below_tube();
   }
    //hose-size cylinder cutter
    translate([0,0,-(ch+wih)+1]) cylinder(d=hole, h=ch+wih+100, $fn=100);
 }    
}

module slopedEntranceNutHole(nhd,ndc,nw,angl,wiw) {
 // hexagon
 rotate([-90,0,0]) cylinder(d=ndc,h=nw,$fn=6, center=true);
 //sloped nut entrance
 hull() {
 //Note: slope cutting volume si made of a hull between two shapes/0.1mm-thick-cubes (basically rectangles that are one nut wide and the height is the distance between two flat sides. Knowing the ndc (nut distance between corners), this distance is ndc*sqr(3)/2 = ndc*0.866 
 translate([ndc/4,0,0]) cube([0.1,nw,ndc*0.866],true);
 trx=wil/2;
 trz=trx*tan(angl);   
 translate([trx,0,trz]) cube([0.1,nw,ndc*0.866],true);  
 }//hole cylinder
 rotate([-90,0,0]) cylinder(d=3,h=wiw+2,$fn=50, center=true);
 }
 
 difference() {
  color("blue") cover(dia,tth,hole,coned1,coned2,cch,ch,wiw,wil,wih);
  //Note: 1.8mm wall thickness under nut
  translate([-(hole/2+wil/2),0,-wih+ndc*0.866/2+1.8]) slopedEntranceNutHole(nhd,ndc,nw,10,wiw);
  mirror([1,0,0]) translate([-(hole/2+wil/2),0,-wih+ndc*0.866/2+1.8]) slopedEntranceNutHole(nhd,ndc,nw,10,wiw);
 }
}

HoseInsert_OutsideTube_Cover(dia,tth,hole,coned1,coned2,cch,ch,wiw,wil,wih,nhd,ndc,nw,angl);



























