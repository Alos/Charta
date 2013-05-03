@STATIC;1.0;I;21;Foundation/CPObject.jI;23;WKTextView/WKTextView.ji;20;CPView+ApplyShadow.jt;15453;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("WKTextView/WKTextView.j", NO);
objj_executeFile("CPView+ApplyShadow.j", YES);
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
{var the_class = objj_allocateClassPair(CPObject, "AppController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("contentView"), new objj_ivar("editorView"), new objj_ivar("toolbar")]);








objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("applicationDidFinishLaunching:"), function $AppController__applicationDidFinishLaunching_(self, _cmd, aNotification)
{
    var theWindow = objj_msgSend(objj_msgSend(CPWindow, "alloc"), "initWithContentRect:styleMask:", CGRectMakeZero(), CPBorderlessBridgeWindowMask);
    self.contentView = objj_msgSend(theWindow, "contentView");
    var colorImage = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(objj_msgSend(CPBundle, "mainBundle"), "pathForResource:", "texture3.png"), CGSizeMake(97, 97));
    objj_msgSend(self.contentView, "setBackgroundColor:", objj_msgSend(CPColor, "colorWithPatternImage:", colorImage));
    var middle = (CGRectGetWidth(objj_msgSend(self.contentView, "bounds")) / 2) - 400;
    self.editorView = objj_msgSend(objj_msgSend(WKTextView, "alloc"), "initWithFrame:", CGRectMake(middle, 40, 1000, CGRectGetHeight(objj_msgSend(self.contentView, "bounds")) - 80));
    objj_msgSend(self.editorView, "setAutohidesScrollers:", NO);
    objj_msgSend(self.editorView, "setAutoresizingMask:", CPViewHeightSizable | CPViewMaxXMargin);
    objj_msgSend(self.editorView, "setDelegate:", self);
    objj_msgSend(self.editorView, "setShouldFocusAfterAction:", YES);
    objj_msgSend(self.editorView, "applyShadow:offset:", objj_msgSend(CPColor, "blackColor"), 5.0);
    objj_msgSend(self.contentView, "addSubview:", self.editorView);
    self.toolbar = objj_msgSend(objj_msgSend(CPToolbar, "alloc"), "initWithIdentifier:", "Styling");
    objj_msgSend(self.toolbar, "setDelegate:", self);
    objj_msgSend(self.toolbar, "setVisible:", YES);
    objj_msgSend(theWindow, "setToolbar:", self.toolbar);
    objj_msgSend(theWindow, "orderFront:", self);
}
,["void","CPNotification"]), new objj_method(sel_getUid("toolbarAllowedItemIdentifiers:"), function $AppController__toolbarAllowedItemIdentifiers_(self, _cmd, aToolbar)
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