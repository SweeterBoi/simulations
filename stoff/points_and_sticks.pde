public class Point {

  public PVector _pos, _lastPos;
  public boolean isLocked;
  public ArrayList<Stick> _connectedSticks;
  public ArrayList<Point> _connectedPoints;

  public final int SIZE = 3;
  public final float hitboxFactor = 1;

  public Point(PVector pos, boolean lock) {
    _pos = pos;
    _lastPos = pos;
    isLocked = lock;
    _connectedSticks = new ArrayList<Stick>();
    _connectedPoints = new ArrayList<Point>();
  }

  public float x() {
    return _pos.x;
  }

  public float y() {
    return _pos.y;
  }

  public void blit() {
    color c = isLocked ? color(255, 180, 180) : color(255, 255, 255);
    fill(c);
    noStroke();
    ellipseMode(CENTER);
    ellipse(x(), y(), SIZE, SIZE);
  }

  public void removeSelf(ArrayList<Point> points, ArrayList<Stick> sticks) {
    for (int i = 0; i < points.size(); i++) {
      Point p = points.get(i);
      if (!this.equals(p)) {
        p._connectedPoints.remove(this);
        for (int j = 0; j < _connectedSticks.size(); j++) {
          Stick s = _connectedSticks.get(j);
          if (p._connectedSticks.contains(s)) {
            p._connectedSticks.remove(s);
          }
          sticks.remove(s);
        }
      }
    }
    points.remove(this);
  }
}

/**
*
*
 */
public class Stick {

  public Point startPoint, endPoint;
  public final float length;
  public final color strokeColor = color(255, 80, 80);

  public Stick(Point a, Point b) {
    startPoint = a;
    endPoint = b;
    length = calc.dist(a._pos, b._pos);
  }

  public void blit() {
    stroke(strokeColor);
    strokeWeight(1);
    line(startPoint.x(), startPoint.y(), endPoint.x(), endPoint.y());
  }
}
