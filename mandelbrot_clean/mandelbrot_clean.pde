int rows = 1000;
int cols = 1000;

int maxIters = 100000; // adjust, especially for zoomed in areas
int maxIterColorCutoff = 1000;

int[][] iterations = new int[rows][cols];

// float aspect = 0.000375;
// float aspect = 0.00006;
// float aspect = 0.000000000000000160;
float aspect = 0.000002560;

float halfAspect = aspect / 2;
// float centerReal = -0.747597;
float centerReal = -1.769110375463767385;
// float centerImag = 0.09001;
float centerImag = 0.009020388228023440;
float startReal = centerReal - halfAspect;
float endReal = centerReal + halfAspect;
float startImag = centerImag + halfAspect;
float endImag = centerImag - halfAspect;
float[] imaginaryComponents = linspace(startImag, endImag, rows, "imaginary");
float[] realComponents = linspace(startReal, endReal, cols, "real");


// float[] imaginaryComponents = linspace(1.25*0.5, -1.25*0.5, rows, "imaginary");
// float[] realComponents = linspace(-2.0*0.5 - 1, 0.5*0.5 - 1, cols, "real");

void setup() {
  size(1000, 1000); // cols, rows
  colorMode(HSB, 360, 100, 100);
  iterations = fillArray(imaginaryComponents, realComponents);
}

void draw() {
  for (int i = 0; i < iterations.length; i++) {  // i indexes the imaginary axis
    for (int j = 0; j < iterations[i].length; j++) {  // j indexes the real axis
      if (iterations[i][j] == 0) {
        // 0 means "(probably) in the Mandelbrot set"; these points iterated maxIters times without diverging
        stroke(0, 0, 0);
      } else { // not in set
        // float hue = map(iterations[i][j], 1, maxIterColorCutoff, 167, 360);
        // better approach for setting hue; compresses high values and spreads out low values:
        float hue = map(log(iterations[i][j]), log(1), log(maxIterColorCutoff), 64, 360);
        stroke(hue, 64, 87);
      }
      point(j, i);
    }
  }
  save("mandelbrot_test.png");
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

float[] linspace(float start, float end, int num, String plane) {
  println("start (" + plane + "):", start);
  println("end: (" + plane + "):", end);
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
