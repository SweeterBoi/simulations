class Cell {

  ArrayList<Point> _points = new ArrayList<>();
  ArrayList<Boolean> _table = new ArrayList<>();
  Point _center;
  float _size;
  ArrayList<Line> _line = new ArrayList<>();

  public Cell(PVector center, float size, ArrayList<Point> points,ArrayList<Metaball> balls) {
    _size = size;
    _center = new Point(center, balls);
    //points are generarted in a Z pattern
    Point p1 = new Point(new PVector(center.x - size/2, center.y - size/2),balls);
    Point p2 = new Point(new PVector(center.x + size/2, center.y - size/2), balls);
    Point p3 = new Point(new PVector(center.x - size/2, center.y + size/2), balls);
    Point p4 = new Point(new PVector(center.x + size/2, center.y + size/2), balls);
    points.add(p1);
    points.add(p2);
    points.add(p3);
    points.add(p4);
    points.add(_center);
    _points.add(p1);
    _points.add(p2);
    _points.add(p3);
    _points.add(p4);
    for (int i = 0; i < 4; i++) {
      _table.add(false);
    }
  }

  public void blit() {
    if (_line.size() > 0) {
      for (int i = 0; i < _line.size(); i++) {
        _line.get(i).blit();
      }
    }
  }
  
  
  public void update(ArrayList<Metaball> balls) {
    for (int i = 0; i < _points.size(); i++) {
      //_points.get(i).blit();
      _points.get(i).update(balls);
      _center.update(balls);
    }
    for (int i = 0; i < _points.size(); i++) {
      _table.set(i, _points.get(i)._isOn);
    }
    makeLine();
  }
  
  
  public void makeLine() {
    int type = Calc.lookup(_table, _center._isOn);
    _line.clear();
    if (type == 1 || type == 2) {
      _line.add(new Line(new PVector(_center._pos.x - _size/2, _center._pos.y), new PVector(_center._pos.x, _center._pos.y - _size/2)));
    } else if (type == 3 | type == 4) {
      _line.add(new Line(new PVector(_center._pos.x, _center._pos.y - _size/2), new PVector(_center._pos.x + _size/2, _center._pos.y)));
    } else if (type == 5 || type == 6) {
      _line.add(new Line(new PVector(_center._pos.x - _size/2, _center._pos.y), new PVector(_center._pos.x, _center._pos.y + _size/2)));
    } else if (type == 7 | type == 8) {
      _line.add(new Line(new PVector(_center._pos.x, _center._pos.y + _size/2), new PVector(_center._pos.x + _size/2, _center._pos.y)));
    } else if (type == 11 || type == 12) {
      _line.add(new Line(new PVector(_center._pos.x, _center._pos.y - _size/2), new PVector(_center._pos.x, _center._pos.y + _size/2)));
    } else if (type == 9 || type == 10) {
      _line.add(new Line(new PVector(_center._pos.x - _size/2, _center._pos.y), new PVector(_center._pos.x + _size/2, _center._pos.y)));
    } else if (type == 13) {
      _line.add(new Line(new PVector(_center._pos.x, _center._pos.y - _size/2), new PVector(_center._pos.x + _size/2, _center._pos.y)));
      _line.add(new Line(new PVector(_center._pos.x - _size/2, _center._pos.y), new PVector(_center._pos.x, _center._pos.y + _size/2)));
    } else if (type == 14) {
      _line.add(new Line(new PVector(_center._pos.x - _size/2, _center._pos.y), new PVector(_center._pos.x, _center._pos.y - _size/2)));
      _line.add(new Line(new PVector(_center._pos.x + _size/2, _center._pos.y), new PVector(_center._pos.x, _center._pos.y + _size/2)));
    }
  }
}
