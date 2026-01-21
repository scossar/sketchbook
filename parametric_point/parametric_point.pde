float x2 = 0;
float y2 = 0;

void setup() {
  size(400, 400);
  textSize(8);
  background(235);
  fill(25);
}

void draw() {
  translate(width/2, height/2);
  scale(1, -1);

  background(235);

  float x1 = -173;
  float y1 = -184;

  float rise = y2 - y1;
  float run = x2 - x1;
  float slope = rise/run;
  float hypotenuse = sqrt(rise*rise + run*run);
  float dirX = run/hypotenuse;
  float dirY = rise/hypotenuse;

  strokeWeight(8);
  stroke(158, 41, 28);
  point(x1, y1);

  stroke(46, 28, 158);
  point(x2, y2);

  float halfway = hypotenuse/2;

  float xHalf = x1 + halfway * dirX;
  float yHalf = y1 + halfway * dirY;

  stroke(28, 158, 65);
  point(xHalf, yHalf);
  strokeWeight(1);
  pushMatrix();
  stroke(122);
  scale(1, -1);
  text("slope: " + str(slope), -width/2 + 8, -height/2 + 8);
  text("hypotenuse: " + str(hypotenuse), -width/2 + 8, -height/2 + 20);
  text("half hypotenuse: " + str(halfway), -width/2 + 8, -height/2 + 32);
  text("calculated distance: " + str(dist(x1, y1, xHalf, yHalf)), -width/2 + 8, -height/2 + 44);
  popMatrix();
}

void mouseDragged() {
  x2 = mouseX - width/2;
  y2 = -1 * (mouseY - height/2);
}
