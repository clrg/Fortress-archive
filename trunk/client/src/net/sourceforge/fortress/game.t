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
            <panel id="left" hshrink="true">
                <ui:box width="10" />
                <ui:box orient="vertical" vshrink="true">
                    <layout:border border="#ffcc00" depth="1" shrink="true">
                        <minimap id="minimap" />
                    </layout:border>
                </ui:box>
                <ui:box width="10" />
            </panel>
            <layout:border border="#ffcc00" depth="1">
                <isogrid id="map" />
            </layout:border>
            <panel id="right" hshrink="true" padding="5" />
        </ui:box>
        <panel id="bottom" vshrink="true" padding="5" />
        
        vexi.ui.frame = thisbox;
        
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
        }
        
        $map.width ++= function(v)
        {
            cascade = v;
            $right.bgx = -((v + $left.width)%256);
        }
        
    </ui:box>
</vexi>