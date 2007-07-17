<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns:layout="vexi.layout" xmlns:widget="vexi.widget"
    xmlns="net.sourceforge.fortress">
    <widget:surface />
    <ui:box titlebar="Fortress Prototype">
        <widget:cardpane id="cp">
            <ui:box id="menu" fill=".image.stonebg" orient="vertical">
                <ui:box />
                <appitem id="res" text="Resume" enabled="false" />
                <appitem id="new" text="New Game" />
                <appitem id="res" text="Options" enabled="false" />
                <appitem text="Quit">
                    action ++= function(v) { surface.Close = true; return; }
                </appitem>
                <ui:box />
            </ui:box>
            <ui:box id="loading" fill=".image.stonebg" orient="vertical">
                <ui:box />
                <appitem text="Loading Map" />
                <ui:box height="10" shrink="true" />
                <busy id="busy" align="center" shrink="true" />
                <ui:box />
            </ui:box>
            <game id="game" />
        </widget:cardpane>
        
        var showGame = function(v)
        {
            $busy.stop();
            $cp.show = $game;
        }
        
        $new.action ++= function(v)
        {
            $game.init(showGame);
            $busy.start();
            $cp.show = $loading;
            return;
        }
        
        vexi.ui.frame = thisbox;
        
    </ui:box>
</vexi>