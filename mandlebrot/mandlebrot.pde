int rows = 800;
int cols = 800;
int[][] iterations = new int[rows][cols];
float[] xDomain = linspace(0, 0.80, rows);
float[] yDomain = linspace(0, 0.80, cols);

void setup() {
  size(800, 800);
  iterations = fillArray(xDomain, yDomain);
  background(235);
}

void draw() {
  for (int i = 0; i < iterations[0].length; i++) {
    for (int j = 0; j < iterations[1].length; j++) {
      float greyVal = map(iterations[i][j], 0, 50, 0, 255);
      stroke(greyVal);
      point(i, j);
    }
  }
  noLoop();
}


int[][] fillArray(float[] xVals, float[] yVals) {
  int[][] result = new int[rows][cols];

  for (int i = 0; i < xVals.length; i++) {
    for (int j = 0; j < yVals.length; j++) {
      Complex c = new Complex(xVals[i], yVals[j]);
      Complex z = new Complex(0, 0);
      boolean diverged = false;
      for (int iter = 0; iter < 50; iter++) {
        if (z.magnitude() >= 2) {
          result[i][j] = iter;
          diverged = true;
          break;
        } else {
          z = z.mult(z).add(c);
        }
      }
      if (!diverged) {
        result[i][j] = 0;
      }
    }
  }

  return result;
}


float[] linspace(float start, float end, int num) {
  float[] result = new float[num];
  if (num == 1) {
    result[0] = start;
    return result;
  }
  float step = (end - start) / (num - 1);
  for (int i = 0; i < num; i++) {
    result[i] = start + i * step;
  }
  return result;
}

class Complex {
  float re, im;

  Complex(float re, float im) {
    this.re = re;
    this.im = im;
  }

  Complex add(Complex other) {
    return new Complex(re + other.re, im + other.im);
  }

  Complex mult(Complex other) {
    return new Complex(
      re * other.re - im * other.im,
      re * other.im + im * other.re
      );
  }

  float magnitude() {
    return sqrt(re*re + im*im);
  }
}
