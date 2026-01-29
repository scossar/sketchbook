import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myLocation;
float windowScale;
boolean clearBg = false;
Complex a, b, c;

void setup() {
  size(600, 600);
  windowScale = width / 3;
  colorMode(HSB, 360, 100, 100);
  background(217, 7, 96);
  stroke(217, 4, 56);
  textSize(18);

  noFill();
  oscP5 = new OscP5(this, 12000);
  myLocation = new NetAddress("127.0.0.1", 9000);
}
void draw() {
  translate(width/2, height/2);
  scale(1, -1);

  stroke(216, 15, 91);
  ellipse(0, 0, 1*windowScale, 1*windowScale);
  line(-width/2, 0, width/2, 0);
  line(0, height/2, 0, -height/2);

  if (clearBg) {
    background(217, 7, 96);
    clearBg = false;
  }

  if (a != null && b != null && c != null) {
    float reA = a.re * windowScale * 0.5;
    float imA = a.im * windowScale * 0.5;
    float reB = b.re * windowScale * 0.5;
    float imB = b.im * windowScale * 0.5;
    float reC = c.re * windowScale * 0.5;
    float imC = c.im * windowScale * 0.5;

    strokeWeight(8);
    stroke(330, 65, 49);
    point(reA, imA);
    stroke(220, 46, 45);
    point(reB, imB);
    stroke(141, 49, 44);
    point(reC, imC);
    strokeWeight(1);
    pushMatrix();
    scale(1, -1);
    fill(217, 4, 56);
    text("A", reA + 12, -imA);
    text("B", reB + 12, -imB);
    text("C", reC + 12, -imC);
    noFill();
    popMatrix();
  }
}

void oscEvent(OscMessage message) {
  println("### OSC message received:");

  if (message.checkAddrPattern("/complex/multiply")) {
    if (message.checkTypetag("ffff")) {
      clearBg = true;
      float re1 = message.get(0).floatValue();
      float im1 = message.get(1).floatValue();
      float re2 = message.get(2).floatValue();
      float im2 = message.get(3).floatValue();
      a = new Complex(re1, im1);
      b = new Complex(re2, im2);
      c = a.mult(b);

      OscMessage statusMessage = new OscMessage("/complex/product");
      statusMessage.add(c.re);
      statusMessage.add(c.im);
      oscP5.send(statusMessage, myLocation);
    }
  }

  if (message.checkAddrPattern("/complex/save")) {
    String reStr = String.format("%.4f", c.re);
    String imStr = String.format("%.4f", c.im);
    String imageName = "complex_" + reStr + "_" + imStr + ".png";
    save(imageName);
    OscMessage statusMessage = new OscMessage("/complex/save/status");
    statusMessage.add(imageName);
    oscP5.send(statusMessage, myLocation);
  }
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
