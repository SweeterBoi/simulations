public static class Calc {
    //private final color MINFARBE = color(50,80,40);
    //private final color MAXFARBE = color(180, 240, 220);
    private static final float AUSBREITUNGSGESCHWINDIGKEIT = 100;
    private static final float AMPLITUDE = 1;
    
    /**
    *
    */
    /*
    public static color farbMap(float wert, int oszillatorZahl) {
    float bildmenge = 2 * oszillatorZahl * AMPLITUDE;
    float rot = (255 - 50) / bildmenge * wert;      // Minimalwert = 50, Maximalwert = 255
    float gruen = (220 - 80) / bildmenge * wert;    // Minimalwert = 80, Maximalwert = 220
    float blau = (200 - 70) / bildmenge * wert;     // Minimalwert = 70, Maximalwert = 200
    return new color(rot, gruen, blau);
}*/
    
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
    
    public static float dist(PVector a, PVector b) {
        return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2));
    }
}