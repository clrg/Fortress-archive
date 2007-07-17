<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns:layout="vexi.layout" xmlns:widget="vexi.widget"
        xmlns="net.sourceforge.fortress">
    <widget:surface />
    <ui:box titlebar="Fortress Prototype">
        <widget:cardpane id="cp">
            <ui:box id="menu" fill=".image.stonebg" orient="vertical">
                <ui:box />
                <appitem id="logo" fill=".image.logo" enabled="false" />
                <appitem id="res" text="Resume" enabled="false" />
                <appitem id="new" text="New Game" />
                <appitem id="opt" text="Options" />
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
            <ui:box id="options" fill=".image.stonebg" orient="vertical">
                <ui:box />
                <appitem text="Options Menu" enabled="false" />
                <ui:box height="10" shrink="true" />
                <!--
                <appitem>
                    <shadowtext text="Map Dimensions" />
                  </appitem>
                  <appitem>
                    <widget:spin id="spin_mapwidth" width="40" min="100" max="200" step="1" />
                    <widget:spin id="spin_mapheight" width="40" min="100" max="200" step="1" />
                </appitem>
                -->
                <appitem id="showgrid" text="Hide Grid" />
                <appitem id="invertmouse" text="Normal Mouse" />
                <appitem id="opt_ret" text="Save and Return to Main Menu" />
                <ui:box />
            </ui:box>
            <game id="game" />
        </widget:cardpane>
        
        //thisbox.mapwidth ++= function(v) { return $spin_mapwidth.value; }
        //thisbox.mapheight ++= function(v) { return $spin_mapheight.value; }
        
        $showgrid.action ++= function(v) 
        {
            cascade = v;
            .game..showgrid = !.game..showgrid;
            trapee.text = .game..showgrid ? "Show Grid" : "Hide Grid";
        }
                    
        $invertmouse.action ++= function(v) 
        {
            cascade = v;
              .game..invertmouse = !.game..invertmouse;
              trapee.text = .game..invertmouse ? "Invert Mouse" : "Normal Mouse";
        }
        
        var showGame = function(v)
        {
            $busy.stop();
            $cp.show = $game;
        }
        
        /* start a new game */
        $new.action ++= function(v)
        {
            $game.init(showGame);
            $busy.start();
            $cp.show = $loading;
            return;
        }
        
        /** show the options menu */
        $opt.action ++= function(v)
        {
            $cp.show = $options;
            return;
        }
        
        /** return from the options menu to the main menu */
        $opt_ret.action ++= function(v)
        {
            $cp.show = $menu;
            return;
        }
        
        vexi.ui.frame = thisbox;
        
    </ui:box>
</vexi>
