int rows = 600;
int cols = 60;
int maxIters = 50;

Complex z = new Complex(0, 0);
Complex c = new Complex(-0.5, 0.5);

void setup() {
  size(600, 600);
  frameRate(1);
}

void draw() {
  translate(width/2, height/2);
  scale(1, -1);
  point(0, 0);
  z = z.mult(z).add(c);
  println("z.re:", z.re, "z.im:", z.im);
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
