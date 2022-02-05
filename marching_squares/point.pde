class Point {
  
  public PVector _pos;
  public boolean _isOn;
  public float value;
  private final color ONCOLOR = color(180, 255, 160);
  private final color OFFCOLOR = color (150, 140, 255);
  private final float SIZE = 3;
  
  public Point(PVector pos, ArrayList<Metaball> balls) {
    _pos = pos;
    update(balls);
  }
  
  
  public void blit() {
    color c = _isOn ? ONCOLOR : OFFCOLOR;
    stroke(c);
    point(_pos.x, _pos.y);
  }
  public void update(ArrayList<Metaball> balls) {
    value = Calc.gradientField(_pos, balls);
    _isOn = value >= 1;
  }
}
