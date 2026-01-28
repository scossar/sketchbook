size(600, 600);
textSize(16);

int hW = width/2;
int hH = height/2;

// translate and scale the window into the Cartesian coordinate system
translate(hW, hH);
scale(1, -1);

int x1 = -183;
int y1 = 190;
int x2 = 107;
int y2 = -30;

int dx = x2 - x1;
int dy = y2 - y1;

stroke(155);
line(-hW, 0, hW, 0);
line(0, hH, 0, -hH);
line(0, 0, dx, dy);
strokeWeight(8);
point(0, 0);
point(dx, dy);

stroke(158, 13, 59);
strokeWeight(8);
point(x1, y1);
strokeWeight(1);
line(x1, -hH, x1, hH);
line(-hW, y1, hW, y1);

stroke(5, 153, 34);
strokeWeight(8);
point(x2, y2);
strokeWeight(1);
line(x2, -hH, x2, hH);
line(-hW, y2, hW, y2);

float angle = atan2(dy, dx);

float xI1 = x1 + 150 * cos(angle);
float yI1 = y1 + 150 * sin(angle);

stroke(173, 138, 40);
strokeWeight(8);
point(xI1, yI1);
strokeWeight(1);
line(x1, y1, xI1, yI1);

float xI2 = x2 + 150 * cos(angle);
float yI2 = y2 + 150 * sin(angle);

stroke(222, 75, 205);
strokeWeight(8);
point(xI2, yI2);
strokeWeight(1);
line(x2, y2, xI2, yI2);
point(dx, dy);

pushMatrix();
scale(1, -1);  // compensate for the reversed y-axis
fill(45);
text("\u03B8 = " + angle, x1 + 28, -y1 + 20);
text("\u03B8 = " + angle, x2 + 28, -y2 + 20);
text("\u03B8 = " + angle, 0 + 28, 20);
text("(dx: "+ dx + ",dy: " + dy + ")", dx - 110, -dy - 6);
popMatrix();

// save("slope_angle_example.png");
