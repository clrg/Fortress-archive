<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns:meta="vexi://meta" xmlns="net.sourceforge.fortress">
    <meta:doc>
        <author>Charles Goodwin</author>
        <about>An portion of an isometric tile on the map</about>
        <usage>
            A tile representing two quarters of an isometric tile on
            the map (hence the name).  The two quarters are either side
            of a diagonal axis of the template box.
            
            There are two types of tile - the diagonal starts either
            topleft or bottomleft - we use the back/forward slash
            analogy as representation.
        </usage>
    </meta:doc>
    
    <ui:box layout="place" shrink="true" width="48" height="24">
        
        // top-left vs bottom-left
        thisbox.forward;
        // used to give the graphics a non-repeating feel
        thisbox.seed = vexi.math.floor(vexi.math.random()*10);
        // used to set the base fill of the tile
        thisbox.type = "grass";
        
        var sync = function() { fill = .image[type][type+seed]; }
        sync();
        
        thisbox.addPiece = function(type, top, left)
        {
            var z = static.zindex[type];
            if (z == null) throw "tried to add nonregistered type '"+type+"' from "+posx+", "+posy;
            var i = 0;
            var p;
            while (numchildren > i)
            {
                p = thisbox[i];
                if (p.type == type and p.left == left and p.top == top)
                    throw "tried to add a duplicate tile piece of type '"+type+"' from "+posx+", "+posy;
                if (p.z > z) break;
                i++;
            }
            
            var b = vexi.box;
            b.fill = .image[static.tileset][type];
            b.left = left;
            b.top = top;
            b.shrink = true;
            b.type = type;
            b.x = left ? 0 : -48;
            b.y = top ? 0 : -24;
            b.z = z;
            thisbox[i] = b;
            // in case we have special meaning attached to the piece
            return b;
        }
        
        thisbox.delPiece = function(type, top, left)
        {
            var p;
            for (var i=0; numchildren>i; i++)
            {
                p = thisbox[i];
                if (p.type == type and p.left == left and p.top == top)
                {
                    thisbox[i] = null;
                    return;
                }
            }
            throw "tried to clear a non-existent piece of type '"+type+"' from "+posx+", "+posy;
        }
        
        thisbox.posx ++= static.posFunc;
        thisbox.posy ++= static.posFunc;
        
    </ui:box>
    
    static.posFunc = function(v)
    {
        cascade = v;
        trapee.top = 0 == (trapee.posx + trapee.posy) % 2;
    }
    
    static.tileset = "iso96";
    
    static.varies = { };
    static.zindex = { };
    static.ztiles = [ ];
    static.z = 0;
    
    static.register = function(name, v)
    {
        if (zindex[name]) throw "duplicate entrie in zindex table";
        if (!v) v = 1;
        varies[name] = v;
        zindex[name] = static.z;
        ztiles[static.z] = name;
        static.z++;
    }
    
    static.init = function()
    {
        register("highlight");
        register("grid");
        register("towerbase");
        register("towerstem");
        register("towertop");
    }
    
    { init(); }
    
</vexi>