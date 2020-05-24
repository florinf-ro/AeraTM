module sqhepafilter(lat,rad,dpt,frame,wall,th) {


module roundedcornerscube(lat,rad,dpt) {
    translate([rad,rad,0]) hull() {
        cylinder(r=rad,h=dpt, $fn=50);
        translate([lat-2*rad,0,0]) cylinder(r=rad,h=dpt, $fn=50);
    translate([0,lat-2*rad,0]) {
        cylinder(r=rad,h=dpt, $fn=50);
        translate([lat-2*rad,0,0]) cylinder(r=rad,h=dpt, $fn=50);
    }
    }
}

module filterframe(lat,rad,dpt,frame,wall) {
difference() {
    difference() {
        roundedcornerscube(lat,rad,dpt);
        translate([frame/2,frame/2,-wall])      roundedcornerscube(lat-frame,rad,dpt+2*wall);
    }
    translate([wall/2,wall/2,wall/2])  roundedcornerscube(lat-wall,rad,dpt-wall);

}
}

module hepafold(th,lex,ley,he,flds) {
 stp=lex/flds;
 bdia=th*3;
 module singlefold(th,lex,ley,he,bdia) {
    nrbe=ley/20; 
    hull() {
     rotate([-90,0,0]) cylinder(d=th,h=ley,$fn=100);
     translate([stp,0,he]) rotate([-90,0,0]) cylinder(d=th,h=ley,$fn=100);
    }
     for ( i = [0:nrbe ] ) {
        translate([0,i*20,0]) {
         hull() {rotate([-90,0,0]) cylinder(d=bdia,h=bdia/2,$fn=100);
         translate([stp,0,he]) rotate([-90,0,0]) cylinder(d=bdia,h=bdia/2,$fn=100);
         }    
        }
     }
 }
 for ( i = [0 : (lex/(2*stp))-1] ){
    translate([i*2*stp+bdia/2,0,bdia/2]) {
    singlefold(th,lex,ley,he,th*3);
    translate([2*stp,0,0]) mirror([1,0,0]) singlefold(th,lex,ley,he,th*3);
    }
 }
}


color("silver") filterframe(lat,rad,dpt,frame,wall);
translate([wall,wall,wall]) color("White") hepafold(th,lat-2*wall-th*3,lat-2*wall-th,dpt-2*wall-th*3,30);
}

