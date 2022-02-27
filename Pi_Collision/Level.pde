/**
*Exemplar erzeugt das Level mit Untergrund und Wand
*
* @author Max Janik
*
* @version 25.12.2019
*/
class level {
    public final int YMARGIN;
    public final int WALL;
    private final color BACKGROUNDCOLOR;
    private final color LINECOLOR;
    public int GROUNDLEVEL;
    
    /**
    *Konstruiert das Spielfeld und gibt sowohl Farbe der Linien als auch
    *die Hintergrungfarbe an. Ausserdem den Abstand von Wand und Boden
    *zum Fensterrand
    *
    *@param xm Abstand des Bodens zum unteren Rand
    *@param ym Abstand der Wand zum linken Rand
    *@param bg Hintergrundfarbe
    *@param ln Farbe der Linien
    */
    public level(int xm, int ym, color bg, color ln) {
        YMARGIN = ym;
        GROUNDLEVEL = height - ym;
        WALL = xm;
        BACKGROUNDCOLOR = bg;
        LINECOLOR = ln;
    }
    
    /**
    *Zeichnet das Spielfeld auf den Bildschirm
    */
    public void blit() {
        GROUNDLEVEL = height - YMARGIN;
        background(BACKGROUNDCOLOR);
        fill(LINECOLOR);
        stroke(LINECOLOR);
        strokeWeight(3);
        line(WALL, 0, WALL, height);
        line(0, GROUNDLEVEL, width, GROUNDLEVEL);
    }
}