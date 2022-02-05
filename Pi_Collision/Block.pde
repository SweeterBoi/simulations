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