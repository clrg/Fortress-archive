public class MapSection {
    private float height;
    private int type;

    //Constructor
    public MapSection () {
        this.height = 0;
        this.type = 0;
    }

    public float getHeight() {
        return this.height;
    }
    
    public int getType() {
        return this.type;
    }

    public void setHeight(float new_height) {
        this.height = new_height;
    }

    public void setType(int new_type) {
        this.type = new_type;
    }
}
