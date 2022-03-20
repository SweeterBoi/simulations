public class Boundary {
    private PVector _start;
    private PVector _end;
    
    Boundary(PVector start, PVector end) {
        _start = start;
        _end = end;
    }
    
    void draw() {
        line(_start.x, _start.y, _end.x, _end.y);
    }
    
    public PVector start() {
        return _start.copy();
    }
    
    public PVector end() {
        return _end.copy();
    }
}