int rows = 1000;
int cols = 1000;

int maxIters = 10000; // adjust, especially for zoomed in areas
int maxIter = 0;
int totalEscaped;

int[][] iterations = new int[rows][cols];
int[] cumulative;

double aspect = 0.125 * 0.0000005;

double halfAspect = aspect / 2;

double centerReal = -0.49 - 0.10238635;
double centerImag = 0.6 + 0.0175717182;
// double centerReal = -1.769110375463767385;
// double centerImag = 0.009020388228023440;

double startReal = centerReal - halfAspect;
double endReal = centerReal + halfAspect;
double startImag = centerImag + halfAspect;
double endImag = centerImag - halfAspect;
double[] imaginaryComponents = linspace(startImag, endImag, rows, "imaginary");
double[] realComponents = linspace(startReal, endReal, cols, "real");

void setup() {
  size(1000, 1000); // cols, rows
  colorMode(HSB, 360, 100, 100);
  iterations = fillArray(imaginaryComponents, realComponents);
  for (int i = 0; i < iterations.length; i++) {
    for (int j = 0; j < iterations[i].length; j++) {
      if (iterations[i][j] > maxIter) {
        maxIter = iterations[i][j];
      }
    }
  }
  println("maxIter", maxIter);
  int[] histogram = new int[maxIter + 1];
  for (int i = 0; i < iterations.length; i++) {
    for (int j = 0; j < iterations[i].length; j++) {
      if (iterations[i][j] > 0) histogram[iterations[i][j]]++;
    }
  }

  cumulative = new int[maxIter + 1];
  cumulative[0] = histogram[0];
  for (int i = 1; i <= maxIter; i++) {
    cumulative[i] = cumulative[i-1] + histogram[i];
  }
  totalEscaped = cumulative[maxIter];
}


void draw() {
  for (int i = 0; i < iterations.length; i++) {  // i indexes the imaginary axis
    for (int j = 0; j < iterations[i].length; j++) {  // j indexes the real axis
      if (iterations[i][j] == 0) {
        // 0 means "(probably) in the Mandelbrot set"; these points iterated maxIters times without diverging
        stroke(0, 0, 0);
      } else { // not in set
        int iter = iterations[i][j];
        float normalized = (float)cumulative[iter] / totalEscaped;
        float hue = map(normalized, 0, 1, 40, 360);
        stroke(hue, 74, 55);
      }
      point(j, i);
    }
  }
  String centerStr = String.format("%.8f", centerReal) + "_" + String.format("%.8f", centerImag) + "_" + String.format("%.8f", aspect);
  println("centerStr:", centerStr);
  save("mandelbrot_" + centerStr + ".png");
  noLoop();
}

int[][] fillArray(double[] imagVals, double[] realVals) {
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

double[] linspace(double start, double end, int num, String plane) {
  println("start (" + plane + "):", start);
  println("end: (" + plane + "):", end);
  println("range:", end - start);
  double[] result = new double[num];
  if (num == 1) {
    result[0] = start;
    return result;
  }
  double step = (end - start) / (num - 1);
  println("step:", step);
  for (int i = 0; i < num; i++) {
    result[i] = start + i * step;
  }
  return result;
}

class Complex {
  double re, im;

  Complex(double re, double im) {
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

  double magnitude() {
    return Math.sqrt(re*re + im*im);
  }
}
