static class Calc {

  final static int period = 5000;

  static float gradientField(PVector p, int time) {
    float x = p.x;
    float y = p.y;
    return 5*(sin((TWO_PI/260)*(x+ORIGIN.x) + (TWO_PI/period)*time) * sin((TWO_PI/260)*(y+ORIGIN.y)+(TWO_PI/period)*time));
  }

  static float gradientField(PVector p, ArrayList<Metaball> balls) {
    if (balls.size() == 0) {
      return 0;
    }
    float sum = 0;
    for (int i = 0; i < balls.size(); i++) {
      Metaball b = balls.get(i);
      float dist = sqrt(pow(b.x() + ORIGIN.x -p.x, 2) + pow(b.y() + ORIGIN.y - p.y, 2));
      sum += b._charge/dist;
    }
    return sum;
  }

  static int lookup(ArrayList<Boolean> list, boolean center) {
    boolean b1 = list.get(0);
    boolean b2 = list.get(1);
    boolean b3 = list.get(2);
    boolean b4 = list.get(3);

    if (!b1 && !b2 && !b3 && !b4) {            //Epmty
      return 0;
    } else if (b1 && !b2 && !b3 && !b4) {      //Edges
      return 1;
    } else if (!b1 && b2 && b3 && b4) {
      return 2;
    } else if (!b1 && b2 && !b3 && !b4) {
      return 3;
    } else if (b1 && !b2 && b3 && b4) {
      return 4;
    } else if (!b1 && !b2 && b3 && !b4) {
      return 5;
    } else if (b1 && b2 && !b3 && b4) {
      return 6;
    } else if (!b1 && !b2 && !b3 && b4) {
      return 7;
    } else if (b1 && b2 && b3 && !b4) {
      return 8;
    } else if (b1 && b2 && !b3 && !b4) {       //Through
      return 9;
    } else if (!b1 && !b2 && b3 && b4) {
      return 10;
    } else if (b1 && !b2 && b3 && !b4) {
      return 11;
    } else if (!b1 && b2 && !b3 && b4) {
      return 12;
    } else if (!b1 && b2 && b3 && !b4 && !center) {       //Regions
      return 13;
    } else if (b1 && !b2 && !b3 && b4 && !center) {
      return 14;
    } else if (!b1 && b2 && b3 && !b4 && center) {
      return 14;
    } else if (b1 && !b2 && !b3 && b4 && center) {
      return 13;
    } else if (b1 && b2 && b3 && b4) {         //Full
      return 15;
    }

    return -1;
  }
}
