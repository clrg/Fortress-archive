import java.util.Random;

public class MapGenerator {
    private MapSection[][] map;
    private int width;
    private int height;

    public int getWidth() {
        return this.width;
    }
    
    public int getHeight() {
        return this.height;
    }
    
    public MapSection getMapSection(int height, int width) {
        return map[height][width];
    }

    //Constructor
    public MapGenerator(int width, int height) {
        this.width = width;
        this.height = height;
        this.map = new MapSection[this.width][this.height];
        for(int h = 0; h < height; h++) {
            for(int w = 0; w < width; w++) {
                this.map[h][w] = new MapSection();
            }
        }
    }

    public void printMap() {
        for(int h = 0; h < this.height; h++) {
            for (int w = 0; w < this.width; w++) {
                System.out.print(this.map[h][w].getHeight() + " "); 
            }
            System.out.println();
        }
    }

    public void generateMap_HillAlgorithm() {
        Random rand = new Random();
        for (int i = 0; i < 1; i++) {
            //generate random centerpoint
            int x1 = rand.nextInt(this.height);
            int y1 = rand.nextInt(this.width);
            //generate random radius
            int radius = rand.nextInt(this.width/2);
            //for each point on the map, calculate height
            for (int x2 = 0; x2 < this.height; x2++) {
                for (int y2 = 0; y2 < this.width; y2++) {
                    map[x2][y2].setHeight((float)java.lang.Math.pow(radius, 2) - ((float)java.lang.Math.pow(x2-x1,2)) + ((float)java.lang.Math.pow(y2-y1,2)));
                }
            }
        }
    }
}
