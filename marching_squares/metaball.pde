/**
* Klasse repräsentiert einen Metaball, der sich über den Bildschirm bewegt und vom Rand abprallt
*
* @version 10.02.2022
* @author Max Janik
*/
class Metaball {
    
    // Position des Metaballs
    private PVector _pos;
    // Geschwindigkeitsvektor des Metaballs
    private PVector _vel;
    // Ladung des Metaballs, wird benutzt um Potenzialfeld zu berechnen
    private float _charge;
    // Letzter Zeitpunkt, zu dem die Position des Metaballs aktualisiert wurde
    private int _lastUpdateTime;
    
    /**
    * Konstruktor initialisiert den Metaball
    *
    * @param pos initiale Position des Metaballs
    * @param vel Geschwindigkeitsvektor des Metaballs
    * @param charge Ladung des Metaballs
    */
    public Metaball(PVector pos, PVector vel, float charge) {
        _pos = pos;
        _vel = vel;
        _charge = charge;
        _lastUpdateTime = millis();
    }
    
    /**
    * Updated den Metaball; ändertdie Richtung des Balls wenn er am Rand abprallt und aktualisiert die Position des Balls
    */
    public void update() {
        if (x() <= ORIGIN.x + _charge * 2 && _vel.x < 0) {
            _vel.x= -_vel.x;
        } else if (x() >= width - _charge * 2 && _vel.x > 0) {
            _vel.x= -_vel.x;
        }
        if (y() <= ORIGIN.y + _charge * 2 && _vel.y < 0) {
            _vel.y= -_vel.y;
        } else if (y() >= height - _charge * 2 && _vel.y > 0) {
            _vel.y= -_vel.y;
        }
        int time = millis();
        float deltaT = time - _lastUpdateTime;
        _lastUpdateTime = time;
        _pos.x += (_vel.x * Calc.timestep * deltaT);
        _pos.y += (_vel.y * Calc.timestep * deltaT);
    }
    
    /**
    * Zeichnet den Metaball auf den Bildschirm    
    */
    private void blit() {
        ellipse(x(), y(), 5, 5);
    }
    
    /**
    * Gibt die x-Position des Metaballs zurück
    *
    * @return x-Position des Metaballs als float
    */
    private float x() {
        return _pos.x;
    }
    
    /**
    * Gibt die y-Position des Metaballs zurück
    *
    * @return y-Position des Metaballs als float
    */
    private float y() {
        return _pos.y;
    }
    
    /**
    * Gibt die Ladung des Metaballs zurück
    *
    * @return Ladung des Metaballs als float
    */
    private float charge() {
        return _charge;
    }
}
