public class Punkt {
    private PVector _position;
    private float _wert;
    
    public Punkt(PVector position) {
        _position = position;
        _wert = 0;
    }
    
    public void update(ArrayList<Oszillator> oszillatoren) {
        _wert = Calc.berechneWert(_position, oszillatoren, millis());
    }
    
    public void draw(int oszillatorZahl) {
        float bildmenge = 2 * oszillatorZahl * Calc.AMPLITUDE;
        float rot = (255 - 50) / bildmenge * _wert;      // Minimalwert = 50, Maximalwert = 255
        float gruen = (220 - 80) / bildmenge * _wert;    // Minimalwert = 80, Maximalwert = 220
        float blau = (200 - 70) / bildmenge * _wert;     // Minimalwert = 70, Maximalwert = 200
        color c = color(rot, gruen, blau);
        //c = (_wert > 0) ? color(255,255,280) : color(0, 0, 0);
        stroke(3 * 255 / bildmenge * _wert);
        point(_position.x, _position.y);
    }
}