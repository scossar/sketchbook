import oscP5.*;
import netP5.*;

Complex z;
Complex c;
float rePrev = 0.0;
float imPrev = 0.0;

OscP5 oscP5;
NetAddress myLocation;

float scaleAdjustment;
float zoom = 1.0;
boolean clearBg = false;

void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100);
  background(334, 0, 94);
  oscP5 = new OscP5(this, 12000);
  myLocation = new NetAddress("127.0.0.1", 9000);
  scaleAdjustment = (width/2 - 10) / 4.0;
}

/*
 * interesting points:
 * -0.391+-0.587i (chaotic)
 * -1.25+0.004i (takes a while to escape)
 * -543689+0i (Douady's rabbit (?))
 * 0+1i (a 4 perioc cycle)
 * 0.4711853349333897+0.3541498236351667i (the point with the greatest real coordinate (?)
 * see: https://mrob.com/pub/muency/easternmostpoint.html)
 */
void draw() {
  translate(width/2, height/2);
  scale(1, -1);

  if (clearBg) {
    background(334, 0, 94);
    clearBg = false;
  }

  if (z != null && z.magnitude() <= 8.0 && clearBg != true) {
    float re = z.re * scaleAdjustment * zoom;
    float im = z.im * scaleAdjustment * zoom;
    float magnitude = z.magnitude();
    float hue = map(magnitude, 0, 2.0, 167, 360);
    stroke(hue, 87, 87, 150);
    strokeWeight(4);
    point(re, im);
    strokeWeight(1);
    line(rePrev, imPrev, re, im);
    rePrev = re;
    imPrev = im;
    z = z.mult(z).add(c);
  }
}

void oscEvent(OscMessage message) {
  println("### OSC message received:");

  if (message.checkAddrPattern("/complex/number")) {
    if (message.checkTypetag("ff")) {
      clearBg = true;
      float re = message.get(0).floatValue();
      float im = message.get(1).floatValue();
      c = new Complex(re, im);
      z = new Complex(0.0, 0.0);
      rePrev = 0;
      imPrev = 0;
      println("Updated z to (0.0, 0.0); Updated z to (" + re + ", " + im + ")" );
      OscMessage statusMessage = new OscMessage("/complex/status");
      statusMessage.add(re);
      statusMessage.add(im);
      oscP5.send(statusMessage, myLocation);
    }
  }

  if (message.checkAddrPattern("/complex/zoom")) {
    if (message.checkTypetag("f")) {
      zoom = message.get(0).floatValue();
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
