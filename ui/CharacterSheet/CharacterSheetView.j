/**
	Button to toggle the Character sheet interface.
*/

@import "../LPMultiLineTextField.j"

@import "../FileDropBox.j"

@implementation CharacterSheetView : CPView {
	CPTextField characterName  @accessors;
	
	LPMultiLineTextField characterDescription  @accessors;
	
	CPTokenField characterTags @accessors;
	
	CPRadioGroup radioGroup;
	CPRadio maleRadioButton  @accessors;
	CPRadio femaleRadioButton  @accessors;
	CPRadio otherRadioButton  @accessors;
	
	CPTextField characterBornDate  @accessors;
	CPTextField characterDeathDate  @accessors;

	CPTabViewItem parentTabItemView;
	CPTabView parentTabView;

	FileDropBox fileDropBox;
}

- (id) initWithFrame:(CGRect) aFrame andParentTabViewItem:(CPTabViewItem) aTabViewItem{

	if (self = [super initWithFrame:aFrame]){
		//[self setBackgroundColor: [CPColor  colorWithHexString:@"DFDFDF"]];

		//The name stuff
	  	var nameLabel = [CPTextField labelWithTitle:@"Name:"];
	   	[nameLabel setFrameOrigin:CGPointMake(55, 45)];
	   	[self addSubview: nameLabel];

		characterName = [[CPTextField alloc] initWithFrame: CGRectMake(100, 40, 200, 29)];
	    [characterName setBezeled:YES];
	    [self addSubview: characterName];

	  	//The description stuff
	  	var descriptionLabel = [CPTextField labelWithTitle:@"Description:"];
	   	[descriptionLabel setFrameOrigin:CGPointMake(28, 105)];
	   	[self addSubview: descriptionLabel];

	   	characterDescription = [[LPMultiLineTextField alloc] initWithFrame: CGRectMake(100, 100, 300, 150)];
	    [characterDescription setBezeled:YES];
	    [self addSubview: characterDescription];

	  	//The Tags stuff
	  	var tagsLabel = [CPTextField labelWithTitle:@"Tags:"];
	   	[tagsLabel setFrameOrigin:CGPointMake(55, 295)];
	   	[self addSubview: tagsLabel];

	   	characterTags = [[CPTokenField alloc] initWithFrame: CGRectMake(100, 290, 300, 100)];
	    [characterTags setBezeled:YES];
	  	[self addSubview: characterTags];

	  	//Sex radio button stuff
	  	var sexLabel = [[CPTextField alloc] initWithFrame: CGRectMake(60, 434, 100, 30)];
		[sexLabel setStringValue:"Sex:"];
		[sexLabel sizeToFit];
		[self addSubview:sexLabel];

		maleRadioButton = [CPRadio radioWithTitle: "Male"];
		femaleRadioButton = [CPRadio radioWithTitle: "Female"];
		otherRadioButton = [CPRadio radioWithTitle: "Other"];
		
		radioGroup = [maleRadioButton radioGroup];
		[femaleRadioButton setRadioGroup:radioGroup];
		[otherRadioButton setRadioGroup:radioGroup];

		[maleRadioButton setFrameOrigin:CGPointMake(100, 430)];
		[femaleRadioButton setFrameOrigin:CGPointMake(CGRectGetMaxX([maleRadioButton frame]) + 8, CGRectGetMinY([maleRadioButton frame]))];
		[otherRadioButton setFrameOrigin:CGPointMake(CGRectGetMaxX([femaleRadioButton frame]) + 8, CGRectGetMinY([femaleRadioButton frame]))];

		[self addSubview:maleRadioButton];
		[self addSubview:femaleRadioButton];
		[self addSubview:otherRadioButton];

		parentTabItemView = aTabViewItem;
		parentTabView = [parentTabItemView tabView];

		//File drop box
		fileDropBox = [[FileDropBox alloc] initWithFrame: CGRectMake(450, 45, 300, 400)];
		[self addSubview: fileDropBox];

		//The delete character button
		var deleteButton = [CPButton buttonWithTitle: "Delete Character"];
		[deleteButton setTarget: self];
		[deleteButton setAction: @selector(deleteCharacter)];


		var x = CGRectGetWidth(aFrame) / 2 - CGRectGetWidth([deleteButton frame]) / 2;
		var y = CGRectGetHeight(aFrame) - CGRectGetHeight([deleteButton frame]) - 40;
		[deleteButton setFrameOrigin: CGPointMake(x, y)];
		[deleteButton setAutoresizingMask: 
							CPViewMinXMargin |
                            CPViewMaxXMargin |
                            CPViewMinYMargin];
		[self addSubview: deleteButton];

		//The notifications
		[[CPNotificationCenter defaultCenter] addObserver:self 
											  selector:@selector(characterSheetBecameKey:) 
											  name:"characterSheetBecameKey" 
											  object:nil];

		[[CPNotificationCenter defaultCenter] addObserver:self 
											  selector:@selector(characterSheetWillClose:) 
											  name:"characterSheetWillClose" 
											  object:nil];

		[[CPNotificationCenter defaultCenter] addObserver:self 
											  selector:@selector(nameDidChange:) 
											  name:"CPControlTextDidChangeNotification" 
											  object:nil];


	}
	return self;
}

- (void) characterSheetBecameKey:(CPNotification) aNotification{
	[characterName setEditable:YES];
	[characterDescription setEditable:YES];
	[characterTags setEditable:YES];

}

-(void) characterSheetWillClose:(CPNotification) aNotification{
	[characterName setEditable:NO];
	[characterDescription setEditable:NO];
	[characterTags setEditable:NO];


}

-(void) nameDidChange:(CPNotification) aNotification {
	CPLog.trace([characterName objectValue]);
	[parentTabItemView setLabel:[characterName objectValue]];
}

-(void)alertDidEnd:(CPAlert)theAlert returnCode:(int)returnCode{
	CPLog.trace(returnCode);
	if(returnCode == 0){
		//They want to remove this character, notify the window to remove the tab and the controller to remove the character
		//from the server
		var info = [CPDictionary dictionaryWithObject: parentTabItemView forKey:"TabView"];
		[[CPNotificationCenter defaultCenter] postNotificationName:"RemoveCharacter" object:self userInfo: info];
	} 
}

-(void) deleteCharacter{
	var errorAlert = [CPAlert 
							alertWithMessageText:"Are you sure you want to remove this character?"
							defaultButton:"Yes" 
							alternateButton:"No"
							otherButton: nil
							informativeTextWithFormat:"This action cannot be undone, think about that for a moment."];

	[errorAlert setDelegate: self];
	[errorAlert runModal];
}

@end



