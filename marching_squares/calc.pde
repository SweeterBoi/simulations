static class Calc {
    
    final static int period = 5000;
    final static double timestep = 0.02;
    /**
    * Methode gibt die Distanz zwischen zwei Punkten zurück.
    *
    * @param a PVector, der den ersten Punkt repräsentiert
    * @param b PVector, der den zweiten Punkt repräsentiert
    *
    * @return Wurzel der Summe der Quadrate der Differenzen als float
    */
    static float dist(PVector a, PVector b) {
        return sqrt(pow(a.x - b.x,2) + pow(a.y - b.y,2) + pow(a.z - b.z,2));
    }
    /**
    */
    static float scalarField(PVector p, ArrayList<Metaball> balls) {
        if (balls.size() == 0) {
            return 0;
        }
        float sum = 0;
        int size = balls.size();
        for (int i = 0; i < size; i++) {
            Metaball b = balls.get(i);
            float dist = sqrt(pow(b.x() + ORIGIN.x - p.x, 2) + pow(b.y() + ORIGIN.y - p.y, 2));
            sum += b.charge() / dist;
        }
        return sum;
    }
    /**
    */
    static int lookup(ArrayList<Boolean> list, boolean center) {
        boolean b1 = list.get(0);
        boolean b2 = list.get(1);
        boolean b3 = list.get(2);
        boolean b4 = list.get(3);
        
        if (!b1 && !b2 && !b3 && !b4) {            //Epmty
            return 0;
        } else if (b1 && !b2 && !b3 && !b4) {      //Edges
            return 1;
        } else if (!b1 && b2 && b3 && b4) {
            return 2;
        } else if (!b1 && b2 && !b3 && !b4) {
            return 3;
        } else if (b1 && !b2 && b3 && b4) {
            return 4;
        } else if (!b1 && !b2 && b3 && !b4) {
            return 5;
        } else if (b1 && b2 && !b3 && b4) {
            return 6;
        } else if (!b1 && !b2 && !b3 && b4) {
            return 7;
        } else if (b1 && b2 && b3 && !b4) {
            return 8;
        } else if (b1 && b2 && !b3 && !b4) {       //Through
            return 9;
        } else if (!b1 && !b2 && b3 && b4) {
            return 10;
        } else if (b1 && !b2 && b3 && !b4) {
            return 11;
        } else if (!b1 && b2 && !b3 && b4) {
            return 12;
        } else if (!b1 && b2 && b3 && !b4 && !center) {       //Regions
            return 13;
        } else if (b1 && !b2 && !b3 && b4 && !center) {
            return 14;
        } else if (!b1 && b2 && b3 && !b4 && center) {
            return 14;
        } else if (b1 && !b2 && !b3 && b4 && center) {
            return 13;
        } else if (b1 && b2 && b3 && b4) {         //Full
            return 15;
        }
        
        return - 1;
    }
}
