//Grid grid;
//Grid cleanGrid;
ArrayList<Metaball> Metaballs = new ArrayList<>();
ArrayList<Grid> grids = new ArrayList<>();

//final static int cellSize = 10;
//final static int cleanCellSize = 1;
final int ballCount = 40; // >1
final int numRes = 25;
int currentRes = 5;

int time = 0;
int counter = 0;

int sum = 0;
int av = 0;

boolean onPause = false;
final static PVector ORIGIN = new PVector(0, 0);

void setup() {
  size(1200, 800);

  //grid = new Grid(cellSize, width/cellSize-4, height/cellSize-4, Metaballs);
  //cleanGrid = new Grid(cleanCellSize, width/cleanCellSize-4, height/cleanCellSize-4, Metaballs);
  for (int i = 1; i < numRes+1; i++) {
    grids.add(new Grid(i, width/i-4, height/i-4, Metaballs));
  }
  for (int i = 0; i < ballCount; i++) {
    PVector pos = new PVector(random(ORIGIN.x, width), random(ORIGIN.y, height));
    PVector vel = new PVector(random(0, 1), random(0, 1)).normalize().mult(2);
    float charge = random(20/log(ballCount), 30/log(ballCount));
    Metaballs.add(new Metaball(pos, vel, charge));
  }
}

void keyPressed() {
  //System.out.println("Pressed: " + str(keyCode));
  if (key == 32) {
    onPause = !onPause;
  } else if (keyCode == 109 || keyCode == 45) {
    if (currentRes < numRes) {
      currentRes += 1;
      sum = 0;
      av = 0 ;
      System.out.println("Current Resolution: " + str(currentRes));
    }
  } else if (keyCode == 107 || keyCode == 521) {
    if (currentRes > 1) {
      currentRes -= 1;
      sum = 0;
      av = 0;
      System.out.println("Current Resolution: " + str(currentRes));
    }
  }
}

void draw() {
  measureTime();
  counter = counter%100;
  counter++;
  background(0);
  if (!onPause) {
    for (int i = 0; i < Metaballs.size(); i++) {
      Metaballs.get(i).update();
    }
  }
  Grid grid = grids.get(currentRes-1);
  grid.update(Metaballs);
  grid.blit();
}

void measureTime() {
  int diff = millis() - time;
  System.out.println("Time needed to render frame: "+str(diff) + "ms");
  time = millis();
  sum += diff;
  av++;
  if (av == 100) {
    System.out.println("Average: "+str(sum/av) + "ms");
    System.out.println("=========================");
    sum = 0;
    av = 0;
  }
}
