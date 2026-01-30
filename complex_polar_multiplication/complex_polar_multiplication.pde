import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myLocation;

ComplexPolar a, b, c;

float windowScale;
boolean clearBg = false;

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

  background(217, 7, 96);

  stroke(216, 15, 91);
  strokeWeight(1);
  ellipse(0, 0, 1*windowScale, 1*windowScale);
  line(-width/2, 0, width/2, 0);

  if (a != null) {
    float re = a.re * windowScale * 0.5;
    float im = a.im * windowScale * 0.5;
    strokeWeight(8);
    stroke(a.hue, 74, 55);
    point(re, im);
  }
  if (b != null) {
    float re = b.re * windowScale * 0.5;
    float im = b.im * windowScale * 0.5;
    strokeWeight(8);
    stroke(b.hue, 74, 55);
    point(re, im);
  }
  if (c != null) {
    float re = c.re * windowScale * 0.5;
    float im = c.im * windowScale * 0.5;
    strokeWeight(8);
    stroke(c.hue, 74, 55);
    point(re, im);
  }
}

void oscEvent(OscMessage message) {
  println("### OSC message received:");

  if (message.checkAddrPattern("/complex/a")) {
    if (message.checkTypetag("ff")) {
      float r = message.get(0).floatValue();
      float theta = message.get(1).floatValue();
      a = new ComplexPolar(r, theta);
      print("a.re", a.re, "a.im", a.im);
    }
  }

  if (message.checkAddrPattern("/complex/b")) {
    if (message.checkTypetag("ff")) {
      float r = message.get(0).floatValue();
      float theta = message.get(1).floatValue();
      b = new ComplexPolar(r, theta);
    }
  }

  if (message.checkAddrPattern("/complex/multiply/ab")) {
    if (a != null && b != null) {
      c = a.mult(b);
    } else {
      OscMessage warningMessage = new OscMessage("/complex/warning");
      String msg;
      if (a == null && b == null) {
        msg = "Set values for polar coordinates \"a\" and \"b\"";
      } else if (a == null) {
        msg = "Set a value for the polar coordinate \"a\"";
      } else {
        msg = "Set a value for the polar coordinate \"b\"";
      }
      warningMessage.add(msg);
      oscP5.send(warningMessage, myLocation);
    }
  }

  if (message.checkAddrPattern("/complex/add/ab")) {
    if (a != null && b != null) {
      c = a.sum(b);
    }
  }

  if (message.checkAddrPattern("/complex/a/delete")) {
    a = null;
  }

  if (message.checkAddrPattern("/complex/b/delete")) {
    b = null;
  }

  if (message.checkAddrPattern("/complex/clear")) {
    a = null;
    b = null;
    c = null;
  }
}


class ComplexPolar {
  float r, theta, re, im;
  int hue;

  ComplexPolar(float r, float theta) {
    this.r = r;
    this.theta = theta;
    this.re = r * cos(theta);
    this.im = r * sin(theta);
    this.hue = (int)(theta * 180.0/PI) % 360;
  }

  ComplexPolar mult(ComplexPolar other) {
    return new ComplexPolar(
      r * other.r, cos(theta + other.theta) + sin(theta + other.theta)
      );
  }

  ComplexPolar sum(ComplexPolar other) {
    return new ComplexPolar(
      re + other.re, im + other.im
    );
  }

  float magnitude() {
    return sqrt(re*re + im*im);
  }
}
