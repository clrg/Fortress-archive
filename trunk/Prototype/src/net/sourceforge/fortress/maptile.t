<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns="net.sourceforge.fortress">
    <ui:box shrink="true" width="20" height="20">
        
        thisbox.sync = function() { fill = .image[type][type+comp+seed]; }
        thisbox.type = "grass";
        thisbox.comp = "";
        thisbox.seed = vexi.math.floor(vexi.math.random()*10);
        
        sync();
        
    </ui:box>
</vexi>