ArrayList<Fish> School = new ArrayList<Fish>();

final String playField = "ENDLESS"; //ENDLESS or BORDER;
final float speed = 0.5;
final int passingChance = 10000;
final int range = 100;
final int num = 4000;

void setup() {
  size(600, 600);
  smooth();
  ellipseMode(CENTER);
  int fac = 10;
  for (int i = 0; i < sqrt(num); i++) {
    for (int j = 0; j < sqrt(num); j++) {
      int x = fac * (1 +i);
      int y = fac * (1 +j);
      PVector pos = new PVector(x, y);
      PVector vel = new PVector(random(-3, 3), random(-3, 3)).normalize();
      School.add(new Fish(pos, vel, fac/2, 0, true, 255));
    }
  }
}


void draw() {
  background(0);
  for (Fish f : School) {
    f.update();
    f.blit();
    f.execute();
  }
}
