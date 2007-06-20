<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns="net.sourceforge.fortress">
    <ui:box width="1" height="1" shrink="true">
        
        var getFillHex = function(s)
        {
            switch (s)
            {
               case 0: return "70";
               case 1: return "78";
               case 2: return "80";
               case 3: return "88";
               case 4: return "90";
               case 5: return "98";
               case 6: return "A0";
               case 7: return "A8";
               case 8: return "B0";
               case 9: return "B8";
            }
            return "FF";
        }
        
        thisbox.setType = function(t, s)
        {
            switch (t)
            {
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
