/**
* Exemplar der Klasse wird benutzt um eine Zahl auf den Bildschirm zu blitten
* und diese ggf. inkrementell zu erhöhen
*
* @author Max Janik
*
* @version 25.12.2019
*/
class counter {
    public int count;
    public final int XPOS;
    public final int YPOS;
    
    /**
    *Konstruktor bei dem die Position angegeben wird und count auf 0 gesetzt wird
    *
    *@param x X-Position der Anzeige
    *@param Y-Position der Anzeige
    */
    public counter(int x, int y) {
        count = 0;
        XPOS = x;
        YPOS = y;
    }
    
    /**
    *Konstruktor bei dem ein Startwert mit angegeben werden kann
    *
    *@param x X-Position der Anzeige
    *@param Y-Position der Anzeige
    @param m Startwert der Anzeige
    */
    public counter(int x, int y, int m) {
        count = m;
        XPOS = x;
        YPOS = y;
    }
    
    /**
    *Erhöht den Wert count um 1
    */
    public void increment() {
        count++;
        }
    
    /**
    *Schreibt den Wert von count auf den Bildschirm
    */
    public void blit() {
        rectMode(CENTER);
        textSize(20);
        text(str(count), XPOS, YPOS);
        }
    /**
    *Schreibt den wert von count im Format 1:count auf den Bildschirm
    *Wird für die Anzeige des Massenverhaeltnises der Bloecke benutzt
    */
    public void rblit() {
        rectMode(CENTER);
        textSize(20);
        text("1:" + str(count), XPOS, YPOS);
        }
    }