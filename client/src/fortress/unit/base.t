<vexi xmlns:ui="vexi://ui" xmlns="fortress.unit">
    <ui:box redirect="null" layout="layer" width="32" height="32">
        <ui:box id="image" align="topleft" shrink="true" />
        
        var xoffset = 0;
        var yoffset = 0;
        var stop = false;
        
        thisbox.face = null;
        thisbox.source = null;
        thisbox.state = null;
        
        source ++= function(v) {
            cascade = v;
            for (var seq in v) {
                if (seq.charAt(0) == '.') continue;
                static.cache(v, seq);
            }
            state = null;
        }
        
        var motion = function(v) {
            while (!stop) {
                $image.x = -xoffset;
                $image.y = -yoffset;
                xoffset += 32;
                if (xoffset >= $image.width) xoffset = 0;
                vexi.thread.sleep(100);
            }
            stop = false;
            tip = false;
        }
        
        var animate = function() {
            if (tip) return;
            tip = true;
            vexi.thread = motion;
        }
        
        state ++= function(v) {
            cascade = v;
            if (!state) { stop = true; return; }
            $image.fill = source[state];
            xoffset = 0;
            animate();
        }
            
        face ++= function(v) {
            cascade = v;
            yoffset = 32 * ((face and static.facepos[face]) ? static.facepos[face] : 0);
            animate();
        }
        
        visible ++= function(v) {
            cascade = v;
            if (!v) stop = true;
        }
        
    </ui:box>
    
    var imagecache = {};
    
    static.cache = function(src, seq) {
        var b = vexi.box;
        try { b.fill = src[seq]; } catch (e) { vexi.log.info(e); }
        imagecache[seq] = b;
    }
    
    static.facepos = { fn: 2, fs: 3, fw: 1, fe: 0, fne: 4, fnw:6, fse:5, fsw:7 }; 
    
</vexi>