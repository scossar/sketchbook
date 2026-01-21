
Complex z = new Complex(4, 5);
Complex a = new Complex(6, 7);

void setup() {
  size(400, 400);
  background(55);
  Complex foo = z.add(a);
  println("COMPLEX ADDED", foo.re, foo.im);
}

void draw() {
  text("test", 20, height/2);
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

  float magnitide() {
    return sqrt(re*re + im*im);
  }
}
