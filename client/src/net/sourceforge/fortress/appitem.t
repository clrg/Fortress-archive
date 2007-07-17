<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns:layout="vexi.layout" xmlns:role="org.vexi.lib.role"
    xmlns="net.sourceforge.fortress">
    <layout:pad align="center" padding="10" shrink="true">
        <role:clickable id="content" enabled="true" fontsize="16">
            
            thisbox.hover ++= function(v) { if (enabled) textcolor = "yellow"; return; }
            
            thisbox.normal ++= function(v)
            {
                cursor = enabled ? "hand" : "none"; 
                textcolor = enabled ? "white" : "gray"; 
                return; 
            }
            
        </role:clickable>
        
        var forwardFunc = function(v) { $content[trapname] = v; return; }
        
        thisbox.enabled ++= forwardFunc;
        thisbox.text ++= forwardFunc;
        
        $content.action ++= function(v) { thisbox.action = v; return; }
        
    </layout:pad>
</vexi>
