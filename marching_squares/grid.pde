class Grid {
    
    ArrayList<Cell> _cells = new ArrayList<>();
    ArrayList<Point> _cornerPoints = new ArrayList<>();
    ArrayList<Point> _centerPoints = new ArrayList<>();
    private int _gridWidth;
    private int _gridHeigth;
    private int cellSize;
    
    public Grid(float cellSize, int wdth, int hgt, LoadingBar lb) {
        // Generiert Punkte auf dem Bildschirm
        for (int i = 0; i < wdth; i++) {
            for (int j = 0; j < hgt; j++) {
                PVector pos = new PVector(i * cellSize + ORIGIN.x, j * cellSize + ORIGIN.y);
                _cornerPoints.add(new Point(pos));
                lb.plusPlus();
            }
        }
        for (int l = 1; l < wdth; l++) {
            for (int k = 1; k < hgt; k++) {
                PVector pos = new PVector(cellSize * l + ORIGIN.x, cellSize * k + ORIGIN.x);
                _cells.add(new Cell(pos, cellSize, _cornerPoints, _centerPoints, hgt, l, k));
            }
        }
        int erw = hgt * wdth + (wdth - 1) * (hgt - 1); //Eckpunkte + Punkte im Zentrum
        int erz = _cornerPoints.size() + _centerPoints.size();
        System.out.println("Erwartete Punkte: " + str(erw));
        System.out.println("Erzeugte Punkte: " + str(erz));
        System.out.println("Ratio: " + str((float)erz / erw));
        System.out.println("");
    }
    
    public void blit() {
        for (int i = 0; i < _cells.size(); i++) {
            int c = counter + i;
            if (c % 1 == 0) {
                _cells.get(i).blit();
            } 
        }
    }
    public void update(ArrayList<Metaball> balls) {
        int lenPoints = _cornerPoints.size();
        for (int i = 0; i < lenPoints; i++) {
            _cornerPoints.get(i).update(balls);
        }
        int lenCells = _cells.size();
        for (int i = 0; i < lenCells; i++) {
            _cells.get(i).update(balls);
        }
    }
}
