int rows = 600;
int cols = 600;
int maxIters = 50;
float scale = rows / 1.41; // sqrt(2)

float aspect = 1;
float halfAspect = aspect * 0.5;
float centerReal = 0.3;
float centerImag = 0;
float startReal = centerReal - halfAspect;
float startImag = centerImag + halfAspect;
float endReal = centerReal + halfAspect;
float endImag = centerImag - halfAspect;
float[] imaginaryComponents = linspace(startImag, endImag, rows, "imaginary");
float[] realComponents = linspace(startReal, endReal, cols, "real");
int[][] iterations = new int[rows][cols];

float rectSize;

Complex[][] cVals = cValues(imaginaryComponents, realComponents);
Complex[][] zVals = zValues();

int traceCount = 0;
float lastReal;
float lastComplex;

void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100);
  frameRate(5);
  background(225);
  noStroke();
  rectSize = width / rows;
  iterations = fillArray(imaginaryComponents, realComponents);
  // translate(width/2, height/2);
  // scale(1, -1);
  // for (int i = 0; i < iterations.length; i++) {
  //   for (int j = 0; j < iterations[i].length; j++) {
  //     if (iterations[i][j] == 0) {
  //       fill(0, 0, 0);
  //     } else {
  //       float hue = map(log(iterations[i][j]), log(1), log(50), 0, 360);
  //       fill(hue, 100, 100);
  //     }
  //     rect(j*rectSize-width/2, i*rectSize-width/2, rectSize, rectSize);
  //   }
  // }
}

void draw() {
  translate(width/2, height/2);
  scale(1, -1);
  background(225);

  for (int i = 0; i < cVals.length; i++) {
    for (int j = 0; j < cVals[i].length; j++) {
      Complex z = zVals[i][j];
      Complex c = cVals[i][j];
      if (z.magnitude() < 8) {

        z = z.mult(z).add(c);
        zVals[i][j] = z;
        float re = z.re * scale;
        float im = z.im * scale;
        strokeWeight(8);

        float hue = map(log(i*j), log(1), log(rows*cols), 0, 360);
        stroke(hue, 100, 100);
        point(re, im);
      }
    }
  }
  // noLoop();
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

Complex[][] cValues(float[] imagVals, float[] realVals) {
  Complex[][] c = new Complex[rows][cols];

  for (int i = 0; i < imagVals.length; i++) {
    for (int j = 0; j < realVals.length; j++) {
      c[i][j] = new Complex(realVals[i], imagVals[j]);
    }
  }

  return c;
}

Complex[][] zValues() {
  Complex[][] z = new Complex[rows][cols];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      z[i][j] = new Complex(0, 0);
    }
  }

  return z;
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
