<!-- Copyright 2007 - GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns:meta="vexi://meta" xmlns="net.sourceforge.fortress"
    xmlns:layout="vexi.layout" xmlns:rdrt="vexi.util.redirect">
    <meta:doc>
       <author>Charles Goodwin</author>
    </meta:doc>
    
    <ui:box redirect="$content">
        <ui:box id="bg" fill=".image.stonebg" />
        <layout:pad id="pad">
            <ui:box id="content" />
        </layout:pad>
        
        layout = "absolute";
        rdrt..addRedirect(thisbox, $content, "layout", "orient");
        rdrt..addRedirect(thisbox, $pad, "padding");
        
        var sizeFunc = function(v) { cascade = v; thisbox["min"+trapname] = v; }
        
        hshrink ++= function(v) { cascade = v; $pad.width ++= sizeFunc; }
        vshrink ++= function(v) { cascade = v; $pad.height ++= sizeFunc; }
        
        thisbox.bgx ++= function(v) { $bg.x = v; return; }
        thisbox.bgy ++= function(v) { $bg.y = v; return; }
        
    </ui:box>
</vexi>