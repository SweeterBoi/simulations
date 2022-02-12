class LoadingBar {
    
    int _min = 0;
    int _max;
    int _progress = 1;
    PVector _pos;
    float _width = 3 * width / 4;
    int _height = 30;
    float perc = 0;
    private boolean isDone = false;
    
    public LoadingBar(int max) {
        _max = max;
        _pos = new PVector(width / 2 - _width / 2, height / 2 - _height / 2);
    }
    
    void update(int progress) {
        _progress = progress;
        if (_progress >= _max) {
            isDone = true;
        }
    }
    
    void plusPlus() {
        _progress += 1;
        if (_progress >= _max) {
            isDone = true;
        }
    }
    
    void setMax(int max) {
        _max = max;
    }
    
    boolean isDone() {
        return isDone;
    }
    
    void draw() {
        float percentage = (float) _progress / _max;
        if (percentage >= perc + 10) {
            //println(str(int(round(100 * percentage))) + "%");
            perc = percentage;
        }
        fill(0);
        stroke(255);
        strokeWeight(5);
        rectMode(CORNER);
        rect(_pos.x, _pos.y, _width, _height);
        fill(255);
        noStroke();
        rect(_pos.x, _pos.y,(float) _width * percentage, _height);
        strokeWeight(1);
    }
}