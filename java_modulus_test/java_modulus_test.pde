void setup() {
  size(300, 300);
  // the desired result is 0.1 (the positive direction)
  float negativeDegrees = -TWO_PI + 0.1;
  println(negativeDegrees % TWO_PI);
  float mod = negativeDegrees % TWO_PI;
  println("Original mod:", mod);
  if (mod < 0) mod += TWO_PI;
  println("Normalized mod:", mod);

  float modImplTest = negativeDegrees - int(negativeDegrees / TWO_PI);
  println("modImplTest:", modImplTest);
  if (modImplTest < 0) modImplTest += TWO_PI;
  println("Normalized modImplTest:", modImplTest);
  println(mod);
}
