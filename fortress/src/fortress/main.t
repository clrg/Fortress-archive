<vexi xmlns:ui="vexi://ui" xmlns="fortress"
    xmlns:role="org.vexi.lib.role"
    xmlns:lay="vexi.layout"
    xmlns:wi="vexi.widget">
    <wi:surface />
    <ui:box framewidth="640" frameheight="480">
        <ui:box layout="place">
            <role:draggable id="board" align="bottomleft" layout="layer" width="4000" height="2000" fill=":.image.grass">
                <ui:box id="grid" fill=":.image.grid" />
                <ui:box id="select" align="bottomleft" fill=":.image.grid_select" shrink="true" />
            </role:draggable>
            <lay:pad id="icons" align="bottom" padding="10" vshrink="true">
                <ui:box fill=":.image.compass" shrink="true" />
                <ui:box />
                <icon id="build" image="hammer" />
                <ui:box width="10" />
                <icon id="build" image="pickaxe" />
                <ui:box width="10" />
                <icon id="build" image="scroll" />
            </lay:pad>
        </ui:box>
        
        ////////
        // icon handling
        
        var selected;
        
        var selectIcon = function(v) {
            var deselect = trapee == selected;
            if (selected) {
                selected.selected = false;
                selected = null;
                if (deselect) return;
            }
            selected = trapee;
            selected.selected = true;
            return;
        }
        
        for (var i=0; $icons.numchildren>i; i++) {
            $icons[i].Press1 ++= selectIcon;
        }
        
        $board.Move ++= function(v) {
            cascade = v;
            var board_m = $board.mouse;
            $select.x = board_m.x - board_m.x%50;
            $select.y = board_m.y - board_m.y%25 - $board.height + 25;
        }
        
        ////////
        // map dragging
        
        var limitx;
        var limity;
        var startx;
        var starty;
        
        $board.dragStart ++= function(v) {
            cascade = v;
            limitx = width-$board.width;
            limity = $board.height-height;
            startx = $board.x;
            starty = $board.y;
        }
        
        var max = function(a, b) { return a>b? a : b; }
        var min = function(a, b) { return b>a? a : b; }
        $board.dragUpdate ++= function(v) {
            cascade = v;
            $board.x = min(0, max(limitx, startx + v.x));
            $board.y = max(0, min(limity, starty + v.y));
        }
        
        vexi.ui.frame = thisbox;
        
    </ui:box>
</vexi>