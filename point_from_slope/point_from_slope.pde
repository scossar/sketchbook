size(400, 400);
textSize(8);
background(235);
fill(25);

translate(width/2, height/2);
scale(1, -1);

int x1 = -123;
int y1 = -44;
int x2 = 157;
int y2 = 99;

int rise = y2 - y1;
int run = x2 - x1;
float slope = float(rise)/float(run);

pushMatrix();
scale(1, -1);
text("slope: " + str(slope), -width/2 + 8, -height/2 + 8);
popMatrix();

strokeWeight(8);
stroke(158, 41, 28);
point(x1, y1);

stroke(46, 28, 158);
point(x2, y2);

float xOffset = 111;
float calculatedX = float(x1) + xOffset;
float calculatedY = float(y1) + slope * xOffset;
stroke(50, 168, 82);
point(calculatedX, calculatedY);

// visually confirm
stroke(122);
strokeWeight(1);
line(x1, y1, x2, y2);
