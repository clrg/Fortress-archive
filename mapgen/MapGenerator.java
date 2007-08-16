import java.util.Random;
import java.lang.Math;

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

    public void generateMap_HillAlgorithm(int iterations) {
        Random rand = new Random();
        for (int i = iterations; i > 0; i--) {
            //generate random centerpoint
            int x1 = rand.nextInt(this.height);
            int y1 = rand.nextInt(this.width);
            //generate random radius
            int radius = rand.nextInt(this.width/4) + 1;
            //for each point in the surrounding box, calculate height
            int boxx = (x1-radius-1 < 0) ? 0 : (x1-radius-1);
            int boxy = (y1-radius-1 < 0) ? 0 : (y1-radius-1);
            int boxx2 = (x1+radius+1 > this.height) ? this.height : (x1+radius+1);
            int boxy2 = (y1+radius+1 > this.width) ? this.width : (y1+radius+1);
            for (int x2 = boxx; x2 < boxx2; x2++) {
                for (int y2 = boxy; y2 < boxy2; y2++) {
                    double value = Math.pow(radius, 2) - (Math.pow((y2-y1),2) + Math.pow((x2-x1),2));
                    //drop negative values
                    if (value > 0)
                        map[x2][y2].setHeight(value + map[x2][y2].getHeight());
                }
            }
        }
        //find min and max for normalization
        double min = map[0][0].getHeight();
        double max = map[0][0].getHeight();
        for (int x = 0; x < this.height; x++)
            for (int y = 0; y < this.width; y++) {
                min = (map[x][y].getHeight() < min) ? map[x][y].getHeight() : min;
                max = (map[x][y].getHeight() > max) ? map[x][y].getHeight() : max;
            }
        //normalize
        for (int x = 0; x < this.height; x++)
             for (int y = 0; y < this.width; y++)
                 map[x][y].setHeight((map[x][y].getHeight() - min) / (max - min));
    }
}
