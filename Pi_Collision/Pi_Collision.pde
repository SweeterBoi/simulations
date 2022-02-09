/**
*Zwei Bloecke stossen, wobei die Anzahl der Stoesse den Ziffern
*von Pi entspricht
*
*author Max Janik
*version 25.12.2019
*/

//Die Bloecke:
block b1; //Block 1
block b2; //Block 2
level lvl; //Das Level
//Die Anzeigen:
counter zaehler; //Zaehlt die Stoesse 
counter masse;   //Zeigt das Massenverhaeltnis

float timeStep = 1;

void setup() {
    size(800, 500);  //Fenstergroesse
    surface.setResizable(true);  //Erlaubt es, das Fenster zu vergroessern oder zuverkleinern
    
    final int digits = 4; //gibt die Anzahl der Stellen von Pi an, die 'berechnet' werden sollen; grosse Zahlen verursachen probleme; 0 < digits < 4
    
    lvl = new level(20, 20, color(0), color(255, 100, 0));  //erstellt das Level, also die Oberfläche
    
    b1 = new block(lvl.WALL * 4); //Erzeugt den kleineren Block
    b2 = new block(lvl.WALL * 7, 80,.1,(int) Math.pow(100, digits - 1));  //Erzeugt den groesseren Block mit masse = 100^digits * m
    
    zaehler = new counter(30, 50);  //Erzeugt den Zähler, der die Stoesse anzeigt
    masse = new counter(200, 50, b2.MASS);  //Erzeugt das Schild, das das Massenverhaeltnis anzeigt
}

/**
* Der Loop, der die Simulation ausführt
*/
void draw() {
    
    //KollisionsAbfrage der Blöcke (stossen vollkommen elastisch und zentral)
    boolean aufprall = b2._xPosition - b1._xPosition <= b1.SIZE; //true, wenn die Bloecke Aufeinander prallen, false sonst
    if (aufprall) {
        double vb1 = (2 * b2.MASS * b2._velocity + b1._velocity * (b1.MASS - b2.MASS)) / (b1.MASS + b2.MASS);  //berechnet die neue Geschwindigkeit des ersten Blocks
        double vb2 = (2 * b1.MASS * b1._velocity + b2._velocity * (b2.MASS - b1.MASS)) / (b1.MASS + b2.MASS);  //berechnet die neue Geschwindigkeit des zweiten Blocks
        
        //Ordnet den Bloecken die neuen Geschwindigkeiten zu
        b1._velocity = vb1;
        b2._velocity = vb2;
        
        //Rrichtet die Position von Block 1 an der von Block 2 aus, minimiert visuelle gliches bei hoher Masse
        b1._xPosition = Math.floor(b2._xPosition - b1.SIZE) - .2;
        //Erhoeht den Zaehler, da ein Stoss ausgefuehrt wurde
        zaehler.increment();
    } else {
        //Bewegt die Bloecke
        b1.update();
        b2.update();
    }
    
    
    //Mahlt erst das Level, dann die beiden Zaehler und dann die Bloecke
    lvl.blit();
    zaehler.blit();
    masse.rblit();
    b1.blit();
    b2.blit();
}