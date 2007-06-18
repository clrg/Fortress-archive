<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns="net.sourceforge.fortress">
    <ui:box shrink="true">
        
        var type = "grass";
        var seed = vexi.math.floor(vexi.math.random()*10);
        
        fill = .image[type+seed];
        
    </ui:box>
</vexi>