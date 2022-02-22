class Point {
    PVector _pos;
    boolean isInCircle;
    int size = 5;
    
    public Point(float x, float y, boolean isincircle) {
        _pos = new PVector(x, y);
        isInCircle = isincircle;
    }
    
    public void blit() {
        point(_pos.x, _pos.y);
    }  
}
