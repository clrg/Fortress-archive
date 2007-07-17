<vexi xmlns:ui="vexi://ui">
    <ui:box width="32" height="32" layout="place">
        <ui:box id="preload" display="false" fill=".net.sourceforge.fortress.image.process" />
        <ui:box id="icon" shrink="true" />
        
        var active = false;
        var size = 0;
        var tip = false;
        var wait = false;
        
        var threadFunc = function(v)
        {
            active = true;
            var i = 1;
            while (active)
            {
                if (wait) continue;
                $icon.x = -(i%8)*size;
                $icon.y = -((i-(i%8))/8)*size;
                vexi.thread.sleep(50);
                if (++i == size) i = 1;
            }
            tip = false;
        }
        
        /** status of the animation */
        thisbox.busy ++= function() { return tip; }
        
        /** pause the busy animation */
        thisbox.pause = function() { wait = true; }
        
        /** (re)start the busy animation */
        thisbox.start = function()
        {
            if (tip) { wait = false; return; }
            tip = true;
            size = 32;
            width = size;
            height = size;
            display = true;
            $icon.fill = $preload.fill;
            vexi.thread = threadFunc;
        }
        
        /** stop the busy animation */
        thisbox.stop = function()
        {
            active = false;
            $icon.x = 0;
            $icon.y = 0;
            display = false;
        }
        
    </ui:box>
</vexi>