/**
* Klasse beschreibt einen Ball auf dem Bildschirm.
* Der Ball speichert seine Position und Geschwindigkeit in einem PVector.
* Bei Kontakt mit dem Bildschirmrand prallt der Ball ab und ändert seine Farbe
*
* @version 07.02.2022
* @author Max Janik
*/
public class ball {
    
    // Klassenvariablen:
    
    // Position auf dem Bildschirm
    PVector _pos;
    // Geschwindigkeit
    PVector _vel;
    // Größe des Balls
    final int SIZE = 15;
    // Farbe des Balls
    color _color;
    
    /**
    * Konstruktor initialisiert den Ball mit gegebener Position, Geschwindigkeit und Farbe
    *
    * @param pos PVector mit der Position auf dem Bildschirm
    * @param vel Geschwindigkeit des Balls
    * @param c Farbe des Balls
    */
    public ball(PVector pos, PVector vel, color c) {
        _pos = pos;
        _vel = vel;
        _color = c;
    }
    
    /**
    * Konstruktor initialisiert den Ball mit zufälliger Position, zufälliger Geschwindigkeit mit Betrag 1
    * und zufälliger Farbe
    */
    public ball() {
        this(new PVector(random(10, width - 10), random(10, height - 10)),
            new PVector(random( -1,1), random( -1,1)).normalize(),
            color(random(0, 255), random(0, 255), random(0, 255)));
    }
    
    /**
    * Methode zeichnet den Ball auf den Bildschirm
    */
    void draw() {
        fill(_color);
        stroke(255);
        ellipse(_pos.x, _pos.y, SIZE, SIZE);
    }
    
    /**
    * Methode Updated den Ball: Lässt ihn abprallen und bewegt ihn mit der Expliziten Euler Methode
    */
    void update() {
        // Ball prallt links ab, wenn der Ball links angekommen ist und sich weiter nach links bewegen würde
        boolean pralltLinksAb = _pos.x - SIZE / 2 <= 0 && _vel.x < 0;
        // Analog zu oben
        boolean pralltRechtsAb = _pos.x + SIZE / 2 >= width && _vel.x > 0;
        // Wenn der Ball links oder rechts abprallt, ändert die x-Geschwindigkeit die Richtung und die Farbe
        // wird zufällig geändert.
        if (pralltLinksAb || pralltRechtsAb) {
            _vel.x = -_vel.x;
            _color = color(random(0, 255), random(0, 255), random(0, 255));
        }
        
        // Analog zu oben
        boolean pralltObenAb = _pos.y - SIZE / 2 <= 0 && _vel.y < 0;
        // Analog zu oben
        boolean pralltUntenAb = _pos.y + SIZE / 2 >= height && _vel.y > 0;
        // Wenn der Ball oben oder unten abprallt, ändert die y-Geschwindigkeit die Richtung und die Farbe
        // wird zufällig geändert.
        if (pralltObenAb || pralltUntenAb) {
            _vel.y = -_vel.y;
            _color = color(random(0, 255), random(0, 255), random(0, 255));
        }
        //Siehe Explizite Euler Methode
        _pos.x += _vel.x;
        _pos.y += _vel.y;
    }
}