void setup() {
  size(400, 400);
  textSize(12);
  fill(0);
  strokeWeight(8);
  point(width/2, height/2);
  text("0", width/2+5, height/2+10);

  // pole
  strokeWeight(1);
  line(width/2, height/2, width-20, height/2);
  line(width-20, height/2, width-30, height/2-10);
  line(width-20, height/2, width-30, height/2+10);
  text("axis", width-50, height/2-4);

  for (int i = 0; i < 36; i++) {
    float x = cos(i/36.0 * -PI) * 100;
    float y = sin(i/36.0 * -PI) * 100;
    point(x + width/2, y + height/2);
    println(x, y);
  }
}

void draw() {
  // line(width/2, height/2, width-20, height/2);
}
