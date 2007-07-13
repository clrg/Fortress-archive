<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns:layout="vexi.layout" xmlns:widget="vexi.widget"
    xmlns="net.sourceforge.fortress">
    <widget:surface />
    <preloadimages />
    <ui:box orient="vertical" titlebar="Fortress Prototype">
        <panel id="top" padding="10" vshrink="true">
            <shadowtext text="Fortress Prototype v2" />
            <ui:box />
            <shadowtext text="Map Size 100 x 100" shrink="true" />
        </panel>
        <ui:box>
            <panel id="left" hshrink="true" orient="vertical" padding="0 10">
                <layout:border border="#ffcc00" depth="1" shrink="true">
                    <minimap id="minimap" />
                </layout:border>
                <ui:box orient="vertical" vshrink="true">
                    <ui:box height="10" />
                    <widget:check id="gridon" cursor="hand" focusable="false" selected="true">
                        <shadowtext text="Toggle Grid" />
                    </widget:check>
                    <ui:box height="10" />
                    <widget:check id="invert" cursor="hand" focusable="false" selected="false">
                        <shadowtext text="Invert Mouse" />
                    </widget:check>
                </ui:box>
                <ui:box />
            </panel>
            <layout:border border="#ffcc00" depth="1">
                <isogrid id="map" />
            </layout:border>
            <panel id="right" hshrink="true" padding="5" />
        </ui:box>
        <panel id="bottom" vshrink="true" padding="5" />
        
        vexi.ui.frame = thisbox;
        
        //// Map / Sidebar Interaction ////////////////////////////////
        
        $gridon.selected ++= function(v) { cascade = v; $map.gridon = v; }
        $invert.selected ++= function(v) { cascade = v; $map.invert = v; }
        
        //// Panel Layout /////////////////////////////////////////////
        
        $top.height ++= function(v)
        {
            cascade = v;
            $left.bgy = -v;
            $right.bgy = -v;
        }
        
        $map.height ++= function(v)
        {
            cascade = v;
            $bottom.bgy = -((v + $top.height)%256);
            surface.setMapView(vexi.math.floor($map.width / 48), vexi.math.floor(v / 24));
        }
        
        $map.width ++= function(v)
        {
            cascade = v;
            $right.bgx = -((v + $left.width)%256);
            surface.setMapView(vexi.math.floor(v / 48), vexi.math.floor($map.height / 24));
        }
        
    </ui:box>
</vexi>
