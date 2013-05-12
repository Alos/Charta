@STATIC;1.0;p;6;main.jt;294;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.jt;208;objj_executeFile("Foundation/Foundation.j", NO);
objj_executeFile("AppKit/AppKit.j", NO);
objj_executeFile("AppController.j", YES);
main = function(args, namedArgs)
{
    CPApplicationMain(args, namedArgs);
}p;15;AppController.jt;21469;@STATIC;1.0;I;21;Foundation/CPObject.jI;23;WKTextView/WKTextView.ji;25;ui/CharacterSheetButton.ji;17;ui/LightBoxView.ji;38;ui/CharacterSheet/CharacterSheetView.ji;40;ui/CharacterSheet/CharacterSheetWindow.jt;21255;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("WKTextView/WKTextView.j", NO);
objj_executeFile("ui/CharacterSheetButton.j", YES);
objj_executeFile("ui/LightBoxView.j", YES);
objj_executeFile("ui/CharacterSheet/CharacterSheetView.j", YES);
objj_executeFile("ui/CharacterSheet/CharacterSheetWindow.j", YES);
var NewToolbarItemIdentifier = "NewToolbarItemIdentifier",
    BoldToolbarItemIdentifier = "BoldToolbarItemIdentifier",
    ItalicsToolbarItemIdentifier = "ItalicsToolbarItemIdentifier",
    UnderlineToolbarItemIdentifier = "UnderlineToolbarItemIdentifier",
    StrikethroughToolbarItemIdentifier = "StrikethroughToolbarItemIdentifier",
    AlignLeftToolbarItemIdentifier = "AlignLeftToolbarItemIdentifier",
    AlignRightToolbarItemIdentifier = "AlignRightToolbarItemIdentifier",
    AlignCenterToolbarItemIdentifier = "AlignCenterToolbarItemIdentifier",
    AlignFullToolbarItemIdentifier = "AlignFullToolbarItemIdentifier",
    InsertLinkToolbarItemIdentifier = "InsertLinkToolbarItemIdentifier",
    UnlinkToolbarItemIdentifier = "UnlinkToolbarItemIdentifier",
    InsertImageToolbarItemIdentifier = "InsertImageToolbarItemIdentifier",
    FontToolbarItemIdentifier = "FontToolbarItemIdentifier",
    BulletsToolbarItemIdentifier = "BulletsToolbarItemIdentifier",
    NumbersToolbarItemIdentifier = "NumbersToolbarItemIdentifier",
    RandomTextToolbarItemIdentifier = "RandomTextToolbarItemIdentifier";
var CHARACTERSHEETWIDTH = 800;
var CHARACTERSHEETHEIGHT = 800;
{var the_class = objj_allocateClassPair(CPObject, "AppController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("contentView"), new objj_ivar("editorView"), new objj_ivar("toolbar"), new objj_ivar("characterSheetButton"), new objj_ivar("characterSheetlightBoxView"), new objj_ivar("characterSheetWindow")]);objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("applicationDidFinishLaunching:"), function $AppController__applicationDidFinishLaunching_(self, _cmd, aNotification)
{
    var theWindow = objj_msgSend(objj_msgSend(CPWindow, "alloc"), "initWithContentRect:styleMask:", CGRectMakeZero(), CPBorderlessBridgeWindowMask);
    self.contentView = objj_msgSend(theWindow, "contentView");
    var colorImage = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(objj_msgSend(CPBundle, "mainBundle"), "pathForResource:", "texture3.png"), CGSizeMake(97, 97));
    objj_msgSend(self.contentView, "setBackgroundColor:", objj_msgSend(CPColor, "colorWithPatternImage:", colorImage));
    var middle = (CGRectGetWidth(objj_msgSend(self.contentView, "bounds")) / 2) - 400;
    var calculatedEditorFrame = CGRectMake(middle, 40, 1000, CGRectGetHeight(objj_msgSend(self.contentView, "bounds")) - 80);
    self.editorView = objj_msgSend(objj_msgSend(WKTextView, "alloc"), "initWithFrame:", calculatedEditorFrame);
    objj_msgSend(self.editorView, "setAutohidesScrollers:", NO);
    objj_msgSend(self.editorView, "setAutoresizingMask:", CPViewHeightSizable | CPViewMaxXMargin);
    objj_msgSend(self.editorView, "setDelegate:", self);
    objj_msgSend(self.editorView, "setShouldFocusAfterAction:", YES);
    var editorViewShadow = objj_msgSend(objj_msgSend(CPShadowView, "alloc"), "initWithFrame:", CGRectMakeZero());
    objj_msgSend(editorViewShadow, "setFrameForContentFrame:", calculatedEditorFrame);
    objj_msgSend(editorViewShadow, "setAutoresizingMask:", CPViewHeightSizable | CPViewMaxXMargin);
    objj_msgSend(self.contentView, "addSubview:", editorViewShadow);
    objj_msgSend(self.contentView, "addSubview:", self.editorView);
    self.characterSheetButton = objj_msgSend(objj_msgSend(CharacterSheetButton, "alloc"), "initWithFrame:", CGRectMake(CGRectGetWidth(objj_msgSend(self.contentView, "bounds")) - 50, CGRectGetHeight(objj_msgSend(self.contentView, "bounds"))/2 , 36 , 50));
    objj_msgSend(self.characterSheetButton, "setAutoresizingMask:", CPViewMinXMargin | CPViewMinYMargin | CPViewMaxYMargin);
    var characterSheetButtonShadow = objj_msgSend(objj_msgSend(CPShadowView, "alloc"), "initWithFrame:", CGRectMakeZero());
    objj_msgSend(characterSheetButtonShadow, "setFrameForContentFrame:", CGRectMake(CGRectGetWidth(objj_msgSend(self.contentView, "bounds")) - 50, CGRectGetHeight(objj_msgSend(self.contentView, "bounds"))/2 , 36 , 50));
    objj_msgSend(characterSheetButtonShadow, "setAutoresizingMask:", CPViewMinXMargin | CPViewMinYMargin | CPViewMaxYMargin);
    objj_msgSend(self.contentView, "addSubview:", characterSheetButtonShadow);
    objj_msgSend(self.contentView, "addSubview:", self.characterSheetButton);
    self.toolbar = objj_msgSend(objj_msgSend(CPToolbar, "alloc"), "initWithIdentifier:", "Styling");
    objj_msgSend(self.toolbar, "setDelegate:", self);
    objj_msgSend(self.toolbar, "setVisible:", YES);
    objj_msgSend(theWindow, "setToolbar:", self.toolbar);
    objj_msgSend(theWindow, "orderFront:", self);
    self.characterSheetWindow = objj_msgSend(objj_msgSend(CharacterSheetWindow, "alloc"), "initWithContentRect:styleMask:", CGRectMake( CGRectGetWidth(objj_msgSend(self.contentView, "bounds")) + CHARACTERSHEETWIDTH, CGRectGetHeight(objj_msgSend(self.contentView, "bounds"))/2 - (CHARACTERSHEETHEIGHT/2) , CHARACTERSHEETWIDTH, CHARACTERSHEETHEIGHT), CPTitledWindowMask);
    self.characterSheetlightBoxView = objj_msgSend(objj_msgSend(LightBoxView, "alloc"), "initWithFrame:", objj_msgSend(self.contentView, "bounds"));
    objj_msgSend(self.characterSheetlightBoxView, "setAutoresizingMask:", CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin);
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("showCharacterSheetView:"), "ShowCharacterSheetView", nil);
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("removeCharacterSheet:"), "RemoveSheet", self.characterSheetlightBoxView);
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("characterSheetWindowBacameMain:"), "CPWindowDidBecomeMainNotification", self.characterSheetWindow);
}
,["void","CPNotification"])]);
}
{
var the_class = objj_getClass("AppController")
if(!the_class) throw new SyntaxError("*** Could not find definition for class \"AppController\"");
var meta_class = the_class.isa;


class_addMethods(the_class, [new objj_method(sel_getUid("animationDidEnd:"), function $AppController__animationDidEnd_(self, _cmd, animation){
    CPLog.trace("Animation did end");
}
,["void","CPViewAnimation"]), new objj_method(sel_getUid("characterSheetWindowBacameMain:"), function $AppController__characterSheetWindowBacameMain_(self, _cmd, notification){
    CPLog.trace("Character sheet became main");
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "postNotificationName:object:userInfo:", "characterSheetBecameKey", self, nil);
}
,["void","CPNotification"]), new objj_method(sel_getUid("showCharacterSheetView:"), function $AppController__showCharacterSheetView_(self, _cmd, aNotification){
    objj_msgSend(self.characterSheetWindow, "makeKeyAndOrderFront:", self);
    var oldFrame = objj_msgSend(self.characterSheetWindow, "frame");
    CPLog.trace(oldFrame.origin.x);
    oldFrame.origin.x -= CHARACTERSHEETWIDTH * 2;
    CPLog.trace(oldFrame.origin.x);
    objj_msgSend(self.characterSheetWindow, "setFrame:display:animate:", oldFrame, NO, YES);
    objj_msgSend(self.contentView, "addSubview:", self.characterSheetlightBoxView);
}
,["void","CPNotification"]), new objj_method(sel_getUid("removeCharacterSheet:"), function $AppController__removeCharacterSheet_(self, _cmd, aNotification){
    objj_msgSend(self.characterSheetlightBoxView, "removeFromSuperview");
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "postNotificationName:object:userInfo:", "characterSheetWillClose", self, nil);
    var oldFrame = objj_msgSend(self.characterSheetWindow, "frame");
    oldFrame.origin.x += CHARACTERSHEETWIDTH * 2;
    objj_msgSend(self.characterSheetWindow, "setFrame:display:animate:", oldFrame, YES, YES);
    objj_msgSend(self.characterSheetWindow, "close");
}
,["void","CPNotification"])]);
}
{
var the_class = objj_getClass("AppController")
if(!the_class) throw new SyntaxError("*** Could not find definition for class \"AppController\"");
var meta_class = the_class.isa;







class_addMethods(the_class, [new objj_method(sel_getUid("toolbarAllowedItemIdentifiers:"), function $AppController__toolbarAllowedItemIdentifiers_(self, _cmd, aToolbar)
{
    return [NewToolbarItemIdentifier, CPToolbarSpaceItemIdentifier, BoldToolbarItemIdentifier, ItalicsToolbarItemIdentifier, UnderlineToolbarItemIdentifier, StrikethroughToolbarItemIdentifier, CPToolbarSpaceItemIdentifier, AlignLeftToolbarItemIdentifier, AlignRightToolbarItemIdentifier, AlignCenterToolbarItemIdentifier, AlignFullToolbarItemIdentifier, CPToolbarSpaceItemIdentifier, BulletsToolbarItemIdentifier, NumbersToolbarItemIdentifier, InsertLinkToolbarItemIdentifier, UnlinkToolbarItemIdentifier, InsertImageToolbarItemIdentifier, FontToolbarItemIdentifier, CPToolbarFlexibleSpaceItemIdentifier, RandomTextToolbarItemIdentifier];
}
,["CPArray","CPToolbar"]), new objj_method(sel_getUid("toolbarDefaultItemIdentifiers:"), function $AppController__toolbarDefaultItemIdentifiers_(self, _cmd, aToolbar)
{
    return objj_msgSend(self, "toolbarAllowedItemIdentifiers:", aToolbar);
}
,["CPArray","CPToolbar"]), new objj_method(sel_getUid("toolbar:itemForItemIdentifier:willBeInsertedIntoToolbar:"), function $AppController__toolbar_itemForItemIdentifier_willBeInsertedIntoToolbar_(self, _cmd, aToolbar, anItemIdentifier, aFlag)
{
    var toolbarItem = objj_msgSend(objj_msgSend(CPToolbarItem, "alloc"), "initWithItemIdentifier:", anItemIdentifier);
    var mainBundle = objj_msgSend(CPBundle, "mainBundle");
    var actionMap =
    {
        NewToolbarItemIdentifier: { 'image': 'page_white.png', 'label': 'New', 'target': self.editorView, 'action':sel_getUid("clearText:") },
        BoldToolbarItemIdentifier: { 'image': 'text_bold.png', 'label': 'Bold', 'target': self.editorView, 'action':sel_getUid("boldSelection:") },
        ItalicsToolbarItemIdentifier: { 'image': 'text_italic.png', 'label': 'Italics', 'target': self.editorView, 'action':sel_getUid("italicSelection:") },
        UnderlineToolbarItemIdentifier: { 'image': 'text_underline.png', 'label': 'Under', 'target': self.editorView, 'action':sel_getUid("underlineSelection:") },
        RandomTextToolbarItemIdentifier: { 'image': 'page_white_text.png', 'label': 'Lorem', 'target': self, 'action':sel_getUid("setRandomText:") },
        StrikethroughToolbarItemIdentifier: { 'image': 'text_strikethrough.png','label': 'Strike', 'target': self.editorView, 'action':sel_getUid("strikethroughSelection:") },
        AlignLeftToolbarItemIdentifier: { 'image': 'text_align_left.png', 'label': 'Left', 'target': self.editorView, 'action':sel_getUid("alignSelectionLeft:") },
        AlignRightToolbarItemIdentifier: { 'image': 'text_align_right.png', 'label': 'Right', 'target': self.editorView, 'action':sel_getUid("alignSelectionRight:") },
        AlignCenterToolbarItemIdentifier: { 'image': 'text_align_center.png', 'label': 'Center', 'target': self.editorView, 'action':sel_getUid("alignSelectionCenter:") },
        AlignFullToolbarItemIdentifier: { 'image': 'text_align_justify.png','label': 'Justify', 'target': self.editorView, 'action':sel_getUid("alignSelectionFull:") },
        BulletsToolbarItemIdentifier: { 'image': 'text_list_bullets.png', 'label': 'Bullets', 'target': self.editorView, 'action':sel_getUid("insertUnorderedList:") },
        NumbersToolbarItemIdentifier: { 'image': 'text_list_numbers.png', 'label': 'Numbers', 'target': self.editorView, 'action':sel_getUid("insertOrderedList:") },
        InsertLinkToolbarItemIdentifier: { 'image': 'link.png', 'label': 'Link', 'target': self, 'action':sel_getUid("doLink:") },
        UnlinkToolbarItemIdentifier: { 'image': 'link_break.png', 'label': 'Unlink', 'target': self.editorView, 'action':sel_getUid("unlinkSelection:") },
        InsertImageToolbarItemIdentifier: { 'image': 'picture.png', 'label': 'Image', 'target': self, 'action':sel_getUid("doImage:") },
    };
    var action = actionMap[anItemIdentifier];
    if (action)
    {
        var image = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(mainBundle, "pathForResource:", "silk/"+action['image']), CPSizeMake(16, 16));
        objj_msgSend(toolbarItem, "setImage:", image);
        objj_msgSend(toolbarItem, "setTarget:", action['target']);
        objj_msgSend(toolbarItem, "setAction:", action['action']);
        objj_msgSend(toolbarItem, "setLabel:", action['label']);
        objj_msgSend(toolbarItem, "setMinSize:", CGSizeMake(16, 16));
        objj_msgSend(toolbarItem, "setMaxSize:", CGSizeMake(16, 16));
    }
    else if (anItemIdentifier == FontToolbarItemIdentifier)
    {
        objj_msgSend(toolbarItem, "setMinSize:", CGSizeMake(160, 25));
        objj_msgSend(toolbarItem, "setMaxSize:", CGSizeMake(160, 25));
        var dropdown = objj_msgSend(objj_msgSend(CPPopUpButton, "alloc"), "initWithFrame:pullsDown:", CGRectMake(0, 0, 160, 25), NO);
        objj_msgSend(dropdown, "setTarget:", self);
        objj_msgSend(dropdown, "setAction:", sel_getUid("doFont:"));
        var fonts = objj_msgSend(objj_msgSend(CPFontManager, "sharedFontManager"), "availableFonts");
        for(var i=0; i<fonts.length; i++)
        {
            var fontName = fonts[i],
                menuItem = objj_msgSend(objj_msgSend(CPMenuItem, "alloc"), "initWithTitle:action:keyEquivalent:", fontName, nil, nil);
            objj_msgSend(dropdown, "addItem:", menuItem);
        }
        objj_msgSend(dropdown, "setTitle:", "Select Font...");
        objj_msgSend(toolbarItem, "setView:", dropdown);
        objj_msgSend(toolbarItem, "setLabel:", "Font");
    }
    return toolbarItem;
}
,["CPToolbarItem","CPToolbar","CPString","BOOL"]), new objj_method(sel_getUid("doFont:"), function $AppController__doFont_(self, _cmd, button) {
    var fontName = objj_msgSend(button, "titleOfSelectedItem");
    objj_msgSend(self.editorView, "setFontNameForSelection:", fontName);
}
,["void",null]), new objj_method(sel_getUid("doLink:"), function $AppController__doLink_(self, _cmd, sender)
{
    var link = prompt("Enter a link: ", "http://www.280north.com");
    if (link)
        objj_msgSend(self.editorView, "linkSelectionToURL:", link);
}
,["id",null]), new objj_method(sel_getUid("doImage:"), function $AppController__doImage_(self, _cmd, sender)
{
    var link = prompt("Enter an image URL: ", "http://objective-j.org/images/cappuccino-icon.png");
    if (link)
        objj_msgSend(self.editorView, "insertImageWithURL:", link);
}
,["id",null]), new objj_method(sel_getUid("setRandomText:"), function $AppController__setRandomText_(self, _cmd, sender)
{
    objj_msgSend(self.editorView, "setHtmlValue:", "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut est urna, vulputate sed viverra dignissim, consequat vitae eros. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Suspendisse ut sapien enim, et pellentesque elit. In commodo facilisis est, et tempus lacus aliquam vitae. Maecenas quam nulla, elementum ut tristique quis, cursus a nisi. Duis mollis risus vel velit molestie convallis nec a purus. Donec neque arcu, suscipit sit amet mattis eu, fringilla ac sapien. Ut lorem nibh, mollis in tincidunt at, volutpat ut turpis. Maecenas nulla est, tincidunt pharetra consectetur vel, laoreet sed nibh. Pellentesque tempor diam vel elit commodo aliquet. Donec congue fringilla eros a tincidunt. Praesent accumsan mi tincidunt arcu ultricies nec pellentesque dolor faucibus. Mauris sed nisl in ligula porta congue et quis turpis. Suspendisse in lorem at felis tempus semper. In porta enim a ipsum aliquet consectetur.</p><p>Mauris ac tellus orci. Aenean egestas porta ornare. Cras nisl lorem, vulputate ac pellentesque eu, aliquet ac leo. Proin eros libero, tincidunt sed sodales eget, elementum non augue. Praesent convallis auctor venenatis. Suspendisse id urna quam. Aliquam sagittis, leo commodo laoreet interdum, arcu felis dictum velit, a sodales justo tortor a erat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nibh magna, consequat et congue eu, bibendum id nisi. Cras gravida risus in nulla pharetra sagittis. Cras neque eros, consectetur nec bibendum eget, bibendum dictum libero. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nam rutrum dictum neque vel eleifend. Vivamus tempus, lorem vel ultricies ullamcorper, ante risus imperdiet massa, nec aliquam orci ipsum ut nisl. Aliquam id justo eu lorem dapibus tincidunt. Donec suscipit consequat metus, sed venenatis lorem malesuada sit amet. Ut at risus ut ligula vulputate auctor. Vivamus rutrum elementum porttitor. Fusce quam arcu, tristique eget consectetur eu, iaculis in urna.</p><p>Donec a metus ac elit faucibus sagittis non a ligula. In aliquet, lectus sed pulvinar bibendum, justo ligula faucibus sem, vestibulum eleifend lacus augue a eros. Suspendisse potenti. Phasellus vehicula blandit ultrices. Donec tortor nulla, fermentum nec viverra id, consequat non metus. Fusce nunc urna, aliquet sit amet varius ut, dapibus a sem. Aliquam erat volutpat. Vestibulum at enim et magna lacinia sollicitudin id nec dolor. Sed ultricies urna ut justo blandit tincidunt. Sed sit amet orci et justo pellentesque iaculis accumsan ac quam.</p><p>Nunc tristique felis quis leo blandit eget iaculis lacus hendrerit. Maecenas euismod consequat lacus quis porttitor. Quisque consequat, metus eu interdum vulputate, quam dolor porttitor dui, non faucibus quam nibh nec erat. Integer sit amet gravida quam. Proin nunc eros, tincidunt sit amet accumsan laoreet, dictum vel sapien. Praesent at fringilla orci. Etiam vehicula lacinia nisi, et molestie justo congue molestie. Maecenas tempus, quam nec placerat suscipit, lorem sapien feugiat augue, id pharetra augue enim eu nisl. Morbi ullamcorper lacus ac dolor ultricies vel pellentesque odio consequat. Maecenas a pellentesque nunc. Phasellus a varius massa. Vestibulum eget tortor eget ante iaculis molestie. Pellentesque eu augue metus, ut pellentesque purus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Curabitur consequat feugiat tincidunt. Proin tellus tortor, pharetra vel rhoncus ac, varius eget nisi. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Cras et nunc metus. Pellentesque tincidunt iaculis erat id porta. Curabitur eget magna et velit eleifend tempor.</p><p>Vestibulum ultricies leo at augue malesuada congue. Maecenas laoreet metus et nunc consectetur placerat. Nulla facilisi. Duis iaculis tristique feugiat. Ut quis consectetur justo. Praesent condimentum sagittis dui, in lobortis tellus accumsan quis. In aliquam lacus non dolor accumsan rutrum. Etiam sed urna dolor. Donec consectetur lacus eu ante sodales feugiat. Aliquam aliquet nibh vel massa mattis pellentesque. Curabitur et tortor nisl, ut consequat felis. Mauris non orci at tortor ultrices condimentum. Aliquam erat volutpat. Mauris porttitor, diam convallis semper hendrerit, erat mi tempor dolor, id semper augue justo fermentum odio. Sed vitae nulla eu augue fringilla pellentesque vel ac neque. Nullam arcu nibh, auctor ut accumsan ac, ullamcorper eu velit. Integer in ligula nec felis auctor viverra. In commodo malesuada volutpat. Etiam justo elit, tincidunt ac semper sed, eleifend eu odio. Cras ac nulla eget lorem tempor venenatis.</p>");
}
,["id",null]), new objj_method(sel_getUid("textViewDidLoad:"), function $AppController__textViewDidLoad_(self, _cmd, textView)
{
    objj_msgSend(self, "textViewCursorDidMove:", textView);
}
,["void",null]), new objj_method(sel_getUid("textViewCursorDidMove:"), function $AppController__textViewCursorDidMove_(self, _cmd, textView)
{
    var items = objj_msgSend(self.toolbar, "visibleItems");
    for (var i=0; i<items.length; i++)
    {
        var item = items[i];
        if (objj_msgSend(item, "itemIdentifier") == FontToolbarItemIdentifier)
        {
            var font = objj_msgSend(self.editorView, "font");
            objj_msgSend(objj_msgSend(item, "view"), "selectItemWithTitle:", font);
        }
    }
}
,["void",null])]);
}
var animateViewToPoint = function(view, point, animation)
{
    var dict = objj_msgSend(CPDictionary, "dictionary"),
        frame1 = objj_msgSend(view, "frame"),
        frame2 = objj_msgSend(view, "frame");
    frame2.origin = point;
    objj_msgSend(dict, "setValue:forKey:", view, CPViewAnimationTargetKey);
    objj_msgSend(dict, "setValue:forKey:", frame1, CPViewAnimationStartFrameKey);
    objj_msgSend(dict, "setValue:forKey:", frame2, CPViewAnimationEndFrameKey);
    objj_msgSend(animation, "setViewAnimations:", [dict]);
    objj_msgSend(animation, "startAnimation");
};p;25;ui/CharacterSheetButton.jt;1852;@STATIC;1.0;t;1833;





{var the_class = objj_allocateClassPair(CPView, "CharacterSheetButton"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("characterSheetImage"), new objj_ivar("characterSheetImageView")]);

objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:"), function $CharacterSheetButton__initWithFrame_(self, _cmd, aFrame) {

 if (self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CharacterSheetButton").super_class }, "initWithFrame:", aFrame)){
  objj_msgSend(self, "setBackgroundColor:", objj_msgSend(CPColor, "colorWithHexString:", "DFDFDF"));

  self.characterSheetImage = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(objj_msgSend(CPBundle, "mainBundle"), "pathForResource:", "runner.png"), CGSizeMake(18, 25));

  var width = CGRectGetWidth(aFrame);
  var height = CGRectGetHeight(aFrame);
  self.characterSheetImageView = objj_msgSend(objj_msgSend(CPImageView, "alloc"), "initWithFrame:", CGRectMake(0, 0, width, height));
        objj_msgSend(self.characterSheetImageView, "setAutoresizingMask:", CPViewWidthSizable | CPViewHeightSizable);
        objj_msgSend(self.characterSheetImageView, "setImageScaling:", CPScaleProportionally);
        objj_msgSend(self.characterSheetImageView, "setHasShadow:", NO);
        objj_msgSend(self.characterSheetImageView, "setImage:", self.characterSheetImage);
        objj_msgSend(self, "addSubview:", self.characterSheetImageView);

 }
 return self;
}
,["id","CGRect"]), new objj_method(sel_getUid("mouseDown:"), function $CharacterSheetButton__mouseDown_(self, _cmd, anEvent){
 objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "postNotificationName:object:userInfo:", "ShowCharacterSheetView", self, nil);
}
,["void","CPEvent"])]);
}p;17;ui/LightBoxView.jt;926;@STATIC;1.0;t;908;





{var the_class = objj_allocateClassPair(CPView, "LightBoxView"),
meta_class = the_class.isa;




objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:"), function $LightBoxView__initWithFrame_(self, _cmd, aFrame) {

 if (self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("LightBoxView").super_class }, "initWithFrame:", aFrame)){


  objj_msgSend(self, "acceptsFirstMouse:", YES);
 }
 return self;
}
,["id","CGRect"]), new objj_method(sel_getUid("acceptsFirstMouse:"), function $LightBoxView__acceptsFirstMouse_(self, _cmd, anEvent){
 return YES
}
,["BOOL","CPEvent"]), new objj_method(sel_getUid("mouseDown:"), function $LightBoxView__mouseDown_(self, _cmd, anEvent){
 objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "postNotificationName:object:userInfo:", "RemoveSheet", self, nil);
}
,["void","CPEvent"])]);
}p;38;ui/CharacterSheet/CharacterSheetView.jt;7518;@STATIC;1.0;i;25;../LPMultiLineTextField.jt;7469;





objj_executeFile("../LPMultiLineTextField.j", YES);

{var the_class = objj_allocateClassPair(CPView, "CharacterSheetView"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("characterName"), new objj_ivar("characterDescription"), new objj_ivar("characterTags"), new objj_ivar("radioGroup"), new objj_ivar("maleRadioButton"), new objj_ivar("femaleRadioButton"), new objj_ivar("otherRadioButton"), new objj_ivar("characterBornDate"), new objj_ivar("characterDeathDate")]);



objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("characterName"), function $CharacterSheetView__characterName(self, _cmd)
{
return self.characterName;
}
,["CPTextField"]), new objj_method(sel_getUid("setCharacterName:"), function $CharacterSheetView__setCharacterName_(self, _cmd, newValue)
{
self.characterName = newValue;
}
,["void","CPTextField"]), new objj_method(sel_getUid("characterDescription"), function $CharacterSheetView__characterDescription(self, _cmd)
{
return self.characterDescription;
}
,["LPMultiLineTextField"]), new objj_method(sel_getUid("setCharacterDescription:"), function $CharacterSheetView__setCharacterDescription_(self, _cmd, newValue)
{
self.characterDescription = newValue;
}
,["void","LPMultiLineTextField"]), new objj_method(sel_getUid("characterTags"), function $CharacterSheetView__characterTags(self, _cmd)
{
return self.characterTags;
}
,["CPTokenField"]), new objj_method(sel_getUid("setCharacterTags:"), function $CharacterSheetView__setCharacterTags_(self, _cmd, newValue)
{
self.characterTags = newValue;
}
,["void","CPTokenField"]), new objj_method(sel_getUid("maleRadioButton"), function $CharacterSheetView__maleRadioButton(self, _cmd)
{
return self.maleRadioButton;
}
,["CPRadio"]), new objj_method(sel_getUid("setMaleRadioButton:"), function $CharacterSheetView__setMaleRadioButton_(self, _cmd, newValue)
{
self.maleRadioButton = newValue;
}
,["void","CPRadio"]), new objj_method(sel_getUid("femaleRadioButton"), function $CharacterSheetView__femaleRadioButton(self, _cmd)
{
return self.femaleRadioButton;
}
,["CPRadio"]), new objj_method(sel_getUid("setFemaleRadioButton:"), function $CharacterSheetView__setFemaleRadioButton_(self, _cmd, newValue)
{
self.femaleRadioButton = newValue;
}
,["void","CPRadio"]), new objj_method(sel_getUid("otherRadioButton"), function $CharacterSheetView__otherRadioButton(self, _cmd)
{
return self.otherRadioButton;
}
,["CPRadio"]), new objj_method(sel_getUid("setOtherRadioButton:"), function $CharacterSheetView__setOtherRadioButton_(self, _cmd, newValue)
{
self.otherRadioButton = newValue;
}
,["void","CPRadio"]), new objj_method(sel_getUid("characterBornDate"), function $CharacterSheetView__characterBornDate(self, _cmd)
{
return self.characterBornDate;
}
,["CPTextField"]), new objj_method(sel_getUid("setCharacterBornDate:"), function $CharacterSheetView__setCharacterBornDate_(self, _cmd, newValue)
{
self.characterBornDate = newValue;
}
,["void","CPTextField"]), new objj_method(sel_getUid("characterDeathDate"), function $CharacterSheetView__characterDeathDate(self, _cmd)
{
return self.characterDeathDate;
}
,["CPTextField"]), new objj_method(sel_getUid("setCharacterDeathDate:"), function $CharacterSheetView__setCharacterDeathDate_(self, _cmd, newValue)
{
self.characterDeathDate = newValue;
}
,["void","CPTextField"]), new objj_method(sel_getUid("initWithFrame:"), function $CharacterSheetView__initWithFrame_(self, _cmd, aFrame) {

 if (self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CharacterSheetView").super_class }, "initWithFrame:", aFrame)){



    var nameLabel = objj_msgSend(CPTextField, "labelWithTitle:", "Name:");
     objj_msgSend(nameLabel, "setFrameOrigin:", CGPointMake(55, 45));
     objj_msgSend(self, "addSubview:", nameLabel);

  self.characterName = objj_msgSend(objj_msgSend(CPTextField, "alloc"), "initWithFrame:", CGRectMake(100, 40, 200, 29));
     objj_msgSend(self.characterName, "setBezeled:", YES);
     objj_msgSend(self, "addSubview:", self.characterName);


    var descriptionLabel = objj_msgSend(CPTextField, "labelWithTitle:", "Description:");
     objj_msgSend(descriptionLabel, "setFrameOrigin:", CGPointMake(28, 105));
     objj_msgSend(self, "addSubview:", descriptionLabel);

     self.characterDescription = objj_msgSend(objj_msgSend(LPMultiLineTextField, "alloc"), "initWithFrame:", CGRectMake(100, 100, 300, 150));
     objj_msgSend(self.characterDescription, "setBezeled:", YES);
     objj_msgSend(self, "addSubview:", self.characterDescription);


    var tagsLabel = objj_msgSend(CPTextField, "labelWithTitle:", "Tags:");
     objj_msgSend(tagsLabel, "setFrameOrigin:", CGPointMake(55, 295));
     objj_msgSend(self, "addSubview:", tagsLabel);

     self.characterTags = objj_msgSend(objj_msgSend(CPTokenField, "alloc"), "initWithFrame:", CGRectMake(100, 290, 300, 100));
     objj_msgSend(self.characterTags, "setBezeled:", YES);
    objj_msgSend(self, "addSubview:", self.characterTags);


    var sexLabel = objj_msgSend(objj_msgSend(CPTextField, "alloc"), "initWithFrame:", CGRectMake(60, 430, 100, 30));
  objj_msgSend(sexLabel, "setStringValue:", "Sex:");
  objj_msgSend(sexLabel, "sizeToFit");
  objj_msgSend(self, "addSubview:", sexLabel);

  self.maleRadioButton = objj_msgSend(CPRadio, "radioWithTitle:", "Male");
  self.femaleRadioButton = objj_msgSend(CPRadio, "radioWithTitle:", "Female");
  self.otherRadioButton = objj_msgSend(CPRadio, "radioWithTitle:", "Other");

  self.radioGroup = objj_msgSend(self.maleRadioButton, "radioGroup");
  objj_msgSend(self.femaleRadioButton, "setRadioGroup:", self.radioGroup);
  objj_msgSend(self.otherRadioButton, "setRadioGroup:", self.radioGroup);

  objj_msgSend(self.maleRadioButton, "setFrameOrigin:", CGPointMake(100, 430));
  objj_msgSend(self.femaleRadioButton, "setFrameOrigin:", CGPointMake(CGRectGetMaxX(objj_msgSend(self.maleRadioButton, "frame")) + 8, CGRectGetMinY(objj_msgSend(self.maleRadioButton, "frame"))));
  objj_msgSend(self.otherRadioButton, "setFrameOrigin:", CGPointMake(CGRectGetMaxX(objj_msgSend(self.femaleRadioButton, "frame")) + 8, CGRectGetMinY(objj_msgSend(self.femaleRadioButton, "frame"))));

  objj_msgSend(self, "addSubview:", self.maleRadioButton);
  objj_msgSend(self, "addSubview:", self.femaleRadioButton);
  objj_msgSend(self, "addSubview:", self.otherRadioButton);

  objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("characterSheetBecameKey:"), "characterSheetBecameKey", nil);

  objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("characterSheetWillClose:"), "characterSheetWillClose", nil);




 }
 return self;
}
,["id","CGRect"]), new objj_method(sel_getUid("characterSheetBecameKey:"), function $CharacterSheetView__characterSheetBecameKey_(self, _cmd, aNotification){
 objj_msgSend(self.characterName, "setEditable:", YES);
 objj_msgSend(self.characterDescription, "setEditable:", YES);
 objj_msgSend(self.characterTags, "setEditable:", YES);

}
,["void","CPNotification"]), new objj_method(sel_getUid("characterSheetWillClose:"), function $CharacterSheetView__characterSheetWillClose_(self, _cmd, aNotification){
 objj_msgSend(self.characterName, "setEditable:", NO);
 objj_msgSend(self.characterDescription, "setEditable:", NO);
 objj_msgSend(self.characterTags, "setEditable:", NO);


}
,["void","CPNotification"])]);
}p;25;ui/LPMultiLineTextField.jt;11186;@STATIC;1.0;I;20;AppKit/CPTextField.jt;11141;objj_executeFile("AppKit/CPTextField.j", NO);
var CPTextFieldInputOwner = nil;
{var the_class = objj_allocateClassPair(CPTextField, "LPMultiLineTextField"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("_DOMTextareaElement"), new objj_ivar("_stringValue"), new objj_ivar("_hideOverflow")]);








 






objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("_DOMTextareaElement"), function $LPMultiLineTextField___DOMTextareaElement(self, _cmd)
{
    if (!self._DOMTextareaElement)
    {
        self._DOMTextareaElement = document.createElement("textarea");
        self._DOMTextareaElement.style.position = "absolute";
        self._DOMTextareaElement.style.background = "none";
        self._DOMTextareaElement.style.border = "0";
        self._DOMTextareaElement.style.outline = "0";
        self._DOMTextareaElement.style.zIndex = "100";
        self._DOMTextareaElement.style.resize = "none";
        self._DOMTextareaElement.style.padding = "0";
        self._DOMTextareaElement.style.margin = "0";
        self._DOMTextareaElement.onblur = function(){
                objj_msgSend(objj_msgSend(CPTextFieldInputOwner, "window"), "makeFirstResponder:", nil);
                CPTextFieldInputOwner = nil;
            };
        self._DOMElement.appendChild(self._DOMTextareaElement);
    }
    return self._DOMTextareaElement;
}
,["DOMElement"]), new objj_method(sel_getUid("initWithFrame:"), function $LPMultiLineTextField__initWithFrame_(self, _cmd, aFrame)
{
    if (self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("LPMultiLineTextField").super_class }, "initWithFrame:", aFrame))
    {
    }
    return self;
}
,["id","CGRect"]), new objj_method(sel_getUid("isScrollable"), function $LPMultiLineTextField__isScrollable(self, _cmd)
{
   return !self._hideOverflow;
}
,["BOOL"]), new objj_method(sel_getUid("setScrollable:"), function $LPMultiLineTextField__setScrollable_(self, _cmd, shouldScroll)
{
    self._hideOverflow = !shouldScroll;
}
,["void","BOOL"]), new objj_method(sel_getUid("setEditable:"), function $LPMultiLineTextField__setEditable_(self, _cmd, shouldBeEditable)
{
    objj_msgSend(self, "_DOMTextareaElement").style.cursor = shouldBeEditable ? "cursor" : "default";
    objj_msgSendSuper({ receiver:self, super_class:objj_getClass("LPMultiLineTextField").super_class }, "setEditable:", shouldBeEditable);
}
,["void","BOOL"]), new objj_method(sel_getUid("selectText:"), function $LPMultiLineTextField__selectText_(self, _cmd, sender)
{
    objj_msgSend(self, "_DOMTextareaElement").select();
}
,["void","id"]), new objj_method(sel_getUid("layoutSubviews"), function $LPMultiLineTextField__layoutSubviews(self, _cmd)
{
    objj_msgSendSuper({ receiver:self, super_class:objj_getClass("LPMultiLineTextField").super_class }, "layoutSubviews");
    var contentView = objj_msgSend(self, "layoutEphemeralSubviewNamed:positioned:relativeToEphemeralSubviewNamed:", "content-view", CPWindowAbove, "bezel-view");
    objj_msgSend(contentView, "setHidden:", YES);
    var DOMElement = objj_msgSend(self, "_DOMTextareaElement"),
        contentInset = objj_msgSend(self, "currentValueForThemeAttribute:", "content-inset"),
        bounds = objj_msgSend(self, "bounds");
    DOMElement.style.top = contentInset.top + "px";
    DOMElement.style.bottom = contentInset.bottom + "px";
    DOMElement.style.left = contentInset.left + "px";
    DOMElement.style.right = contentInset.right + "px";
    DOMElement.style.width = (CGRectGetWidth(bounds) - contentInset.left - contentInset.right) + "px";
    DOMElement.style.height = (CGRectGetHeight(bounds) - contentInset.top - contentInset.bottom) + "px";
    DOMElement.style.color = objj_msgSend(objj_msgSend(self, "currentValueForThemeAttribute:", "text-color"), "cssString");
    DOMElement.style.font = objj_msgSend(objj_msgSend(self, "currentValueForThemeAttribute:", "font"), "cssString");
    switch (objj_msgSend(self, "currentValueForThemeAttribute:", "alignment"))
    {
        case CPLeftTextAlignment:
            DOMElement.style.textAlign = "left";
            break;
        case CPJustifiedTextAlignment:
            DOMElement.style.textAlign = "justify";
            break;
        case CPCenterTextAlignment:
            DOMElement.style.textAlign = "center";
            break;
        case CPRightTextAlignment:
            DOMElement.style.textAlign = "right";
            break;
        default:
            DOMElement.style.textAlign = "left";
    }
    DOMElement.value = self._stringValue || "";
    if(self._hideOverflow)
        DOMElement.style.overflow="hidden";
}
,["void"]), new objj_method(sel_getUid("scrollWheel:"), function $LPMultiLineTextField__scrollWheel_(self, _cmd, anEvent)
{
    var DOMElement = objj_msgSend(self, "_DOMTextareaElement");
    DOMElement.scrollLeft += anEvent._deltaX;
    DOMElement.scrollTop += anEvent._deltaY;
}
,["void","CPEvent"]), new objj_method(sel_getUid("mouseDown:"), function $LPMultiLineTextField__mouseDown_(self, _cmd, anEvent)
{
    if (objj_msgSend(self, "isEditable") && objj_msgSend(self, "isEnabled"))
        objj_msgSend(objj_msgSend(objj_msgSend(self, "window"), "platformWindow"), "_propagateCurrentDOMEvent:", YES);
    else
        objj_msgSendSuper({ receiver:self, super_class:objj_getClass("LPMultiLineTextField").super_class }, "mouseDown:", anEvent);
}
,["void","CPEvent"]), new objj_method(sel_getUid("mouseDragged:"), function $LPMultiLineTextField__mouseDragged_(self, _cmd, anEvent)
{
    return objj_msgSend(objj_msgSend(objj_msgSend(anEvent, "window"), "platformWindow"), "_propagateCurrentDOMEvent:", YES);
}
,["void","CPEvent"]), new objj_method(sel_getUid("keyDown:"), function $LPMultiLineTextField__keyDown_(self, _cmd, anEvent)
{
    if (objj_msgSend(anEvent, "keyCode") === CPTabKeyCode)
    {
        if (objj_msgSend(anEvent, "modifierFlags") & CPShiftKeyMask)
            objj_msgSend(objj_msgSend(self, "window"), "selectPreviousKeyView:", self);
        else
            objj_msgSend(objj_msgSend(self, "window"), "selectNextKeyView:", self);
        if (objj_msgSend(objj_msgSend(objj_msgSend(self, "window"), "firstResponder"), "respondsToSelector:", sel_getUid("selectText:")))
            objj_msgSend(objj_msgSend(objj_msgSend(self, "window"), "firstResponder"), "selectText:", self);
        objj_msgSend(objj_msgSend(objj_msgSend(self, "window"), "platformWindow"), "_propagateCurrentDOMEvent:", NO);
    }
    else
        objj_msgSend(objj_msgSend(objj_msgSend(self, "window"), "platformWindow"), "_propagateCurrentDOMEvent:", YES);
    objj_msgSend(objj_msgSend(CPRunLoop, "currentRunLoop"), "limitDateForMode:", CPDefaultRunLoopMode);
}
,["void","CPEvent"]), new objj_method(sel_getUid("keyUp:"), function $LPMultiLineTextField__keyUp_(self, _cmd, anEvent)
{
    if (self._stringValue !== objj_msgSend(self, "stringValue"))
    {
        self._stringValue = objj_msgSend(self, "stringValue");
        if (!self._isEditing)
        {
            self._isEditing = YES;
            objj_msgSend(self, "textDidBeginEditing:", objj_msgSend(CPNotification, "notificationWithName:object:userInfo:", CPControlTextDidBeginEditingNotification, self, nil));
        }
        objj_msgSend(self, "textDidChange:", objj_msgSend(CPNotification, "notificationWithName:object:userInfo:", CPControlTextDidChangeNotification, self, nil));
    }
    objj_msgSend(objj_msgSend(objj_msgSend(self, "window"), "platformWindow"), "_propagateCurrentDOMEvent:", YES);
}
,["void","CPEvent"]), new objj_method(sel_getUid("performKeyEquivalent:"), function $LPMultiLineTextField__performKeyEquivalent_(self, _cmd, anEvent)
{
    objj_msgSend(objj_msgSend(objj_msgSend(self, "window"), "platformWindow"), "_propagateCurrentDOMEvent:", YES);
    return YES;
}
,["BOOL","CPEvent"]), new objj_method(sel_getUid("becomeFirstResponder"), function $LPMultiLineTextField__becomeFirstResponder(self, _cmd)
{
    self._stringValue = objj_msgSend(self, "stringValue");
    objj_msgSend(self, "setThemeState:", CPThemeStateEditing);
    setTimeout(function(){
        objj_msgSend(self, "_DOMTextareaElement").focus();
        CPTextFieldInputOwner = self;
    }, 0.0);
    objj_msgSend(self, "textDidFocus:", objj_msgSend(CPNotification, "notificationWithName:object:userInfo:", CPTextFieldDidFocusNotification, self, nil));
    return YES;
}
,["BOOL"]), new objj_method(sel_getUid("resignFirstResponder"), function $LPMultiLineTextField__resignFirstResponder(self, _cmd)
{
    objj_msgSend(self, "unsetThemeState:", CPThemeStateEditing);
    objj_msgSend(self, "setStringValue:", objj_msgSend(self, "stringValue"));
    objj_msgSend(self, "_DOMTextareaElement").blur();
    if (self._isEditing)
    {
        self._isEditing = NO;
        objj_msgSend(self, "textDidEndEditing:", objj_msgSend(CPNotification, "notificationWithName:object:userInfo:", CPControlTextDidEndEditingNotification, self, nil));
        if (objj_msgSend(self, "sendsActionOnEndEditing"))
            objj_msgSend(self, "sendAction:to:", objj_msgSend(self, "action"), objj_msgSend(self, "target"));
    }
    objj_msgSend(self, "textDidBlur:", objj_msgSend(CPNotification, "notificationWithName:object:userInfo:", CPTextFieldDidBlurNotification, self, nil));
    return YES;
}
,["BOOL"]), new objj_method(sel_getUid("stringValue"), function $LPMultiLineTextField__stringValue(self, _cmd)
{
    return (!!self._DOMTextareaElement) ? self._DOMTextareaElement.value : "";
}
,["CPString"]), new objj_method(sel_getUid("setStringValue:"), function $LPMultiLineTextField__setStringValue_(self, _cmd, aString)
{
    self._stringValue = aString;
    objj_msgSend(self, "setNeedsLayout");
}
,["void","CPString"])]);
}
var LPMultiLineTextFieldStringValueKey = "LPMultiLineTextFieldStringValueKey",
    LPMultiLineTextFieldScrollableKey = "LPMultiLineTextFieldScrollableKey";
{
var the_class = objj_getClass("LPMultiLineTextField")
if(!the_class) throw new SyntaxError("*** Could not find definition for class \"LPMultiLineTextField\"");
var meta_class = the_class.isa;
class_addMethods(the_class, [new objj_method(sel_getUid("initWithCoder:"), function $LPMultiLineTextField__initWithCoder_(self, _cmd, aCoder)
{
    if (self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("LPMultiLineTextField").super_class }, "initWithCoder:", aCoder))
    {
        objj_msgSend(self, "setStringValue:", objj_msgSend(aCoder, "decodeObjectForKey:", LPMultiLineTextFieldStringValueKey));
        objj_msgSend(self, "setScrollable:", objj_msgSend(aCoder, "decodeBoolForKey:", LPMultiLineTextFieldScrollableKey));
    }
    return self;
}
,["id","CPCoder"]), new objj_method(sel_getUid("encodeWithCoder:"), function $LPMultiLineTextField__encodeWithCoder_(self, _cmd, aCoder)
{
    objj_msgSendSuper({ receiver:self, super_class:objj_getClass("LPMultiLineTextField").super_class }, "encodeWithCoder:", aCoder);
    objj_msgSend(aCoder, "encodeObject:forKey:", self._stringValue, LPMultiLineTextFieldStringValueKey);
    objj_msgSend(aCoder, "encodeBool:forKey:", (self._hideOverflow?NO:YES), LPMultiLineTextFieldScrollableKey);
}
,["void","CPCoder"])]);
}p;40;ui/CharacterSheet/CharacterSheetWindow.jt;3301;@STATIC;1.0;i;20;CharacterSheetView.jt;3257; objj_executeFile("CharacterSheetView.j", YES);
{var the_class = objj_allocateClassPair(CPWindow, "CharacterSheetWindow"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("contentView"), new objj_ivar("characterTabs"), new objj_ivar("addCharacterViewTab"), new objj_ivar("tabCounter")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithContentRect:styleMask:"), function $CharacterSheetWindow__initWithContentRect_styleMask_(self, _cmd, aRect, aStyleMask){
 self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CharacterSheetWindow").super_class }, "initWithContentRect:styleMask:", aRect, aStyleMask);
 if(self){
  objj_msgSend(self, "setTitle:", "Character sheet");
    self.contentView = objj_msgSend(self, "contentView");
    self.tabCounter == 1;
    self.characterTabs=objj_msgSend(objj_msgSend(CPTabView, "alloc"), "initWithFrame:", CGRectMake( 0, 0, CGRectGetWidth(aRect), CGRectGetHeight(aRect)));
    objj_msgSend(self.characterTabs, "setDelegate:", self);
    var newCharacterSheetView = objj_msgSend(objj_msgSend(CharacterSheetView, "alloc"), "initWithFrame:", CPRectMakeZero());
    var newCharacterViewTab=objj_msgSend(objj_msgSend(CPTabViewItem, "alloc"), "initWithIdentifier:", "FirstNewCharacterViewItem");
    objj_msgSend(newCharacterViewTab, "setLabel:", " New Character ");
    objj_msgSend(newCharacterViewTab, "setView:", newCharacterSheetView);
    objj_msgSend(self.characterTabs, "addTabViewItem:", newCharacterViewTab);
    var addCharacterSheetView = objj_msgSend(objj_msgSend(CharacterSheetView, "alloc"), "initWithFrame:", CPRectMakeZero());
    self.addCharacterViewTab=objj_msgSend(objj_msgSend(CPTabViewItem, "alloc"), "initWithIdentifier:", "AddCharacterTabViewItem");
    objj_msgSend(self.addCharacterViewTab, "setLabel:", " + ");
    objj_msgSend(self.addCharacterViewTab, "setView:", addCharacterSheetView);
    objj_msgSend(self.characterTabs, "addTabViewItem:", self.addCharacterViewTab);
    objj_msgSend(self.contentView, "addSubview:", self.characterTabs);
 }
 return self;
}
,["id","CGRect","unsigned int"]), new objj_method(sel_getUid("tabView:shouldSelectTabViewItem:"), function $CharacterSheetWindow__tabView_shouldSelectTabViewItem_(self, _cmd, tabView, tabViewItem){
  if(objj_msgSend(tabViewItem, "identifier") == "AddCharacterTabViewItem"){
    self.tabCounter ++;
    CPLog.trace("Tabview was add character, returning no. tabCounter:" + self.tabCounter);
    var newCharacterSheetView = objj_msgSend(objj_msgSend(CharacterSheetView, "alloc"), "initWithFrame:", CPRectMakeZero());
    var newCharacterViewTab = objj_msgSend(objj_msgSend(CPTabViewItem, "alloc"), "initWithIdentifier:", self.tabCounter);
    objj_msgSend(newCharacterViewTab, "setLabel:", "New Character " + self.tabCounter);
    objj_msgSend(newCharacterViewTab, "setView:", newCharacterSheetView);
    var numberOfItems = objj_msgSend(self.characterTabs, "numberOfTabViewItems");
    objj_msgSend(self.characterTabs, "insertTabViewItem:atIndex:", newCharacterViewTab, self.tabCounter);
    CPLog.trace("Label: " + objj_msgSend(newCharacterViewTab, "label"));
    return NO;
  } else {
    return YES;
  }
}
,["BOOL","CPTabView","CPTabViewItem"])]);
}