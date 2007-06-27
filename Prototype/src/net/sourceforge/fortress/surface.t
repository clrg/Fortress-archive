<!-- Copyright 2006 - see COPYING for details [LGPL] -->

<vexi xmlns:ui="vexi://ui" xmlns:meta="vexi://meta" xmlns:role="org.vexi.lib.role">
    <meta:doc>
        <author>Charles Goodwin</author>
        <desc>Applied to every new surface (frame/window)</desc>
    </meta:doc>
    
    <ui:box>
        
        var closeLock = false;  // for locking trap forwarding on CLose/s.Close
        var s = {};             // the surface object
        
        /** proxy to the surface object */
        thisbox.surface ++= function() { return s; };
        
        /** notify surface.Close when closing surface */
        thisbox.Close ++= function(v)
        {
            if (closeLock) return;
            closeLock = true;
            s.Close = true;
            closeLock = false;
            cascade = v;
        }
        
        /** manually redirect s.Close */
        s.Close ++= function(v)
        {
            if (closeLock) return;
            closeLock = true;
            Close = true;
            closeLock = false;
            cascade = v;
        }
        
        /** root.distanceTo proxy function */
        s.distanceto = function(v) { return thisbox.distanceto(v); }
        
        /** access to the surface mouse object */
        s.mouse ++= function() { return thisbox.mouse; }
        
        /** used to add traps on surface.Move as redirecting Move impacts performance */
        s.addMoveTrap = function(v) { thisbox._Move ++= v; }
        
        /** used to remove traps from surface.Move */
        s.delMoveTrap = function(v) { thisbox._Move --= v; }
        
        /** redirect events to the surface object for access */
        vexi..vexi.util.redirect..addRedirect(surface, thisbox,
            "width", "height", "x", "y", "titlebar",
            "Focused", "Maximized", "Minimized",
            "Click1", "Click2", "Click3", "HScroll", "VScroll",
            "DoubleClick1", "DoubleClick2", "DoubleClick3",
            "KeyPressed", "KeyReleased",
            "Press1", "Press2", "Press3",
            "Release1", "Release2", "Release3",
            "_Click1", "_Click2", "_Click3", "_HScroll", "_VScroll",
            "_DoubleClick1", "_DoubleClick2", "_DoubleClick3",
            "_KeyPressed", "_KeyReleased",
            "_Press1", "_Press2", "_Press3",
            "_Release1", "_Release2", "_Release3" );
        
    </ui:box>
    <role:focusmanager />
    <role:popupmanager />
    <role:tooltipmanager />
</vexi>
