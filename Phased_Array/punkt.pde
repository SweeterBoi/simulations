/**
* Diese Klasse stellt ein Teichen im Medium dar und wird benutzt um die Welle zu rendern
*
* @version 01.03.2022
*
* @author Max Janik
*/
public class Punkt {
    private PVector _position;
    private float _wert;
    
    /**
    * Instanziert den Punkt an gegebener Position
    *
    * @param position Ortsvektor des Punktes
    */
    public Punkt(PVector position) {
        _position = position;
        _wert = 0;
    }
    
    /**
    * Berechnet den aktuellen Wert des Punktes - also seine Amplitude
    *
    * @param oszillatoren Liste der Oszillatoren, die zur Welle beitragen
    */
    public void update(ArrayList<Oszillator> oszillatoren) {
        _wert = Calc.berechneWert(_position, oszillatoren, millis());
    }
    
    /**
    * Zeichnet den Punkt auf den Bildschrim
    *
    * @param oszillatorZahl Anzahlder Oszillatoren auf dem Bildschirm
    */
    public void draw(int oszillatorZahl) {
        float bildmenge = 2 * oszillatorZahl * Calc.AMPLITUDE;
        stroke(3 * 255 / bildmenge * _wert);
        point(_position.x, _position.y);
    }
}