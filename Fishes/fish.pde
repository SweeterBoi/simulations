class Fish {

  public PVector _pos; 
  public PVector _vel; 
  public int _size; 
  public float _phi; 
  public boolean _type;
  public color _col;

  Fish(PVector pos, PVector vel) {
    _pos = pos; 
    _vel = vel; 
    _size = 30; 
    _phi = 0;
    _col = 255;
    _type = false;
  }

  Fish(PVector pos, PVector vel, int size) {
    this(pos, vel); 
    _size = size;
  }

  Fish(PVector pos, PVector vel, float phi) {
    this(pos, vel); 
    _phi = phi;
  }

  Fish(PVector pos, PVector vel, boolean type) {
    this(pos, vel); 
    _type = type;
  }

  Fish(PVector pos, PVector vel, int size, float phi, boolean type, color col) {
    this(pos, vel); 
    _size = size; 
    _phi = phi;
    _type = type;
    _col = col;
  }

  void blit() {
    if (_type) {
      float k = 1.5; 
      float l = 0.5 * sqrt(pow(_size, 2) + pow (_size/2, 2)); 
      float x1 = _pos.x + cos(_phi) * k * l; 
      float y1 = _pos.y + sin(_phi) * k * l; 
      float x2 = _pos.x + cos(_phi+TWO_PI/3) * l; 
      float y2 = _pos.y + sin(_phi+TWO_PI/3) * l; 
      float x3 = _pos.x + cos(_phi+2*TWO_PI/3) * l; 
      float y3 = _pos.y + sin(_phi+2*TWO_PI/3) * l; 
      fill(255); 
      triangle(x1, y1, x2, y2, x3, y3);
    } else {
      fill(_col); 
      ellipse(_pos.x, _pos.y, _size, _size);
    }
  }

  void update() {
    float ratio = (_vel.y/_vel.x); 
    _phi = atan(ratio); 

    if (_vel.x < 0) {
      _phi = _phi + PI;
    }

    _pos.x += speed*_vel.x; 
    _pos.y += speed*_vel.y;
    if (playField == "BORDER") {
      if ((_pos.x >= width && _vel.x > 0) || (_pos.x <= 0 && _vel.x < 0)) {
        _vel.x = - _vel.x;
      } else if ((_pos.y >= height && _vel.y > 0) || (_pos.y <= 0 && _vel.y < 0)) {
        _vel.y = - _vel.y;
      }
    } else if (playField == "ENDLESS") {
      if (_pos.x > width) {
        _pos.x = 0;
      } else if (_pos.x < 0) {
        _pos.x = width;
      }
      if (_pos.y > height) {
        _pos.y = 0;
      } else if (_pos.y < 0) {
        _pos.y = height;
      }
    }
  }

  void execute() {
    if (_type) {
      int rand = (int) random(0, passingChance); 
      if (rand == 0) {
        for (Fish target : School) {
          float xdiff = _pos.x - target._pos.x; 
          float ydiff = _pos.y - target._pos.y; 
          float dist = sqrt(pow(xdiff, 2) + pow(ydiff, 2)); 
          if (dist <= range) {
            target._vel.x = _vel.x; 
            target._vel.y = _vel.y;
          }
        }
      }
    } else {
      for (Fish f : School) {
        float xdiff = _pos.x - f._pos.x; 
        float ydiff = _pos.y - f._pos.y; 
        float dist = sqrt(pow(xdiff, 2) + pow(ydiff, 2)); 
        if (dist <= range) {
          if (xdiff * f._vel.x > 0) {
            f._vel.x = -f._vel.x;
          }
          if (ydiff * f._vel.y > 0) {
            f._vel.y = -f._vel.y;
          }
        }
      }
    }
  }
}
