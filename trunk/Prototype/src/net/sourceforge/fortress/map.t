<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns="net.sourceforge.fortress">
    <ui:box layout="absolute">
        <ui:box id="map" shrink="true" />
        <ui:box id="cur" fill="#88ffffff" display="false" />
        
        var drag1 = false;
        var drag2 = false;
        
        //////// sample road creation /////////////////////////////////
        
        var createMudTile = function(tile)
        {
            if (tile.type == "mud") return;
            var posx = tile.posx;
            var posy = tile.posy;
            var comp = "";
            if (posy > 0 and $map[posx][posy-1].type == "mud")
            {
                var nt = $map[posx][posy-1];
                nt.comp = nt.comp.substring(0, 2) + "m" + nt.comp.substring(3);
                nt.sync();
                comp = comp + "m";
            }
            else comp = comp + "_";
            if ($map.numchildren > posx+1 and $map[posx+1][posy].type == "mud")
            {
                var nt = $map[posx+1][posy];
                nt.comp = nt.comp.substring(0, 3) + "m";
                nt.sync();
                comp = comp + "m";
            }
            else comp = comp + "_";
            if ($map[posx].numchildren > posy+1 and $map[posx][posy+1].type != "grass")
            {
                var nt = $map[posx][posy+1];
                nt.comp = "m" + nt.comp.substring(1);
                nt.sync();
                comp = comp + "m";
            }
            else comp = comp + "_";
            if (posx > 0 and $map[posx-1][posy].type != "grass")
            {
                var nt = $map[posx-1][posy];
                nt.comp = nt.comp.substring(0, 1) + "m" + nt.comp.substring(2);
                nt.sync();
                comp = comp + "m";
            }
            else comp = comp + "_";
            tile.seed = "";
            tile.type = "mud";
            tile.comp = comp;
            tile.sync();
            surface.setMapTile(tile);
        }
        
        var sr1Func = function(v)
        {
            drag1 = false;
            surface.Focused --= sr1Func;
            surface._Release1 --= sr1Func;
        }
        
        thisbox.Press1 ++= function(v)
        {
            if (!activeTile or drag2) return;
            createMudTile(activeTile);
            drag1 = true;
            surface.Focused ++= sr1Func;
            surface._Release1 ++= sr1Func;
        }
        
        //////// minimap interaction //////////////////////////////////
        
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
            var nx = ox + m.x - mx;
            var ny = oy + m.y - my;
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
            surface._Release2 --= dragStop;
            drag2 = false;
            cascade = v;
            active = true;
        }
        
        var dragStart = function(v)
        {
            if (drag1) return;
            drag2 = true;
            $cur.display = false;
            var m = thisbox.mouse;
            mx = m.x;
            my = m.y;
            ox = $map.x;
            oy = $map.y;
            vx = width - $map.width;
            vy = height - $map.height;
            surface.addMoveTrap(dragMove);
            surface._Release2 ++= dragStop;
            cascade = v;
        }
        
        thisbox.Press2 ++= dragStart;
        
        //////// tile tracking ////////////////////////////////////////
        
        thisbox.activeTile = null;
        
        thisbox.active ++= function(v)
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
            cascade = v;
            activeTile = trapee;
            if (drag1) createMudTile(trapee);
            if (!drag2) active = true;
        }
        
        thisbox.Leave ++= function(v) { $cur.display = false; }
        
        for (var i=0; 100>i; i++)
        {
            $map[i] = vexi.box;
            $map[i].orient = "vertical";
            for (var j=0; 100>j; j++)
            {
                var t = .maptile(vexi.box);
                t.Enter ++= enterFunc;
                t.posx = i;
                t.posy = j;
                $map[i][j] = t;
            }
        }
        
        surface ++= function(v)
        {
            cascade = v;
            surface.setMapContents($map);
            
            surface.moveMapTo = function(x, y)
            {
                var d = $map.distanceto($map[x][y]);
                var dx = width/2 - d.x;
                var dy = height/2 - d.y;
                $map.x = 0 > dx ? (dx > width - $map.width ? dx : width - $map.width) : 0;
                $map.y = 0 > dy ? (dy > height - $map.height ? dy : height - $map.height) : 0;
                surface.setMapPos($map.x, $map.y);
            }
        }
        
    </ui:box>
</vexi>