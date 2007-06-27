<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns="net.sourceforge.fortress">
    <surface />
    <preloadimages />
    <ui:box titlebar="Fortress Prototype">
        <ui:box orient="vertical" shrink="true">
            <minimap />
            <ui:box fill="#888888" height="1" />
            <ui:box height="5" />
            <ui:box id="tiletype" align="center" textcolor="white" />
            <ui:box height="5" />
            <ui:box id="position" align="center" textcolor="white" />
        </ui:box>
        <ui:box fill="#888888" width="1" hshrink="true" />
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