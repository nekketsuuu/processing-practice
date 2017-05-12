float time = 0.0;
float theta = 0.0;

void setup() {
  size(400, 400);
  background(255);
}

void draw() {
  background(255);
  pushMatrix();
  translate(width * 0.5, height * 0.5);
  float side = 0.1 * abs(mouseX - width * 0.5) + 1;
  if (side <= 1) {
    side = 10;
  }
  mesh(side);
  rotate(theta);
  mesh(side);
  popMatrix();
  time += 0.01;
  theta += 0.1 * sin(time);
}

void mesh(float side) {
  float w = width * 0.7;
  float h = height * 0.7;
  float x = -w;
  while (x <= w) {
    line(x, -h, x, h);
    x += side;
  }
  float y = -h;
  while (y <= h) {
    line(-w, y, w, y);
    y += side;
  }
}