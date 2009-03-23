<vexi xmlns:ui="vexi://ui" xmlns:lay="vexi.layout" xmlns="vexi.widget"
    xmlns:image="fortress.image" xmlns:unit="fortress.unit">
    <surface />
    <ui:box frameheight="200" framewidth="420">
        <lay:pad orient="vertical" padding="10" hshrink="true">
            <ui:box vshrink="true" text="Unit" />
            <option id="units" />
            <ui:box vshrink="true" text="Animation" />
            <option id="anims" />
            <ui:box vshrink="true" text="Zoom Level" />
            <ui:box vshrink="true">
                <radio id="x1" text="x1" />
                <radio id="x2" text="x2" />
                <radio id="x4" text="x4" />
                $x4.group = $x2.group = $x1.group;
            </ui:box>
            <ui:box />
        </lay:pad>
        <ui:box orient="vertical" hshrink="true">
            <ui:box shrink="true">
                <unit:arrow id="fnw" face="fnw" />
                <unit:arrow id="fn" face="fn" />
                <unit:arrow id="fne" face="fne" />
            </ui:box>
            <ui:box shrink="true">
                <unit:arrow id="fw" face="fw" />
                <ui:box layout="layer" width="38" height="38">
                    <unit:base id="base" />
                </ui:box>
                <unit:arrow id="fe" face="fe" />
            </ui:box>
            <ui:box shrink="true">
                <unit:arrow id="fsw" face="fsw" />
                <unit:arrow id="fs" face="fs" />
                <unit:arrow id="fse" face="fse" />
            </ui:box>
            <ui:box />
        </ui:box>
        <ui:box />
        
        vexi.ui.frame = thisbox;
        
        var nowface = null;
        
        var pressEvent = function(v) {
            cascade = v;
            var t = trapee;
            if (t == nowface) return;
            if (nowface) {
                nowface.full = false;
            }
            nowface = t;
            $base.face = t.face;
            t.full = true;
        }
        
        $fnw.Press1 ++= pressEvent;
        $fn.Press1  ++= pressEvent;
        $fne.Press1 ++= pressEvent;
        $fw.Press1  ++= pressEvent;
        $fe.Press1  ++= pressEvent;
        $fsw.Press1 ++= pressEvent;
        $fs.Press1  ++= pressEvent;
        $fse.Press1 ++= pressEvent;
        
        for (var u in image.unit) {
            if (u.charAt(0) == '.') continue;
            var b = .item(vexi.box);
            b.text = u;
            $units[$units.numchildren] = b;
        }
        
        $anims.value ++= function(v) {
            cascade = v;
            $base.state = v;
        }
        
        $units.value ++= function(v) {
            cascade = v;
            while ($anims[0]) $anims[0] = null;
            var animbase = image.unit[v];
            for (var a in animbase) {
                if (a.charAt(0) == '.') continue;
                var b = .item(vexi.box);
                b.text = a.substring(0, a.length-4);
                b.value = a;
                $anims[0] = b;
            }
            $base.source = animbase;
            if ($anims[0]) $anims[0].selected = true;
        }
        
        if ($units[0]) $units[0].selected = true;
        
    </ui:box>
</vexi>