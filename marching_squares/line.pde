class Line {
  PVector _start;
  PVector _end;
  private final color COLOR = color(180, 255, 160);
  
  public Line(PVector start, PVector end) {
    _start = start;
    _end = end;
  }
  
  void blit() {
    stroke(COLOR);
    line(_start.x, _start.y, _end.x, _end.y);
  }
  
}
