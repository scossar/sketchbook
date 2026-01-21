float t = 0;

void setup() {
  size(400, 400);
  textSize(8);
  background(235);
  fill(25);
}

void draw() {
  translate(width/2, height/2);
  scale(1, -1);

  stroke(0);
  noFill();
  point(0, 0);
  beginShape();
  float r = t * 5;
  float x = r * cos(t);
  float y = r * sin(t);
  float t2 = t + 0.01;
  float r2 = t2 * 5;
  float x2 = r2 * cos(t2);
  float y2 = r2 * sin(t2);
  vertex(x, y);
  vertex(x2, y2);
  endShape();

  // beginShape();
  // for (float t = 0; t < 4*TWO_PI; t += 0.1) {
  //   float r = t * 5;  // radius grows with t
  //   float x = r * cos(t);
  //   float y = r * sin(t);
  //   vertex(x, y);
  // }
  // endShape();
}

void mouseDragged() {
  t = mouseX * 0.01 %  8 * TWO_PI;
  println("t: ", t);
}
