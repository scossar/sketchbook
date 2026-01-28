size(600, 600);
textSize(18);
background(235);
noFill();

// translate to Cartesian plane for entire sketch
translate(width/2, height/2);
scale(1, -1);

stroke(200);
line(-width/2, 0, width/2, 0);
line(0, -height/2, 0, height/2);

for (int x = -width/2; x < width/2; x += 20) {
  stroke(155);
  line(x, 2, x, -2);
}

for (int y = -height/2; y < height/2; y += 20) {
  stroke(155);
  line(-2, y, 2, y);
}

for (int x = -width/2; x < width/2; x += 20) {
  for (int y = -height/2; y < height/2; y += 20 ) {
    strokeWeight(1);
    stroke(176);
    point(x, y);
  }
}

fill(55);
stroke(55);
triangle(width/2, 0, width/2 - 8, 4, width/2 - 8, -4);
triangle(-width/2, 0, -width/2 + 8, 4, -width/2 + 8, -4);
triangle(0, height/2, 4, height/2 - 8, -4, height/2 - 8);
triangle(0, -height/2, 4, -height/2 + 8, -4, -height/2 + 8);

noFill();
ellipse(0, 0, 400, 400);
strokeWeight(6);
point(0, 0);
point(200, 0);
point(0, 200);
point(-200, 0);
point(0, -200);

pushMatrix();
scale(1, -1);

text("1+0i", 210, -8);
text("-1+0i", -250, -8);
text("0+i", 8, -208);
text("0+-i", 8, 216);

text("Real", width/2 - 200, -8);
pushMatrix();
rotate(-PI/2);
translate(-50, -150);
text("Imaginary", 122, 140);
popMatrix();

popMatrix();

save("complex_rectangular_unit_circle.png");
