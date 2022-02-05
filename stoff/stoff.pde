//Liste aller Punkte aud dem Bildschirm
ArrayList<Point> points = new ArrayList<Point>();
//Liste Aller Verbindungen auf dem Bildschirm
ArrayList<Stick> sticks = new ArrayList<Stick>();

//Der letzte angeklickte Punkt
Point lastTarget = null;
//Temporäre Verbindung um neu gezeichneten Stick zu verdeutlichen
Stick tempStick = null;
//Dragged Point
Point draggedPoint = null;


//Stärke der Gravitation pro Timestep
float gravity = .8;
//Stärke der Reibung
float reibungsKoeffizient = 0.95;
//Anzahl der Iterationen bei der Berechnung der Physik
int numIterations = 5;

//Legt fest ob die Zeit eingefroren wird oder nicht
boolean playAnimation = false;


void setup() {
  size(800, 800);
  generateGrid();
}

void generateGrid() {
  float x0 = 50;
  float y0 = 50;
  float distance = 10;
  int sizeX = 70;
  int sizeY = 55;
  for (int i = 0; i < sizeY+1; i++) {
    for (int j = 0; j < sizeX+1; j++) {
      if (i == 0) {
        PVector pos = new PVector(x0 + distance*j, y0 + distance*i);
        points.add(new Point(pos, j%2 == 0));
      } else {
        PVector pos = new PVector(x0 + distance*j, y0 + distance*i);
        points.add(new Point(pos, false));
      }
    }
  }

  for (int i = 0; i < points.size(); i++) {
    Point p = points.get(i);
    for (int j = 0; j < points.size(); j++) {
      Point t = points.get(j);
      float dist = calc.dist(p._pos, t._pos);
      if (dist == distance && !t._connectedPoints.contains(p) && !p._connectedPoints.contains(t)) {
        makeStick(p, t);
      }
    }
  }
}

void mouseClicked() {
  //Vektor mit der Mausposition
  PVector mousePosition = new PVector(mouseX, mouseY);
  if (mouseButton == 37) {
    boolean canPutPoint = true;
    //Iteriert über alle Punkte auf dem Screen
    for (int i = 0; i < points.size(); i++) {
      Point p = points.get(i);
      //Checkt ob die Maus in der Hitbo des Punktes ist
      if (calc.dist(mousePosition, p._pos) <= p.hitboxFactor * p.SIZE) {
        //Wenn der Punkt schon rot (festgesetzt) ist, wird der Punkt gelöscht
        if (p.isLocked) {
          p.removeSelf(points, sticks);
        } else {
          //wenn der Punkt noch nicht rot ist, wird er festgesetzt
          p.isLocked = true;
        }
        canPutPoint = false;
      }
    }
    //Erstellt, falls möglich, einen neuen Punkt
    if (canPutPoint) {
      println("adding new Point at " + str(mouseX) + ", "+ str(mouseY));
      points.add(new Point(mousePosition, false));
    }
  }
}

void mousePressed() {
  //Vektor mit der Mausposition
  PVector mousePosition = new PVector(mouseX, mouseY);
  if (mouseButton == 37) {
    //Iteriert über alle Punkte auf dem Screen
    for (int i = 0; i < points.size(); i++) {
      Point p = points.get(i);
      //Speichert den Punkt über dem man hovert, wenn man den Mousebutton drückt
      if (calc.dist(mousePosition, p._pos) <= p.hitboxFactor* p.SIZE && lastTarget == null) {
        lastTarget = null;//p;
      }
    }
    if (lastTarget != null) {
      tempStick = new Stick(lastTarget, new Point(mousePosition, false));
    }
  } else if (mouseButton == 39) {
    for (int i = 0; i < points.size(); i++) {
      Point p = points.get(i);
      //Speichert den Punkt über dem man hovert, wenn man den Mousebutton drückt
      if (calc.dist(mousePosition, p._pos) <= p.hitboxFactor* p.SIZE && p.isLocked) {
        draggedPoint = null;//p;
      }
    }
  }
}

void mouseDragged() {
  PVector mousePosition = new PVector(mouseX, mouseY);
  if (mouseButton == 37 || true) {
    if ( draggedPoint != null) {
      draggedPoint._pos = mousePosition;
    } else {
      
        for (int i = 0; i < sticks.size(); i++) {
        Stick s = sticks.get(i);
        PVector startPointPos = s.startPoint._pos;
        PVector endPointPos = s.endPoint._pos;
        float dist1 = calc.dist(startPointPos, mousePosition);
        float dist2 = calc.dist(endPointPos, mousePosition);
        float dist3 = calc.dist(startPointPos, endPointPos);

        float epsilon = 1;
        if (dist1 + dist2 - dist3 <= epsilon) {
          sticks.remove(s);
        }
      }
    }
  }
}

void mouseReleased() {
  draggedPoint = null;
  if (lastTarget != null) {
    //Vektor mit der Mausposition
    PVector mousePosition = new PVector(mouseX, mouseY);
    //Iteriert über alle Punkte auf dem Screen
    for (int i = 0; i < points.size(); i++) {
      Point p = points.get(i);
      if (lastTarget._connectedPoints != null && p._connectedPoints != null) {
        boolean mouseOverPoint = calc.dist(mousePosition, p._pos) <= p.hitboxFactor* p.SIZE;
        boolean connectsTwoPoints = !lastTarget.equals(p);
        boolean isNotAlreadyConnected = !lastTarget._connectedPoints.contains(p);
        if (mouseOverPoint && connectsTwoPoints && isNotAlreadyConnected) {
          makeStick(p, lastTarget);
        }
      }
    }
    lastTarget = null;
  }
  tempStick = null;
}

void makeStick(Point p1, Point p2) {
  Stick newStick = new Stick(p2, p1);
  sticks.add(newStick);
  p2._connectedPoints.add(p1);
  p2._connectedSticks.add(newStick);
  p1._connectedPoints.add(lastTarget);
  p1._connectedSticks.add(newStick);
}

void keyPressed() {
  //println(keyCode);
  if (keyCode == 32) {
    playAnimation = !playAnimation;
  }
  if (keyCode == 116) {
    points.clear();
    sticks.clear();
    generateGrid();
  }
}

void draw() {
  background(0);
  if (playAnimation) {
    updateAllItems();
  }
  cleanUp();
  drawAllItems();
}

void cleanUp() {
  for (int i = 0; i < points.size(); i++) {
    Point p = points.get(i);
    if (p.y() > height + 500) {
      points.remove(p);
    }
  }
  for (int i = 0; i < sticks.size(); i++) {
    Stick s = sticks.get(i);
    if (s.startPoint.y() > height + 20*s.length) {
      sticks.remove(s);
    }
  }
}


//Updates all Items (duh)
void updateAllItems() {

  //randomizeLists();


  //Update Points
  for (int i = 0; i < points.size(); i++) {
    Point p = points.get(i);
    if (!p.isLocked) {
      PVector positionBeforeUpdate = p._pos.copy();
      p._pos.x += reibungsKoeffizient*(p._pos.x - p._lastPos.x);
      p._pos.y += reibungsKoeffizient*(p._pos.y - p._lastPos.y);
      p._pos.y += gravity;
      p._lastPos = positionBeforeUpdate;
    }
  }

  //Update Sticks
  for (int k = 0; k < numIterations; k++) {
    for (int i = 0; i < sticks.size(); i++) {
      Stick s = sticks.get(i);
      float x1 = s.startPoint.x() + s.endPoint.x();
      float y1 = s.startPoint.y() + s.endPoint.y();
      PVector stickCentre = new PVector(x1/2, y1/2);
      float x2 = s.endPoint.x() - s.startPoint.x();
      float y2 = s.endPoint.y() - s.startPoint.y();
      PVector stickDir = new PVector(x2, y2).normalize();

      if (!s.startPoint.isLocked) {
        s.startPoint._pos.x = stickCentre.x - stickDir.x * s.length/2;
        s.startPoint._pos.y = stickCentre.y - stickDir.y * s.length/2;
      }
      if (!s.endPoint.isLocked) {
        s.endPoint._pos.x = stickCentre.x + stickDir.x * s.length/2;
        s.endPoint._pos.y = stickCentre.y + stickDir.y * s.length/2;
      }
    }
  }
}

//Randomizes the points- and sticks- lists
void randomizeLists() {
  ArrayList<Point> pTemp = new ArrayList<Point>();
  ArrayList<Stick> sTemp = new ArrayList<Stick>();

  for (int i = 0; i < points.size()+1; i++) {
    int rand = int(random(0, points.size()));
    pTemp.add(points.get(rand));
    points.remove(rand);
  }
  points = pTemp;

  for (int i = 0; i < sticks.size()+1; i++) {
    int rand = int(random(0, sticks.size()));
    sTemp.add(sticks.get(rand));
    sticks.remove(rand);
  }
  sticks = sTemp;
}
//Draws all Items on the Screen
void drawAllItems() {
  //Draw Sticks
  for (int i = 0; i < sticks.size(); i++) {
    Stick s = sticks.get(i);
    s.blit();
  }
  //Draw and Update tempStick
  if (tempStick != null) {
    tempStick.endPoint._pos.x = mouseX;
    tempStick.endPoint._pos.y = mouseY;
    tempStick.blit();
  }
  //Draw points
  for (int i = 0; i < points.size(); i++) {
    Point p = points.get(i);
    p.blit();
  }
}
