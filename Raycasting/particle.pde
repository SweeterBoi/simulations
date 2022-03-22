/**
* Klasse ist eine Lichtquelle, die Straklen in alle Richtungen aussendet
*
* @version 22.03.2022
* @author Max Janik
*/
public class Particle {
    // Liste der Strahlen
    private ArrayList<Ray> rays = new ArrayList<>();
    // Position des Objektes
    private PVector _pos;
    
    /**
    * Instanziert das Objekt in der Mitte des Bildschirmes
    */
    public Particle() {
        _pos = new PVector(width / 2, height / 2);
        for (float i = 0; i < 360; i += 0.5) {
            PVector vec = PVector.fromAngle(radians(i));
            Ray r = new Ray(_pos, vec);
            rays.add(r);
        }
    }
    
    /**
    * Methode ändert die Position zu den angegebenen x- und y-Koordinaten
    *
    * @param x neue x-Koordinate
    * @param y neue y-Koordinate
    */
    public void update(float x, float y) {
        _pos.x = x;
        _pos.y = y;
    }
    
    /**
    * Methode zeichent die Lichtquelle auf den Bildschirm
    */
    public void draw() {
        ellipse(_pos.x, _pos.y, 10, 10);
    }
    
    /**
    * Mehode sendet Straklen aus und zeichnet sie bis zu dem Punkt an dem sie auf Hindernisse treffen
    *
    * @param boundarys Liste aller Hindernisse in der Szene
    */
    public void castRays(ArrayList<Boundary> boundarys) {
        stroke(color(255, 60));
        // Iteriert über alle Strahlen
        for (Ray r : rays) {
            PVector hitpoint = null; 
            float mindist = 100000000.0;
            // Iteriert über alle Hindernisse und findet das (räumlich-) nächste
            for (Boundary b : boundarys) {
                PVector intersect = r.cast(b);
                if (intersect != null) {
                    float d = dist(_pos.x, _pos.y, intersect.x, intersect.y);
                    if (d < mindist) {
                        mindist = d;
                        hitpoint = intersect;
                    }
                }
            }
            // Zeichnet Strahl bis zum Schnittpunkt mit hindernis
            line(_pos.x, _pos.y, hitpoint.x, hitpoint.y);
        }
    }
    
}