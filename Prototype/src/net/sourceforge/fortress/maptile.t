<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns="net.sourceforge.fortress">
    <ui:box shrink="true" width="20" height="20">
        
        thisbox.type = "grass";
        thisbox.seed = vexi.math.floor(vexi.math.random()*10);
        
        fill = .image[type+seed];
        
    </ui:box>
</vexi>