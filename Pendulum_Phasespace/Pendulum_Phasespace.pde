/**
A simple visualisation of a pendulum and its trajecoty in phase space
@author: Max Janik
*/

float initialAngle = 45;    //initial angle of the pendulum from its equillibrium
float initialMomentum = 0;  //initial momentum or rather change of angle



PVector condition = new PVector(initialAngle, initialMomentum); //stores the condition of the pendulum
float length = 100; //length of the pendulums rod
PVector pivot = new PVector(150, 150);  //coordinates of the pivot
ArrayList<PVector> trace = new ArrayList<PVector>();  //list of coordinates on the phaseplane for leaving a trace

void setup() {
  size(600,400);  //size of the window
}

void draw() {
  background(0);
  updatePendulum();
  drawPendulum();
  updatePhasePlot();
  drawPhasePlot();
}

/**
Function updates the conditions of the pendulum each cycle
*/
void updatePendulum() {
  //following clause keeps the angle within +-180 degrees for the phaseplane visualization
  if(condition.x > 180) {
    condition.x -= 360;
  } else if( condition.x < -180) {
    condition.x += 360;
  }
  
  //updates the angle and the momentum
  condition.x += condition.y;
  condition.y += - 0.1 * cos(radians(90-condition.x)); //<>//
}

/**
Function draws the pendulum on screen
*/
void drawPendulum() {
  float headX = pivot.x + length * cos(radians(90-condition.x));
  float headY = pivot.y + length * sin(radians(90-condition.x));
  stroke(255);
  line(pivot.x, pivot.y, headX, headY);
  fill(255);
  ellipseMode(RADIUS);
  ellipse(headX,headY,10,10);
  
}

/**
Function updates the trace List to keep track of the phaseplane trajectory
*/
void updatePhasePlot() {
  //Only stores a certain amount of points so the movement is still visible
  if(trace.size() >= 100) {
    trace.remove(0);
  }
  //adds current position in phasespace to the List
  trace.add(new PVector(condition.x, condition.y));
}

/**
Function draws the phasediagram on the screen
*/
void drawPhasePlot() {
  stroke(255);
  line(350, 200, 550, 200);
  line(450, 100, 450, 300);
  stroke(color(255, 100, 100));
  //mapping of the axes
  //note: still a little bodged ._.
  float maximumMomentum = initialMomentum+5;
  float maximumAngle = initialAngle + 10*maximumMomentum;
  //draws each point on the phasediagram
  for(int i = 0; i< trace.size(); i++) {
  point(450 + map(trace.get(i).x,-maximumAngle,maximumAngle,-80,80), 200 + map(trace.get(i).y,-maximumMomentum,maximumMomentum,-80,80));
  }
}
