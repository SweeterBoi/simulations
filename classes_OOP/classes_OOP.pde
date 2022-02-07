// Liste der Bälle auf dem Bildschirm
ArrayList<ball> Baelle = new ArrayList<ball>();
// Anzahl der Bälle
int num = 100;

void setup() {
    size(800, 600);
    ellipseMode(CENTER);
    // Erzeugt die Bälle und speichert sie in der Liste
    for (int i = 0; i < num; i++) {
        ball b = new ball();
        Baelle.add(b);
    }
}

void draw() {
    background(0);
    // Speichert die Zahl an Bällen in der ArrayList
    int listSize = Baelle.size();
    // Iteriert über alle Bälle und updated und zeichnet sie
    for (int i = 0; i < listSize; i++) {
        ball b = Baelle.get(i);
        b.update();
        b.draw();
    }
}