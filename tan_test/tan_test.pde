size(600, 600);
textSize(12);
background(235);
noFill();

// translate to Cartesian plane for entire sketch
translate(width/2, height/2);
scale(1, -1);

stroke(200);
line(-width/2, 0, width/2, 0);
line(0, -height/2, 0, height/2);

for (int x = -width/2; x < width/2; x += 10) {
  if (x % 100 == 0 && x != 0) {
    stroke(100);
    line(x, 4, x, -4);
  } else {
    stroke(155);
    line(x, 2, x, -2);
  }
}

for (int y = -height/2; y < height/2; y += 20) {
  if (y % 100 == 0 && y != 0) {
    stroke(100);
    line(-4, y, 4, y);
  } else {
    stroke(155);
    line(-2, y, 2, y);
  }
}

// float x = 180;
// strokeWeight(4);
// point(x, 0);
//
// float angle = 28;
// float angleRad = PI * angle/180;
// println("28 degrees in radians: ", angleRad);
//
// float y = tan(angleRad) * x;
// println("y: ", y);
//
// point(x, y);
// line(0, 0, x, y);
//
// float fourthQuadrantAngle = 360 - angle;
// float fourthQuadrantAngleRad = PI * fourthQuadrantAngle/180;
// println(str(fourthQuadrantAngle) + " in radians: ", fourthQuadrantAngleRad);
// println("tan(angleRad) ", tan(angleRad), "tan(fourthQuad) ", tan(fourthQuadrantAngleRad));
// float fourthQuadrantY = tan(fourthQuadrantAngleRad) * x;
// println(fourthQuadrantY);
//
// point(x, fourthQuadrantY);
// line(0, 0, x, fourthQuadrantY);

float ang45 = PI/4;
float x45 = 100;

float y45 = tan(ang45) * x45;

line(0, 0, x45, y45);

float ang225 = ang45 + PI;
float y225 = tan(ang225) * x45;

stroke(255, 0, 0);
line(0, 0, x45, y225);
