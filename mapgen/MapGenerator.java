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

    public void generateMap_HillAlgorithm(int iterations) {
        Random rand = new Random();
        double min = 0;
        double max = 0;
        for (int i = 0; i < iterations; i++) {
            //generate random centerpoint
            int x1 = rand.nextInt(this.height);
            int y1 = rand.nextInt(this.width);
            //generate random radius
            int radius = rand.nextInt(this.width/2) + 1;
            double radius2 = java.lang.Math.pow(radius, 2);
            //for each point on the map, calculate height
            for (int x2 = 0; x2 < this.height; x2++) {
                for (int y2 = 0; y2 < this.width; y2++) {
                    double left = java.lang.Math.pow((x2-x1),2);
                    double right = java.lang.Math.pow((y2-y1),2);
                    double value = radius2 - (left + right);
                    if (value >= 0) {
                        min = (value < min) ? value : min;
                        max = (value > max) ? value : max;
                        double h = map[x2][y2].getHeight();
                        map[x2][y2].setHeight(value + h);
                    }
                }
            }
        }
        //normalize
        System.out.println("max : "+ max);
        System.out.println("min : "+ min);
        double nmin = 0;
        double nmax = 0;
        for (int x = 0; x < this.height; x++) {
             for (int y = 0; y < this.width; y++) {
                 double h = map[x][y].getHeight();
                 double value = ((h - min) / (max - min));
                 nmin = (value < nmin) ? value : nmin;
                 nmax = (value > nmax) ? value : nmax;
                 map[x][y].setHeight(value);
             }
        }
        System.out.println("nmax : "+ nmax);
        System.out.println("nmin : "+ nmin);
    }
}
