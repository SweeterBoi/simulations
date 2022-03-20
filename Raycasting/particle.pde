public class Particle {
    private ArrayList<Ray> rays = new ArrayList<>();
    private PVector _pos;
    
    public Particle() {
        _pos = new PVector(width / 2, height / 2);
        for (int i = 0; i < 360; i++) {
            PVector vec = PVector.fromAngle(radians(i));
            Ray r = new Ray(_pos, vec);
            rays.add(r);
        }
    }
    
    public void update(float x, float y) {
        _pos.x = x;
        _pos.y = y;
    }
    
    public void draw() {
        ellipse(_pos.x, _pos.y, 10, 10);
    }
    
    public void castRays(ArrayList<Boundary> boundarys) {
        stroke(color(255, 80));
        for (Ray r : rays) {
            PVector hitpoint = null; 
            float mindist = 100000000.0;
            //r.draw();
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
            line(_pos.x, _pos.y, hitpoint.x, hitpoint.y);
        }
    }
    
}