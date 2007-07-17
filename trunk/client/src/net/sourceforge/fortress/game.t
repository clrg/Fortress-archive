<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns:layout="vexi.layout" xmlns:widget="vexi.widget"
    xmlns="net.sourceforge.fortress">
    
    static.invertmouse = false;
    static.showgrid = true;
    
    <preloadimages />
    <ui:box orient="vertical">
        <panel id="top" padding="10" vshrink="true">
            <shadowtext text="Fortress Prototype v2" />
            <ui:box />
            <shadowtext text="Map Size 100 x 100" shrink="true" />
        </panel>
        <ui:box>
            <panel id="left" hshrink="true" orient="vertical" padding="5" />
            <layout:border border="#ffcc00" depth="1">
                <isogrid id="map" />
            </layout:border>
            <panel id="right" hshrink="true" orient="vertical" padding="5" />
        </ui:box>
        <panel id="bottom" vshrink="true" padding="10">
            <layout:border border="#ffcc00" depth="1" shrink="true">
                <minimap id="minimap" />
            </layout:border>
            <ui:box orient="vertical" vshrink="true">
            <!--
            <ui:box height="10" />
                <widget:check id="gridon" cursor="hand" focusable="false" selected="true">
                    <shadowtext text="Toggle Grid" />
                </widget:check>
                <ui:box height="10" />
                <widget:check id="invert" cursor="hand" focusable="false" selected="false">
                    <shadowtext text="Invert Mouse" />
                </widget:check>
               -->
            </ui:box>
            <layout:border border="#ffcc00" depth="1" shrink="true">
                <ui:box width="100" height="100" layout="place">
                    <ui:box fill=".image.logo_white" />
                </ui:box>
            </layout:border>
        </panel>
        
        thisbox.init = $map.init;
        
        //// Map / Sidebar Interaction ////////////////////////////////
        
        static.showgrid ++= function(v) { cascade = v; $map.gridon = v; }
        static.invertmouse ++= function(v) { cascade = v; $map.invert = v; }
       
        //// Panel Layout /////////////////////////////////////////////
        
        $top.height ++= function(v)
        {
            cascade = v;
            if (!display) return;
            $left.bgy = -v;
            $right.bgy = -v;
        }
        
        $map.height ++= function(v)
        {
            cascade = v;
            if (!display) return;
            $bottom.bgy = -((v + $top.height)%256);
            surface.setMapView(vexi.math.floor($map.width / 48), vexi.math.floor(v / 24));
        }
        
        $map.width ++= function(v)
        {
            cascade = v;
            if (!display) return;
            $right.bgx = -((v + $left.width)%256);
            surface.setMapView(vexi.math.floor(v / 48), vexi.math.floor($map.height / 24));
        }
        
    </ui:box>
</vexi>
