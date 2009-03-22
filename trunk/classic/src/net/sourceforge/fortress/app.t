<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns:layout="vexi.layout" xmlns:widget="vexi.widget"
        xmlns="net.sourceforge.fortress">
    <widget:surface />
    <ui:box titlebar="Fortress Prototype">
        <widget:cardpane id="cp">
            <ui:box id="menu" fill=":.image.stonebg">
                <ui:box />
                <ui:box align="center" fill=":.image.logo_white" shrink="true" />
                <ui:box align="center" orient="vertical" shrink="true">
                    <appitem id="res" text="Resume" enabled="false" />
                    <appitem id="new" text="New Game" />
                    <appitem id="opt" text="Options" />
                    <appitem text="Quit">
                        action ++= function(v) { surface.Close = true; return; }
                    </appitem>
                </ui:box>
                <ui:box />
            </ui:box>
            <ui:box id="loading" fill=":.image.stonebg" orient="vertical">
            <ui:box />
                <appitem text="Loading Map" />
                <ui:box height="10" shrink="true" />
                <busy id="busy" align="center" shrink="true" />
                <ui:box />
            </ui:box>
            <ui:box id="options" fill=":.image.stonebg" orient="vertical">
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
                <appitem id="showgrid" option="showgrid" text1="Show Grid" text2="Hide Grid" />
                <appitem id="invertmouse" option="invertmouse" text1="Normal Mouse" text2="Invert Mouse" />
                <appitem id="opt_ret" text="Save and Return to Main Menu" />
                <ui:box />
            </ui:box>
            <game id="game" />
        </widget:cardpane>
        
        
        //// Option Handling //////////////////////////////////////////
        
        //thisbox.mapwidth ++= function(v) { return $spin_mapwidth.value; }
        //thisbox.mapheight ++= function(v) { return $spin_mapheight.value; }
        
        var toggleOption = function(v)
        {
            cascade = v;
            // this is like .game..gameoption - [""] is equivalent to .
            // needed as we are using strings for property reference
            .game[""][trapee.option] = !.game[""][trapee.option];
            trapee.value = .game[""][trapee.option];
        }
        
        $showgrid.action ++= toggleOption;
        $invertmouse.action ++= toggleOption;
        
        // ensure menu options represent current settings
        .game..showgrid ++= function(v) { cascade = v; $showgrid.value = v; };
        .game..invertmouse ++= function(v) { cascade = v; $invertmouse.value = v; };
        // initialise to defaults as set in game.t
        .game..showgrid = .game..showgrid;
        .game..invertmouse = .game..invertmouse;
        
        // FIXME: why does this not work?
        surface._KeyPressed ++= function(k)
        {
            cascade = k;
            if (v == "escape") $cp.show = $menu;
        }
        
        
        //// Game Loading /////////////////////////////////////////////
        
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
        surface = true;
        
    </ui:box>
</vexi>
