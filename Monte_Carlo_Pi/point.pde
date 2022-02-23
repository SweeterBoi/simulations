/**
* Repräsentiert einen Punkt.
*
* @version 23.02.2022
*
* @author Max Janik
*/
class Point {
    PVector _pos;
    boolean _istImKreis;
    int size = 5;
    
    /**
    * Istanziert einen Punkt.
    *
    * @param x x-Komponente des Punktes
    * @param y y-Komponente des Punktes
    * @param istImKreis Gibt an ob der Punkt innerhalb des Kreises gelandet ist
    */
    public Point(float x, float y, boolean istImKreis) {
        _pos = new PVector(x, y);
        _istImKreis = istImKreis;
    }
    
    /**
    * Zeichnet den Punkt auf den Bildschirm.
    */
    public void blit() {
        point(_pos.x, _pos.y);
    }  
}
