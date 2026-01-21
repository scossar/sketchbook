int x2 = 0;
int y2 = 0;

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

  int x1 = -173;
  int y1 = -184;

  strokeWeight(8);
  stroke(158, 41, 28);
  point(x1, y1);
  stroke(46, 28, 158);
  point(x2, y2);

  int rise = y2 - y1;
  int run = x2 - x1;
  float slope = float(rise)/float(run);

  float xOffset = 100;

  float calculatedX = float(x1) + xOffset;
  float calculatedY = float(y1) + xOffset * slope;

  stroke(50, 168, 82);
  point(calculatedX, calculatedY);

  // confirm
  strokeWeight(1);
  stroke(165);
  line(x1, y1, x2, y2);

  pushMatrix();
  scale(1, -1);
  stroke(125);
  text("slope: " + str(slope), -width/2 + 8, -height/2 + 8);
  popMatrix();
}

void mouseDragged() {
  x2 = mouseX - width/2;
  y2 = -1 * (mouseY - height/2);
}
