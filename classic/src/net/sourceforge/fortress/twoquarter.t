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
    
    <ui:box align="topleft" layout="place" shrink="true" width="48" height="24">
        
        // top-left vs bottom-left
        thisbox.forward;
        // used to give the graphics a non-repeating feel
        thisbox.seed = vexi.math.floor(vexi.math.random()*10);
        // used to set the base fill of the tile
        thisbox.base = "grass";
        
        var sync = function() { fill = .iso96[base][base+seed]; }
        sync();
        
        thisbox.addPiece = function(type, top, left, zoffset) {
            var t = type.split('.');
            var z = static.zindex[t[0]];
            if (z == null) throw "tried to add nonregistered type '"+type+"' from "+posx+", "+posy;
            // static.z*zoffset allows us to place tiles untouchably infront of others
            z += static.z * (zoffset ? zoffset : 0);
            var p;
            var i = 0;
            var n = numchildren;
            while (n > i) {
                p = thisbox[i];
                if (p.z == z and p.left == left and p.top == top)
                    throw "tried to add a duplicate piece '"+t[0]+"("+z+") ' from "+posx+", "+posy;
                if (p.z > z) break;
                i++;
            }
            
            var r = .iso96;
            for (var i=0; t.length>i; i++) r = r[t[i]];
            var b = vexi.box;
            b.fill = r;
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
        
        thisbox.delPiece = function(type, top, left, zoffset) {
            var z = static.zindex[type];
            if (z == null) throw "tried to add nonregistered type '"+type+"' from "+posx+", "+posy;
            // static.z*zoffset allows us to place tiles untouchably infront
            z += static.z * (zoffset ? zoffset : 0);
            var p;
            for (var i=0; numchildren>i; i++) {
                p = thisbox[i];
                if (p.z == z and p.left == left and p.top == top) {
                    thisbox[i] = null;
                    return;
                }
            }
            throw "tried to clear a non-existent piece of type '"+type[0]+"' from "+posx+", "+posy;
        }
        
        thisbox.posx ++= static.posFunc;
        thisbox.posy ++= static.posFunc;
        
    </ui:box>
    
    static.posFunc = function(v) {
        cascade = v;
        trapee.top = 0 == (trapee.posx + trapee.posy) % 2;
    }
    
    static.tileset = "iso96";
    
    static.varies = {};
    static.zindex = {};
    static.ztiles = [];
    static.z = 0;
    
    static.register = function(name, v) {
        if (zindex[name]) throw "duplicate entrie in zindex table";
        if (!v) v = 1;
        varies[name] = v;
        zindex[name] = static.z;
        ztiles[static.z] = name;
        static.z++;
    }
    
    static.init = function() {
        register("highlight");
        register("grid");
        register("squaretower");
    }
    
    { init(); }
    
</vexi>