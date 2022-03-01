/**
* Diese Hilfsklasse wird benutzt um die Wellengleichung der Teilchen aufzustellen und dient als Zugangspunkt für Klassenübergreifende berechnungen.
* @version 01.03.2022
*
* @author Max Janik
*/
public static class Calc {
    //Ausbreitungsgeschwindigkeit der Welle im MEdium
    private static final float AUSBREITUNGSGESCHWINDIGKEIT = 100;
    //Amplitude der Welle
    private static final float AMPLITUDE = 1;
    
    /**
    * Methode iteriert über alle Oszillatoren und berechent aus der Superposition der Wellen der einzelnen Oszillatoren
    * die Amplitude an einer gegebenen Position
    *
    * @param position die Position für die die Wellenamplitude berechnet werden soll
    * @param oszillatoren Liste der Oszillatoren, die zur Welle beitragen
    * @param mill Zeit in Millisekunden
    *
    * @return die Amplitude als float
    */
    public static float berechneWert(PVector position, ArrayList<Oszillator> oszillatoren, int mill) {
        float value = 0;
        float Zeit = (float) mill / 1000;
        for (Oszillator o : oszillatoren) {
            float dist = dist(position, o._position);
            float A0 = AMPLITUDE;
            float frequenz = o._frequenz;
            float wellenzahl = (float) frequenz / AUSBREITUNGSGESCHWINDIGKEIT;
            float phase =  o._phase;
            float v = A0 * sin(frequenz * Zeit - dist * wellenzahl + phase);
            value += v;
        }
        return value;
    }
    
    /**
    * Methode berechnet den Abstand zweier Punkte aus ihren Ortsvektoren
    * 
    * @param a erster Vektor
    * @param b zweiter Vektor
    *
    * @return Abstand als float
    */
    public static float dist(PVector a, PVector b) {
        return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2));
    }
}