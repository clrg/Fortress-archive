<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns="net.sourceforge.fortress">
    <ui:box width="1" height="1" shrink="true">
        
        var getFillHex = function(s) {
            switch (s) {
            case 0: return "50";
            case 1: return "58";
            case 2: return "60";
            case 3: return "68";
            case 4: return "70";
            case 5: return "78";
            case 6: return "80";
            case 7: return "88";
            case 8: return "90";
            case 9: return "98";
            }
            return "FF";
        }
        
        thisbox.setType = function(t, s) {
            switch (t) {
            case "mud":
                fill = "#5f2a07";
                break;
            case "grass":
            default:
                fill = "#00" + getFillHex(s) + "00";
            }
        }
        
    </ui:box>
</vexi>
