/**
	Button to toggle the Character sheet interface.
*/

@import "../LPMultiLineTextField.j"

@import "../FileDropBox.j"

@implementation CharacterSheetView : CPView {
	CPTextField characterName  @accessors;
	
	LPMultiLineTextField characterDescription  @accessors;
	LPMultiLineTextField phycologicalDescription  @accessors;
	LPMultiLineTextField sociologicalDescription  @accessors;

	CPTokenField characterTags @accessors;
	
	CPTabViewItem parentTabItemView;
	CPTabView parentTabView;

	FileDropBox fileDropBox;
}

- (id) initWithFrame:(CGRect) aFrame andParentTabViewItem:(CPTabViewItem) aTabViewItem{

	if (self = [super initWithFrame:aFrame]){
		parentTabItemView = aTabViewItem;

		CPLog.trace(CGRectGetWidth([self bounds]));
		//Main data box
		var mainDataBox = [[CPBox alloc] initWithFrame: CGRectMake(40, 40, 720, 300)];
		[mainDataBox setTitle: "Phisical Description"];
		[mainDataBox setTitlePosition: CPAtTop];
		[mainDataBox setBoxType: CPBoxSeparator];
		[self addSubview: mainDataBox];

		//The name stuff
	  	var nameLabel = [CPTextField labelWithTitle:@"Name:"];
	   	[nameLabel setFrameOrigin:CGPointMake(85, 85)];
	   	[self addSubview: nameLabel];

		characterName = [[CPTextField alloc] initWithFrame: CGRectMake(130, 80, 200, 29)];
	    [characterName setBezeled:YES];
	    [self addSubview: characterName];

	  	//The description stuff
	  	var descriptionLabel = [CPTextField labelWithTitle:@"Description:"];
	   	[descriptionLabel setFrameOrigin:CGPointMake(58, 125)];
	   	[self addSubview: descriptionLabel];

	   	characterDescription = [[LPMultiLineTextField alloc] initWithFrame: CGRectMake(130, 120, 350, 200)];
	    [characterDescription setBezeled:YES];
	    [self addSubview: characterDescription];

	    //Phicological profile box
	    var phycologicalDescriptionBox = [[CPBox alloc] initWithFrame: CGRectMake(40, 365, 340, 200)];
		[phycologicalDescriptionBox setTitle: "Phisical Description"];
		[phycologicalDescriptionBox setTitlePosition: CPAtTop];
		[phycologicalDescriptionBox setBoxType: CPBoxSeparator];
		[self addSubview: phycologicalDescriptionBox];

		phycologicalDescription = [[LPMultiLineTextField alloc] initWithFrame: CGRectMake(50, 395, 318, 155)];
	    [phycologicalDescription setBezeled:YES];
	    [self addSubview: phycologicalDescription];


		//Sociological description box
		var sociologicalDescriptionBox = [[CPBox alloc] initWithFrame: CGRectMake(418, 365, 340, 200)];
		[sociologicalDescriptionBox setTitle: "Sociological Description"];
		[sociologicalDescriptionBox setTitlePosition: CPAtTop];
		[sociologicalDescriptionBox setBoxType: CPBoxSeparator];
		[self addSubview: sociologicalDescriptionBox];

		sociologicalDescription = [[LPMultiLineTextField alloc] initWithFrame: CGRectMake(428, 395, 318, 155)];
	    [sociologicalDescription setBezeled:YES];
	    [self addSubview: sociologicalDescription];


		//Sociological description box
		var tagsBox = [[CPBox alloc] initWithFrame: CGRectMake(40, 585, 720, 80)];
		[tagsBox setTitle: "Tags"];
		[tagsBox setTitlePosition: CPAtTop];
		[tagsBox setBoxType: CPBoxSeparator];
		[self addSubview: tagsBox];

	   	characterTags = [[CPTokenField alloc] initWithFrame: CGRectMake(50, 618, 700, 32)];
	    [characterTags setBezeled:YES];
	  	[self addSubview: characterTags];
	  

		//File drop box
		fileDropBox = [[FileDropBox alloc] initWithFrame: CGRectMake(540, 70, 200, 250)];
		[fileDropBox setController:self];
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

-(void) viewDidMoveToSuperview {
	[characterName setEditable: YES];
	[characterDescription setEditable: YES];
	[phycologicalDescription setEditable: YES];
	[sociologicalDescription setEditable: YES];
	[characterTags setEditable: YES];
}

/**
	When the sheet will close we get rid of the editing of fields to prevent a bug in Cappuccino
	NOTE: Later fix the bug in capp
*/
-(void) characterSheetWillClose:(CPNotification) aNotification{
	[characterName setEditable:NO];
	[characterDescription setEditable:NO];
	[characterTags setEditable:NO];
}

/**
	Method that will catch the changing of the name fieled to change the tabs name. 
	NOTE: there is a bug in capp preventing this. Fix it later on.
*/
-(void) nameDidChange:(CPNotification) aNotification {
	if(!parentTabView)
		parentTabView = [parentTabItemView tabView];
	[parentTabItemView setLabel:[characterName objectValue]];
	[parentTabView layoutSubviews];
}
/**
	When the alert ends send a notification.
	They want to remove this character, notify the window to remove the tab and the controller to remove the character
	from the server
*/
-(void)alertDidEnd:(CPAlert)theAlert returnCode:(int)returnCode{
	if(returnCode == 0){
		var info = [CPDictionary dictionaryWithObject: parentTabItemView forKey:"TabView"];
		[[CPNotificationCenter defaultCenter] postNotificationName:"RemoveCharacter" object:self userInfo: info];
	} 
}

/**
	Used when the user clicks the delete method.
*/
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



