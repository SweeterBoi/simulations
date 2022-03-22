/**
* Klasse stellt einen Lichtstrahl dar
*
* @version 22.03.2022
* @author Max Janik
*/
public class Ray {
    // Position des Strahls
    private PVector _pos;
    // Richtung des Strahls
    private PVector _dir;
    
    /**
    * Instanziert den Strahl mit Position und Richtung
    *
    * @param pos Position des Strahls als PVector
    * @param dir Richtung des Strahls als PVector
    */
    public Ray(PVector pos, PVector dir) {
        _pos = pos;
        _dir = dir;
        _dir.normalize();
    }
    
    /**
    * Zeichnet den Strahl auf den Bildschirm
    */
    public void draw() {
        float fac = 100;
        line(_pos.x, _pos.y, _pos.x + fac * _dir.x, _pos.y + fac * _dir.y);
    }
    
    /**
    * Methode findet Schnittpunkt mit einem Hindernis und gibt diesen Falls vorhanden zurück, andernfalls wird Null zurückgegeben
    *
    * @param b Boundary auf der der Schnittpunkt gesucht werden soll
    *
    * @return PVector mit Schnittpunkt, Null falls dieser nicht existiert
    */
    public PVector cast(Boundary b) {
        float x1 = b.start().x;
        float y1 = b.start().y;
        float x2 = b.end().x;
        float y2 = b.end().y;
        
        float x3 = _pos.x;
        float y3 = _pos.y;
        float x4 = _pos.x + _dir.x;
        float y4 = _pos.y + _dir.y;
        
        float nenner = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
        if (nenner == 0) {
            return null;
        }
        float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / nenner;
        float u = ((x1 - x3) * (y1 - y2) - (y1 - y3) * (x1 - x2)) / nenner;
        if (t >= 0  &&  t <= 1.0 && u >= 0) {
            return new PVector(x1 + t * (x2 - x1),y1 + t * (y2 - y1));
        }
        return null;
    }
}