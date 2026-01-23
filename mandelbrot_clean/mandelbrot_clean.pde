int rows = 4000;
int cols = 4000;
int maxIters = 8000; // adjust, especially for zoomed in areas
int maxIterColorCutoff = 7000;
float pxScale = 0.25;  // allows for having 2x rows and columns than pixels, defaults to 1

int[][] iterations = new int[cols][rows];
float[] realComponents = centeredLinspace(-0.7474475, 0.000025, cols);
float[] imaginaryComponents = centeredLinspace(0.085984, 0.000025, rows);

void setup() {
  size(1000, 1000);
  colorMode(HSB, 360, 100, 100);
  iterations = fillArray(realComponents, imaginaryComponents);
}

void draw() {
  for (int i = 0; i < iterations[0].length; i++) {
    for (int j = 0; j < iterations[1].length; j++) {
      if (iterations[i][j] == 0) {
        stroke(0, 0, 0); // in the Mandelbrot set
      } else if (iterations[i][j] > maxIterColorCutoff) {  // probably on a boundary; adjust this value
        stroke(360, 89, 79);
      } else { // not in set and (probably) not on the boundary
        float hue = map(iterations[i][j], 1, maxIterColorCutoff, 167, 360);
        stroke(hue, 89, 79);
      }
      point(i*pxScale, j*pxScale);
    }
  }
  save("mandelbrot_seahorse_valley_5.png");
  noLoop();
}

int[][] fillArray(float[] xVals, float[] yVals) {
  int[][] result = new int[rows][cols];

  for (int i = 0; i < xVals.length; i++) {
    for (int j = 0; j < yVals.length; j++) {
      Complex c = new Complex(xVals[i], yVals[j]);
      Complex z = new Complex(0, 0);
      boolean diverged = false;
      for (int iter = 0; iter < maxIters; iter++) {
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

float findCenter(float start, float end) {
  float dif = end - start;
  float halfDif = dif/2;
  return start + halfDif;
}

float[] centeredLinspace(float center, float range, int num) {
  float[] result = new float[num];
  float halfRange = range * 0.5;
  float start = center - halfRange;
  float end = center + halfRange;
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
