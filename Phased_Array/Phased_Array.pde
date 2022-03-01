Medium medium;

void setup() {
    size(800, 600);
    ellipseMode(CENTER);
    medium = new Medium(20, 3, 3);
}

void draw() {
    background(0);
    medium.richteStrahlAus();
    medium.draw();
}