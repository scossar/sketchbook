float h = 0;
float k = 0;
float a = 25;
float b = 25;

size(400, 400);
textSize(8);
background(235);
strokeWeight(2);

translate(width/2, height/2);
scale(1, -1);

for (float t = 0; t <= TWO_PI; t += 0.01) {
  float x = a * (1/cos(t)) + h;
  float y = b * tan(t) + k;
  point(x, y);
}

// save("parametric_hyperbola.png");
