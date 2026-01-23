int rows = 2000;
int cols = 2000;
int[][] iterations = new int[cols][rows];
// float[] xDomain = linspace(-0.7485 + 0.001, -0.7475 + 0.001, cols);
// float[] yDomain = linspace(0.097, 0.098, rows );
// float[] xDomain = linspace(-0.753, -0.742, cols);
// float[] yDomain = linspace(0.09, 0.1, rows );
// float[] xDomain = linspace(-1.79 + 0.012, -1.77 + 0.012, cols);
// float[] yDomain = linspace(-0.01, 0.01, rows );
// float[] xDomain = linspace(-1.78999, -1.74, cols);
// float[] yDomain = linspace(-0.025, 0.025, rows );
float[] xDomain = linspace(-2.5, 1, cols);
float[] yDomain = linspace(-1.75, 1.75, rows );

color[] palette = {
  color(0, 2, 0),
  color(0, 7, 100),
  color(32, 107, 203),
  color(237, 255, 255),
  color(255, 170, 0),
};

void setup() {
  size(1000, 1000);
  iterations = fillArray(xDomain, yDomain);
  background(235);
}

void draw() {
  for (int i = 0; i < iterations[0].length; i++) {
    for (int j = 0; j < iterations[1].length; j++) {
      if (iterations[i][j] == 0) {
        stroke(25); // in the set
      } else { // map iterations with color
        float hue = map(iterations[i][j], 1, 100, 169, 360);
        colorMode(HSB, 360, 100, 100);
        stroke(hue, 57, 39);
      }
      point(i * 0.5, j * 0.5);
    }
  }
  save("mandelbrot.png");
  noLoop();
}

int[][] fillArray(float[] xVals, float[] yVals) {
  int[][] result = new int[rows][cols];

  for (int i = 0; i < xVals.length; i++) {
    for (int j = 0; j < yVals.length; j++) {
      Complex c = new Complex(xVals[i], yVals[j]);
      Complex z = new Complex(0, 0);
      boolean diverged = false;
      for (int iter = 0; iter < 100; iter++) {
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
