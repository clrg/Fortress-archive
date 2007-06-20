<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns="net.sourceforge.fortress" xmlns:role="org.vexi.lib.role">
    <role:surface />
    <ui:box titlebar="Fortress Prototype">
        <ui:box cols="1" hshrink="true">
            <minimap />
            <ui:box fill="#888888" height="1" />
            <ui:box height="5" />
            <ui:box id="tiletype" textcolor="white" vshrink="true" />
            <ui:box height="5" />
            <ui:box id="position" textcolor="white" vshrink="true" />
            <ui:box />
        </ui:box>
        <ui:box fill="#888888" width="1" />
        <map id="map" />
        
        vexi.ui.frame = thisbox;
        
        $map.active ++= function(v)
        {
            $position.text = "( "+$map.activeTile.posx+", "+$map.activeTile.posy+" )";
            $tiletype.text = $map.activeTile.type;
            cascade = v;
        }
        
    </ui:box>
</vexi>