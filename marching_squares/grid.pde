class Grid {

  ArrayList<Cell> _cells = new ArrayList<>();
  ArrayList<Point> _points = new ArrayList<>();
  int _gridWidth;
  int _gridHeigth;
  int cellSize;

  public Grid(float cellSize, int wdth, int hgt, ArrayList<Metaball> balls) {
    for (int i = 0; i < wdth; i++) {
      for (int j = 0; j < hgt; j++) {
        PVector cen = new PVector((i+1) * cellSize + ORIGIN.x + cellSize/2, (j+1) * cellSize + ORIGIN.y + cellSize/2);
        Cell c = new Cell(cen, cellSize, _points, balls);
        _cells.add(c);
      }
    }
  }

  public void blit() {
    for (int i = 0; i < _cells.size(); i++) {
      int c = counter + i;
      if(c%1 == 0) {
      _cells.get(i).blit();
      } 
    }
  }
  public void update(ArrayList<Metaball> balls) {
    for (int i = 0; i < _cells.size(); i++) {
      _cells.get(i).update(balls);
    }
  }
}
