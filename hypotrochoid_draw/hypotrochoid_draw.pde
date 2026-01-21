float r = 4 * 16;
float R = 8 * 16;
float d = 11 * 16;
float t = 0;

ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  size(500, 500);
  noFill();
  frameRate(30);
}

void draw() {
  translate(width/2, height/2);
  scale(1, -1);

  background(235);
  stroke(112, 26, 56, 12);
  ellipse(0, 0, R * 2, R *2);

  float rcX = (R-r) * cos(t);
  float rcY = (R-r) * sin(t);
  float dX = rcX + d * cos(((R-r)/r) * t);
  float dY = rcY - d * sin(((R-r)/r) * t);


  ellipse(rcX, rcY, r*2, r*2);
  stroke(112, 26, 56, 22);
  line(rcX, rcY, dX, dY);

  stroke(43, 61, 153);
  strokeWeight(2);
  points.add(new PVector(dX, dY));
  for (int i = 0; i < points.size() - 1; i++) {
    PVector p1 = points.get(i);
    PVector p2 = points.get(i+1);
    line(p1.x, p1.y, p2.x, p2.y);
  }

  t += 0.1;

  // saveFrame();
  if (frameCount > 1200) {
    noLoop();
  }
}
