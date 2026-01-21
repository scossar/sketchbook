float a = 160;
float b = 160;
float kx = 3;
float ky = 2;

size(400, 400);
textSize(8);
background(235);
strokeWeight(1);

translate(width/2, height/2);
scale(1, -1);

for (float t = 0; t <= TWO_PI; t += 0.001) {

  float x = a * cos(kx * t);
  float y = b * sin(ky * t);
  point(x, y);
}

// save("lissajous_curve.png");
