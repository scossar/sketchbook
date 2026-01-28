size(600, 600);
textSize(18);
background(235);
noFill();

// translate to Cartesian plane for entire sketch
translate(width/2, height/2);
scale(1, -1);

line(0, 0, width, 0);
strokeWeight(4);
point(0, 0);
fill(23);
triangle(width/2-4, 0, width/2 - 14, 6, width/2 - 14, -6);
noFill();

strokeWeight(1);
for (int x = 0; x < width/2; x += 20) {
  if (x % 200 == 0 && x != 0) {
    stroke(100);
    line(x, 4, x, -4);
  } else {
    stroke(155);
    line(x, 2, x, -2);
  }
}

/*
 * Translation from actual scale to unit-circle scale:
 * x = -1: -200
 * x = 1: 200
 * y = 1: 200
 * y = -1: -200
 *
 * Distance of 0.1 is 20px
 * */

// "unit" circle
strokeWeight(1);
ellipse(0, 0, 400, 400);

// points at each PI/2 angle
strokeWeight(4);
stroke(25);
point(200, 0);
point(0, 200);
point(-200, 0);
point(0, -200);

// float theta = PI/3;
// float x = 200 * cos(theta);
// float y = 200 * sin(theta);
// point(x, y);
// strokeWeight(1);
// line(0, 0, x, y);


// flip the scale of y to prevent text from being written upside down
fill(25);
pushMatrix();
scale(1, -1);

text("1(cos 0 + i sin 0)", 160, -8);
text("1(cos \u03C0 + i sin \u03C0)", -244, -8);

text("1(cos \u03C0/2 + i sin \u03C0/2)", 3, -206);

text("1(cos 3/2\u03C0 + i sin 3\u03C0/2)", 3, 216);


save("polar_uc_powers_of_i.png");
