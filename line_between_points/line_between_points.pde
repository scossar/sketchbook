size(400, 400);
background(245);
fill(20);

final int HALF_W = width/2;
final int HALF_H = height/2;

translate(HALF_W, HALF_H);
scale(1, -1);

strokeWeight(1);
stroke(155);
line(-HALF_W, 0, HALF_W, 0);
line(0, -HALF_H, 0, HALF_H);

for (int x = -HALF_W; x <= HALF_W; x+= 10) {
  line(x, 2, x, -2);
}

for (int y = -HALF_H; y <= HALF_H; y+= 10) {
  line(-2, y, 2, y);
}


float x1 = 143;
float y1 = -74;
float x2 = -164;
float y2 = 100;

stroke(0, 0, 255);
strokeWeight(4);
point(x1, y1);
point(x2, y2);

float run = x2 - x1;
float rise = y2 - y1;
float slope = rise/run;

stroke(3, 78, 252);
strokeWeight(2);

for (float x = x1; x > x2; x -= 10) {
  float y = y1 + (x - x1) * slope;
  point(x, y);
}

float x3 = -123;
float y3 = -173;
float x4 = 97;
float y4 = 176;

stroke(255, 0, 0);
strokeWeight(4);
point(x3, y3);
point(x4, y4);

float run2 = x4 - x3;
float rise2 = y4 - y3;
float hypotenuse = sqrt(rise2*rise2 + run2*run2);
// float angle2 = atan2(rise2, run2);

strokeWeight(2);
for (float t = 0; t <= hypotenuse; t+= 10) {
  // float x = x3 + t * cos(angle2);
  float x = x3 + t * run2/hypotenuse;
  // float y = y3 + t * sin(angle2);
  float y = y3 + t * rise2/hypotenuse;
  point(x, y);
}
