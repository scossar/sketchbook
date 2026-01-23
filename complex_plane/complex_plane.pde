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
  if (x % 200 == 0 && x != 0) {
    stroke(100);
    line(x, 4, x, -4);
  } else {
    stroke(155);
    line(x, 2, x, -2);
  }
}

for (int y = -height/2; y < height/2; y += 20) {
  if (y % 200 == 0 && y != 0) {
    stroke(100);
    line(-4, y, 4, y);
  } else {
    stroke(155);
    line(-2, y, 2, y);
  }
}

for (int x = -width/2; x < width/2; x += 20) {
  for (int y = -height/2; y < height/2; y += 20 ) {
    strokeWeight(1);
    stroke(100);
    point(x, y);
    if (x == 3*20 && y == 4*20) {
      println("got it");
      pushMatrix();
      scale(1, -1);
      translate(0, -y*2);
      fill(0, 0, 255);
      stroke(0, 0, 255);
      text("3+4j", x + 4, y);
      strokeWeight(4);
      point(x, y);
      stroke(100);
      strokeWeight(1);
      popMatrix();
    }
  }
}

fill(55);
triangle(width/2, 0, width/2 - 8, 4, width/2 - 8, -4);
triangle(-width/2, 0, -width/2 + 8, 4, -width/2 + 8, -4);
triangle(0, height/2, 4, height/2 - 8, -4, height/2 - 8);
triangle(0, -height/2, 4, -height/2 + 8, -4, -height/2 + 8);

noFill();

pushMatrix();
scale(1, -1);

textSize(12);
pushMatrix();
translate(0, 32);
text("10", 200, -16);
text("-10", -200, -16);
popMatrix();

pushMatrix();
translate(0, -390);
text("10", 10, 195);
popMatrix();

pushMatrix();
translate(0, 410);
text("-10", 10, -205);
popMatrix();

pushMatrix();
translate(0, 32);
text("10", 200, -16);
text("-10", -200, -16);
popMatrix();
textSize(18);
pushMatrix();
translate(0, -16);
text("Real", width/2 - 150, 8);
popMatrix();

pushMatrix();
rotate(-PI/2);
translate(0, -150);
text("Imaginary", 122, 140);
popMatrix();

popMatrix();

save("complex_plane.png");
