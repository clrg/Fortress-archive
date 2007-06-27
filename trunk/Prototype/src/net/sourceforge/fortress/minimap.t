<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns="net.sourceforge.fortress">
    <ui:box height="100" width="100" layout="absolute">
        <ui:box layout="absolute">
            $minimap.width ++= function(v) { cascade = v; width = v; }
            $minimap.height ++= function(v) { cascade = v; height = v; }
            <ui:box id="minimap" shrink="true" />
            <ui:box id="viewbox" orient="vertical" align="topleft">
                <ui:box fill="white" height="1" vshrink="true" />
                <ui:box>
                    <ui:box fill="white" width="1" hshrink="true" />
                    <ui:box />
                    <ui:box fill="white" width="1" hshrink="true" />
                </ui:box>
                <ui:box fill="white" height="1" vshrink="true" />
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
        
        var moveMapFunc = function(v)
        {
            vexi.log.info(v);
            // assumes minimap tiles are 1px by 1px
            surface.moveMapTo(mouse.x, mouse.y);
            cascade = v;
        }
        
        var releaseFunc = function(v)
        {
            Move --= moveMapFunc;
            surface._Release1 --= releaseFunc;
        }
        
        var pressFunc = function(v)
        {
            Move ++= moveMapFunc;
            surface._Release1 ++= releaseFunc;
        }
        
        thisbox.Press1 ++= pressFunc;
        
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
                    $minimap[i].orient = "vertical";
                    for (var j=0; nj > j; j++)
                    {
                        var t = .minimaptile(vexi.box);
                        t.Press1 ++= moveMapFunc;
                        t.setType(map[i][j].type, map[i][j].seed);
                        $minimap[i][j] = t;
                    }
                }
            }
            
            surface.setMapTile = function(t)
            {
                $minimap[t.posx][t.posy].setType(t.type, t.seed);
            }
        }
        
    </ui:box>
</vexi>
