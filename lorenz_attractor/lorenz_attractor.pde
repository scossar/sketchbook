float sigma = 10.0;
float rho = 37.4;
float beta = 8.0/3.0;

float x = 0.1;
float y = 1.0;
float z = 1.0;

float dt = 0.003;
float scale = 2.4;

void setup() {
  size(400, 400, P3D);
  background(55);
  noStroke();
}

int i = 0;
void draw() {
  lights();

  float dx = dxdt(x, y);
  float dy = dydt(x, y, z);
  float dz = dzdt(x, y, z);

  x += dx * dt;
  y += dy * dt;
  z += dz * dt;

  translate(x * scale + width/2, y * scale + height/2, z * scale);
  rotateX(-PI/8);
  rotateY(PI/8);
  rotateZ(-PI/8);
  sphere(2);
  if (i % 3000 == 0) {
    println("Z: ", z);
    println("X: ", x);
    save("lorenz_" + str(i) + ".png");
  }
  i++;
}

float dxdt(float cur_x, float cur_y) {
  return sigma * (cur_y - cur_x);
}

float dydt(float cur_x, float cur_y, float cur_z) {
  return cur_x * (rho - cur_z) - cur_y;
}

float dzdt(float cur_x, float cur_y, float cur_z) {
  return cur_x * cur_y - beta * cur_z;
}
