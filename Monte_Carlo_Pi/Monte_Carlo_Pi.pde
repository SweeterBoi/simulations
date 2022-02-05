int radius = 400;
double numberOfPointsInCircle;

ArrayList<Point> points = new ArrayList<Point>();

void setup() {
  size(400, 600);
}


void draw() {
  background(0);
  addPoint();
  countPoints();
  drawRectangle();
  drawPoints();
  drawCircle();
}

void drawCircle() {
  noFill();
  strokeWeight(3);
  stroke(color(255, 200, 150));
  ellipseMode(CENTER);
  ellipse(0, height, 2*radius, 2*radius);
}

void drawRectangle() {
  fill(0);
  strokeWeight(3);
  stroke(255);
  rectMode(CENTER);
  rect(radius/2, height-radius/2, radius, radius);
}

void addPoint() {
  float x = random(0, radius);
  float y = random(0, radius);
  float dist = sqrt(pow(x, 2) + pow(y, 2));
  boolean iic = dist <= radius;
  points.add(new Point(x, height - y, iic));
}

void countPoints() {
  double c = 0;
  for (int i = 0; i < points.size(); i++) {
    Point p = points.get(i);
    if (p.isInCircle) {
      c++;
    }
  }
  numberOfPointsInCircle = c;
  println(4*c/points.size());
}

void drawPoints() {
  for (int i = 0; i < points.size(); i++) {
    points.get(i).blit();
  }
}

void drawText() {
  textSize(100);
  fill(200);
  stroke(255);
  text(str((float)numberOfPointsInCircle), 0, 0, width, 200);
}
