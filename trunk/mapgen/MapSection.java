public class MapSection {
    private double height;
    private int type;

    //Constructor
    public MapSection () {
        this.height = 0;
        this.type = 0;
    }

    public double getHeight() {
        return this.height;
    }
    
    public int getType() {
        return this.type;
    }

    public void setHeight(double new_height) {
        this.height = new_height;
    }

    public void setType(int new_type) {
        this.type = new_type;
    }
}
