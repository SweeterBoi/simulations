/**
* Die Simulation Approximiert die Kreiszahl Pi nach der Monte Carlo Methode.
*
* @version 23.02.2022
*
* @author Max Janik
*/
int radius = 400;                               //Radius des Krises
double punkteImKreis = 0;                       //Anzahl der Punkte im Kreis
ArrayList<Point> punkte = new ArrayList<>();    //Liste aller Punkte
ArrayList<Float> werte = new ArrayList<>();     //liste der bisher berechneten Approximationen für Pi

void setup() {
    size(1200, 400);
    rectMode(CENTER);
    ellipseMode(CENTER);
}


void draw() {
    background(0);
    neuerPunkt();
    berechnePI();
    zeichneQuadrat();
    zeichnePunkte();
    zeichneKreis();
    zeichneGraph();
}

/**
* Zeichnet das Kreisviertel auf den Bildschirm.
*/
void zeichneKreis() {
    noFill();                                   // Zeichnet nur den Umkreis und füllt ihn nicht aus
    strokeWeight(3);                            // Dicke der Linie in Pixeln
    stroke(color(255, 200, 150));               // Farbe des Kreises
    ellipse(0, height, 2 * radius, 2 * radius); // Zeichnet den Kreis
}

/**
* Zeichent das QUadrat auf den Bildschirm
*/
void zeichneQuadrat() {
    fill(0);                                                // füllt das Quadrat mit schwarzer Farbe
    strokeWeight(3);                                        // Dicke der Linie in Pixeln
    stroke(255);                                            // Farbe der Linie
    rect(radius / 2, height - radius / 2, radius, radius);  // Zeichnet das Quadrat
}

/**
* Erstellt einen neuen Punkt und aktualisiert die Variable, die die Punkte im Kreis zählt.
*/
void neuerPunkt() {
    float x = random(0, radius);                        // Generiert einen zufälligen x- und y-Wert
    float y = random(0, radius);                        //
    float dist = sqrt(pow(x, 2) + pow(y, 2));           // Berechnet den Abstand zum Kreismittelpunkt
    boolean istImKreis = dist <= radius;                // Ist der Abstand größer als der Kreisradius liegt der Punkt nicht im Kreis
    punkte.add(new Point(x, height - y, istImKreis));   // Generiert den neuen Punkt und Speichert ihn in der Liste
    if (istImKreis) {                                   // Liegt der Punkt im Kreis wird die Zahl der punkteImKreis erhöht
        punkteImKreis += 1;
    }
}

/**
* Berechnet Pi aus dem Verhältnis der Punkte im Kreis zur Gesamtzahl der Punkte
*/
void berechnePI() {
    int size = punkte.size();
    //Berechnet Pi nur alle 100 Punkte
    if (size % 100 == 0) {
        double pi = 4 * punkteImKreis / size;   // Diese Formel findet sich in der Anleitung
        werte.add((float) pi);                  // Fügt den neuen Wert an die Liste der Werte an
        println(pi);                            // Gibt die derzeitige Approximation von Pi in der Konsole aus
    }
}

/**
* Zeichnet die ersten  10,000 Punkte auf den Binldschirm.
*/
void zeichnePunkte() {
    int size = (punkte.size() < 10000) ? punkte.size() : 10000; // Zeichnet nur die ersten 10,000 Punkte, oder alle wenn es weniger sind
    for (int i = 0; i < size; i++) {                            //
        punkte.get(i).blit();                                   // Zeichnet den Punkt
    }
}

/**
* Zeichnet den Graphen auf den Bildschirm
*/
void zeichneGraph() {
    int y0 = 200;                                   // Höhe der x-Achse
    int x0 = 500;                                   // Position der y-Achse
    float laenge = 600;                             // Länge der x-Achse
    int hoehe = 300;                                // Länge der y-Achse
    float scale = 1000.0;                           // Skalierungsfaktor der ABgebildeten Werte
    int size = werte.size();                        // Anzahl der zu zeichnenden Werte
    // Verteilt die Werte geleichmäßig über die Länge der x-Achse, die ersten 20 haben eine festgelegte Länge.
    float intervall = (size > 20) ? (laenge / (float) size) : (laenge / 20);
    
    stroke(255);                                    // Macht die Achsen weiß
    line(x0, y0 - hoehe / 2, x0, y0 + hoehe / 2);   // Zeichnet die y-Achse
    line(x0 - 20, y0, x0 + laenge, y0);             // Zeichnet die x-Achse
    
    stroke(color(255,100,100));                     // Macht die Linie rot
    for (int i = 0; i < size - 1; i++) {            // iteriert über alle Werte
        float x1 = i * intervall;                   // legt den x-Wert des Anfangs der Linie fest
        float y1 = scale * (PI - werte.get(i));     // Legt den y-Wert des Anfangs der Linie fest
        float x2 = (i + 1) * intervall;             // legt den x-Wert des ENdes der Linie fest
        float y2 = scale * (PI - werte.get(i + 1)); // Legt den y-Wert des ENdes der Linie fest
        line(x0 + x1, y0 + y1, x0 + x2, y0 + y2);   // Zeichnet die Linie
    }
}