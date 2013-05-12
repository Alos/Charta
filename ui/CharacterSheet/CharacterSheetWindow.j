/*
 * NewWorkItemWindow.j
 * Seshat
 *
 * Created by Alos on February 24, 2013.
 * Copyright 2013, Your Company All rights reserved.
 */

 @import "CharacterSheetView.j"


@implementation CharacterSheetWindow : CPWindow {
	CPView contentView;
    CPTabView characterTabs;
    CPTabViewItem addCharacterViewTab;

    unsigned int tabCounter;
}


-(id) initWithContentRect:(CGRect) aRect styleMask:(unsigned int) aStyleMask{

	self = [super initWithContentRect: aRect styleMask: aStyleMask];
	if(self){
		[self setTitle: @"Character sheet"];

    contentView = [self contentView];
    tabCounter == 1;
    characterTabs=[[CPTabView alloc] initWithFrame:CGRectMake( 0, 0, CGRectGetWidth(aRect), CGRectGetHeight(aRect))]; 
    [characterTabs setDelegate: self];

    var newCharacterViewTab=[[CPTabViewItem alloc] initWithIdentifier:@"FirstNewCharacterViewItem"]; 
    var newCharacterSheetView = [[CharacterSheetView alloc] initWithFrame:CPRectMakeZero()  andParentTabViewItem: newCharacterViewTab];
    [newCharacterViewTab setLabel:@" New Character "]; 
    [newCharacterViewTab setView:newCharacterSheetView]; 
    [characterTabs addTabViewItem:newCharacterViewTab];


    var addCharacterSheetView = [[CharacterSheetView alloc] initWithFrame:CPRectMakeZero()];
    addCharacterViewTab=[[CPTabViewItem alloc] initWithIdentifier:@"AddCharacterTabViewItem"]; 
    [addCharacterViewTab setLabel:@" + "]; 
    [addCharacterViewTab setView:addCharacterSheetView]; 
    [characterTabs addTabViewItem:addCharacterViewTab];


    [contentView addSubview: characterTabs];


    [[CPNotificationCenter defaultCenter] addObserver:self 
                                              selector:@selector(removeTabItemView:) 
                                              name:"RemoveCharacter" 
                                              object:nil];
    

	}
	return self;
}

-(void) removeTabItemView:(CPNotification) aNotification {
    CPLog.trace("removeing tab item view");
    var info = [aNotification userInfo];
    var aTabView = [info objectForKey:"TabView"];
    [characterTabs removeTabViewItem: aTabView];
    tabCounter--;
}


- (BOOL)tabView:(CPTabView)tabView shouldSelectTabViewItem:(CPTabViewItem )tabViewItem{
  if([tabViewItem identifier] == "AddCharacterTabViewItem"){
    tabCounter ++;
    CPLog.trace("Tabview was add character, returning no. tabCounter:" + tabCounter);
    var newCharacterViewTab = [[CPTabViewItem alloc] initWithIdentifier: tabCounter]; 
    var newCharacterSheetView = [[CharacterSheetView alloc] initWithFrame:CPRectMakeZero() andParentTabViewItem: newCharacterViewTab];
    [newCharacterViewTab setLabel: @"New Character " + tabCounter]; 
    [newCharacterViewTab setView: newCharacterSheetView];
    //[characterTabs addTabViewItem: newCharacterViewTab];
    var numberOfItems = [characterTabs numberOfTabViewItems];
    [characterTabs insertTabViewItem: newCharacterViewTab atIndex: tabCounter];
    CPLog.trace("Label: " +  [newCharacterViewTab label]);
    return NO;
  } else {
    return YES;
  }

}

 
@end