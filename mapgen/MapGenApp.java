import java.awt.*;
import java.awt.geom.*;
import javax.swing.*;

public class MapGenApp extends JPanel {
    private MapGenerator map;

    public void paintComponent(Graphics g) {
        clear(g);
        Graphics2D g2d = (Graphics2D)g;
        for(int h = 0; h < map.getHeight(); h++) {
            for(int w = 0; w < map.getWidth(); w++) {
                double c = map.getMapSection(h,w).getHeight();
                float nc = 1 - (float)c;
                try {
                    g2d.setColor(new Color(nc,nc,nc));
                } catch (java.lang.IllegalArgumentException e) {
                    System.out.println(h + " " + w + " " + nc);
                    g2d.setColor(new Color(255,0,0));
                }
                g2d.draw(new Ellipse2D.Double((double)h,(double)w,1.0,1.0));
            }
        }
    }
    
    protected void clear(Graphics g) {
        super.paintComponent(g);
    }
    
    public static void main(String[] args) {
        MapGenApp app = new MapGenApp();
        int iterations = new Integer(args[0]);
        app.map = new MapGenerator(600,600);
        app.map.generateMap_HillAlgorithm(iterations);
        JFrame frame = new JFrame("mapgen");
        frame.setBackground(Color.white);
        app.setBackground(Color.white);
        frame.setSize(600,600);
        frame.setContentPane(app);
        frame.addWindowListener(new ExitListener());
        frame.setVisible(true);
    }
}
