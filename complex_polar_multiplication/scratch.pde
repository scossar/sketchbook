class ComplexPolarMult {
  float r, theta;

  ComplexPolarMult(float r, float theta) {
    this.r = r;
    this.theta = theta;
  }

  ComplexPolarMult mult(ComplexPolarMult other) {
    return new ComplexPolarMult(
      r * other.r, cos(theta + other.theta) + sin(theta + other.theta)
    );
  }

  float magnitude() {
    return r;
  }
}
