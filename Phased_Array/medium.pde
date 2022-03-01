public class Medium {
    private int resolution;
    private ArrayList<Oszillator> _oszillatoren = new ArrayList<>();
    public ArrayList<Punkt> _punkte = new ArrayList<>();
    private float _frequenz = 20;
    private int _abstand;
    
    public Medium(int anzahlOszillatoren, int abstand, int punktAbstand) {
        _abstand = abstand;
        for (int i = 0; i < anzahlOszillatoren; i++) {
            PVector pos = new PVector(width / 2 - anzahlOszillatoren / 2 * abstand + i * abstand, height);
            Oszillator o = new Oszillator(pos, 0, _frequenz);
            _oszillatoren.add(o);
        }
        int wdth = width / punktAbstand;
        int hgt = height / punktAbstand;
        for (int i = 0; i < wdth; i++) {
            for (int j = 0; j < hgt; j++) {
                PVector pos = new PVector(i * punktAbstand,j * punktAbstand);
                Punkt p = new Punkt(pos);
                _punkte.add(p);
            }
        }
    }
    
    public void richteStrahlAus() {
        int size = _oszillatoren.size();
        float tan = atan2(mouseY - height, mouseX - width / 2);
        float alpha = (mouseX < width / 2) ? tan - PI / 2 : - PI / 2 - tan;
        float d = _abstand;
        float ds = d * sin(alpha);
        for (int i = 0; i < size; i++) {
            Oszillator o = _oszillatoren.get(i);
            o.setzePhase(i * ds * (float) PI / size);
        }
    }
    
    public void draw() {
        for (Punkt p : _punkte) {
            p.update(_oszillatoren);
            p.draw(_oszillatoren.size());
        }
    }
    
}