/**
* Diese Klasse stellt ein Medium da, in welchem sich wellen ausbreiten können.
*
* @version 01.03.2022
*
* @author Max Janik
*/
public class Medium {
    // Liste der Oszillatoren
    private ArrayList<Oszillator> _oszillatoren = new ArrayList<>();
    // Liste der Teilchen des Mediums
    public ArrayList<Punkt> _punkte = new ArrayList<>();
    // Frequenz der Oszillatoren
    private float _frequenz = 20;
    // Abstand der Oszillatoren
    private int _oszillatorAbstand;
    
    /**
    * Instanziert das Medium mit gegebener Anzahl an Oszillatoren bei gegebenem Oszillator- und Punktabstand 
    *
    * @param anzahlOszillatoren Anzahl der erwünschten Oszillatoren
    * @param oszillatorAbstand Abstand der Oszillatoren auf der Grundlinie
    * @param punktAbstand Abstand der Punkte und damit verbunden räumliche Auflösung der Simulation
    */
    public Medium(int anzahlOszillatoren, int oszillatorAbstand, int punktAbstand) {
        _oszillatorAbstand = oszillatorAbstand;
        generiereOszillatoren(anzahlOszillatoren, oszillatorAbstand);
        generierePunkte(punktAbstand);
    }
    
    /**
    * Richtet den Strahl zur Maus hin aus.
    */
    public void richteStrahlAus() {
        int size = _oszillatoren.size();                                    // Anzahl der Oszillatoren
        float tan = atan2(mouseY - height, mouseX - width / 2);             // Winkel der Verbindungslinie vom Mittelpunkt des unteren Randes zur Maus und dem unteren Rand
        float alpha = (mouseX < width / 2) ? tan - PI / 2 : - PI / 2 - tan; // Winkel zur Mittelachse
        float d = _oszillatorAbstand;                                       // Den  Oszillatorabstand d zu nennen Macht die nächste Gleichung leichter zu lesen
        float ds = d * sin(alpha);                                          // Gleichung für den Gangunterschied des Hauptmaximums bei einem Gitter
        
        // Iteriert über alle Oszillatoren und ändert die Phase wie berechnet
        for (int i = 0; i < size; i++) {
            Oszillator o = _oszillatoren.get(i);
            o.setzePhase(i * ds * (float) PI / size);
        }
    }
    
    /**
    * Updated- und zeichnet die Punkte
    */
    public void draw() {
        for (Punkt p : _punkte) {
            p.update(_oszillatoren);
            p.draw(_oszillatoren.size());
        }
    }
    
    /**
    * Generiert die Punkte im Konstruktor
    *
    * @param punnktAbstand Abstand der Punkte
    */
    private void generierePunkte(int punktAbstand) {
        int wdth = width / punktAbstand;
        int hgt = height / punktAbstand;
        
        for (int i = 0; i < wdth; i++) {
            for (int j = 0; j < hgt; j++) {
                PVector pos = new PVector(i * punktAbstand, j * punktAbstand);
                Punkt p = new Punkt(pos);
                _punkte.add(p);
            }
        }
    }
    
    /**
    * Generiert die Oszillatoren im Konstruktor
    *
    * @param anzahlOszillatoren Anzahl der Oszillatoren
    * @param punnktAbstand Abstand der Oszillatoren
    */
    private void generiereOszillatoren(int anzahlOszillatoren, int oszillatorAbstand) {
        for (int i = 0; i < anzahlOszillatoren; i++) {
            PVector pos = new PVector(width / 2 - anzahlOszillatoren / 2 * oszillatorAbstand + i * oszillatorAbstand, height);
            Oszillator o = new Oszillator(pos, _frequenz);
            _oszillatoren.add(o);
        }
    }
}