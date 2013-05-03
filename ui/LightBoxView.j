/**
	Button to toggle the Character sheet interface.
*/

@implementation LightBoxView : CPView {
	
}

- (id) initWithFrame:(CGRect) aFrame {

	if (self = [super initWithFrame:aFrame]){
		//var aBackgroundColor = [CPColor colorWithCalibratedRed:209.0/255.0 green:216.0/255.0 blue:227.0/255.0 alpha:0.7];
		//[self setBackgroundColor: aBackgroundColor];
	}
	return self;
}


- (void) mouseDown:(CPEvent) anEvent{
	[[CPNotificationCenter defaultCenter] postNotificationName:"RemoveSheets" object:self userInfo: nil];
}


@end