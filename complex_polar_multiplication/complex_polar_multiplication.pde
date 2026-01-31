import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myLocation;

ComplexPolar a, b, c;

float windowScale;
boolean clearBg = false;

boolean closeBA, closeCA, closeCB = false;


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
  println("mod test", -5.0 % 2);
}

void draw() {
  translate(width/2, height/2);
  scale(1, -1);

  background(217, 7, 96);

  stroke(216, 15, 91);
  strokeWeight(1);
  noFill();
  ellipse(0, 0, 1*windowScale, 1*windowScale);
  line(-width/2, 0, width/2, 0);

  if (a != null) {
    float re = a.re() * windowScale * 0.5;
    float im = a.im() * windowScale * 0.5;
    strokeWeight(8);
    stroke(a.hue, 74, 55);
    point(re, im);

    pushMatrix();
    scale(1, -1);
    fill(0, 0, 0);
    text("A", re + 10, -im);
    text("Point 'A', r: " + a.r + " theta: " + a.theta, -width/2 + 10, -height/2 + 20);
    popMatrix();
  }
  if (b != null) {
    float re = b.re() * windowScale * 0.5;
    float im = b.im() * windowScale * 0.5;
    strokeWeight(8);
    stroke(b.hue, 74, 55);
    point(re, im);

    pushMatrix();
    scale(1, -1);
    String label = "B";
    int labelOffset = 10;
    if (closeBA) labelOffset += 12;
    text(label, re + labelOffset, -im);

    fill(0, 0, 0);
    text("Point 'B', r: " + b.r + " theta: " + b.theta, -width/2 + 10, -height/2 + 42);
    popMatrix();
  }
  if (c != null) {
    float re = c.re() * windowScale * 0.5;
    float im = c.im() * windowScale * 0.5;
    strokeWeight(8);
    stroke(c.hue, 74, 55);
    point(re, im);

    pushMatrix();
    scale(1, -1);
    String label = "C";
    int labelOffset = 10;
    if (closeCA) labelOffset += 12;
    if (closeCB) labelOffset += 12;
    text(label, re + labelOffset, -im);
    fill(0, 0, 0);
    text("Point 'C', r: " + c.r + " theta: " + c.theta, -width/2 + 10, -height/2 + 64);
    popMatrix();
  }

  if (a != null && b != null) {
    closeBA = isClose(b, a);
    if (c != null) {
      closeCA = isClose(c, a);
      closeCB = isClose(c, b);
    }
  }
}

boolean isClose(ComplexPolar a, ComplexPolar b) {
  float thetaA = normalizeTheta(a.theta);
  float thetaB = normalizeTheta(b.theta);
  if (abs(thetaA - thetaB) < PI/16 && abs(a.r - b.r) < 12) {
    return true;
  }
  return false;
}

float normalizeTheta(float theta) {
  float normalizedTheta = theta % TWO_PI;
  if (normalizedTheta < 0) normalizedTheta += TWO_PI;
  return normalizedTheta;
}

void oscEvent(OscMessage message) {
  println("### OSC message received:");

  if (message.checkAddrPattern("/complex/a")) {
    if (message.checkTypetag("ff")) {
      float r = message.get(0).floatValue();
      float theta = message.get(1).floatValue();
      a = new ComplexPolar(r, theta);
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
  float r, theta;
  int hue;

  ComplexPolar(float r, float theta) {
    this.r = r;
    this.theta = theta;
    float normalizedTheta = theta % TWO_PI;
    if (normalizedTheta < 0) normalizedTheta += TWO_PI;
    this.hue = (int)(normalizedTheta * 180/PI);
  }

  ComplexPolar mult(ComplexPolar other) {
    return new ComplexPolar(
      r * other.r, theta + other.theta
      );
  }

  ComplexPolar sum(ComplexPolar other) {
    float real = this.re() + other.re();
    float imag = this.im() + other.im();
    float magnitude = sqrt(real*real + imag*imag);
    float theta = atan2(imag, real);

    return new ComplexPolar(
      magnitude, theta
      );
  }

  float magnitude() {
    return r;
  }

  float re() {
    return r * cos(theta);
  }

  float im() {
    return r * sin(theta);
  }
}
