void setup() {
  size(200, 200);
}

void draw() {
  point(100, 100);
}
void keyPressed() {
  println("key:", key);
  if (key == CODED) {
    println("keycode:", keyCode);
  }
}


