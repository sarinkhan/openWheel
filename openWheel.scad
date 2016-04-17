

openWheelRimLipOn=1;
openWheelRimLipThickness=1;


servoWheelsTyreThickness=2;


servoWheelWidth=5+openWheelRimLipThickness*2*openWheelRimLipOn;

openWheelRimThickness=2.5;
servoWheelCentralHubRadius=20/2;
servoWheelCentralHubLip=1;
servoWheelCentralHubHoleRadius=7/2;
servoWheelRimBarsThickness=2;
servoWheelRimBarsWidth=4;

servoWheelFixHolesDistFromCenter=8.5;
servoWheelFixHolesRadius=2/2;

openWheelsArmsCount01=6;


openWheelRimBumps=1;
openWheelRimBumpsRadius=openWheelRimThickness;
openWheelRimBumpsCount=16;


openWheelRimRidges=1;
openWheelRimRidgesCount=openWheelRimBumpsCount;
openWheelRimRidgesRadius=openWheelRimThickness;

openWheelRimPerimeter=openWheelRimBumpsCount*2*openWheelRimBumpsRadius;

//servoWheelsRadius=35-servoWheelsTyreThickness;
//openWheelRimPerimeter=3.14159*servoWheelsRadius*2;
servoWheelsRadius=(openWheelRimPerimeter/3.14159)/2;

servoWheelRimBarsLength=servoWheelsRadius-servoWheelCentralHubRadius-openWheelRimThickness;

servoTyreRadius=servoWheelsRadius*97/100;


openWheelTyreInteralBumpsCount=openWheelRimBumpsCount+32;
openWheelTyreInternalPerimeter=openWheelTyreInteralBumpsCount*2*openWheelRimBumpsRadius;

//openWheelInternalTrackRadius=20;
openWheelInternalTrackRadius=(openWheelTyreInternalPerimeter/3.14159)/2;



module openWheelRimBar()
{
translate([servoWheelCentralHubRadius,-servoWheelRimBarsWidth/2,0])
cube([servoWheelRimBarsLength,servoWheelRimBarsWidth,servoWheelRimBarsThickness]);
    
translate([servoWheelCentralHubRadius-1,-1/2,0])
cube([servoWheelRimBarsLength+1,1,servoWheelWidth]);
}

module openWheelCentralHub()
{
    difference()
    {
        union()
        {
        cylinder(r=servoWheelCentralHubRadius,h=servoWheelWidth,$fn=128);
            cylinder(r=servoWheelCentralHubRadius+servoWheelCentralHubLip,h=servoWheelRimBarsThickness,$fn=128);
        }
        translate([0,0,-1])
            cylinder(r=servoWheelCentralHubHoleRadius,h=  servoWheelWidth*2,$fn=128); 
        for(i = [0 : 1 : 4])
        {
        angle01=90*i;
        rotate([0,0,angle01])
            translate([servoWheelFixHolesDistFromCenter,0,-1])
            cylinder(r=servoWheelFixHolesRadius,h=  servoWheelWidth*2,$fn=8);
        
        }
    }
        
}

module openWheel()
{
    difference()
    {
        union()
        {
            cylinder(r=servoWheelsRadius,h=servoWheelWidth,$fn=128);
        }
        
        
        translate([0,0,-1])
        cylinder(r=servoWheelsRadius-openWheelRimThickness,h=servoWheelWidth*2,$fn=128);
        if(openWheelRimRidges==1)
        {

            rotationAngle01=360/openWheelRimRidgesCount;
            for(i = [0 : 1 : openWheelRimRidgesCount])
            {
                angle01=rotationAngle01*i;
                rotate([0,0,angle01])
                    translate([servoWheelsRadius,0,-1])
                    cylinder(r=openWheelRimRidgesRadius/2,h=servoWheelWidth+2,$fn=10);
                
            }
        }
    }
    openWheelCentralHub();
    rotationAngle01=360/openWheelsArmsCount01;

    for(i = [0 : 1 : openWheelsArmsCount01])
    {
        angle01=rotationAngle01*i;
        rotate([0,0,angle01])
            openWheelRimBar();
        

    }
    
    
    
    if(openWheelRimBumps==1)
    {

    rotationAngle01=360/openWheelRimBumpsCount;
    for(i = [0 : 1 : openWheelRimBumpsCount])
    {
        angle01=rotationAngle01*i+rotationAngle01/2;
        rotate([0,0,angle01])
            translate([servoWheelsRadius,0,0])
            cylinder(r=openWheelRimBumpsRadius/2,h=servoWheelWidth,$fn=10);
        
    }
    }
    
    
    if(openWheelRimLipOn==1)
    {
        difference()
        {
            union()
            {
                translate([0,0,0])
                    cylinder(r=servoWheelsRadius+openWheelRimRidgesRadius/2,h=openWheelRimLipThickness,$fn=128);
                translate([0,0,servoWheelWidth-openWheelRimLipThickness])
                    cylinder(r=servoWheelsRadius+openWheelRimRidgesRadius/2,h=openWheelRimLipThickness,$fn=128);
            }
            translate([0,0,-openWheelRimLipThickness-1])              
                cylinder(r=servoWheelsRadius-openWheelRimThickness,h=servoWheelWidth*2+openWheelRimLipThickness*2,$fn=128);
         }
    }
}





module openWheelTyre()
{
difference()
{
    cylinder(r=servoTyreRadius,h=servoWheelWidth,$fn=128);
    
    translate([0,0,-1])
    cylinder(r=servoTyreRadius-servoWheelsTyreThickness,h=servoWheelWidth*2,$fn=128);
}

difference()
{
    translate([0,0,-1])
    cylinder(r=servoTyreRadius,h=1,$fn=128);
    translate([0,0,-2])
    cylinder(r=servoTyreRadius-servoWheelsTyreThickness-2,h=servoWheelWidth*2,$fn=128);
}

difference()
{
    translate([0,0,servoWheelWidth])
    cylinder(r=servoTyreRadius,h=1,$fn=128);
    translate([0,0,-1])
    cylinder(r=servoTyreRadius-servoWheelsTyreThickness-2,h=servoWheelWidth*2,$fn=128);
}

gripBars=81;
rotationAngle01=360/gripBars;
for(i = [0 : 1 : gripBars])
{
    angle01=rotationAngle01*i;
    rotate([0,0,angle01])
        translate([servoTyreRadius-0.5,0,-1])
        cube([1.5,1,servoWheelWidth+2]);
    
}
}


module openWheelTrack()
{
difference()
{
    cylinder(r=openWheelInternalTrackRadius+servoWheelsTyreThickness,h=servoWheelWidth,$fn=128);
    
    translate([0,0,-1])
    cylinder(r=openWheelInternalTrackRadius,h=servoWheelWidth*2,$fn=128);
    
    rotationAngle01=360/openWheelTyreInteralBumpsCount;
            for(i = [0 : 1 : openWheelTyreInteralBumpsCount])
            {
                angle01=rotationAngle01*i+rotationAngle01/2;
                rotate([0,0,angle01])
                    translate([openWheelInternalTrackRadius,0,-1])
                    cylinder(r=openWheelRimRidgesRadius/2,h=servoWheelWidth+2,$fn=10);
                
            }
}

    rotationAngle01=360/openWheelTyreInteralBumpsCount;
            for(i = [0 : 1 : openWheelTyreInteralBumpsCount])
            {
                angle01=rotationAngle01*i;
                rotate([0,0,angle01])
                    translate([openWheelInternalTrackRadius,0,0])
                    cylinder(r=openWheelRimRidgesRadius/2,h=servoWheelWidth,$fn=10);
                
            }
/*
difference()
{
    translate([0,0,-1])
    cylinder(r=servoTyreRadius,h=1,$fn=128);
    translate([0,0,-2])
    cylinder(r=servoTyreRadius-servoWheelsTyreThickness-2,h=servoWheelWidth*2,$fn=128);
}

difference()
{
    translate([0,0,servoWheelWidth])
    cylinder(r=servoTyreRadius,h=1,$fn=128);
    translate([0,0,-1])
    cylinder(r=servoTyreRadius-servoWheelsTyreThickness-2,h=servoWheelWidth*2,$fn=128);
}
*/
/*
gripBars=81;
rotationAngle01=360/gripBars;
for(i = [0 : 1 : gripBars])
{
    angle01=rotationAngle01*i;
    rotate([0,0,angle01])
        translate([servoTyreRadius-0.5,0,-1])
        cube([1.5,1,servoWheelWidth+2]);
    
}*/
}



//openWheelTrack();

openWheel();
//servoWheelTyre();





