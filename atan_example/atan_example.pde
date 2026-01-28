// draw a square that's centered on a line defined by two random points
float x1, y1, x2, y2;
float sqX1, sqY1, sqX2, sqY2, sqX3, sqY3, sqX4, sqY4;
float slope;
float angle;

void setup() {
  size(400, 400);
  background(185);

  x1 = random(-width/2 + 10, width/2 - 10);
  y1 = height/2 - 10;
  x2 = random(-width/2, width/2);
  y2 = -height/2 + 10;

  float opposite = x2 - x1;
  float adjacent = y2 - y1;
  float hypotenuse = sqrt(opposite*opposite + adjacent*adjacent);
  float dx = x2 - x1;
  float dy = y2 - y1;
  angle = atan2(dy, dx);

  sqX1 = x1 + (hypotenuse/2 - 40) * cos(angle);
  sqY1 = y1 + (hypotenuse/2 - 40) * sin(angle);
  sqX2 = sqX1 + 80 * cos(angle + PI/2);
  sqY2 = sqY1 + 80 * sin(angle + PI/2);
  sqX3 = sqX2 - 80 * cos(angle + PI);
  sqY3 = sqY2 - 80 * sin(angle + PI);
  sqX4 = sqX3 + 80 * cos(angle + 3*PI/2);
  sqY4 = sqY3 + 80 * sin(angle + 3*PI/2);
  println("angle", angle);
}

void draw() {
  // begin setting Cartesian plane
  translate(width/2, height/2);
  scale(1, -1);
  // end setting Cartesian plane

  stroke(100);
  line(-width/2 + 10, 0, width/2 - 10, 0);
  line(0, height/2 - 10, 0, -height/2 + 10);

  stroke(155);
  line(x1, y1, x2, y2);

  stroke(23);
  strokeWeight(8);
  point(x1, y1);
  point(x2, y2);

  point(sqX1, sqY1);
  point(sqX2, sqY2);
  point(sqX3, sqY3);
  point(sqX4, sqY4);

  noLoop();
}
