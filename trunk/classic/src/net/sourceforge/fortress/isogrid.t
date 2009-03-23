<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns:meta="vexi://meta" xmlns="net.sourceforge.fortress"
    xmlns:role="org.vexi.lib.role">
    <meta:doc>
        <author>Charles Goodwin</author>
        <about>A grid of isometric tiles</about>
        <usage>
            This is not a typical isometric layout - rather than being
            a isometrically-shaped grid it is bound by perpendicular
            edges to the top, left, bottom, and right. i.e. the edges
            of the grid make a rectangular shape instead of a rhombus.
        </usage>
    </meta:doc>
    
    <ui:box align="topleft" layout="place">
        <ui:box id="map" shrink="true" />
        
        
        //// PIECE MANAGEMENT /////////////////////////////////////////
        
        var addPiece = function(piece, px, py, zoff) {
            if (!$map[px][py]) return;
            $map[px][py].addPiece(piece, true, true, zoff);
            $map[px+1][py].addPiece(piece, true, false, zoff);
            $map[px][py+1].addPiece(piece, false, true, zoff);
            $map[px+1][py+1].addPiece(piece, false, false, zoff);
        }
        
        var delPiece = function(piece, px, py) {
            if (!$map[px][py]) return;
            $map[px][py].delPiece(piece, true, true, zoff);
            $map[px+1][py].delPiece(piece, true, false, zoff);
            $map[px][py+1].delPiece(piece, false, true, zoff);
            $map[px+1][py+1].delPiece(piece, false, false, zoff);
        }
        
        var activePiece = null;
        
        var hx, hy;
        
        var highlight = function(tx, ty) {
            if (hx != null and hy != null) {
                delPiece("highlight", hx, hy);
                hx = null;
                hy = null;
            }
            
            // FIXME: replace hardcoded upper limits
            if (0 > tx or 0 > ty or tx + 1 > 99 or ty + 1 > 99) return;
            
            hx = tx;
            hy = ty;
            addPiece("highlight", hx, hy);
        }
        
        var moveFunc = function(v) {
            cascade = v;
            var m = activePiece.mouse;
            var f = activePiece.forward;
            // work out which isometric tile we are closest to
            var d = (f ? (24 - m.y) : m.y) * 2 > m.x;
            highlight(activePiece.posx - (d ? 1 : 0),
                      activePiece.posy - (f ? (d ? 1 : 0) : (d ? 0 : 1)));
        }
        
        thisbox.Move ++= moveFunc;
        
        var leaveFunc = function(v) {
            cascade = v;
            highlight(-1, -1);
        }
        
        thisbox.Leave ++= leaveFunc;
        
        var pieceEnterFunc = function(v) {
            cascade = v;
            activePiece = trapee;
        }
        
        var callSetMapPos = function(v) {
            var tx = vexi.math.floor($map.x / 48);
            var ty = vexi.math.floor($map.y / 24);
            surface.setMapPos(tx, ty);
        }
        
        
        //// GRID HANDLING ////////////////////////////////////////////
        
        /* grid is a special piece referenced to tile.grid during map
         * creation - so displaying the grid is as a simple as putting
         * to tile.grid.display */
        
        var hideGrid = function() {
            var n = $map.numchildren;
            var m = $map[0] ? $map[0].numchildren : 0;
            for (var i=0; n>i; i++)
                for (var j=0; m>j; j++)
                    $map[i][j].grid.display = false;
        }
        
        var showGrid = function() {
            var n = $map.numchildren;
            var m = $map[0] ? $map[0].numchildren : 0;
            for (var i=0; n>i; i++)
                for (var j=0; m>j; j++)
                    $map[i][j].grid.display = true;
        }
        
        /** check what options have been set */
        var invert;
        
        .game..showgrid ++= function(v) { cascade = v; if (v) showGrid(); else hideGrid(); };
        .game..invertmouse ++= function(v) { cascade = v; invert = v; };
        
        /** initialises the map, calling callback() on completion */
        thisbox.init = function(callback) {
            vexi.thread = function(v) {
                for (var i=0; 100>i; i++) {
                    $map[i] = vexi.box;
                    $map[i].orient = "vertical";
                    for (var j=0; 100>j; j++) {
                        var t = .twoquarter(vexi.box);
                        t.Enter ++= pieceEnterFunc;
                        t.forward = (i+j)%2 == 0;
                        t.posx = i;
                        t.posy = j;
                        $map[i][j] = t;
                        $map[i][j].grid = 
                            $map[i][j].addPiece("grid", $map[i][j].forward, true);
                        vexi.thread.yield();
                    }
                }
                callSetMapPos();
                surface.setMap($map);
                surface.setMapDim(100,100);
                if (!.game..showgrid) hideGrid();
                invert = .game..invertmouse;
                callback();
            }
        }
        
        surface ++= function(v) {
            cascade = v;
            
            surface.moveMapTo = function(x, y) {
                var d = $map.distanceto($map[x][y]);
                var dx = width/2 - d.x;
                var dy = height/2 - d.y;
                $map.x = 0 > dx ? (dx > width - $map.width ? dx : width - $map.width) : 0;
                $map.y = 0 > dy ? (dy > height - $map.height ? dy : height - $map.height) : 0;
                callSetMapPos();
            }
        }
        
        
        //// MAP DRAGGING /////////////////////////////////////////////
        
        // invert mouse movement on map dragging
        var drag1 = false;
        var drag2 = false;
        var mx;
        var my;
        var ox;
        var oy;
        var vx;
        var vy;
        
        var drag2Func = function(v) {
            var m = surface.frame.mouse;
            var nx;
            var ny;
            if (!invert) {
                // new_x,y = map_origin_x,y + current_mouse_x,y - mouse_origin_x,y
                nx = ox + m.x - mx;
                ny = oy + m.y - my;
            } else {
                // new_x,y = map_origin_x,y + mouse_origin_x,y - current_mouse_x,y
                nx = ox + mx - m.x;
                ny = oy + my - m.y;
            }
            // crop new_x,y to keep map display within screen bounds
            // below is an optimized version of: max(0, min(nx, vy))
            nx = 0 > nx ? (nx > vx ? nx : vx) : 0;
            ny = 0 > ny ? (ny > vy ? ny : vy) : 0;
            $map.x = nx;
            $map.y = ny;
            cascade = v;
        }
        
        var release2Func = function(v) {
            drag2 = false;
            Move ++= moveFunc;
            surface.event._Release2 --= callee;
            surface.event.delMoveTrap(drag2Func);
            callSetMapPos();
            cascade = v;
        }
        
        var press2Func = function(v) {
            if (drag1) return;
            drag2 = true;
            Move --= moveFunc;
            var s = surface;
            // mouse origin
            mx = s.frame.mouse.x;
            my = s.frame.mouse.y;
            // map origin
            ox = $map.x;
            oy = $map.y;
            // x,y limit
            vx = width - $map.width;
            vy = height - $map.height;
            s.event._Release2 ++= release2Func;
            s.event.addMoveTrap(drag2Func);
            highlight(-1, -1);
            cascade = v;
        }
        
        thisbox.Press2 ++= press2Func;
        
        
        //// Piece Placing ////////////////////////////////////////////
        
        var press1Func = function(v) {
            cascade = v;
            if (drag2) return;
            drag1 = true;
            if (hx == null or hy == null) return;
            addPiece("squaretower.base", hx, hy);
            addPiece("squaretower.stem", hx, hy-2, 1);
            addPiece("squaretower.top1", hx, hy-4, 2);
            addPiece("squaretower.top2", hx, hy-6, 3);
        }
        
        thisbox.Press1 ++= press1Func;
        
        var release1Func = function(v) {
            cascade = v;
            drag1 = false;
        }
        
        thisbox.Release1 ++= release1Func;
        
        
        //// Keyboard Shortcuts ///////////////////////////////////////
        
        thisbox.KeyPressed ++= function(v) {
            cascade = v;
            if (v == "A-g" or v == "A-G")
                .game..showgrid = !.game..showgrid;
            else if (v == "A-i" or v == "A-I")
                .game..invertmouse = !.game..invertmouse;
        }
        
    </ui:box>
    <role:focusable />
</vexi>
