<vexi xmlns:ui="vexi://ui" xmlns="fortress"
    xmlns:lay="vexi.layout">
    <ui:box layout="layer" shrink="true">
        <lay:border id="outer" depth="1">
            <lay:border id="inner" depth="1" />
        </lay:border>
        <ui:box id="image" cursor="hand" />
        
        thisbox.border ++= function(v) {
            $outer.border = v ? "#88"+v.substring(1) : null;
            $inner.border = v;
            return;
        }
        
        Enter ++= function(v) { if (!selected) border = "#ffff00"; return; }
        Leave ++= function(v) { if (!selected) border = null; return; }
        
        thisbox.selected ++= function(v) {
            cascade = v;
            border = v ? "#ff9900" : (mouse.inside ? "#ffff00" : null);
        }
        
        thisbox.image ++= function(v) {
            cascade = v;
            $image.fill = .image[v];
        }
        
    </ui:box>
</vexi>