//Anzahl der Vögel die zu Beginn generiert werden sollen
int num = 100;
//Diese Liste merkt sich die individuellen Vögel, die zum Schwarm gehören
ArrayList<Bird> schwarm = new ArrayList<Bird>();
//Sichtweite der Vögel
float visualRange = 5;
//relative einheit für Dichte des Schwarms
float schwarmDichte = 100;
//größe der Vögel
int vogelGroesse = 5;

void setup() {
  size(900, 600);  //Bild- breite und höhe
  noStroke();      //Formen haben keine Umrisslinien (optional)

  //Loop erzeugt für die oben angegeben Zahl je einen Vogel und fügt ihn zum Schwarm hinzu
  for (int i = 0; i < num; i++) {
    schwarm.add(neuerZufallsVogel());  //fügt der Liste Schwarm einen neuen Vogel hinzu, der in "neuerZufallsVogel()" generiert wird
  }
}


void draw() {
  background(0);  //Macht den Hintergrund schwarz
  PVector schwerpunkt = getMeanPosition(schwarm);
  PVector meanDir = getMeanVelocity(schwarm);
  for (Bird vogel : schwarm) {  //nimmt nach einander jedes Element in der Liste schwarm und weist ihn der Variable vogel zu
    turnToMean(vogel, schwerpunkt);
    //velocityToMean(vogel, meanDir, schwerpunkt);
    noCollision(vogel, visualRange);
    beispielRegeln(vogel);  //Beispielfunktion, damit Du eien Überblick bekommst, wi Du vorgehen könntest
    vogel.move();  //bewegt den gerade ausgewählten Vogel
    vogel.blit();  //zeichnet den Vogel auf den Bildschirm
  }
}

//Diese Funktion erzeugt einen neuen Vogel mit zufälligen Parametern
Bird neuerZufallsVogel() {  //Bird bedeutet hier, dass die Funktion einen Vogel zurückgibt
  PVector pos = new PVector(random (10, width-10), random(10, height-10));  //zufällige Posizion
  PVector vel = new PVector(random(-10, 10), random(-10, 10));    //zufällige Blickrichtung
  vel.normalize();  //Der Pfeil, der din die Plickrichtung zeigt bekommt die länge 1. Wichtig, da eine anderer Parameter die geschwindigkeit regelt
  float speed = 1;  //Geschwindigkeit des Vogels
  color farbe = color(50, 180, 255); //Farbe des Vogels in RGB Werten angegeben
  return new Bird(pos, vel, speed, vogelGroesse, farbe);  //Gibt den Vogel zurück
}

//Verhindert, dass Vögel den Bildschirm verlassen
void beispielRegeln(Bird vogel) {
  PVector position = vogel.getPosition();
  PVector richtung = vogel.getRichtung();

  if ((position.x <= 0 && richtung.x < 0) || (position.x >= width && richtung.x > 0)) {
    vogel.setRichtung(-richtung.x, richtung.y);
  }
  if ((position.y <= 0 && richtung.y < 0) || (position.y >= height && richtung.y > 0)) {
    vogel.setRichtung(richtung.x, -richtung.y);
  }
}

//Vögel richten sich zur Durchschnittsposition des Schwarms aus, wenn sie weit genug von dieser entfernt sind
void turnToMean(Bird Vogel, PVector meanPosition) {
  PVector position = Vogel.getPosition();
  float dist = sqrt(pow(position.x-meanPosition.x, 2) + pow(position.y-meanPosition.y, 2));
  if (dist >= schwarmDichte) {
    Vogel.setRichtung(meanPosition.x - position.x, meanPosition.y - position.y);
  }
}

//Gibt die Durchschnittsposition der Elemente einer Liste mit Vögeln als PVektor zurück
PVector getMeanPosition(ArrayList<Bird> birds) {
  float xSum = 0;
  float ySum = 0;
  for (Bird v : birds) {
    xSum += v.getPosition().x;
    ySum += v.getPosition().y;
  }
  float xAverage = (float) xSum/birds.size();
  float yAverage = (float) ySum/birds.size();
  point(xAverage, yAverage);
  return new PVector(xAverage, yAverage);
}

//Verhindert, dass Vögel mit einander kollidieren
void noCollision(Bird vogel, float range) {
  ArrayList<Bird> inRange = new ArrayList<Bird>();
  ArrayList<Float> distList = new ArrayList<Float>();
  for (Bird target : schwarm) {
    if (!vogel.equals(target)) {
      float dist = sqrt(pow(vogel.getPosition().x - target.getPosition().x, 2) + pow(vogel.getPosition().y - target.getPosition().y, 2));
      if (dist <= range) {
        inRange.add(target);
        distList.add(dist);
      }
    }
  }

  if (inRange.size() > 0) {
    float xSum = 0;
    float ySum = 0;
    for (int i = 0; i < inRange.size(); i++) {
      xSum += inRange.get(i).getPosition().x;
      ySum += inRange.get(i).getPosition().y;
    }
    float xAverage = xSum/inRange.size();
    float yAverage = ySum/inRange.size();
    PVector position = vogel.getPosition();
    vogel.setRichtung((position.x-xAverage), (position.y-yAverage));
  }
}

PVector getMeanVelocity(ArrayList<Bird> list) {
  float xSum = 0;
  float ySum = 0;
  for (Bird target : list) {
    PVector richtung = target.getRichtung();
    xSum += richtung.x;
    ySum += richtung.y;
  }
  float xAverage = (float) xSum/list.size();
  float yAverage = (float) ySum/list.size();
  return new PVector(xAverage, yAverage);
}

void velocityToMean(Bird vogel, PVector newDirection, PVector meanPosition) {
  PVector position = vogel.getPosition();
  float dist = sqrt(pow(position.x-meanPosition.x, 2) + pow(position.y-meanPosition.y, 2));
  if (dist <= schwarmDichte) {
    vogel.setRichtung(newDirection);
  }
}
