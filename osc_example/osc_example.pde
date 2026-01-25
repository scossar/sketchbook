import oscP5.*;
import netP5.*;
import java.nio.ByteBuffer;
import java.nio.*;

OscP5 oscP5;
NetAddress myLocation;

int r, g, b = 45;
float product = 0.0;
int[][] iterationCounts = new int[50][50];
byte[] receivedData = new byte[2500];
boolean mandelbrotReceived = false;
int xOuter = 0;
int x = 0;
int y = 0;
float hue;
color c;

void setup() {
  size(800, 800);
  textSize(22);
  colorMode(HSB, 360, 100, 100);
  background(55, 12, 12);
  stroke(200);
  strokeWeight(8);
  frameRate(10);
  oscP5 = new OscP5(this, 12000);
  myLocation = new NetAddress("127.0.0.1", 9000);
}

void draw() {
  sendToMandelbrot(x, y);
  if (mandelbrotReceived) {
    for (int i = 0; i < iterationCounts[0].length; i++) {
      for (int j = 0; j < iterationCounts[1].length; j++) {
        int count = iterationCounts[i][j];

        if (count == 0) {
          fill(0, 0, 0);
        } else {
          hue = map(count, 0, 30, 0, 360);
          fill(hue, 80, 80);
        }
        noStroke();
        rect(i * 16, j * 16, 16, 18);
      }
    }

    xOuter++;
    if (xOuter >= width) {
      x = 2 * width - xOuter;
    } else {
      x = xOuter;
    }
    if (xOuter == width || xOuter == 2 * width) {
      y++;
    }
    xOuter %= 2 * width;
    y %= height;
  }
}

void sendToMultiply(float f1, float f2) {
  OscMessage myMessage = new OscMessage("/multiply");
  myMessage.add(f1);
  myMessage.add(f2);
  oscP5.send(myMessage, myLocation);
}

void sendToMandelbrot(int x, int y) {
  float centerReal = map(x, 0, width, -1.5, 0.75);
  float centerImag = map(y, 0, height, -1.125, 1.125);
  OscMessage makeMandelbrot = new OscMessage("/mandelbrot");
  makeMandelbrot.add(centerReal);
  makeMandelbrot.add(centerImag);
  oscP5.send(makeMandelbrot, myLocation);
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.isPlugged() == false) {
    if (theOscMessage.checkAddrPattern("/sketch/bg")) {
      if (theOscMessage.checkTypetag("iii")) {
        r = theOscMessage.get(0).intValue();
        g = theOscMessage.get(1).intValue();
        b = theOscMessage.get(2).intValue();
      }
    }

    if (theOscMessage.checkAddrPattern("/product")) {
      if (theOscMessage.checkTypetag("f")) {
        print("Product received");
        product = theOscMessage.get(0).floatValue();
      }
    }

    if (theOscMessage.checkAddrPattern("/iterations/chunk")) {
      int offset = theOscMessage.get(0).intValue();
      byte[] receivedBytes = theOscMessage.get(1).bytesValue();
      for (int i = 0; i < receivedBytes.length; i++) {
        receivedData[offset + i] = receivedBytes[i];
      }
    }

    if (theOscMessage.checkAddrPattern("/iterations/complete")) {
      int totalSize = theOscMessage.get(0).intValue();
      int gridSize = (int)sqrt(totalSize);
      for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridSize; j++) {
          iterationCounts[i][j] = receivedData[i*gridSize + j] & 0xFF;
        }
      }
      mandelbrotReceived = true;
    }
  }
}
