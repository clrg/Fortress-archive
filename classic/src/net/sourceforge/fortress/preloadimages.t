<!-- Copyright 2007 licensed under GPL v3 -->

<vexi xmlns:ui="vexi://ui" xmlns="net.sourceforge.fortress">
    <ui:box>
        <ui:box display="false">
            <ui:box fill=":.image.stonebg" />
            <ui:box fill=":.image.logo_white" />
            <ui:box fill=":.image.logo" />
            <ui:box fill=":.iso96.grid" />
            <ui:box fill=":.iso96.highlight" />
            <ui:box fill=":.iso96.squaretower.base" />
            <ui:box fill=":.iso96.squaretower.stem" />
            <ui:box fill=":.iso96.squaretower.top1" />
            <ui:box fill=":.iso96.squaretower.top2" />
            <ui:box name="grass" loop="10" />
            
            for (var i=0; numchildren>i; i++)
            {
                if (thisbox[i].name)
                {
                    var p = thisbox[i];
                    for (var j=0; p.loop>j; j++)
                    {
                        var b = vexi.box;
                        b.fill = .image[p.name][p.name+j];
                        p[j] = b;
                    }
                }
            }
            
        </ui:box>
    </ui:box>
</vexi>