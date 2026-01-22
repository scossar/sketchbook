int rows = 1600;
int cols = 1600;
int[][] iterations = new int[cols][rows];
float[] xDomain = linspace(-1.78999, -1.74, cols);
float[] yDomain = linspace(-0.025, 0.025, rows );

color[] palette = {
  color(0, 2, 0),
  color(0, 7, 100),
  color(32, 107, 203),
  color(237, 255, 255),
  color(255, 170, 0),
};

void setup() {
  size(800, 800);
  iterations = fillArray(xDomain, yDomain);
  background(235);
}

void draw() {
  for (int i = 0; i < iterations[0].length; i++) {
    for (int j = 0; j < iterations[1].length; j++) {
      if (iterations[i][j] == 0) {
        stroke(25); // in the set
      } else { // map iterations with color
        float hue = map(iterations[i][j], 1, 50, 169, 323);
        colorMode(HSB, 360, 100, 100);
        stroke(hue, 57, 39);
      }
      point(i * 0.5, j * 0.5);
    }
  }
  save("mandlebrot5.png");
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
        if (z.magnitude() >= 3) {
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
