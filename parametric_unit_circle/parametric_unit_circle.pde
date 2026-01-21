float radius = 100;

size(400, 400);
textSize(8);
background(235);
strokeWeight(2);

translate(width/2, height/2);
scale(1, -1);

for (float t = 0; t <= TWO_PI; t += 0.1) {

  float x = radius * cos(t);
  float y = radius * sin(t);
  point(x, y);
}
