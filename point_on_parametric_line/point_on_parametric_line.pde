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

float rise = y2 - y1;
float run = x2 - x1;
float hypotenuse = sqrt(rise*rise + run*run);
float slope = rise/run;
float dirX = run/hypotenuse;
float dirY = rise/hypotenuse;


strokeWeight(8);
stroke(158, 41, 28);
point(x1, y1);

stroke(46, 28, 158);
point(x2, y2);

float oneThird = hypotenuse/3;

float newX = x1 + oneThird * dirX;
float newY = y1 + oneThird * dirY;

stroke(28, 158, 65);
point(newX, newY);

strokeWeight(1);
pushMatrix();
stroke(122);
scale(1, -1);
text("slope: " + str(slope), -width/2 + 8, -height/2 + 8);
text("hypotenuse: " + str(hypotenuse), -width/2 + 8, -height/2 + 20);
text("one-third hypotenuse: " + str(oneThird), -width/2 + 8, -height/2 + 32);
text("calculated distance: " + str(dist(x1, y1, newX, newY)), -width/2 + 8, -height/2 + 44);
popMatrix();

// visually confirm
stroke(175);
line(x1, y1, x2, y2);
