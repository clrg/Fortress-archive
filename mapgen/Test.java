public class Test {
    public static void main(String argv[]) {
        MapGenerator mg = new MapGenerator(10,10);
        mg.printMap();
        mg.generateMap_HillAlgorithm();
        mg.printMap();
    }
}
