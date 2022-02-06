// Speichert die Position des Balls
float xPosition = 200;
float yPosition = 150;

//Speichert die Geschwindigkeit des Balls
float xGeschw = 20;
float yGeschw = 15;

//setup() wird zu Beginn des Programms einmal ausgeführt
void setup() {
    //Legt die Dimensionen des Fensters auf 600 px Breite und 400 px Höhe fest
    size(600, 400);
}

//draw() wird immer wieder ausgeführt, solange das Programm läuft
void draw() {
    background(0);
    
    //Der Ball prallt links ab, wenn die x-Koordinate <= 0 ist und sich der Ball weiter nach links bewegt
    //Gleiches gilt für die anderen drei Ränder
    boolean pralltLinksAb = xPosition <= 0 && xGeschw < 0;
    boolean pralltRechtsAb = xPosition >= width && xGeschw > 0;
    if (pralltLinksAb || pralltRechtsAb) {
        xGeschw = -xGeschw;
    }
    
    boolean pralltObenAb = yPosition <= 0 && yGeschw < 0;
    boolean pralltUntenAb = yPosition >= height && yGeschw > 0;
    if (pralltObenAb || pralltUntenAb) {
        yGeschw = -yGeschw;
    }
    
    // Die Position ändert sich indem die Geschwindigkeit bei jedem Timestep aufaddiert wird
    // Diese Implementierung diskreter Mechanik wird Explizite Euler Methode genannt.
    xPosition = xPosition + xGeschw;
    yPosition = yPosition + yGeschw;
    
    // Zeichnet den Ball auf den Bildschirm
    drawBall(xPosition, yPosition);
}


/**
* Diese Funktion zeichnet den Ball auf den Bildschirm
* Dabei werden die x- und y-Position als Parameter übergeben
*
* @param x die x-Position an die der Ball gezeichnet werden soll
* @param y die y-Position an die der Ball gezeichnet werden soll
*/
void drawBall(float x, float y) {
    int size = 30;              //Größe des Balls
    fill(255);                  //Farbe des Kreises hier Weiß
    stroke(0);                  //Farbe der Outline hier Schwarz
    ellipseMode(CENTER);        //Legt fest, dass x und y den Mittelpunkt festlegen
    ellipse(x,y,size,size);     //Zeichnet den Kreis
}