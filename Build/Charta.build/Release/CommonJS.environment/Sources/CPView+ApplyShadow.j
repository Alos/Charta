@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/CPView.jI;20;AppKit/CPTextField.jt;2145;

objj_executeFile("Foundation/Foundation.j", NO);
objj_executeFile("AppKit/CPView.j", NO);
objj_executeFile("AppKit/CPTextField.j", NO);



{
var the_class = objj_getClass("CPView")
if(!the_class) throw new SyntaxError("*** Could not find definition for class \"CPView\"");
var meta_class = the_class.isa;









class_addMethods(the_class, [new objj_method(sel_getUid("applyShadow:offset:"), function $CPView__applyShadow_offset_(self, _cmd, aShadowColor, anOffset)
{
    var subviews = objj_msgSend(CPArray, "arrayWithArray:", objj_msgSend(self, "subviews"));

    for (var i = 0; i < objj_msgSend(subviews, "count"); i++)
    {
        var v = objj_msgSend(subviews, "objectAtIndex:", i);
        if (objj_msgSend(v, "isKindOfClass:", CPTextField) && !objj_msgSend(v, "isEditable"))
        {
            objj_msgSend(v, "setValue:forThemeAttribute:", aShadowColor, "text-shadow-color");
            objj_msgSend(v, "setValue:forThemeAttribute:", anOffset, "text-shadow-offset");
        }
    }
}
,["void","CPColor","CGSize"]), new objj_method(sel_getUid("applyShadow"), function $CPView__applyShadow(self, _cmd)
{
    objj_msgSend(self, "applyShadow:offset:", objj_msgSend(CPColor, "whiteColor"), CGSizeMake(0.0, 1.0));
}
,["void"]), new objj_method(sel_getUid("applyGlow"), function $CPView__applyGlow(self, _cmd)
{
    objj_msgSend(self, "applyGlow:spread:size:", objj_msgSend(CPColor, "whiteColor"), 10, CGSizeMake(0, 0));
}
,["void"]), new objj_method(sel_getUid("applyGlow:spread:size:"), function $CPView__applyGlow_spread_size_(self, _cmd, aColor, aSpreadValue, aSize)
{
    var CSSString = aColor ? aSize.height + "px " + aSize.width + "px  " + aSpreadValue + "px " + objj_msgSend(aColor, "cssString") : "";

    self._DOMElement.style.boxShadow = CSSString;
    self._DOMElement.style.MozBoxShadow = CSSString;
    self._DOMElement.style.WebkitBoxShadow = CSSString;
}
,["void","CPColor","int","CGSize"]), new objj_method(sel_getUid("setHasWhiteShadow:"), function $CPView__setHasWhiteShadow_(self, _cmd, shouldHaveWhiteShadow)
{
    if (shouldHaveWhiteShadow)
        objj_msgSend(self, "applyShadow");
}
,["void","BOOL"])]);
}