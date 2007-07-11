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
    
    <ui:box layout="absolute">
        <ui:box id="map" shrink="true" />
        
        //// GRID HANDLING ////////////////////////////////////////////
        
        var hideGrid = function()
        {
            for (var i=0; 100>i; i++)
                for (var j=0; 100>j; j++)
                    $map[i][j].delPiece("grid", true);
        }
        
        var showGrid = function()
        {
            for (var i=0; 100>i; i++)
                for (var j=0; 100>j; j++)
                    $map[i][j].addPiece("grid", true);
        }
        
        var gridon = false;
        
        // temporarily assignment of Press1 to grid toggling
        thisbox.Press1 ++= function(v)
        {
            cascade = v;
            gridon = !gridon;
            if (gridon) showGrid(); else hideGrid();
        }
        
        //// MAP DRAGGING /////////////////////////////////////////////
        
        var drag1 = false;
        var drag2 = false;
        var mx;
        var my;
        var ox;
        var oy;
        var vx;
        var vy;
        
        var move2Func = function(v)
        {
            var m = surface.mouse;
            var nx = ox + m.x - mx;
            var ny = oy + m.y - my;
            nx = 0 > nx ? (nx > vx ? nx : vx) : 0;
            ny = 0 > ny ? (ny > vy ? ny : vy) : 0;
            $map.x = nx;
            $map.y = ny;
            cascade = v;
        }
        
        var release2Func = function(v)
        {
            drag2 = false;
            surface._Release2 --= callee;
            surface.delMoveTrap(move2Func);
            cascade = v;
        }
        
        var press2Func = function(v)
        {
            var s = surface;
            drag2 = true;
            mx = s.mouse.x;
            my = s.mouse.y;
            ox = $map.x;
            oy = $map.y;
            vx = width - $map.width;
            vy = height - $map.height;
            s._Release2 ++= release2Func;
            s.addMoveTrap(move2Func);
            cascade = v;
        }
        
        thisbox.Press2 ++= press2Func;
        
        //// MAP CREATION /////////////////////////////////////////////
        
        var activePiece = null;
        
        var enterFunc = function(v)
        {
            cascade = v;
            activePiece = trapee;
            if (!drag2)
            {
                var top = trapee.mouse.x > trapee.mouse.y * 2;
            }
        }
        
        for (var i=0; 100>i; i++)
        {
            $map[i] = vexi.box;
            $map[i].orient = "vertical";
            for (var j=0; 100>j; j++)
            {
                var t = .twoquarter(vexi.box);
                t.Enter ++= enterFunc;
                t.posx = i;
                t.posy = j;
                t.fill = "#009900"; // temporary
                $map[i][j] = t;
            }
        }
        
    </ui:box>
</vexi>