/**
* Klasse stellt einen Echpunkt des Rasters dar.
*
* @version 10.02.2022
* @author Max Janik
*/
class Point {
    // Position des Punktes
    public PVector _pos;
    // Speichert ob der Punkt an ist oder nicht
    public boolean _isOn;
    // Wert des Skalarfeldes an diesem Punkt
    public float value;
    // Farbe des Punktes wenn der Punkt an ist
    private final color ONCOLOR = color(180, 255, 160);
    // Farbe des Punktes wenn der Punkt aus ist
    private final color OFFCOLOR = color(150, 140, 255);
    
    /**
    * Instanziert den Punkt an der Position
    *
    * @param pos Position des Punktes
    */
    public Point(PVector pos) {
        _pos = pos;
    }
    
    /**
    * Zeichnet den Punkt auf den Bildschirm
    */
    public void blit() {
        color c = _isOn ? ONCOLOR : OFFCOLOR;
        stroke(c);
        point(_pos.x, _pos.y);
    }
    
    /**
    * Aktualisiert den Wert des Puktes und schaltet ihn ein bzw. aus, wenn der Wert über bzw unter 1 liegt
    */
    public void update(ArrayList<Metaball> balls) {
        value = Calc.scalarField(_pos, balls);
        _isOn = value >= 1;
    }
}
