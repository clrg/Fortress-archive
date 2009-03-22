<vexi xmlns:ui="vexi://ui" xmlns="fortress.image">
    <ui:box cursor="hand" width="38" height="38" layout="layer" shrink="true">
        <ui:box id="arrow" display="false" shrink="true" />
        
        thisbox.full = false;
        
        var syncArrow = function(v) {
            cascade = v;
            $arrow.fill = .misc["arrow"+(full?"1":"2")+"_"+face];
            $arrow.align = static.facealigns[face];
        }
        
        thisbox.full ++= syncArrow;
        thisbox.face ++= syncArrow;
        
        thisbox.full ++= function(v) { cascade = v; if (!v) $arrow.display = false; }
        
        Enter ++= function(v) {
            cascade = v;
            $arrow.display = true;
        }
        
        Leave ++= function(v) {
            cascade = v;
            if (!full) $arrow.display = false;
        }
        
    </ui:box>
    
    static.facealigns = { fn: "bottom", fs: "top", fe:"left", fw:"right",
        fne: "bottomleft", fnw: "bottomright", fse: "topleft", fsw: "topright" };
    
</vexi>