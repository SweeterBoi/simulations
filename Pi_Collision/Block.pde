/**
* Exemplar der Klasse ist ein Block der sich in x-Richtung bewegt.
* Exemplare besitzen eine X-Position, eine X-Geschwindigkeit
* Eine Groesse und eine numerische Masse für Stossberechnung
*
* @author Max Janik
*
* @version 25.12.2019
*/
class block {
    
    public double _xPosition;    //position auf der x-Achse
    public double _velocity;     //geschwindigkeit des Blocks entlang der x-Achse
    public final int SIZE;       //Groesse des Blocks
    public final int MASS;       //masse des Blocks
    
    /**
    *Konstruktor erzeugt Block wobei alle Parameter angegeben werden
    *
    *@param x X-Position yu Begin
    *@param size Groesse des Blocks
    *@param vel Startgeschwindigkeit
    *@param mass virtuelle Masse des Blocks
    */
    public block(int x, int size, float vel, int mass) {
        _xPosition = x;
        _velocity = vel;
        SIZE = size;
        MASS = mass;
    }
    
    /**
    *Konstruktor erzeugt Block wobei die Groesse vorbestimmt ist
    *
    *@param x X-Position yu Begin
    *@param size Groesse des Blocks
    *@param vel Startgeschwindigkeit
    *@param mass virtuelle Masse des Blocks
    */
    public block(int x, float vel, int mass) {
        _xPosition = x;
        _velocity = vel;
        SIZE = 50;
        MASS = mass;
    }
    
    /**
    *Konstruktor erzeugt Block wobei nur die X-Position festgelegt werden kann
    *@param x X-Position yu Begin
    *@param size Groesse des Blocks
    *@param vel Startgeschwindigkeit
    *@param mass virtuelle Masse des Blocks
    */
    public block(int x) {
        _xPosition = x;
        _velocity = 0;
        SIZE = 50;
        MASS = 1;
    }
    
    /**
    *Updated denBlock und verschiebt ihn entsprechend der Geschwindigkeit
    */
    public void update() {
        if (_xPosition <= lvl.WALL && _velocity > 0) {
            _velocity = -_velocity;
            _xPosition = lvl.WALL;
            zaehler.increment();
        }
        rungeKutta4();
    }
    
    private void rungeKutta4() {
        double x0 = 0;
        double x = _velocity;
        double y0 = _xPosition;
        double h = timeStep;
        // Count number of iterations using step size or
        // step height h
        int n = (int)((x - x0) / h);
        
        double k1, k2, k3, k4, k5;
        
        // Iterate for number of iterations
        double y = y0;
        for (int i = 1; i <= n; i++)
        {
            // Apply Runge Kutta Formulas to find
            // next value of y
            k1 = h * (dydx(x0, y));
            k2 = h * (dydx(x0 + 0.5 * h, y + 0.5 * k1));
            k3 = h * (dydx(x0 + 0.5 * h, y + 0.5 * k2));
            k4 = h * (dydx(x0 + h, y + k3));
            
            // Update next value of y
            y = y + (1.0 / 6.0) * (k1 + 2 * k2 + 2 * k3 + k4);
            
            // Update next value of x
            x0 = x0 + h;
        }
        _xPosition = y - h * x;
    }
    
    private double dydx(double x, double y)
    {
        return((x - y) / 2);
    }
    
    
    private void euler() {
        _xPosition -= _velocity;
    }
    
    /** 
    *Zeichnet den Block auf den Bildschirm
    */
    public void blit() {
        rectMode(CORNER);
        fill(255);
        noStroke();
        rect((float) _xPosition, lvl.GROUNDLEVEL - SIZE, SIZE, SIZE);
    }
}