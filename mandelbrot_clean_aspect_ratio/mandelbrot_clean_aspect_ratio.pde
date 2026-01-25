int rows = 1000;
int cols = 1200;
float aspectRatio = (float)cols / rows; // width/height

int maxIters = 70; // adjust, especially for zoomed in areas
int maxIterColorCutoff = 70;
float pxScale = 1;  // allows for having 2x rows and columns than pixels, defaults to 1

int[][] iterations = new int[rows][cols];

float imaginaryRange = 2.5;
float realRange = imaginaryRange * aspectRatio;

float[] imaginaryComponents = linspace(1.25, -1.25, rows);

float centerReal = -0.75;
float[] realComponents = linspace(centerReal - realRange/2, centerReal + realRange/2, cols);

void setup() {
  size(1200, 1000); // cols, rows
  colorMode(HSB, 360, 100, 100);
  iterations = fillArray(imaginaryComponents, realComponents);
}

void draw() {
  for (int i = 0; i < iterations.length; i++) {  // i indexes the imaginary axis
    for (int j = 0; j < iterations[i].length; j++) {  // j indexes the real axis
      if (iterations[i][j] == 0) {
        stroke(0, 0, 0); // in the Mandelbrot set
        // a hack to prevent high outliers from compressing the color range:
      } else if (iterations[i][j] > maxIterColorCutoff) {
        stroke(360, 89, 79);
      } else { // not in set and (probably) not on the boundary
        float hue = map(iterations[i][j], 1, maxIterColorCutoff, 167, 360);
        stroke(hue, 89, 79);
      }
      point(j*pxScale, i*pxScale);
    }
  }
  save("fixed_set.png");
  noLoop();
}

int[][] fillArray(float[] imagVals, float[] realVals) {
  int[][] result = new int[rows][cols];

  for (int i = 0; i < imagVals.length; i++) {
    for (int j = 0; j < realVals.length; j++) {
      Complex c = new Complex(realVals[j], imagVals[i]);
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
