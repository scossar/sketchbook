import oscP5.*;
OscP5 oscP5;

float rInp = 3;
float RInp = 4;
float dInp = 1;

boolean rec = false;
boolean snap = false;

// float r = rInp * 16;
// float R = RInp * 16;
// float d = dInp * 16;
float t = 0;

ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  size(800, 800);
  noFill();
  frameRate(30);
  oscP5 = new OscP5(this, 12000);
}

void draw() {
  translate(width/2, height/2);
  scale(1, -1);

  float r = rInp * 16;
  float R = RInp * 16;
  float d = dInp * 16;

  background(235);
  stroke(112, 26, 56, 42);
  ellipse(0, 0, R * 2, R *2);

  float rcX = (R-r) * cos(t);
  float rcY = (R-r) * sin(t);
  float dX = rcX + d * cos(((R-r)/r) * t);
  float dY = rcY - d * sin(((R-r)/r) * t);


  ellipse(rcX, rcY, r*2, r*2);
  stroke(112, 26, 56, 42);
  line(rcX, rcY, dX, dY);

  stroke(43, 61, 153);
  strokeWeight(2);
  points.add(new PVector(dX, dY));
  for (int i = 0; i < points.size() - 1; i++) {
    PVector p1 = points.get(i);
    PVector p2 = points.get(i+1);
    line(p1.x, p1.y, p2.x, p2.y);
  }

  t += 0.05;

  if (rec) {
    saveFrame();
  }
  if (snap) {
    print("saving frame");
    saveFrame("snap_" + str(t) + ".png");
    snap = false;
  }

  if (rec) {
    saveFrame("./video_files/video_" + str(t) + ".tif");
  }
  // saveFrame();
  // if (frameCount > 1200) {
  //   noLoop();
  // }
}

void oscEvent(OscMessage theOscMessage) {
  /* with theOscMessage.isPlugged() you check if the osc message has already been
   * forwarded to a plugged method. if theOscMessage.isPlugged()==true, it has already
   * been forwared to another method in your sketch. theOscMessage.isPlugged() can
   * be used for double posting but is not required.
   */
  if (theOscMessage.isPlugged()==false) {
    /* print the address pattern and the typetag of the received OscMessage */
    println("### received an osc message.");
    // println("### addrpattern\t"+theOscMessage.addrPattern());
    // println("### typetag\t"+theOscMessage.typetag());
  }

  if (theOscMessage.checkAddrPattern("/sketch/r")) {
    float r = theOscMessage.get(0).floatValue();
    println("r", r);
    rInp = r;
  } else if (theOscMessage.checkAddrPattern("/sketch/R")) {
    float R = theOscMessage.get(0).floatValue();
    println("R", R);
    RInp = R;
  } else if (theOscMessage.checkAddrPattern("/sketch/d")) {
    float d = theOscMessage.get(0).floatValue();
    println("d", d);
    dInp = d;
  } else if (theOscMessage.checkAddrPattern("/sketch/clear")) {
    points.clear();
  } else if (theOscMessage.checkAddrPattern("/sketch/snapshot")) {
    int snapshot = theOscMessage.get(0).intValue();
    snap = (snapshot == 1) ? true : false;
  } else if (theOscMessage.checkAddrPattern("/sketch/rec")) {
    int recOn = theOscMessage.get(0).intValue();
    rec = (recOn == 1) ? true : false;
  }
}

// void mouseDragged() {
//   if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) {
//     rInp = floor(float(mouseX) / float(width) * 24);
//     println("rInp: ", rInp);
//     RInp = floor(float(mouseY) / float(height) * 24);
//     println("RInp: ", RInp);
//     points.clear();
//   }
// }
//
// void mouseWheel(MouseEvent event) {
//   float e = event.getCount();
//   println("mouseWheel event: ", e);
//
//   if (e == -1.0 && dInp > 1) {
//     dInp -= 1;
//   } else {
//     dInp += 1;
//   }
//   points.clear();
// }
