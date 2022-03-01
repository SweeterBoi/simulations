public class Oszillator {
    private final int SIZE = 20;
    private PVector _position;
    private float _phase;
    private float _frequenz;
    
    public Oszillator(PVector position, float phase, float frequenz) {
        _position = position;
        _phase = phase;
        _frequenz = frequenz;
    }
    
    public float phase() {
        return _phase;
    }
    public void setzePhase(float phase) {
        _phase = phase;
    }
    public double frequenz() {
        return _frequenz;
    }
    public void setzeFrequenz(float frequenz) {
        _frequenz = frequenz;
    }
    
    public void draw() {
        ellipse(_position.x, _position.y, SIZE, SIZE);
    }
}