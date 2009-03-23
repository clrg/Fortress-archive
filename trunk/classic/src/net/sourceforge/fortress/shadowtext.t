<vexi xmlns:ui="vexi://ui">
    <ui:box layout="place">
        <ui:box id="shadow" textcolor="black" x="1" y="1" shrink="true" />
        <ui:box id="text" textcolor="white" shrink="true" />
        
        text ++= function(v) {
            $shadow.text = v;
            $text.text = v;
            cascade = "";
        }
        
        var sizeFunc = function(v) { cascade = v; thisbox[trapname] = v + 1; }
        
        $text.height ++= sizeFunc;
        $text.width ++= sizeFunc;
        
    </ui:box>
</vexi>