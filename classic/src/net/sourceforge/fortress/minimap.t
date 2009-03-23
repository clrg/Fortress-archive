<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns="net.sourceforge.fortress">
    <ui:box height="100" width="100" layout="place">
        <ui:box align="topleft" layout="place">
            $minimap.width ++= function(v) { cascade = v; width = v; }
            $minimap.height ++= function(v) { cascade = v; height = v; }
            <ui:box id="minimap" shrink="true" />
            <ui:box id="viewbox" orient="vertical">
                <ui:box fill="white" height="1" vshrink="true" />
                <ui:box>
                    <ui:box fill="white" width="1" hshrink="true" />
                    <ui:box />
                    <ui:box fill="white" width="1" hshrink="true" />
                </ui:box>
                <ui:box fill="white" height="1" vshrink="true" />
            </ui:box>
        </ui:box>
        
        var map_w = 1;
        var map_h = 1;
        var map_x = 1;
        var map_y = 1;
        var view_w = 1;
        var view_h = 1;
        
        /** synchronizes the viewbox with the map */
        var syncView = function() {
            $viewbox.width = $minimap.width * (view_w / map_w) + 2;
            $viewbox.height = $minimap.height * (view_h / map_h) + 2;
            $viewbox.x = $minimap.width * (-map_x / map_w) - 1;
            $viewbox.y = $minimap.height * (-map_y / map_h) - 1;
        }
        
        var mx, my;
        var ox, oy;
        
        var moveMap = function() {
            // assumes minimap tiles are 1px by 1px
            var m = surface.mouse;
            var nx = ox + m.x - mx;
            var ny = oy + m.y - my;
            nx = 0 > nx ? 0 : (nx > $minimap.width-1 ? $minimap.width-1 : nx);
            ny = 0 > ny ? 0 : (ny > $minimap.height-1 ? $minimap.height-1 : ny);
            surface.moveMapTo(nx, ny);
        }
        
        var moveMapFunc = function(v) {
            cascade = v;
            moveMap();
        }
        
        var releaseFunc = function(v) {
            cascade = v;
            surface.delMoveTrap(moveMapFunc);
            surface.Focused --= releaseFunc;
            surface._Release1 --= releaseFunc;
        }
        
        var pressFunc = function(v) {
            cascade = v;
            var m = surface.mouse;
            mx = m.x;
            my = m.y;
            ox = mouse.x;
            oy = mouse.y;
            surface.addMoveTrap(moveMapFunc);
            surface.Focused ++= releaseFunc;
            surface._Release1 ++= releaseFunc;
            moveMap();
        }
        
        thisbox.Press1 ++= pressFunc;
        
        surface ++= function(v) {
            cascade = v;
            
            surface.setMapView = function(vw, vh) {
                view_w = vw;
                view_h = vh;
                syncView();
            }
            
            surface.setMapDim = function(mw, mh) {
                map_w = mw;
                map_h = mh;
                syncView();
            }
            
            surface.setMapPos = function(mx, my) {
                map_x = mx;
                map_y = my;
                syncView();
            }
            
            surface.setMap = function(map) {
                var ni = map.numchildren;
                var nj = map[0].numchildren;
                for (var i=0; ni > i; i++) {
                    $minimap[i] = vexi.box;
                    $minimap[i].orient = "vertical";
                    for (var j=0; nj > j; j++) {
                        var t = .minimaptile(vexi.box);
                        t.Press1 ++= moveMapFunc;
                        t.setType(map[i][j].type, map[i][j].seed);
                        $minimap[i][j] = t;
                    }
                }
            }
            
            surface.setMapTile = function(x, y, type, seed) {
                $minimap[x][y].setType(type, seed);
            }
        }
        
    </ui:box>
</vexi>
