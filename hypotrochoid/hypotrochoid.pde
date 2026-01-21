float r = 4 * 20;
float R = 6 * 20;
float d = 1 * 20;

size(430, 430);
background(235);
strokeWeight(2);

translate(width/2, height/2);
scale(1, -1);

// ellipse(0, 0, R, R);
// ellipse(0.5 * (R - r), 0, r, r);
// line(0.5*(R-r), 0, (R-r) + d, 0);

for (float t = 0; t <= TWO_PI * 30; t += 0.05) {
  float x = (R - r) * cos(t) + d * cos(((R - r)/r) * t);
  float y = (R - r) * sin(t) - d * sin(((R - r)/r) * t);
  point(x, y);
}

// save("hypotrochoid_r3_R4_2_d6.png");
