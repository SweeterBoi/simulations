/**
* Exemplar der Klasse ist ein Vogel, der durch ein Dreieck auf dem Bildschirm repräsentiert wird.
*/
class Bird {

  //Position des Vogels. (0,0) ist die obere linke Ecke. x wird nach rechts größer, y wird nach unten größer
  private PVector _position;
  //gibt die richtung an, in die der Vogel zeigt. die länge des Pfeils (Vectors) muss mit .normalize() immer auf 1 gesetzt werden (siehe unten).
  private PVector _richtung;
  //gibt die geschwindigkeit des Vogels an
  private float _geschwindigkeit;
  //bestimmt die größe des Vogels
  private final int GROESSE;
  //Farbe des Vogels
  private final color FARBE;

  /**
  *  Erzeugt einen neuen Vogel
  *
  * @param position          Vektor der die Position des Vogels auf dem Bildschirm zu Beginn angibt
  * @param richtung          Vektor der angibt in welche Richtung der Vogel zu Beginn schaut
  * @param geschwindigkeit   Geschwindigkeit, mit der sich der Vogel fortbewegen wird
  * @param groesse           Größe des Vogels. Kann nicht mehr verändert werden.
  * @param farbe             Farbe des Vogels. Kann nicht mehr verändert werden.    entweder color(r,b,g) mit r,b,g von 0 bis 255 oder nur 0-255 für graustufen
  */
  public Bird(PVector position, PVector richtung, float geschwindigkeit, int groesse, color farbe) {
    _position = position;
    _richtung = richtung;
    _geschwindigkeit = geschwindigkeit;
    GROESSE = groesse;
    FARBE = farbe;
  }

  /**
  * Gibt die aktuelle position als Vektor zurück
  *
  * @return PVector mit der Position. return.x ist die X-Position, return.y ist die Y-Position
  */
  public PVector getPosition() {
    return _position;
  }
  
  /**
  * Gibt die Blickrichtung des Vogels zurück
  *
  * @return PVector mit der Blickrichtung
  */
  public PVector getRichtung() {
    return _richtung;
  }
  
  /**
  * Gibt die aktuelle Geschwindigkeit des Vogels zurück
  *
  * @return float mit der Geschwindigkeit
  */
  public float getGeschwindigkeit() {
    return _geschwindigkeit;
  }
  
  /**
  * Gibt die Größe des Vogels zurück
  *
  * @return int mit der Größe des Vogels
  */
  public int getGroesse() {
    return GROESSE;
  }

  /**
  * Bewegt den Vogel um die Geschwindigkeit des Vogels in Blickrichtung des Vogels
  */
  public void move() {
    _position.x += _geschwindigkeit * _richtung.x;  //Ändert die X-Position
    _position.y += _geschwindigkeit * _richtung.y;  //Ändert die Y-Position
  }

  /**
  * Erlaubt es Dir die Richtug des Vogels mittels eines Vectors zu ändern
  *
  * @param PVector mit neuer Richtung
  */
  public void setRichtung(PVector newR) {
    _richtung = newR;
    _richtung.normalize();    //Setzt den Richtungspfeil auf die Länge 1 (damit nur die _geschwindigkeit die Geschwindigkeit beeinflusst
  }
  
  /**
  * Erlaubt es Dir die Richtug des Vogels mittels mit individuelle Verten zu ändern
  *
  * @param x die neue X-Richtung
  * @param y die neue Y-Richtung
  */
  public void setRichtung(float x, float y) {
    _richtung.x = x;
    _richtung.y = y;
    _richtung.normalize();    //Setzt den Richtungspfeil auf die Länge 1 (damit nur die _geschwindigkeit die Geschwindigkeit beeinflusst
  }
  
  /**
  * Erlaubt es dir die Geschwindigkeit des Vogels zu verändern
  *
  * @param speed neue Geschwindigkeit des Vogels
  */
  public void setSpeed(float speed) {
    if(speed < 0)
    {
      speed = - speed;  //Stellt sicher, dass die Geschwindigkeit positiv ist (keine rückwärts fliegenden Vögel, bitte)
    }
    
    if(speed != 0) {  //Stellt sicher, dass die neue Geschwindigkeit nicht null ist (im Flug stehenbleiben ist nicht gesund!)
    _geschwindigkeit = speed;
    }
  }
  
  
  /**
  * Zeichent den Vogel auf den Bildschirm indem die Eckpunkte des Dreiecks auf einen Kreis gemalt werden
  * Diese Funktion funktioniert wie sie soll und muss zur Lösung der Aufgabe nicht bearbeitet werden.
  * Je nachdem wie weit ihr im Matheunterricht seid kannst Du dir ja trotzdem überlegen was da genau passiert
  */
  public void blit() {
    float _phi = atan((_richtung.y/_richtung.x)); //Bestimmt den Winkel des ersten Punktes auf dem Kreis aus der Blickrichtung
    if (_richtung.x < 0) {
      _phi = _phi + PI;  //Dreht den Vogel um 180° wenn er nach links fliegt damit er nicht rückwärts fliegt (Warum das nötig ist ist eine interessante Frage. Für die Beantwortung gibt es Respekt ud Anerkennung :D)
    }
    float k = 1.5; //Streckungsfaktor, der die vordere Spitze etwas nach vorne zieht (dann sieht mal leichter wohin der Vogel fliegt
    float l = 0.5 * sqrt(pow(GROESSE, 2) + pow (GROESSE/2, 2)); //Radius des Kreises, auf dem die Eckpunkte liegen
    //Position der Punkte auf dem Kreis mit Hilfe der trigonometrischen Funktionen
    float x1 = _position.x + cos(_phi) * k * l;         
    float y1 = _position.y + sin(_phi) * k * l; 
    float x2 = _position.x + cos(_phi+TWO_PI/3) * l; 
    float y2 = _position.y + sin(_phi+TWO_PI/3) * l; 
    float x3 = _position.x + cos(_phi+2*TWO_PI/3) * l; 
    float y3 = _position.y + sin(_phi+2*TWO_PI/3) * l; 
    //Füllt den Vogel mit Farbe
    fill(FARBE); 
    //Malt das Dreieck mit den Koordinaten der Eckpunkte auf den Bildschirm
    triangle(x1, y1, x2, y2, x3, y3);
  } 
}