<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns="net.sourceforge.fortress">
    <ui:box>
        <ui:box id="map" align="topleft" cols="1" packed="false" shrink="true" />
        <ui:box id="cur" align="topleft" fill="#88ffffff" display="false" packed="false" />
        
        var mapDim = function(v)
        {
            cascade = v;
            surface.setMapDim($map.width, $map.height);
        }
        
        $map.width ++= mapDim;
        $map.height ++= mapDim;
        
        var mapBox = function(v)
        {
            cascade = v;
            surface.setMapBox(width, height);
        }
        
        thisbox.width ++= mapBox;
        thisbox.height ++= mapBox;
        
        //////// map movement /////////////////////////////////////////
        
        var mx;
        var my;
        var ox;
        var oy;
        var vx;
        var vy;
        
        var dragMove = function(v)
        {
            var m = thisbox.mouse;
            var nx = ox - m.x + mx;
            var ny = oy - m.y + my;
            nx = 0 > nx ? (nx > vx ? nx : vx) : 0;
            ny = 0 > ny ? (ny > vy ? ny : vy) : 0;
            $map.x = nx;
            $map.y = ny;
            surface.setMapPos(nx, ny);
            cascade = v;
        }
        
        var dragStop = function(v)
        {
            surface.delMoveTrap(dragMove);
            surface.Release2 --= dragStop;
            cascade = v;
        }
        
        var dragStart = function(v)
        {
            var m = thisbox.mouse;
            mx = m.x;
            my = m.y;
            ox = $map.x;
            oy = $map.y;
            vx = width - $map.width;
            vy = height - $map.height;
            surface.addMoveTrap(dragMove);
            surface.Release2 ++= dragStop;
            cascade = v;
        }
        
        thisbox.Press2 ++= dragStart;
        
        //////// tile tracking ////////////////////////////////////////
        
        thisbox.activeTile = null;
        
        var active = function()
        {
            var d = thisbox.distanceto(activeTile);
            $cur.display = true;
            $cur.width = activeTile.width;
            $cur.height = activeTile.height;
            $cur.x = d.x;
            $cur.y = d.y;
        }
        
        var enterFunc = function(v)
        {
            activeTile = trapee;
            cascade = v;
            active();
        }
        
        thisbox.Leave ++= function(v) { $cur.display = false; }
        
        for (var i=0; 50>i; i++)
        {
            $map[i] = vexi.box;
            for (var j=0; 50>j; j++)
            {
                var t = .maptile(vexi.box);
                t.Enter ++= enterFunc;
                t.posx = j;
                t.posy = i;
                $map[i][j] = t;
            }
        }
        
        surface ++= function(v)
        {
            cascade = v;
            surface.setMapContents($map);
        }
        
    </ui:box>
</vexi>