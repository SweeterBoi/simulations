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
    public Cell(PVector center, float size, ArrayList<Point> points, int hgt) {
        _size = size;
        _center = new Point(center);
        //points are generarted in a Z pattern
        //
        //  1------2
        //      /
        //    /
        //  3------4
        
        // Generiert neue Punkte
        Point p1 = new Point(new PVector(center.x - size / 2, center.y - size / 2));
        Point p2 = new Point(new PVector(center.x + size / 2, center.y - size / 2));
        Point p3 = new Point(new PVector(center.x - size / 2, center.y + size / 2));
        Point p4 = new Point(new PVector(center.x + size / 2, center.y + size / 2));
        
        boolean add1 = true;
        boolean add2 = true;
        boolean add3 = true;
        boolean add4 = true;
        
        Point t1 = null;
        Point t2 = null;
        Point t3 = null;
        
        // Gesamtzahl der Punkte im Raster
        int lastPointPos = points.size() - 1;
        
        if (lastPointPos >= hgt) {
            //Target Points
            t1 = points.get(lastPointPos - hgt);
            t2 = points.get(lastPointPos); // this one works, teh others don't
            t3 = points.get(lastPointPos - hgt + 1);
            
            // Abstände
            float dist1 = Calc.dist(t1._pos, p2._pos);
            float dist2 = Calc.dist(t2._pos, p2._pos);
            float dist3 = Calc.dist(t3._pos, p3._pos);
            
            // Abstand an dem Punkte noch als überlappend angeshen werden
            float epsilon = 0.5;
            
            
            add1 = dist1 >= epsilon;
            add2 = dist2 >= epsilon;
            add3 = dist3 >= epsilon;
        } else {
            add4 = false;
            add2 = false;
            add1 = false;
        }
        
        if (add1) {
            points.add(p1);
            _points.add(p1);
        } else {
            _points.add(t1);
        }
        if (add2) {
            points.add(p2);
            _points.add(p2);
        } else {
            _points.add(t2);
        }
        if (add3) {
            points.add(p3);
            _points.add(p3);
        } else {
            _points.add(t3);
        }
        
        if (add4) {
            points.add(p4);
            _points.add(p4);
        }
        
        points.add(_center);
        
        // Initiiert die An-Aus-Tabelle
        for (int i = 0; i < 4; i++) {
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
    * Aktualisiert die Punkte der Zelle und erstell, bzw löcht Linien nach bedarf
    *
    * @param balls Liste der Meatbälle
    */
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
    
    /**
    * Sucht nach duplicaten in den Punkten, da eine neue Zelle biszu drei Punkte mit zuvor generierten Zellen gemeinsam hat.
    *
    */
    private void checkForDuplicates() {
        
    }
    
}
