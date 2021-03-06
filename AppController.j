/*
 * AppController.j
 * null
 *
 * Created by Alos on May 1, 2013.
 * Copyright 2013, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>

@import <WKTextView/WKTextView.j>
@import "ui/CharacterSheetButton.j"
@import "ui/LightBoxView.j"

@import "ui/CharacterSheet/CharacterSheetView.j"
@import "ui/CharacterSheet/CharacterSheetWindow.j"

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

@implementation AppController : CPObject
{
    CPView contentView;
    WKTextView  editorView;
    CPToolBar   toolbar;
    CharacterSheetButton characterSheetButton;

    LightBoxView characterSheetlightBoxView;
    CharacterSheetWindow characterSheetWindow;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];
    
    contentView = [theWindow contentView];

    var colorImage = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:@"texture3.png"] size:CGSizeMake(97, 97)];
    [contentView setBackgroundColor:[CPColor colorWithPatternImage:colorImage]];

    var middle = (CGRectGetWidth([contentView bounds]) / 2) - 400;
    var calculatedEditorFrame = CGRectMake(middle, 40, 1000, CGRectGetHeight([contentView bounds]) - 80);

    //Add the main editor
    editorView = [[WKTextView alloc] initWithFrame:calculatedEditorFrame];
    [editorView setAutohidesScrollers:NO];
    [editorView setAutoresizingMask: CPViewHeightSizable | CPViewMaxXMargin];
    [editorView setDelegate:self];
    [editorView setShouldFocusAfterAction:YES];
    //Adding shadow
    var editorViewShadow = [[CPShadowView alloc] initWithFrame:CGRectMakeZero()];
    [editorViewShadow setFrameForContentFrame: calculatedEditorFrame];
    [editorViewShadow setAutoresizingMask:CPViewHeightSizable | CPViewMaxXMargin];
    [contentView addSubview:editorViewShadow];
    [contentView addSubview:editorView];
    

    //Add the character sheet button
    characterSheetButton = [[CharacterSheetButton alloc]  initWithFrame: CGRectMake(CGRectGetWidth([contentView bounds]) - 50, CGRectGetHeight([contentView bounds])/2 , 36 , 50)];
    [characterSheetButton setAutoresizingMask:CPViewMinXMargin | CPViewMinYMargin | CPViewMaxYMargin];
    //Add a shadow to the button
    var characterSheetButtonShadow = [[CPShadowView alloc] initWithFrame:CGRectMakeZero()];
    [characterSheetButtonShadow setFrameForContentFrame: CGRectMake(CGRectGetWidth([contentView bounds]) - 50, CGRectGetHeight([contentView bounds])/2 , 36 , 50)];
    [characterSheetButtonShadow setAutoresizingMask:CPViewMinXMargin | CPViewMinYMargin | CPViewMaxYMargin];
    [contentView addSubview:characterSheetButtonShadow];
    [contentView addSubview:characterSheetButton];

    toolbar = [[CPToolbar alloc] initWithIdentifier:"Styling"];
    [toolbar setDelegate:self];
    [toolbar setVisible:YES];
    [theWindow setToolbar:toolbar];

    [theWindow orderFront:self];
    //Creating helper windows
    characterSheetWindow = [[CharacterSheetWindow alloc] initWithContentRect: CGRectMake( CGRectGetWidth([contentView bounds]) + CHARACTERSHEETWIDTH, CGRectGetHeight([contentView bounds])/2 - (CHARACTERSHEETHEIGHT/2) , CHARACTERSHEETWIDTH, CHARACTERSHEETHEIGHT)
                                                         styleMask: CPTitledWindowMask];
    
    //Creating the lightbox
    characterSheetlightBoxView = [[LightBoxView alloc] initWithFrame: [contentView bounds]];
    [characterSheetlightBoxView setAutoresizingMask: CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];

    //Notifications
    [[CPNotificationCenter defaultCenter] addObserver:self selector:@selector(showCharacterSheetView:) name:"ShowCharacterSheetView" object:nil];
    [[CPNotificationCenter defaultCenter] addObserver:self selector:@selector(removeCharacterSheet:) name:"RemoveSheet" object:characterSheetlightBoxView];
    [[CPNotificationCenter defaultCenter] addObserver:self selector:@selector(characterSheetWindowBacameMain:) name:"CPWindowDidBecomeMainNotification" object:characterSheetWindow];
}

@end


@implementation AppController (NotificationHandlers)

-(void)characterSheetWindowBacameMain:(CPNotification)notification{
    [[CPNotificationCenter defaultCenter] postNotificationName:"characterSheetBecameKey" object:self userInfo: nil];
}

- (void) showCharacterSheetView:(CPNotification) aNotification{
    [characterSheetWindow makeKeyAndOrderFront: self];
    //Calculate the width position
    var oldFrame = [characterSheetWindow frame];
    oldFrame.origin.x -= CHARACTERSHEETWIDTH * 2;
    //Recalculate the y position in case the window was resized
    //TODO maybe move this to the windowbridge resize to make it faster
    var newYPosition = CGRectGetHeight([contentView bounds])/2 - (CHARACTERSHEETHEIGHT/2);
    oldFrame.origin.y = newYPosition; 
    [characterSheetWindow setFrame: oldFrame display: NO animate: YES];
    [contentView addSubview: characterSheetlightBoxView]; 
}

-(void) removeCharacterSheet:(CPNotification)aNotification{
    [characterSheetlightBoxView removeFromSuperview];
    [[CPNotificationCenter defaultCenter] postNotificationName:"characterSheetWillClose" object:self userInfo: nil];
    var oldFrame = [characterSheetWindow frame];
    oldFrame.origin.x += CHARACTERSHEETWIDTH * 2;
    [characterSheetWindow setFrame: oldFrame display: YES animate: YES];
    [characterSheetWindow close];
}

@end


@implementation AppController (ToolBarImplementation)


// Return an array of toolbar item identifier (all the toolbar items that may be present in the toolbar)
- (CPArray)toolbarAllowedItemIdentifiers:(CPToolbar)aToolbar
{
    return [NewToolbarItemIdentifier, CPToolbarSpaceItemIdentifier, BoldToolbarItemIdentifier, ItalicsToolbarItemIdentifier, UnderlineToolbarItemIdentifier, StrikethroughToolbarItemIdentifier, CPToolbarSpaceItemIdentifier, AlignLeftToolbarItemIdentifier, AlignRightToolbarItemIdentifier, AlignCenterToolbarItemIdentifier, AlignFullToolbarItemIdentifier, CPToolbarSpaceItemIdentifier, BulletsToolbarItemIdentifier, NumbersToolbarItemIdentifier, InsertLinkToolbarItemIdentifier, UnlinkToolbarItemIdentifier, InsertImageToolbarItemIdentifier, FontToolbarItemIdentifier, CPToolbarFlexibleSpaceItemIdentifier, RandomTextToolbarItemIdentifier];
}

// Return an array of toolbar item identifier (the default toolbar items that are present in the toolbar)
- (CPArray)toolbarDefaultItemIdentifiers:(CPToolbar)aToolbar
{
    return [self toolbarAllowedItemIdentifiers:aToolbar];
}

// Create the toolbar item that is requested by the toolbar.
- (CPToolbarItem)toolbar:(CPToolbar)aToolbar itemForItemIdentifier:(CPString)anItemIdentifier willBeInsertedIntoToolbar:(BOOL)aFlag
{
    // Create the toolbar item and associate it with its identifier
    var toolbarItem = [[CPToolbarItem alloc] initWithItemIdentifier:anItemIdentifier];

    var mainBundle = [CPBundle mainBundle];

    var actionMap =
    {
        NewToolbarItemIdentifier:           { 'image': 'page_white.png',        'label': 'New',     'target': editorView,   'action':@selector(clearText:) },
        BoldToolbarItemIdentifier:          { 'image': 'text_bold.png',         'label': 'Bold',    'target': editorView,   'action':@selector(boldSelection:) },
        ItalicsToolbarItemIdentifier:       { 'image': 'text_italic.png',       'label': 'Italics', 'target': editorView,   'action':@selector(italicSelection:) },
        UnderlineToolbarItemIdentifier:     { 'image': 'text_underline.png',    'label': 'Under',   'target': editorView,   'action':@selector(underlineSelection:) },
        RandomTextToolbarItemIdentifier:    { 'image': 'page_white_text.png',   'label': 'Lorem',   'target': self,         'action':@selector(setRandomText:) },
        StrikethroughToolbarItemIdentifier: { 'image': 'text_strikethrough.png','label': 'Strike',  'target': editorView,   'action':@selector(strikethroughSelection:) },
        AlignLeftToolbarItemIdentifier:     { 'image': 'text_align_left.png',   'label': 'Left',    'target': editorView,   'action':@selector(alignSelectionLeft:) },
        AlignRightToolbarItemIdentifier:    { 'image': 'text_align_right.png',  'label': 'Right',   'target': editorView,   'action':@selector(alignSelectionRight:) },
        AlignCenterToolbarItemIdentifier:   { 'image': 'text_align_center.png', 'label': 'Center',  'target': editorView,   'action':@selector(alignSelectionCenter:) },
        AlignFullToolbarItemIdentifier:     { 'image': 'text_align_justify.png','label': 'Justify', 'target': editorView,   'action':@selector(alignSelectionFull:) },
        BulletsToolbarItemIdentifier:       { 'image': 'text_list_bullets.png', 'label': 'Bullets', 'target': editorView,   'action':@selector(insertUnorderedList:) },
        NumbersToolbarItemIdentifier:       { 'image': 'text_list_numbers.png', 'label': 'Numbers', 'target': editorView,   'action':@selector(insertOrderedList:) },
        InsertLinkToolbarItemIdentifier:    { 'image': 'link.png',              'label': 'Link',    'target': self,         'action':@selector(doLink:) },
        UnlinkToolbarItemIdentifier:        { 'image': 'link_break.png',        'label': 'Unlink',  'target': editorView,   'action':@selector(unlinkSelection:) },
        InsertImageToolbarItemIdentifier:   { 'image': 'picture.png',           'label': 'Image',   'target': self,         'action':@selector(doImage:) },
    };

    var action = actionMap[anItemIdentifier];
    if (action)
    {
        var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"silk/"+action['image']] size:CPSizeMake(16, 16)];
        [toolbarItem setImage:image];

        [toolbarItem setTarget:action['target']];
        [toolbarItem setAction:action['action']];
        [toolbarItem setLabel:action['label']];

        [toolbarItem setMinSize:CGSizeMake(16, 16)];
        [toolbarItem setMaxSize:CGSizeMake(16, 16)];
    }
    else if (anItemIdentifier == FontToolbarItemIdentifier)
    {
        [toolbarItem setMinSize:CGSizeMake(160, 25)];
        [toolbarItem setMaxSize:CGSizeMake(160, 25)];

        var dropdown = [[CPPopUpButton alloc] initWithFrame:CGRectMake(0, 0, 160, 25) pullsDown:NO];
        [dropdown setTarget:self];
        [dropdown setAction:@selector(doFont:)];

        var fonts = [[CPFontManager sharedFontManager] availableFonts];

        for(var i=0; i<fonts.length; i++)
        {
            var fontName = fonts[i],
                menuItem = [[CPMenuItem alloc] initWithTitle:fontName action:nil keyEquivalent:nil];
            [dropdown addItem:menuItem];
        }

        [dropdown setTitle:@"Select Font..."];
        [toolbarItem setView:dropdown];
        [toolbarItem setLabel:"Font"];
    }

    return toolbarItem;
}

- (void)doFont:button {
    var fontName = [button titleOfSelectedItem];
    [editorView setFontNameForSelection:fontName];
}

- (@action)doLink:sender
{
    var link = prompt("Enter a link: ", "http://www.280north.com");
    if (link)
        [editorView linkSelectionToURL:link];
}

- (@action)doImage:sender
{
    var link = prompt("Enter an image URL: ", "http://objective-j.org/images/cappuccino-icon.png");
    if (link)
        [editorView insertImageWithURL:link];
}


- (@action)setRandomText:sender
{
    [editorView setHtmlValue:"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut est urna, vulputate sed viverra dignissim, consequat vitae eros. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Suspendisse ut sapien enim, et pellentesque elit. In commodo facilisis est, et tempus lacus aliquam vitae. Maecenas quam nulla, elementum ut tristique quis, cursus a nisi. Duis mollis risus vel velit molestie convallis nec a purus. Donec neque arcu, suscipit sit amet mattis eu, fringilla ac sapien. Ut lorem nibh, mollis in tincidunt at, volutpat ut turpis. Maecenas nulla est, tincidunt pharetra consectetur vel, laoreet sed nibh. Pellentesque tempor diam vel elit commodo aliquet. Donec congue fringilla eros a tincidunt. Praesent accumsan mi tincidunt arcu ultricies nec pellentesque dolor faucibus. Mauris sed nisl in ligula porta congue et quis turpis. Suspendisse in lorem at felis tempus semper. In porta enim a ipsum aliquet consectetur.</p><p>Mauris ac tellus orci. Aenean egestas porta ornare. Cras nisl lorem, vulputate ac pellentesque eu, aliquet ac leo. Proin eros libero, tincidunt sed sodales eget, elementum non augue. Praesent convallis auctor venenatis. Suspendisse id urna quam. Aliquam sagittis, leo commodo laoreet interdum, arcu felis dictum velit, a sodales justo tortor a erat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nibh magna, consequat et congue eu, bibendum id nisi. Cras gravida risus in nulla pharetra sagittis. Cras neque eros, consectetur nec bibendum eget, bibendum dictum libero. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nam rutrum dictum neque vel eleifend. Vivamus tempus, lorem vel ultricies ullamcorper, ante risus imperdiet massa, nec aliquam orci ipsum ut nisl. Aliquam id justo eu lorem dapibus tincidunt. Donec suscipit consequat metus, sed venenatis lorem malesuada sit amet. Ut at risus ut ligula vulputate auctor. Vivamus rutrum elementum porttitor. Fusce quam arcu, tristique eget consectetur eu, iaculis in urna.</p><p>Donec a metus ac elit faucibus sagittis non a ligula. In aliquet, lectus sed pulvinar bibendum, justo ligula faucibus sem, vestibulum eleifend lacus augue a eros. Suspendisse potenti. Phasellus vehicula blandit ultrices. Donec tortor nulla, fermentum nec viverra id, consequat non metus. Fusce nunc urna, aliquet sit amet varius ut, dapibus a sem. Aliquam erat volutpat. Vestibulum at enim et magna lacinia sollicitudin id nec dolor. Sed ultricies urna ut justo blandit tincidunt. Sed sit amet orci et justo pellentesque iaculis accumsan ac quam.</p><p>Nunc tristique felis quis leo blandit eget iaculis lacus hendrerit. Maecenas euismod consequat lacus quis porttitor. Quisque consequat, metus eu interdum vulputate, quam dolor porttitor dui, non faucibus quam nibh nec erat. Integer sit amet gravida quam. Proin nunc eros, tincidunt sit amet accumsan laoreet, dictum vel sapien. Praesent at fringilla orci. Etiam vehicula lacinia nisi, et molestie justo congue molestie. Maecenas tempus, quam nec placerat suscipit, lorem sapien feugiat augue, id pharetra augue enim eu nisl. Morbi ullamcorper lacus ac dolor ultricies vel pellentesque odio consequat. Maecenas a pellentesque nunc. Phasellus a varius massa. Vestibulum eget tortor eget ante iaculis molestie. Pellentesque eu augue metus, ut pellentesque purus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Curabitur consequat feugiat tincidunt. Proin tellus tortor, pharetra vel rhoncus ac, varius eget nisi. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Cras et nunc metus. Pellentesque tincidunt iaculis erat id porta. Curabitur eget magna et velit eleifend tempor.</p><p>Vestibulum ultricies leo at augue malesuada congue. Maecenas laoreet metus et nunc consectetur placerat. Nulla facilisi. Duis iaculis tristique feugiat. Ut quis consectetur justo. Praesent condimentum sagittis dui, in lobortis tellus accumsan quis. In aliquam lacus non dolor accumsan rutrum. Etiam sed urna dolor. Donec consectetur lacus eu ante sodales feugiat. Aliquam aliquet nibh vel massa mattis pellentesque. Curabitur et tortor nisl, ut consequat felis. Mauris non orci at tortor ultrices condimentum. Aliquam erat volutpat. Mauris porttitor, diam convallis semper hendrerit, erat mi tempor dolor, id semper augue justo fermentum odio. Sed vitae nulla eu augue fringilla pellentesque vel ac neque. Nullam arcu nibh, auctor ut accumsan ac, ullamcorper eu velit. Integer in ligula nec felis auctor viverra. In commodo malesuada volutpat. Etiam justo elit, tincidunt ac semper sed, eleifend eu odio. Cras ac nulla eget lorem tempor venenatis.</p>"];
}

- (void)textViewDidLoad:textView
{
    // Update the selected font.
    [self textViewCursorDidMove:textView];
}

- (void)textViewCursorDidMove:textView
{
    var items = [toolbar visibleItems];
    for (var i=0; i<items.length; i++)
    {
        var item = items[i];
        if ([item itemIdentifier] == FontToolbarItemIdentifier)
        {
            var font = [editorView font];
            [[item view] selectItemWithTitle:font];
        }
    }
}

@end

var animateViewToPoint = function(view, point, animation)
{
    var dict = [CPDictionary dictionary],
        frame1 = [view frame],
        frame2 = [view frame];
        
    frame2.origin = point;
        
    [dict setValue:view forKey:CPViewAnimationTargetKey];
    [dict setValue:frame1 forKey:CPViewAnimationStartFrameKey];
    [dict setValue:frame2 forKey:CPViewAnimationEndFrameKey];
    
    [animation setViewAnimations:[dict]];
    [animation startAnimation];
};



