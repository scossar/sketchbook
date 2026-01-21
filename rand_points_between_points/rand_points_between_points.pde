int[] randX;
int[] randY;
float[] hypotenuses;
float[] dirX;
float[] dirY;
int numPoints = 36;
int t = 20;
float maxHypotenuse;

void setup() {
  size(1920/2, 400);
  background(245);
  frameRate(10);
  randX = new int[numPoints];
  randY = new int[numPoints];
  hypotenuses = new float[numPoints - 1];
  dirX = new float[numPoints - 1];
  dirY = new float[numPoints - 1];

  for (int i = 0; i < numPoints; i++) {
    int x = int(random(-width/2, width/2));
    int y = int(random(-width/2, width/2));
    randX[i] = x;
    randY[i] = y;
  }

  for (int i = 0; i < numPoints - 1; i++) {
    float x1 = randX[i];
    float x2 = randX[i+1];
    float y1 = randY[i];
    float y2 = randY[i+1];
    float rise = y2 - y1;
    float run = x2 - x1;
    float h = sqrt(sq(rise) + sq(run));
    float dirx = run/h;
    float diry = rise/h;
    dirX[i] = dirx;
    dirY[i] = diry;
    hypotenuses[i] = h;
  }

  maxHypotenuse = hypotenuses[0];
  for (int i = 1; i < hypotenuses.length; i++) {
    if (hypotenuses[i] > maxHypotenuse) {
      maxHypotenuse = hypotenuses[i];
    }
  }
}

void draw() {
  translate(width/2, width/2);
  scale(1, -1);
  background(245);

  for (int i = 0; i < numPoints -1; i++) {
    float x1 = randX[i];
    float y1 = randY[i];
    stroke(0, 0, 255);
    strokeWeight(4);
    point(x1, y1);
    float x2 = randX[i + 1];
    float y2 = randY[i + 1];
    point(x2, y2);
    float h = hypotenuses[i];
    float dirx = dirX[i];
    float diry = dirY[i];

    stroke(0);
    strokeWeight(2);
    int th = t % int(h);
    if (th < h) {
      float x = x1 + th * dirx;
      float y = y1 + th * diry;
      point(x, y);
    }
  }

  t += 2;
  if (t > maxHypotenuse) {
    // println("max reached");
    // noLoop();
  }
}
