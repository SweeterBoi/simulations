/**
* Klasse repräsentiert eine Zelle (ein Quadrat aus vier Eckpunkten und einem Mittelpunkt) in Raster (Grid)
*
* @version 10.02.2022
* @author Max Janik
*/
class Cell {
    // Liste aller Punkte die zu dieser Zelle gehören
    ArrayList<Point> _points = new ArrayList<>(4);
    // Liste, die speichert welche der Punkte An bzw aus sind
    ArrayList<Boolean> _table = new ArrayList<>(4);
    // Mittelpunkt der Zelle
    Point _center;
    // Größe der Zelle (Abstand der Eckpunkte)
    float _size;
    // Liste, die alle Linien speichert, die eingeschaltete Punkte von erloschenen trennt
    ArrayList<Line> _line = new ArrayList<>();
    
    /**
    * Instanziert eine neue Zelle mit der Position des Zentrums der Zelle, seiner Größe, der Liste aller erzeugten Punkte und der Breite des Rasters (Grid).
    *
    * @param center PVector, der zentrum der Zelle zeigt
    * @param size Größe der Zelle
    * @param points Liste aller bisherigen Punkte des Rasters
    * @param hgt Breite des Grids bzw Anzahl Punkte pro Zeile des Grids
    */
    public Cell(PVector center, float size, ArrayList<Point> cornerPoints, ArrayList<Point> centerPoints, int hgt, int i, int j) {
        _size = size;
        _center = new Point(center);
        Point p1 = cornerPoints.get(hgt * (i - 1) + (j - 1));
        Point p2 = cornerPoints.get(hgt * i + (j - 1));
        Point p3 = cornerPoints.get(hgt * (i - 1) + j);
        Point p4 = cornerPoints.get(hgt * i + j);
        
        _points.add(p1);
        _points.add(p2);
        _points.add(p3);
        _points.add(p4);
        centerPoints.add(_center);
        
        // Initiiert die An-Aus-Tabelle
        for (int k = 0; k < 4; k++) {
            _table.add(false);
        }
    }
    /**
    * Zeichnet die Linien auf den Bildschirm
    */
    public void blit() {
        if (_line.size() > 0) {
            for (int i = 0; i < _line.size(); i++) {
                _line.get(i).blit();
            }
        }
    }
    
    /**
    * Aktualisiert die Punkte der Zelle und erstell, bzw löscht Linien nach bedarf
    *
    * @param balls Liste der Meatbälle
    */
    public void update(ArrayList<Metaball> balls) {
        _center.update(balls);
        for (int i = 0; i < _points.size(); i++) {
            _table.set(i, _points.get(i)._isOn);
        }
        makeLine();
    }
    
    /**
    * Erzeugt linien nach den Vorgaben der Tabelle in der Klasse Calc.
    */
    private void makeLine() {
        // Prüft welcher der 16 möglichen Konfigurationen diese Zelle entspricht
        int type = Calc.lookup(_table, _center._isOn);
        //löscht alle Linien
        _line.clear();
        //Erzeugt neue Linen
        if (type == 1 || type == 2) {
            _line.add(new Line(new PVector(_center._pos.x - _size / 2, _center._pos.y), new PVector(_center._pos.x, _center._pos.y - _size / 2)));
        } else if (type == 3 | type == 4) {
            _line.add(new Line(new PVector(_center._pos.x, _center._pos.y - _size / 2), new PVector(_center._pos.x + _size / 2, _center._pos.y)));
        } else if (type == 5 || type == 6) {
            _line.add(new Line(new PVector(_center._pos.x - _size / 2, _center._pos.y), new PVector(_center._pos.x, _center._pos.y + _size / 2)));
        } else if (type == 7 | type == 8) {
            _line.add(new Line(new PVector(_center._pos.x, _center._pos.y + _size / 2), new PVector(_center._pos.x + _size / 2, _center._pos.y)));
        } else if (type == 11 || type == 12) {
            _line.add(new Line(new PVector(_center._pos.x, _center._pos.y - _size / 2), new PVector(_center._pos.x, _center._pos.y + _size / 2)));
        } else if (type == 9 || type == 10) {
            _line.add(new Line(new PVector(_center._pos.x - _size / 2, _center._pos.y), new PVector(_center._pos.x + _size / 2, _center._pos.y)));
        } else if (type == 13) {
            _line.add(new Line(new PVector(_center._pos.x, _center._pos.y - _size / 2), new PVector(_center._pos.x + _size / 2, _center._pos.y)));
            _line.add(new Line(new PVector(_center._pos.x - _size / 2, _center._pos.y), new PVector(_center._pos.x, _center._pos.y + _size / 2)));
        } else if (type == 14) {
            _line.add(new Line(new PVector(_center._pos.x - _size / 2, _center._pos.y), new PVector(_center._pos.x, _center._pos.y - _size / 2)));
            _line.add(new Line(new PVector(_center._pos.x + _size / 2, _center._pos.y), new PVector(_center._pos.x, _center._pos.y + _size / 2)));
        }
    }
}
