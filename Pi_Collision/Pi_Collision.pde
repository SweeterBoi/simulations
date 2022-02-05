/** //<>//
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

void setup() {
  size(800, 500);  //Fenstergroesse
  surface.setResizable(true);  //Erlaubt es, das Fenster zu vergroessern oder zuverkleinern

  final int digits = 1; //gibt die Anzahl der Stellen von Pi an, die 'berechnet' werden sollen; grosse Zahlen verursachen probleme; 0 < digits < 4

  lvl = new level(20, 20, color(0), color(255, 100, 0));  //erstellt das Level, also die Oberfläche

  b1 = new block(lvl.WALL * 4); //Erzeugt den kleineren Block
  b2 = new block(lvl.WALL * 12, 70, .5, (int) Math.pow(100, digits -1));  //Erzeugt den groesseren Block mit masse = 100^digits * m

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
    double vb1 = (2*b2.MASS * b2._velocity + b1._velocity * (b1.MASS - b2.MASS)) / (b1.MASS + b2.MASS);  //berechnet die neue Geschwindigkeit des ersten Blocks
    double vb2 = (2*b1.MASS * b1._velocity + b2._velocity * (b2.MASS - b1.MASS)) / (b1.MASS + b2.MASS);  //berechnet die neue Geschwindigkeit des zweiten Blocks
    
    //Ordnet den Bloecken die neuen Geschwindigkeiten zu
    b1._velocity = vb1;
    b2._velocity = vb2;

    //Rrichtet die Position von Block 1 an der von Block 2 aus, minimiert visuelle gliches bei hoher Masse
    b1._xPosition = Math.floor( b2._xPosition - b1.SIZE)-.2;
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

//==========================================================================================================================================================

//Definition einiger Klassen

//==========================================================================================================================================================


/**
 *Exemplar der Klasse ist ein Block der sich in x-Richtung bewegt.
 *Exemplare besitzen eine X-Position, eine X-Geschwindigkeit
 *Eine Groesse und eine numerische Masse für Stossberechnung
 */
class block {

  public double _xPosition;    //position auf der x-Achse
  public double _velocity;     //geschwindigkeit des Blocks entlang der x-Achse
  public final int SIZE;       //Groesse des Blocks
  public final int MASS;       //masse des Blocks

  /**
   *Konstruktor erzeugt Block wobei alle Parameter angegeben werden
   *
   *@param x X-Position yu Begin
   *@param size Groesse des Blocks
   *@param vel Startgeschwindigkeit
   *@param mass virtuelle Masse des Blocks
   */
  public block(int x, int size, float vel, int mass) {
    _xPosition = x;
    _velocity = vel;
    SIZE = size;
    MASS = mass;
  }

  /**
   *Konstruktor erzeugt Block wobei die Groesse vorbestimmt ist
   *
   *@param x X-Position yu Begin
   *@param size Groesse des Blocks
   *@param vel Startgeschwindigkeit
   *@param mass virtuelle Masse des Blocks
   */
  public block(int x, float vel, int mass) {
    _xPosition = x;
    _velocity = vel;
    SIZE = 50;
    MASS = mass;
  }

  /**
   *Konstruktor erzeugt Block wobei nur die X-Position festgelegt werden kann
   *@param x X-Position yu Begin
   *@param size Groesse des Blocks
   *@param vel Startgeschwindigkeit
   *@param mass virtuelle Masse des Blocks
   */
  public block(int x) {
    _xPosition = x;
    _velocity = 0;
    SIZE = 50;
    MASS = 1;
  }

  /**
   *Updated den Block und verschiebt ihn entsprechend der Geschwindigkeit
   */
  public void update() {
    if (_xPosition <= lvl.WALL) {
      _velocity = - _velocity;
      _xPosition = lvl.WALL+.1;
      zaehler.increment();
    } else {
      _xPosition -= _velocity;
    }
  }

  /**
   *Zeichnet den Block auf den Bildschirm
   */
  public void blit() {
    rectMode(CORNER);
    fill(255);
    noStroke();
    rect((float) _xPosition, lvl.GROUNDLEVEL - SIZE, SIZE, SIZE);
  }
}
/**
 *Exemplar erzeugt das Level mit Untergrund und Wand
 */
class level {
  public final int YMARGIN;
  public final int WALL;
  private final color BACKGROUNDCOLOR;
  private final color LINECOLOR;
  public int GROUNDLEVEL;

  /**
   *Konstruiert das Spielfeld und gibt sowohl Farbe der Linien als auch
   *die Hintergrungfarbe an. Ausserdem den Abstand von Wand und Boden
   *zum Fensterrand
   *
   *@param xm Abstand des Bodens zum unteren Rand
   *@param ym Abstand der Wand zum linken Rand
   *@param bg Hintergrundfarbe
   *@param ln Farbe der Linien
   */
  public level(int xm, int ym, color bg, color ln) {
    YMARGIN = ym;
    GROUNDLEVEL = height - ym;
    WALL = xm;
    BACKGROUNDCOLOR = bg;
    LINECOLOR = ln;
  }

  /**
   *Zeichnet das Spielfeld auf den Bildschirm
   */
  public void blit() {
    GROUNDLEVEL = height - YMARGIN;
    background(BACKGROUNDCOLOR);
    fill(LINECOLOR);
    stroke(LINECOLOR);
    strokeWeight(3);
    line(WALL, 0, WALL, height);
    line(0, GROUNDLEVEL, width, GROUNDLEVEL);
  }
}

/**
 *Exemplar der Klasse wird benutzt um eine Zahl auf den Bildschirm zu blitten
 *und diese ggf. inkrementell zu erhöhen
 */
class counter {
  public int count;
  public final int XPOS;
  public final int YPOS;

  /**
   *Konstruktor bei dem die Position angegeben wird und count auf 0 gesetzt wird
   *
   *@param x X-Position der Anzeige
   *@param Y-Position der Anzeige
   */
  public counter(int x, int y) {
    count = 0;
    XPOS = x;
    YPOS = y;
  }

  /**
   *Konstruktor bei dem ein Startwert mit angegeben werden kann
   *
   *@param x X-Position der Anzeige
   *@param Y-Position der Anzeige
   @param m Startwert der Anzeige
   */
  public counter(int x, int y, int m) {
    count = m;
    XPOS = x;
    YPOS = y;
  }

  /**
   *Erhöht den Wert count um 1
   */
  public void increment() {
    count++;
  }

  /**
   *Schreibt den Wert von count auf den Bildschirm
   */
  public void blit() {
    rectMode(CENTER);
    textSize(20);
    text(str(count), XPOS, YPOS);
  }
  /**
   *Schreibt den wert von count im Format 1:count auf den Bildschirm
   *Wird für die Anzeige des Massenverhaeltnises der Bloecke benutzt
   */
  public void rblit() {
    rectMode(CENTER);
    textSize(20);
    text("1:"+str(count), XPOS, YPOS);
  }
}
