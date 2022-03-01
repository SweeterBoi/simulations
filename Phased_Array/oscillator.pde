/**
* Die Klasse stellt einen Oszillator dar, der Kugelwellen aussendet.
*
* @version 01.03.2022
*
* @author Max Janik
*/
public class Oszillator {
    private final int SIZE = 20;
    private PVector _position;
    private float _phase;
    private float _frequenz;
    
    /**
    * Instanziert den Oszillator an gegebener Position mit gegebener Frequenz
    *
    * @param position Position des Oszillators
    * @param frequenz Frequenz des Oszillators
    */
    public Oszillator(PVector position, float frequenz) {
        _position = position;
        _frequenz = frequenz;
        _phase = 0;
    }
    
    /**
    * Ändert die Phase des Oszillators
    *
    * @param phase Neue Phase des Oszillators
    */
    public void setzePhase(float phase) {
        _phase = phase;
    }
    
    /**
    * Zeichnet den OSzillator auf den Bildschirm
    */
    public void draw() {
        ellipse(_position.x, _position.y, SIZE, SIZE);
    }
}