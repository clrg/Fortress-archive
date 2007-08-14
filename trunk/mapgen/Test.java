public class Test {
    public static void main(String argv[]) {
        MapGenerator mg = new MapGenerator(20,20);
        mg.generateMap_HillAlgorithm(1);
        mg.printMap();
    }
}
