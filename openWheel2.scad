

openWheelRimLipOn=1;
openWheelRimLipThickness=1;
openWheelRimLipLengthAdjustment=1;


servoWheelsTyreThickness=2;

trackSprocketWidthAdjustment=1;

servoWheelWidth=5+openWheelRimLipThickness*2*openWheelRimLipOn+trackSprocketWidthAdjustment*openWheelRimLipOn;

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
openWheelRimBumpsCount=27;


openWheelRimRidges=1;
openWheelRimRidgesCount=openWheelRimBumpsCount;
openWheelRimRidgesRadius=openWheelRimThickness;


openWheelRimBumpsCount=27;
openWheelRimPerimeter=openWheelRimBumpsCount*2*openWheelRimBumpsRadius;

/*servoWheelsRadius=35-servoWheelsTyreThickness;
//openWheelRimPerimeter=3.14159*servoWheelsRadius*2;
wheelRadius1=(openWheelRimPerimeter/3.14159)/2;
echo (wheelRadius1);

servoWheelRimBarsLength=servoWheelsRadius-servoWheelCentralHubRadius-openWheelRimThickness;*/
/*

servoTyreRadius=servoWheelsRadius*97/100;


openWheelTyreInteralBumpsCount=openWheelRimBumpsCount+32;
openWheelTyreInternalPerimeter=openWheelTyreInteralBumpsCount*2*openWheelRimBumpsRadius;

//openWheelInternalTrackRadius=20;
openWheelInternalTrackRadius=(openWheelTyreInternalPerimeter/3.14159)/2;


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
}
*/


//openWheelTrack();

//openWheel();
//servoWheelTyre();





/**
 * This module describes the central hub of a wheel.
 * It is a cylinder whith a set radius and thickness,
 * and a hole in the middle. The level of curve can
 * be set with the parameter curveLevel : the higher
 * it is, the more segments it will have, and thus
 * the smoother, but the longer to compile.
 * @param hubRadius the radius of the cylinder
 * @param hubThickness the thickness of the cylinder
 * @param hubCentralHoleRadius : the radius of the central hole
 * @param curveLevel is the amount of segments used for the cylinder ($fn parameter)
 */
module wheelCentralHubNoHoles(hubRadius,hubThickness,hubCentralHoleRadius=5.6/2,curveLevel=64,axleHeadRadius=9/2,axleHeadHeight=4)
{
    difference()
    {
    cylinder(r=hubRadius,h=hubThickness,$fn=curveLevel);
        translate([0,0,-hubThickness])
          cylinder(r=hubCentralHoleRadius,h=hubThickness*3,$fn=64);

        translate([0,0,hubThickness-axleHeadHeight])
          cylinder(r=axleHeadRadius,h=hubThickness*3,$fn=64);
    }
}


/**
 * This modules creates cylinders used for fixation holes in the hub.
 * the holes radius can be defined, as well as the cut depth.
 * If cutDepthThickness is set to 0, trough holes will be created.
 * Otherwise, holes of the corresponding depth will be created.
 * NOTE : you can set a negative value for cutDepthThickness to create
 * the non traversing holes on the other side of the hub.
 * @param holesCount the number of cylinders (used for holes) to create
 * @param holesRadius the radius of the holes to create
 * @param holesDist the distance of the center of the holes from the center of the hub
 * @param hubThickness the thickness of the hub
 * @param angleShift if set to non zero, it will shift the rotation of the holes of this value;
 * i.e. if set to 30, holes will start after a 30° rotation.
 * cutDepthThickness : how deep the holes must be cut. if set to 0, it will be trhough holes.
 * positive values cut the specified depth from the top, negative from the bottom
 * @param screwsCurveLevel is the amount of segments used for the cylinders ($fn parameter)
 */
module wheelCentralHubFixationHoles(holesCount=4,holesRadius=defaultScrewRadius,
  holesDist,hubThickness,angleShift=0,cutDepthThickness=0,screwsCurveLevel=16,axleHeadRadius=9/2,axleHeadHeight=4)
{
    rotAngle=360/(holesCount);
    for(i = [0 : 1 : holesCount-1])
    {

      //echo (rotAngle*i+angleShift);
        rotate([0,0,rotAngle*i+angleShift-90])
            if(cutDepthThickness==0)
            {
                translate([0,holesDist,-hubThickness])
                    cylinder(r=holesRadius,h=hubThickness*3,$fn=16);
            }
            else if(cutDepthThickness>0)
            {
                cutDecal=hubThickness-cutDepthThickness;
                translate([0,holesDist,cutDecal])
                cylinder(r=holesRadius,h=cutDepthThickness*2,$fn=16);
            }
            else
            {
                cutDecal=-cutDepthThickness;
                translate([0,holesDist,-cutDecal])
                cylinder(r=holesRadius,h=-cutDepthThickness*2,$fn=16);
            }
    }
}

/**
 * This modules create a wheel central hub, as a cylinder with a central hole and multiple surrouding holes.
 * the central hole is to be used for a central axle, but can be set to 0 if not necessary.
 * the surrounding holes are used for fixation screws, and can also be set to 0 if needed.
 * @param hubRadius the radius of the hub
 * @param hubThickness the thickness of the hub
 * @param hubCentralHoleRadius : the radius of the central hole
 * @param curveLevel is the amount of segments used for the hub ($fn parameter)
 * @param holesCount the number of peripheral holes to create
 * @param holesRadius the radius of the peripheral holes to create
 * @param holesDist the distance of the center of the holes from the center of the hub
 * @param angleShift if set to non zero, it will shift the rotation of the holes of this value;
 * i.e. if set to 30, holes will start after a 30° rotation.
 * cutDepthThickness : how deep the holes must be cut. if set to 0, it will be trhough holes.
 * positive values cut the specified depth from the top, negative from the bottom
 * @param screwsCurveLevel is the amount of segments used for the cylinders ($fn parameter)
 * @param screwsHeadRadius the radius of the screws heads
 * @param screwsHeadDepth how deep we cut to countersunk the screws heads
 */
module wheelCentralHubWithFixations(hubRadius, hubThickness, hubCentralHoleRadius=4/2,
  curveLevel=64, holesCount=4, holesRadius=defaultScrewRadius, holesDist, angleShift=0,
  cutDepthThickness=0, screwsHeadRadius=defaultScrewRadius*2, screwsHeadDepth=3, screwsCurveLevel=16,axleHeadRadius=9/2,axleHeadHeight=4)
{
    difference()
    {
        wheelCentralHubNoHoles(hubRadius,hubThickness,hubCentralHoleRadius,curveLevel,axleHeadRadius,axleHeadHeight);

        wheelCentralHubFixationHoles(holesCount,holesRadius,holesDist,
          hubThickness,angleShift,cutDepthThickness,screwsCurveLevel);
        wheelCentralHubFixationHoles(holesCount,screwsHeadRadius,holesDist,
          hubThickness,angleShift,screwsHeadDepth,screwsCurveLevel);
    }
}

/**
 * Creates a simple ring, with a defined thickness, height, and radius.
 * @param ringInnerRadius the internal radius of the ring
 * @param ringThickness the thickness of the ring -> external radius =ringThickness+ringInnerRadius
 * @param ringHeight the height of the ring
 * @param ringcurve the facets count for the ring. More = smoother but more rendering time
 */
module ring(ringInnerRadius,ringThickness,ringHeight,ringcurve=128)
{
  difference()
  {
    cylinder(r=ringInnerRadius+ringThickness,h=ringHeight,$fn=ringcurve);
    translate([0,0,-1])
      cylinder(r=ringInnerRadius,h=ringHeight+2,$fn=ringcurve);
  }
}

module openWheelBasicRimBar(hubRadius,hubThickness,rimBarWidth=4,rimBarLength)
{
  rimBarsPadding=2;
  basicRimBarThickness=2;
  translate([hubRadius-rimBarsPadding/2,-rimBarWidth/2,0])
  cube([rimBarLength+rimBarsPadding,rimBarWidth,basicRimBarThickness]);

  translate([hubRadius-rimBarsPadding/2,-1/2,0])
  cube([rimBarLength+rimBarsPadding,1,hubThickness]);
}


module basicWheel(hubRadius, hubThickness, hubCentralHoleRadius=4/2,
  curveLevel=64, holesCount=4, holesRadius=defaultScrewRadius, holesDist, angleShift=0,
  cutDepthThickness=0, screwsHeadRadius=defaultScrewRadius*2, screwsHeadDepth=3,
   screwsCurveLevel=16,rimBarsCount=5,rimbarsAngleShift=0,rimbarsWidth=4,wheelExternalRadius,
   wheelRimThickness=2,lipsThickness=1,lipsOverHang=1,cogsCount=openWheelRimBumpsCount,axleHeadRadius=9/2,axleHeadHeight=4)
{
  rimBarsLength=wheelExternalRadius-wheelRimThickness-hubRadius;

  wheelCentralHubWithFixations(hubRadius,hubThickness,hubCentralHoleRadius,
  curveLevel,holesCount,holesRadius,holesDist,angleShift,cutDepthThickness,
  screwsHeadRadius,screwsHeadDepth,screwsCurveLevel,axleHeadRadius,axleHeadHeight);

  rotAngle=360/(rimBarsCount);
  for(i = [0 : 1 : rimBarsCount-1])
  {
    rotate([0,0,rotAngle*i+rimbarsAngleShift])
      openWheelBasicRimBar(hubRadius,hubThickness,rimbarsWidth,rimBarLength=rimBarsLength);
  }

    bumpsCurveLevel=rimbumpsCurveLevel;

    //rim
    difference()
    {
      ring(ringInnerRadius=wheelExternalRadius-wheelRimThickness,ringThickness=wheelRimThickness,
      ringHeight=hubThickness,ringcurve=128);

      rotationAngle01=360/cogsCount;
              for(i = [0 : 1 : cogsCount])
              {
                  angle01=rotationAngle01*i;
                  rotate([0,0,angle01])
                      translate([wheelExternalRadius,0,-1])
                        cylinder(r=openWheelRimRidgesRadius/2,h=hubThickness*2,$fn=bumpsCurveLevel);

              }
    }
    ring(ringInnerRadius=wheelExternalRadius-wheelRimThickness,ringThickness=2+lipsOverHang,
        ringHeight=lipsThickness,ringcurve=128);

    translate([0,0,hubThickness-lipsThickness])
      ring(ringInnerRadius=wheelExternalRadius-wheelRimThickness,ringThickness=2+lipsOverHang,ringHeight=lipsThickness,ringcurve=128);

    if(openWheelRimBumps==1)
    {
      rotationAngle01=360/cogsCount;
      for(i = [0 : 1 : cogsCount])
      {
          angle01=rotationAngle01*i+rotationAngle01/2;
          rotate([0,0,angle01])
            translate([wheelExternalRadius,0,0])
              cylinder(r=openWheelRimBumpsRadius/2,h=hubThickness,$fn=bumpsCurveLevel);
      }
    }

}



/*
wheelHubWithBars(hubRadius=wheel1HubRadius,hubThickness=wheel1HubThickness,hubCentralHoleRadius=4/2,
curveLevel=64,holesCount=5,holesRadius=defaultScrewRadius,holesDist=8,
angleShift=0,cutDepthThickness=0,screwsHeadRadius=defaultScrewRadius*2,
screwsHeadDepth=3,screwsCurveLevel=16,rimBarsCount=5,rimbarsAngleShift=0,
rimBarsLength=20);

ring(ringInnerRadius=wheel1HubRadius+wheel1RimBarsLength,ringThickness=2,
  ringHeight=wheel1HubThickness,ringcurve=128);
*/

/*module basicWheel(hubRadius=wheel1HubRadius,hubThickness=wheel1HubThickness,hubCentralHoleRadius=4/2,
  curveLevel=64,holesCount=5,holesRadius=defaultScrewRadius,holesDist=8,
  angleShift=0,cutDepthThickness=0,screwsHeadRadius=defaultScrewRadius*2,
  screwsHeadDepth=3,screwsCurveLevel=16,rimBarsCount=5,rimbarsAngleShift=0,
  rimBarsLength=20)
  {
    wheelHubWithBars(hubRadius,hubThickness,hubCentralHoleRadius,
    curveLevel,holesCount,holesRadius=defaultScrewRadius,holesDist=8,
    angleShift=0,cutDepthThickness=0,screwsHeadRadius=defaultScrewRadius*2,
    screwsHeadDepth=3,screwsCurveLevel=16,rimBarsCount=5,rimbarsAngleShift=0,
    rimBarsLength=20);

    ring(ringInnerRadius=wheel1HubRadius+wheel1RimBarsLength,ringThickness=2,
      ringHeight=wheel1HubThickness,ringcurve=128);


  }*/

  //the main propulsion wheel that will move the track (or tyres)
  rIanWheelRimBumpsCount=27;
  rIanWheelRimPerimeter=rIanWheelRimBumpsCount*2*openWheelRimBumpsRadius;

  //servoWheelsRadius=35-servoWheelsTyreThickness;
  //openWheelRimPerimeter=3.14159*servoWheelsRadius*2;
  rIanWheelRadius1=(rIanWheelRimPerimeter/3.14159)/2;
  echo (rIanWheelRadius1);
  rIanWheelTotalRadius=rIanWheelRadius1+openWheelRimBumpsRadius;


  rIanWrIanWheel1CentralHoleAxleHeadRadius=9.7/2; //8.5/2 in reality
  rIanWheel1CentralHoleAxleHeadThickness=4; //3.5 in reality
  defaultScrewRadius=3.1/2;
  rIanWheel1HubRadius=12;
  rIanWheel1HubThickness=14+rIanWheel1CentralHoleAxleHeadThickness;
  rIanWheelLipsThickness=1;
  rIanWheel1InternalPathWidth=rIanWheel1HubThickness-rIanWheelLipsThickness*2-1;

  //wheel1RimBarsLength=20;
  centralHole1Radius=5.7/2;

  //the radius of the screw part of the wheels axles
  centralAxleScrewRadius=3.95/2;
  //this is the gearing that will move the wheel
  gearing1CogsCount=20;
  gearing1Perimeter=gearing1CogsCount*2*openWheelRimBumpsRadius;
  gearing1Thickness=9.5;
  gearing1Radius=(gearing1Perimeter/3.14159)/2;
  rIanGearing1Radius=gearing1Radius+openWheelRimBumpsRadius;

  rimbumpsCurveLevel=16;






module r_ian_wheel1()
{
  basicWheel(hubRadius=rIanWheel1HubRadius,hubThickness=rIanWheel1HubThickness,hubCentralHoleRadius=centralHole1Radius,
  curveLevel=64,holesCount=4,holesRadius=defaultScrewRadius,holesDist=8,
  angleShift=180,cutDepthThickness=0,screwsHeadRadius=defaultScrewRadius*2,
  screwsHeadDepth=3,screwsCurveLevel=16,rimBarsCount=8,rimbarsAngleShift=360/16,rimbarsWidth=4,
  wheelExternalRadius=rIanWheelRadius1,wheelRimThickness=2.5,lipsThickness=rIanWheelLipsThickness,
  lipsOverHang=openWheelRimBumpsRadius/2,axleHeadRadius=rIanWrIanWheel1CentralHoleAxleHeadRadius,
  axleHeadHeight=rIanWheel1CentralHoleAxleHeadThickness);

}

module r_ian_gearing1()
  {
  difference()
  {
  basicWheel(hubRadius=rIanWheel1HubRadius,hubThickness=gearing1Thickness,hubCentralHoleRadius=centralHole1Radius,
  curveLevel=64,holesCount=4,holesRadius=2/2,holesDist=8.5,
  angleShift=180,cutDepthThickness=0,screwsHeadRadius=defaultScrewRadius*2,
  screwsHeadDepth=3,screwsCurveLevel=16,rimBarsCount=8,rimbarsAngleShift=360/16,rimbarsWidth=4,
  wheelExternalRadius=gearing1Radius,wheelRimThickness=2.5,lipsThickness=0,
  lipsOverHang=openWheelRimBumpsRadius/2,cogsCount=gearing1CogsCount,axleHeadRadius=0,axleHeadHeight=0);

  wheelCentralHubFixationHoles(holesCount=4,holesRadius=defaultScrewRadius,
    holesDist=8,hubThickness=gearing1Thickness,angleShift=45,cutDepthThickness=0,screwsCurveLevel=16);
  }
}
gearingPadding=0.2;


gearingRotationAngle=30;


  gearing1ToWheel1AxleDist=(gearing1Radius*2+gearingPadding);//direct, straight line distance between both axles centers
  gearing1ToWheel1AxleDistY=cos(gearingRotationAngle)*gearing1ToWheel1AxleDist; //distance on Y axis (projection)
  gearing1ToWheel1AxleDistZ=sin(gearingRotationAngle)*gearing1ToWheel1AxleDist; //distance on Z axis (projection)


//max value for printing on printrbot simple = 29
frontBackAxleDistanceInCogs=16;
frontBackAxleStretchingDistance=5;
distanceFrontBackWheelsAxles=frontBackAxleDistanceInCogs*openWheelRimBumpsRadius*2+frontBackAxleStretchingDistance;

trackLength=frontBackAxleDistanceInCogs*2+rIanWheelRimBumpsCount;


fitechFS90RServoFix1DistFromAxle=9;
fitechFS90RServoFix2DistFromAxle=19.5;
fitechFS90RServoHeight=12.2;

fixationBlockX=10;
fixationBlockY=distanceFrontBackWheelsAxles+10*2;
fixationBlockZ=10;

fixationSupportWheelSPacingDiscRadius=5;
fixationSupportWheelSPacingDiscThickness=2;


  motor1FixScrew1DistFromWheelAxle=8;
  motor1FixScrewsDist=10;
  motor1FixScrewsCount=5;

  fixationBlockEndScrewsXEdgeDistance=4;
  fixationBlockEdgeDecal=10;


//rotate([0,-90,0])
difference()
{
  union()
  {
    translate([-fixationBlockX-fixationSupportWheelSPacingDiscThickness,-fixationBlockEdgeDecal,-fixationBlockZ/2])
      cube([fixationBlockX,fixationBlockY,fixationBlockZ]);

    translate([-fixationSupportWheelSPacingDiscThickness,0,0])
      rotate([0,90,0])
        cylinder(r=fixationSupportWheelSPacingDiscRadius,h=fixationSupportWheelSPacingDiscThickness);

    translate([-fixationSupportWheelSPacingDiscThickness,distanceFrontBackWheelsAxles,0])
      rotate([0,90,0])
        cylinder(r=fixationSupportWheelSPacingDiscRadius,h=fixationSupportWheelSPacingDiscThickness);

  }

  translate([-fixationBlockX*2,0,0])
    rotate([0,90,0])
      cylinder(r=centralAxleScrewRadius,h=fixationBlockX*5);

translate([-fixationBlockX*2,0,0])
  rotate([0,90,0])
    cylinder(r=centralAxleScrewRadius,h=fixationBlockX*5);


    translate([-fixationSupportWheelSPacingDiscThickness-fixationBlockX/2,motor1FixScrew1DistFromWheelAxle,-fixationBlockZ])
        cylinder(r=centralAxleScrewRadius,h=fixationBlockX*5);

    translate([-fixationSupportWheelSPacingDiscThickness-fixationBlockX/2,-fixationBlockEdgeDecal+fixationBlockEndScrewsXEdgeDistance,-fixationBlockZ])
        cylinder(r=centralAxleScrewRadius,h=fixationBlockX*5);

    translate([-fixationSupportWheelSPacingDiscThickness-fixationBlockX/2,fixationBlockY-fixationBlockEdgeDecal-fixationBlockEndScrewsXEdgeDistance,-fixationBlockZ])
        cylinder(r=centralAxleScrewRadius,h=fixationBlockX*5);

        for(i = [0 : 1 : motor1FixScrewsCount])
        {
          translate([-fixationSupportWheelSPacingDiscThickness-fixationBlockX/2,motor1FixScrew1DistFromWheelAxle+motor1FixScrewsDist*i,-fixationBlockZ])
              cylinder(r=centralAxleScrewRadius,h=fixationBlockX*5);
        }


translate([-fixationBlockX*2,distanceFrontBackWheelsAxles,0])
  rotate([0,90,0])
    cylinder(r=centralAxleScrewRadius,h=fixationBlockX*5);




}

  translate([gearing1Thickness,0,0])
  rotate([0,90,0])
    r_ian_wheel1();


    translate([gearing1Thickness,distanceFrontBackWheelsAxles,0])
    rotate([0,90,0])
      r_ian_wheel1();
    translate([0,distanceFrontBackWheelsAxles,0])
    rotate([0,90,0])
        r_ian_gearing1();

        rotate(gearingRotationAngle,v=[1,0,0])
        translate([0,gearing1Radius*2+gearingPadding,0])
        rotate([360/(gearing1CogsCount*2)+gearingRotationAngle,0,0])
        rotate([0,90,0])
          r_ian_gearing1();
  rotate([0,90,0])
    r_ian_gearing1();

module openWheelTrack(trackWidth,trackCogsCount,trackThickness,externalBumpsCount=0,externalBumpsThickness=1)
{

  trackIntPerimeter=trackCogsCount*2*openWheelRimBumpsRadius;
  trackIntRadius1=(trackIntPerimeter/3.14159)/2;
  //echo (trackIntRadius1);
  difference()
  {
    cylinder(r=trackIntRadius1+trackThickness,h=trackWidth,$fn=128);

    translate([0,0,-1])
    cylinder(r=trackIntRadius1,h=trackWidth*2,$fn=128);

    rotationAngle01=360/trackCogsCount;
    for(i = [0 : 1 : trackCogsCount])
    {
        angle01=rotationAngle01*i+rotationAngle01/2;
        rotate([0,0,angle01])
          translate([trackIntRadius1,0,-1])
            cylinder(r=openWheelRimRidgesRadius/2+0.25,h=trackWidth+2,$fn=10);

    }
  }


    rotationAngle01=360/trackCogsCount;
    for(i = [0 : 1 : trackCogsCount])
    {
        angle01=rotationAngle01*i;
        rotate([0,0,angle01])
          translate([trackIntRadius1,0,0])
            cylinder(r=openWheelRimRidgesRadius/2-0.25,h=trackWidth,$fn=10);

    }


  if(externalBumpsCount>0)
  {
    rotationAngle01=360/externalBumpsCount;
    for(i = [0 : 1 : externalBumpsCount])
    {
        angle01=rotationAngle01*i;
        rotate([0,0,angle01])
          translate([trackIntRadius1+trackThickness,0,0])
            cylinder(r=externalBumpsThickness/2,h=trackWidth,$fn=6);

    }
  }

}


module openWheelTyre(tyreWidth,wheelCogsCount,tyreThickness,externalBumpsCount=0,externalBumpsThickness=1)
{

  tyreIntPerimeter=wheelCogsCount*2*openWheelRimBumpsRadius;
  tyreIntRadius1=(tyreIntPerimeter/3.14159)/2;
  //echo (trackIntRadius1);
  difference()
  {
    cylinder(r=tyreIntRadius1+tyreThickness,h=tyreWidth,$fn=128);

    translate([0,0,-1])
    cylinder(r=tyreIntRadius1,h=tyreWidth*2,$fn=128);

    rotationAngle01=360/wheelCogsCount;
    for(i = [0 : 1 : wheelCogsCount])
    {
        angle01=rotationAngle01*i+rotationAngle01/2;
        rotate([0,0,angle01])
          translate([tyreIntRadius1,0,-1])
            cylinder(r=openWheelRimRidgesRadius/2+0.25,h=tyreWidth+2,$fn=10);

    }
  }


    rotationAngle01=360/wheelCogsCount;
    for(i = [0 : 1 : wheelCogsCount])
    {
        angle01=rotationAngle01*i;
        rotate([0,0,angle01])
          translate([tyreIntRadius1,0,0])
            cylinder(r=openWheelRimRidgesRadius/2-0.25,h=tyreWidth,$fn=10);

    }


  if(externalBumpsCount>0)
  {
    rotationAngle01=360/externalBumpsCount;
    for(i = [0 : 1 : externalBumpsCount])
    {
        angle01=rotationAngle01*i;
        rotate([0,0,angle01])
          translate([tyreIntRadius1+tyreThickness,0,0])
            cylinder(r=externalBumpsThickness/2,h=tyreWidth,$fn=6);

    }
  }

}

//openWheelTyre(rIanWheel1InternalPathWidth,rIanWheelRimBumpsCount,2.5,externalBumpsCount=90,externalBumpsThickness=1);


  //openWheelTrack(rIanWheel1InternalPathWidth,trackLength,2.25,externalBumpsCount=150);


/*
translate([-fixationBlockX,gearing1ToWheel1AxleDistY,0])
  cube([fixationBlockX,fixationBlockY,gearing1ToWheel1AxleDistZ]);
*/
