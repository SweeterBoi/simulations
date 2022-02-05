class Metaball {

  PVector _pos;
  PVector _vel;
  float _charge;

  public Metaball(PVector pos, PVector vel, float charge) {
    _pos = pos;
    _vel = vel;
    _charge = charge;
  }

  public void update() {
    if(x() <= ORIGIN.x && _vel.x < 0) {
      _vel.x = -_vel.x;
    } else if(x() >= width && _vel.x > 0) {
      _vel.x = -_vel.x;
    }
    if(y() <= ORIGIN.y && _vel.y < 0) {
      _vel.y = -_vel.y;
    } else if(y() >= height && _vel.y > 0) {
      _vel.y = -_vel.y;
    }
    _pos.x += _vel.x;
    _pos.y += _vel.y;
    //blit();
  }
  
  private void blit() {
    ellipse(x(), y(), 5, 5);
  }

  private float x() {
    return _pos.x;
  }
  private float y() {
    return _pos.y;
  }
}
