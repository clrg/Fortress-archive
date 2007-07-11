<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns:meta="vexi://meta" xmlns="net.sourceforge.fortress">
    <meta:doc>
        <author>Charles Goodwin</author>
        <about>An portion of an isometric tile on the map</about>
        <usage>
            A tile representing two quarters of an isometric tile on
            the map (hence the name).  The two quarters are either side
            of a diagonal axis of the template box.
            
            There are two types of tile - top and bottom.  This means
            whether the tile to the right is a top piece or on the
            bottom of an isometric tile.
        </usage>
    </meta:doc>
    
    <ui:box layout="absolute" shrink="true" width="48" height="24">
        
        // top-left vs bottom-left
        thisbox.top = true;
        // used to give the graphics a non-repeating feel
        thisbox.seed = vexi.math.floor(vexi.math.random()*10);
        
        thisbox.addPiece = function(type, left)
        {
            var z = static.zindex[type];
            if (z == null) throw "tried to add nonregistered type '"+type+"' from "+posx+", "+posy;
            var i = 0;
            while (numchildren > i)
            {
                if (thisbox[i].type == type and thisbox[i].left == left)
                    throw "tried to add a duplicate tile piece of type '"+type+"' from "+posx+", "+posy;
                if (thisbox[i].z > z) break;
                i++;
            }
            
            var b = vexi.box;
            b.fill = .image[static.tileset][type];
            b.left = left;
            b.shrink = true;
            b.type = type;
            b.x = left ? 0 : -48;
            b.y = top ? 0 : -24;
            //vexi.log.info(posx+", "+posy+" -- "+top+", "+left);
            b.z = z;
            thisbox[i] = b;
        }
        
        thisbox.delPiece = function(type, left)
        {
            for (var i=0; numchildren>i; i++)
            {
                if (thisbox[i].type == type and thisbox[i].left == left)
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
    }
    
    { init(); }
    
</vexi>