ArrayList<Boundary> walls = new ArrayList<>();
Particle p;

float xoff = 0;
float yoff = 100;

void setup() {
    size(800,600);
    stroke(255);
    strokeWeight(1);
    fill(255);
    ellipseMode(CENTER);
    
    p = new Particle();
    walls.add(new Boundary(new PVector(0,0), new PVector(width,0)));
    walls.add(new Boundary(new PVector(width,0), new PVector(width,height)));
    walls.add(new Boundary(new PVector(0,0), new PVector(0,height)));
    walls.add(new Boundary(new PVector(0,height), new PVector(width,height)));
    
    for (int i = 0; i < 5; i++) {
        walls.add(new Boundary(new PVector(random(width),random(height)), new PVector(random(width),random(height))));
    }
}

void draw() {
    background(0);
    p.update(noise(xoff) * width, noise(yoff) * height);
    xoff += 0.006;
    yoff += 0.006;
    p.castRays(walls);
    p.draw();
    for (Boundary b : walls) {
        b.draw();
    }
}