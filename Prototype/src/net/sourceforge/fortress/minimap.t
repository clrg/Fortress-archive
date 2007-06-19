<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns="net.sourceforge.fortress">
    <ui:box height="100" width="100">
        <ui:box shrink="true">
            <ui:box id="minimap" cols="1" shrink="true" />
            <ui:box id="viewbox" cols="1" align="topleft" packed="false">
                <ui:box fill="white" height="1" />
                <ui:box>
                    <ui:box fill="white" width="1" />
                    <ui:box />
                    <ui:box fill="white" width="1" />
                </ui:box>
                <ui:box fill="white" height="1" />
            </ui:box>
        </ui:box>
        
        var mw = 1;
        var mh = 1;
        var mx = 1;
        var my = 1;
        var vw = 1;
        var vh = 1;
        
        var syncView = function()
        {
            $viewbox.width = $minimap.width * (vw / mw) + 1;
            $viewbox.height = $minimap.height * (vh / mh) + 1;
            $viewbox.x = $minimap.width * (-mx / mw);
            $viewbox.y = $minimap.height * (-my / mh);
        }
        
        surface ++= function(v)
        {
            cascade = v;
            
            surface.setMapBox = function(_vw, _vh)
            {
                vw = _vw;
                vh = _vh;
                syncView();
            }
            
            surface.setMapDim = function(_mw, _mh)
            {
                mw = _mw;
                mh = _mh;
                syncView();
            }
            
            surface.setMapPos = function(_mx, _my)
            {
                mx = _mx;
                my = _my;
                syncView();
            }
            
            surface.setMapContents = function(map)
            {
                var ni = map.numchildren;
                var nj = map[0].numchildren;
                for (var i=0; ni > i; i++)
                {
                    $minimap[i] = vexi.box;
                    for (var j=0; nj > j; j++)
                    {
                        var t = .minimaptile(vexi.box);
                        t.setType(map[i][j].type, map[i][j].seed);
                        $minimap[i][j] = t;
                    }
                }
            }
        }
        
    </ui:box>
</vexi>
